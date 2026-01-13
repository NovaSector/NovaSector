GLOBAL_LIST_EMPTY(aaerp_maskcache)
GLOBAL_DATUM_INIT(erp_belly_prefshelper, /datum/erp_belly_prefshelper, new)

// == EXPANDED MIRROR OF ALT_APPEARANCE/BASIC ==
/datum/atom_hud/alternate_appearance/erp
	/// Target atom that this alt_appearance is applied to.
	var/atom/target
	/// The final mixdown image actually displayed in client.images, including layered overlays via BLEND_INSET_OVERLAY.
	var/image/image
	/// The original image that was provided for this overlay, before edits for BLEND_INSET_OVERLAY support.
	var/image/original_image
	/// The base key for this ERP part's series of appearances.  Used for finding other related alt_appearances.
	var/base_key = ""
	/// The size of this ERP part.  Used for bellies, et al, so people can disable hyper stuff.
	var/size

	/// Icon state used for the off-hand mask.  Some unique hand types will require overriding this.
	var/offhand_iconstate = "offhand_clip"
	/// List of bespoke off-hand mask variants for unique hand types.
	var/list/supported_offhands = list(
		SPECIES_TESHARI = "offhand_clip_teshari",
		SPECIES_VOX_PRIMALIS = "offhand_clip_vox_primalis"
	)
	/// Icon state used for the shoe mask.  Some unique leg types will require overriding this.
	var/shoe_iconstate = "shoe_clip"
	/// List of bespoke shoe mask variants for unique leg types.
	var/list/supported_shoes = list(
		SPECIES_TESHARI = "shoe_clip_teshari",
		SPECIES_VOX_PRIMALIS = "shoe_clip_vox_primalis"
	)

	uses_global_hud_category = FALSE
	/// List of hooked signals, as per basic alt_appearances.
	var/list/signals_registering = list(
		COMSIG_MOB_ANTAGONIST_REMOVED,
		COMSIG_MOB_GHOSTIZED,
		COMSIG_MOB_MIND_TRANSFERRED_INTO,
		COMSIG_MOB_MIND_TRANSFERRED_OUT_OF,
	)

/datum/atom_hud/alternate_appearance/erp/New(key, image/base_image, options = AA_TARGET_SEE_APPEARANCE, in_target, in_basekey, in_size, in_bodytype)
	target = in_target
	base_key = in_basekey
	size = in_size
	if(in_bodytype in supported_offhands)
		offhand_iconstate = supported_offhands[in_bodytype]
	if(in_bodytype in supported_shoes)
		shoe_iconstate = supported_shoes[in_bodytype]
	..()
	transfer_overlays = options & AA_MATCH_TARGET_OVERLAYS
	/// Set the alt_appearance image to the specified one.  This image gets modified.
	image = base_image
	/// Clone the original image to retain it for a final overlay.
	original_image = image(base_image)
	original_image.pixel_x -= image.pixel_x
	original_image.pixel_y -= image.pixel_y
	image.appearance_flags |= KEEP_TOGETHER
	image.color = COLOR_WHITE
	LAZYADD(target.update_on_z, image)
	if(transfer_overlays)
		copy_overlays(target, TRUE)

	add_atom_to_hud(target)
	target.set_hud_image_active(appearance_key, exclusive_hud = src)

	if((options & AA_TARGET_SEE_APPEARANCE) && ismob(target))
		if(mobShouldSee(target))
			show_to(target)

/datum/atom_hud/alternate_appearance/erp/mobShouldSee(mob/viewer)
	/// Sanity check section here.
	if(target == null)
		return FALSE
	if(!islist(target.alternate_appearances))
		return FALSE
	var/key = "[base_key][(size+1)]"
	if(isnull(key))
		return FALSE
	/// Determine the max size for the target to be able to view.
	var/maxsize = get_max_size(viewer)
	/// If we're already above the viewer's maximum size pref, back out.
	if(size > maxsize)
		return FALSE
	/// There is a higher size to render, either stop here or hide.
	if(target.alternate_appearances[key] != null)
		/// If it's too big for the user we won't render it, so stop here- this is the highest layer.
		if(size + 1 > maxsize)
			return TRUE
		/// Otherwise, hide this to avoid wasted draw calls.
		return FALSE
	else
		/// This is the top layer and nothing else says no: go ahead and render.
		return TRUE

/// Helper function for getting a viewer's maximum size pref.
/// Base form: return viewer.client?.prefs?.read_preference(some_numeric_preference)
/datum/atom_hud/alternate_appearance/erp/proc/get_max_size(mob/viewer)
	return 0

/datum/atom_hud/alternate_appearance/erp/Destroy()
	. = ..()
	LAZYREMOVE(target.update_on_z, image)
	QDEL_NULL(image)
	target = null

/datum/atom_hud/alternate_appearance/erp/track_mob(mob/new_viewer)
	RegisterSignals(new_viewer, signals_registering, PROC_REF(check_hud), override = TRUE)

/datum/atom_hud/alternate_appearance/erp/untrack_mob(mob/former_viewer)
	UnregisterSignal(former_viewer, signals_registering)

/datum/atom_hud/alternate_appearance/erp/add_atom_to_hud(atom/target_atom)
	LAZYINITLIST(target_atom.hud_list)
	target_atom.hud_list[appearance_key] = image
	return ..()

/datum/atom_hud/alternate_appearance/erp/remove_atom_from_hud(atom/target_atom)
	. = ..()
	LAZYREMOVE(target_atom.hud_list, appearance_key)
	target_atom.set_hud_image_inactive(appearance_key)
	if(. && !QDELETED(src))
		qdel(src)

/// This is where the magic happens.  This overrides base copy_overlays.
/// By copying only overlays that would layer above the core image...
/// ...and using BLEND_INSET_OVERLAY, they only overlay over the core image.
/// This means you don't get duplicate parts or pixels that then render over your actual appearance.overlays.
/datum/atom_hud/alternate_appearance/erp/copy_overlays(atom/other, cut_old)
	var/list/cached_other = target.overlays
	if(length(image.overlays) != length(cached_other) + 1)
		image.overlays -= image.overlays
		for(var/an_overlay in cached_other)
			var/arm_check = FALSE
			if(findtext(an_overlay:icon_state, "_arm"))
				if(an_overlay:layer == -BODYPARTS_LAYER)
					arm_check = TRUE
			if(an_overlay:layer >= image.layer || arm_check)
				var/image/new_overlay = image(an_overlay)
				var/static/mask_icons = list()
				if(arm_check)
					new_overlay.layer = -BODYPARTS_HIGH_LAYER
				if(new_overlay.layer == -HANDS_LAYER || new_overlay.layer == -GLOVES_LAYER || new_overlay.layer == -BODYPARTS_HIGH_LAYER || arm_check)
					if(!(offhand_iconstate in mask_icons))
						mask_icons[offhand_iconstate] = icon('modular_nova/modules/tums/icons/helpers.dmi', offhand_iconstate)
					if(!(new_overlay.icon in GLOB.aaerp_maskcache))
						GLOB.aaerp_maskcache[new_overlay.icon] = list()
					if(!(offhand_iconstate in GLOB.aaerp_maskcache[new_overlay.icon]))
						var/icon/masked_iconfile = icon(new_overlay.icon)
						masked_iconfile.Blend(mask_icons[offhand_iconstate], ICON_MULTIPLY)
						GLOB.aaerp_maskcache[new_overlay.icon][offhand_iconstate] = masked_iconfile
					new_overlay.icon = GLOB.aaerp_maskcache[new_overlay.icon][offhand_iconstate]
				else if(new_overlay.layer == -SHOES_LAYER)
					if(!(shoe_iconstate in mask_icons))
						mask_icons[shoe_iconstate] = icon('modular_nova/modules/tums/icons/helpers.dmi', shoe_iconstate)
					if(!(new_overlay.icon in GLOB.aaerp_maskcache))
						GLOB.aaerp_maskcache[new_overlay.icon] = list()
					if(!(shoe_iconstate in GLOB.aaerp_maskcache[new_overlay.icon]))
						var/icon/masked_iconfile = icon(new_overlay.icon)
						masked_iconfile.Blend(mask_icons[shoe_iconstate], ICON_MULTIPLY)
						GLOB.aaerp_maskcache[new_overlay.icon][shoe_iconstate] = masked_iconfile
					new_overlay.icon = GLOB.aaerp_maskcache[new_overlay.icon][shoe_iconstate]
				else
					new_overlay.blend_mode = BLEND_INSET_OVERLAY
				new_overlay.pixel_x -= image.pixel_x
				new_overlay.pixel_y -= image.pixel_y
				image.overlays += new_overlay
		image.overlays += original_image

// ==ACTUAL ALTERNATE APPEARANCE FOR BELLIES==
/datum/atom_hud/alternate_appearance/erp/belly/get_max_size(mob/viewer)
	return viewer.client?.prefs?.read_preference(/datum/preference/numeric/erp_belly_maxsize)

/datum/atom_hud/alternate_appearance/erp/belly/mobShouldSee(mob/viewer)
	if((viewer.client?.prefs?.read_preference(/datum/preference/toggle/erp/belly) == TRUE))
		return ..()
	return FALSE

/// ==BREAKER FOR MAIN PREFERENCES==
/// Master visibility preference.  If this is off, everything else is.
/datum/preference/toggle/erp/belly_master
	savefile_key = "erp_enable_belly"

/datum/preference/toggle/erp/belly_master/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_tums_preferences))
		return FALSE

	return TRUE

/// Belly sprite visibility pref, used for blocking out the alt_appearance.
/datum/preference/toggle/erp/belly
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "erp_belly_base"

/datum/preference/toggle/erp/belly/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_tums_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/erp/belly_master)

/datum/preference/toggle/erp/belly/deserialize(input, datum/preferences/preferences)
	if(!preferences.read_preference(/datum/preference/toggle/erp/belly_master))
		return FALSE
	return ..()

/// Sound pref (full but not stuffed sounds)
/datum/preference/toggle/erp/belly/sound_groans
	savefile_key = "erp_belly_sound_groans"

/// Sound pref (stuffed sounds)
/datum/preference/toggle/erp/belly/sound_gurgles
	savefile_key = "erp_belly_sound_gurgles"

/// Movement sound pref (full but not stuffed sounds, plays when walking or being jostled)
/datum/preference/toggle/erp/belly/sound_move_creaks
	savefile_key = "erp_belly_sound_move_creaks"

/// Movement sound pref (stuffed sounds, plays when walking or being jostled)
/datum/preference/toggle/erp/belly/sound_move_sloshes
	savefile_key = "erp_belly_sound_move_sloshes"

/// Per-character preference for being vored.
/// Why is this not integrated into the existing vore prefs, you ask?
/// Because they aren't granular enough...and because it shows on examine, which some people might not want public.
/datum/preference/choiced/erp_vore_prey_pref
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_belly_vore_prey"

/datum/preference/choiced/erp_vore_prey_pref/init_possible_values()
	return list(
		"Never",
		"Query",
		"Always",
	)

/datum/preference/choiced/erp_vore_prey_pref/create_default_value()
	return "Never"

/datum/preference/choiced/erp_vore_prey_pref/deserialize(input, datum/preferences/preferences)
	if(!preferences.read_preference(/datum/preference/toggle/erp/belly_master))
		return create_default_value()
	return ..()

/datum/preference/choiced/erp_vore_prey_pref/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_tums_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/erp/belly_master)

/datum/preference/choiced/erp_vore_prey_pref/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Game pref for how large a belly sprite you're willing to see.
/// If new sizes are added, adjust the maximum here accordingly.
/// Ignored if /toggle/erp/belly is off.
/datum/preference/numeric/erp_belly_maxsize
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "erp_belly_maxsize"
	step = 1
	minimum = 0
	maximum = 16

/datum/preference/numeric/erp_belly_maxsize/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_belly_maxsize/create_default_value()
	return 3

/datum/preference/numeric/erp_belly_maxsize/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_tums_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/erp/belly)

/// ==BREAKER FOR QUIRK PREFERENCES==
/// This is the master quirk that allows one to have a belly.
/// Quirks are a somewhat suboptimal system for bringing this in, but...
/// The special prefs subsection accessible from the menu & mob trait make it overall easier to work with.
/datum/quirk/belly
	name = "Big Boned"
	desc = "Your midriff just stands out more than others'..."
	icon = FA_ICON_PERSON_PREGNANT
	value = 0
	mob_trait = TRAIT_PREDATORY
	gain_text = span_notice("You feel like your suit doesn't quite fit.")
	lose_text = span_notice("You feel like your suit fits again.")
	medical_record_text = "Patient's midriff is well defined." //Why does QUIRK_HIDE_FROM_SCAN not cut this from medical records too?
	quirk_flags = QUIRK_PROCESSES | QUIRK_CHANGES_APPEARANCE | QUIRK_HIDE_FROM_SCAN
	maximum_process_stat = null
	erp_quirk = TRUE
	tum_quirk = TRUE
	/// Local reference to our connected belly helper object.
	var/obj/item/belly_function/the_bwelly

/datum/quirk/belly/add_unique(client/client_source)
	the_bwelly = new /obj/item/belly_function(quirk_holder)

	/// Main sprite color.
	the_bwelly.color = client_source?.prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
	/// Skintone toggle - this adjusts the sprite files.
	the_bwelly.use_skintone = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE

	/// Size modifier - overall.
	the_bwelly.sizemod = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod) || 1
	/// Size modifier - auto-calculated stuffed size.
	the_bwelly.sizemod_autostuffed = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed) || 1
	/// Size modifier - audio size.
	the_bwelly.sizemod_audio = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_audio) || 1
	/// Maximum display size for this belly.
	the_bwelly.maxsize = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_maxsize) || 16

	/// Base cosmetic size.
	the_bwelly.base_size_cosmetic = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_base) || 0
	/// Base fullness size - permanent and not dependent on actually having someone nommed.
	the_bwelly.base_size_full = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_full) || 0
	/// Base stuffed size - permanent and not dependent on actually having high nutrition or a bunch of stomach regaents.
	the_bwelly.base_size_stuffed = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_stuffed) || 0

	/// Sound toggle: full groans.  All but cosmetic size adds to these.
	the_bwelly.allow_sound_groans =client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE
	/// Sound toggle: stuffed gurgles.  Only stuffed sizes add to these.
	the_bwelly.allow_sound_gurgles = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE
	/// Sound toggle: Full creaks when moving.  All but cosmetic size adds to these.
	the_bwelly.allow_sound_move_creaks = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE
	/// Sound toggle: stuffed sloshes when moving.  Only stuffed sizes add to these.
	the_bwelly.allow_sound_move_sloshes = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes)|| FALSE

	/// Pred prefs mode
	the_bwelly.pred_mode = client_source?.prefs.read_preference(/datum/preference/choiced/erp_bellyquirk_pred_pref) || "Never"
	/// Default endosoma size
	the_bwelly.endo_size = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_endo) || 1000

	/// Manually run add() for dummies so we get preview on the character screen.
	if(isdummy(quirk_holder))
		add()

/// Manually run an initial sprite calculation & other initializations during addition.
/// This means your sprite is instantly visible on spawnin & appears properly in chargen.
/datum/quirk/belly/add()
	. = ..()
	if(the_bwelly != null)
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
		the_bwelly.loc = quirk_holder
		the_bwelly.apply_to_user(quirk_holder)
		the_bwelly.belly_process(0)

/// Redundant calculations in case add() errors out or doesn't work as expected.
/datum/quirk/belly/post_add()
	. = ..()
	if(the_bwelly != null)
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
		the_bwelly.loc = quirk_holder
		the_bwelly.apply_to_user(quirk_holder)
		the_bwelly.belly_process(0)

/// The meat of the processing happens in the equippable_belly file.
/// This is largely sanity checks & things designed to *stop* it from processing if it's not appropriate.
/datum/quirk/belly/process(seconds_per_tick)
	if(the_bwelly == null)
		return
	/// If something has gone catastrophically wrong, stash the helper in pseudo-nullspace before anyone can see it.
	if(the_bwelly.loc != quirk_holder || quirk_holder == null)
		the_bwelly.loc = src
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
	/// Search for the client connected to the mob- and if it doesn't have the quirk, do NOT keep treating this as active.
	/// This is primarily a fallback in case people do brain swaps for some reason.  There are...very few other ways this could come up.
	if(quirk_holder?.client?.prefs)
		if(!(src.name in quirk_holder.client.prefs.all_quirks))
			if(the_bwelly.loc != src)
				the_bwelly.loc = src
				if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
					the_bwelly.remove_from_user(the_bwelly.lastuser)
		else
			/// If the helper was nullspaced or otherwise messed with, reapply it to the associated mob once things are clear.
			if(the_bwelly.loc != quirk_holder && quirk_holder != null)
				the_bwelly.loc = quirk_holder
				the_bwelly.apply_to_user(quirk_holder)
	/// If the helper is where it should be, only then do we actually let it process.
	if(the_bwelly.loc == quirk_holder)
		the_bwelly.belly_process(seconds_per_tick)

/// Final removal checks for sanity happen here.
/datum/quirk/belly/remove()
	. = ..()
	the_bwelly.loc = src
	if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
		the_bwelly.remove_from_user(the_bwelly.lastuser)

/// Extra qdels and nulling to minimize GC issues and CI errors.
/datum/quirk/belly/Destroy()
	. = ..()
	qdel(the_bwelly)

/// Per-character pref, main sprite color.
/// This should be migrated to tricolor down the line, if spriters are interested in making alternate patterns of belly.
/datum/preference/color/erp_bellyquirk_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_color"

/datum/preference/color/erp_bellyquirk_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, determines if the belly uses the skintone spritesheet or not.
/datum/preference/toggle/erp_bellyquirk_skintone
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_skintone"
	default_value = FALSE

/datum/preference/toggle/erp_bellyquirk_skintone/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, an overall sprite size modifier.
/datum/preference/numeric/erp_bellyquirk_sizemod
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sizemod"
	step = 0.01
	minimum = 0
	maximum = 10

/datum/preference/numeric/erp_bellyquirk_sizemod/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_sizemod/create_default_value()
	return 1

/// Per-character pref, a multiplier that applies to auto-calculated stuffed size.
/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sizemod_autostuffed"
	step = 0.01
	minimum = 0
	maximum = 10

/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed/create_default_value()
	return 1

/// Per-character pref, a size modifier that applies specifically to calculations for sound.
/datum/preference/numeric/erp_bellyquirk_sizemod_audio
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sizemod_audio"
	step = 0.01
	minimum = 0
	maximum = 10

/datum/preference/numeric/erp_bellyquirk_sizemod_audio/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_sizemod_audio/create_default_value()
	return 1

/// Per-character pref, a base cosmetic size that has no noises & is unmodified by stats.  All sizes stack.
/datum/preference/numeric/erp_bellyquirk_size_base
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_size_base"
	step = 1
	minimum = 0
	maximum = 10000

/datum/preference/numeric/erp_bellyquirk_size_base/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_size_base/create_default_value()
	return 0

/// Per-character pref, a base cosmetic size that provides sounds of fullness.  All sizes stack.
/// Implied endosoma, but doesn't require actually having someone in your belly.
/datum/preference/numeric/erp_bellyquirk_size_full
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_size_full"
	step = 1
	minimum = 0
	maximum = 10000

/datum/preference/numeric/erp_bellyquirk_size_full/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_size_full/create_default_value()
	return 0

/// Per-character pref, a base cosmetic size that provides sounds of fullness & churns.  All sizes stack.
/// Implied stuffing, but doesn't depend on your get_fullness value whatsoever.
/datum/preference/numeric/erp_bellyquirk_size_stuffed
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_size_stuffed"
	step = 1
	minimum = 0
	maximum = 10000

/datum/preference/numeric/erp_bellyquirk_size_stuffed/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_size_stuffed/create_default_value()
	return 0

/// Per-character pref, a toggle for whether this belly can make full groans.
/datum/preference/toggle/erp_bellyquirk_groans
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_groans"

/datum/preference/toggle/erp_bellyquirk_groans/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, a toggle for whether this belly can make stuffed gurgles & churns.
/datum/preference/toggle/erp_bellyquirk_gurgles
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_gurgles"

/datum/preference/toggle/erp_bellyquirk_gurgles/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, a toggle for whether this belly can make full creaks & groans during movement.
/datum/preference/toggle/erp_bellyquirk_move_creaks
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_move_creaks"

/datum/preference/toggle/erp_bellyquirk_move_creaks/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, a toggle for whether this belly can make stuffed sloshes & churns during movement.
/datum/preference/toggle/erp_bellyquirk_move_sloshes
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_move_sloshes"

/datum/preference/toggle/erp_bellyquirk_move_sloshes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, analgous to the prey pref above.
/// Determines whether this character can act as a pred at all.
/datum/preference/choiced/erp_bellyquirk_pred_pref
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_pred"

/datum/preference/choiced/erp_bellyquirk_pred_pref/init_possible_values()
	return list(
		"Never",
		"Query",
		"Always",
	)

/datum/preference/choiced/erp_bellyquirk_pred_pref/create_default_value()
	return "Never"

/datum/preference/choiced/erp_bellyquirk_pred_pref/deserialize(input, datum/preferences/preferences)
	if(!preferences.read_preference(/datum/preference/toggle/erp/belly_master))
		return create_default_value()
	return ..()

/datum/preference/choiced/erp_bellyquirk_pred_pref/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_tums_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/erp/belly_master)

/datum/preference/choiced/erp_bellyquirk_pred_pref/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Per-character pref, a default size for a newly-nommed guest.
/datum/preference/numeric/erp_bellyquirk_size_endo
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_size_endo"
	step = 1
	minimum = 0
	maximum = 10000

/datum/preference/numeric/erp_bellyquirk_size_endo/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_size_endo/create_default_value()
	return 1000

/// Per-character pref, how big this belly can actually get.
/// If this is below someone's game prefs, they won't see it go above that.
/// If someone's game prefs are below this, they won't see it go above their prefs, even if this gets bigger.
/datum/preference/numeric/erp_bellyquirk_maxsize
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_maxsize"
	step = 1
	minimum = 0
	maximum = 16

/datum/preference/numeric/erp_bellyquirk_maxsize/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_bellyquirk_maxsize/create_default_value()
	return 16



/// Quirk data helper.
/datum/quirk_constant_data/stuffable
	associated_typepath = /datum/quirk/belly

/datum/quirk_constant_data/stuffable/New()
	customization_options = list(/datum/preference/color/erp_bellyquirk_color, /datum/preference/toggle/erp_bellyquirk_skintone,
	/datum/preference/numeric/erp_bellyquirk_sizemod, /datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed, /datum/preference/numeric/erp_bellyquirk_sizemod_audio, /datum/preference/numeric/erp_bellyquirk_maxsize,
	/datum/preference/numeric/erp_bellyquirk_size_base, /datum/preference/numeric/erp_bellyquirk_size_full, /datum/preference/numeric/erp_bellyquirk_size_stuffed,
	/datum/preference/toggle/erp_bellyquirk_groans, /datum/preference/toggle/erp_bellyquirk_gurgles, /datum/preference/toggle/erp_bellyquirk_move_creaks, /datum/preference/toggle/erp_bellyquirk_move_sloshes,
	/datum/preference/choiced/erp_bellyquirk_pred_pref)

	return ..()


/// Helper for managing preferences independent of an equipped belly.
/datum/erp_belly_prefshelper
	/// Tracker for this helper's client.
	//var/client/associated_client
	/// Tracker for this helper's associated belly function, if it's in-round.
	//var/obj/item/belly_function/belly
	/// Tracker for whether or not this helper's associated preferences datum had changes made; keeps us from doing save_preferences every time.
	//var/wrote_prefs = FALSE
	var/debug_ui_name = "NovaTumsPrefs"

/datum/erp_belly_prefshelper/ui_state(mob/user)
	return GLOB.always_state

/datum/erp_belly_prefshelper/proc/get_assoc_client(mob/user)
	RETURN_TYPE(/client)
	/*if(belly != null)
		if(belly.lastuser != null)
			if(belly.lastuser.client != null)
				return belly.lastuser.client*/
	return user?.client

/datum/erp_belly_prefshelper/proc/get_assoc_belly(mob/user)
	RETURN_TYPE(/obj/item/belly_function)
	var/obj/item/belly_function/belly = null
	for(var/something in user.contents)
		belly = something
		if(istype(belly))
			return belly

/datum/erp_belly_prefshelper/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, debug_ui_name, "bwelly")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/erp_belly_prefshelper/ui_static_data(mob/user)
	. = list()
	//.["a_constant"] = A_CONSTANT
	var/static/consent_options = list("Never", "Query", "Always")
	.["pred_options"] = consent_options
	.["prey_options"] = consent_options
	.["ckeyTab"] = "[user.client?.ckey]TumsTab"

/datum/erp_belly_prefshelper/ui_data(mob/user)
	. = list()

	// Figure out what tab we're in
	var/ui_tab = 2
	if("[user.client?.ckey]TumsTab" in tgui_shared_states)
		ui_tab = text2num(tgui_shared_states["[user.client?.ckey]TumsTab"])


	var/obj/item/belly_function/belly = get_assoc_belly(user)
	.["has_belly"] = (belly != null || (/datum/quirk/belly::name in get_assoc_client(user)?.prefs.all_quirks))
	.["has_player"] = (belly != null)

	if(ui_tab == 1)
		if(belly == null)
			tgui_shared_states["[user.client?.ckey]TumsTab"] = "2"
			return
		if(belly.lastuser == null)
			tgui_shared_states["[user.client?.ckey]TumsTab"] = "2"
			return
		// == LOCAL SETTINGS BREAKER ==
		// Send title
		.["title"] = "Local belly prefs: [belly.lastuser]"
		// Send current color & sprite variants
		.["color"] = belly.color
		.["use_skintone"] = belly.use_skintone
		// Send current size modifiers
		.["sizemod"] = belly.sizemod
		.["sizemod_autostuffed"] = belly.sizemod_autostuffed
		.["sizemod_audio"] = belly.sizemod_audio
		// Send current sound rules
		.["allow_sound_groans"] = belly.allow_sound_groans
		.["allow_sound_gurgles"] = belly.allow_sound_gurgles
		.["allow_sound_move_creaks"] = belly.allow_sound_move_creaks
		.["allow_sound_move_sloshes"] = belly.allow_sound_move_sloshes
		// Send details on current calculated belly size
		.["maxsize"] = belly.maxsize
		var/nutritionmaxxing = "N/A"
		var/belly_current_size_unclamped = ((((belly.base_size_cosmetic + belly.base_size_full + belly.base_size_stuffed) / 10)**1.5) / (4/3) / PI)**(1/3)
		var/belly_last_size = FLOOR(belly_current_size_unclamped, 1)
		if(belly_last_size > 16)
			belly_last_size = 16
		if(belly_last_size > belly.maxsize)
			belly_last_size = belly.maxsize
		if(belly_last_size < 0)
			belly_last_size = 0
		if(belly.sizemod_autostuffed > 0 && belly.sizemod > 0)
			nutritionmaxxing = (((25.9852 * ((belly_current_size_unclamped)**2))/belly.sizemod/belly.sizemod_autostuffed) + 500) / 0.4
		.["calculated_size"] = "Base cosmetic sizes: these provide mechanics-agnostic belly size and/or audio.\nCalculated total sprite size of [belly_current_size_unclamped]/16 ([belly_last_size]/[belly.maxsize] clamped); equivalent to [nutritionmaxxing] nutrition."
		// Send a calculated max for the sliders - this is based on the volume equation.
		// This sets per-category max to the value required to reach a smidge beyond the maximum sprite size.
		if(belly.sizemod > 0)
			.["base_size_max"] = (25.9852 * ((16+1)**2))/belly.sizemod
		else
			.["base_size_max"] = (25.9852 * ((16+1)**2))
		.["base_size_cosmetic"] = belly.base_size_cosmetic
		.["base_size_full"] = belly.base_size_full
		.["base_size_stuffed"] = belly.base_size_stuffed
		// Send current vore-related prefs
		.["pred_mode"] = belly.pred_mode
		.["endo_size_label"] = "Default endo size (sprite size [(((belly.endo_size / 10 * belly.sizemod)**1.5) / (4/3) / PI)**(1/3)])"
		.["endo_size"] = belly.endo_size
		// Possibly need to refactor this to store prey_mode on mobs somewhere to avoid constant pref reads
		.["prey_mode"] = get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/erp_vore_prey_pref) || "Never"
	else if(ui_tab == 2)
		// == PREFS SETTINGS BREAKER ==
		// Send title
		.["title"] = "Character belly prefs: [get_assoc_client(user).prefs.read_preference(/datum/preference/name/real_name)]"
		// Send current color & sprite variants
		.["color"] = get_assoc_client(user).prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
		.["use_skintone"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE
		// Send current size modifiers
		var/prefs_sizemod = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod) || 1
		.["sizemod"] = prefs_sizemod
		var/prefs_sizemod_autostuffed = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed) || 1
		.["sizemod_autostuffed"] = prefs_sizemod_autostuffed
		var/prefs_sizemod_audio = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_audio) || 1
		.["sizemod_audio"] = prefs_sizemod_audio
		// Send current sound rules
		.["allow_sound_groans"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE
		.["allow_sound_gurgles"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE
		.["allow_sound_move_creaks"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE
		.["allow_sound_move_sloshes"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes) || FALSE
		// Read & calculate current prefs-based sizes
		var/prefs_base_size_cosmetic = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_base) || 0
		var/prefs_base_size_full = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_full) || 0
		var/prefs_base_size_stuffed = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_stuffed) || 0
		var/prefs_maxsize = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_maxsize) || 0
		.["maxsize"] = prefs_maxsize
		var/prefs_current_size_unclamped = ((((prefs_base_size_cosmetic + prefs_base_size_full + prefs_base_size_stuffed) / 10)**1.5) / (4/3) / PI)**(1/3)
		var/prefs_last_size = FLOOR(prefs_current_size_unclamped, 1)
		if(prefs_last_size > 16)
			prefs_last_size = 16
		if(prefs_last_size > prefs_maxsize)
			prefs_last_size = prefs_maxsize
		if(prefs_last_size < 0)
			prefs_last_size = 0
		// Send details on current calculated belly size
		var/nutritionmaxxing = "N/A"
		if(prefs_sizemod_autostuffed > 0 && prefs_sizemod > 0)
			nutritionmaxxing = (((25.9852 * ((prefs_current_size_unclamped)**2))/prefs_sizemod/prefs_sizemod_autostuffed) + 500) / 0.4
		.["calculated_size"] = "Base cosmetic sizes: these provide mechanics-agnostic belly size and/or audio.\nCalculated total sprite size of [prefs_current_size_unclamped]/16 ([prefs_last_size]/[prefs_maxsize] clamped); equivalent to [nutritionmaxxing] nutrition."
		// Send a calculated max for the sliders - this is based on the volume equation.
		// This sets per-category max to the value required to reach a smidge beyond the maximum sprite size.
		if(prefs_sizemod > 0)
			.["base_size_max"] = (25.9852 * ((16+1)**2))/prefs_sizemod
		else
			.["base_size_max"] = (25.9852 * ((16+1)**2))
		.["base_size_cosmetic"] = prefs_base_size_cosmetic
		.["base_size_full"] = prefs_base_size_full
		.["base_size_stuffed"] = prefs_base_size_stuffed
		// Send current vore-related prefs
		.["pred_mode"] = get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/erp_bellyquirk_pred_pref) || "Never"
		var/prefs_endo_size = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_endo) || 1000
		.["endo_size_label"] = "Default endo size (sprite size [(((prefs_endo_size / 10 * prefs_sizemod)**1.5) / (4/3) / PI)**(1/3)])"
		.["endo_size"] = prefs_endo_size
		.["prey_mode"] = get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/erp_vore_prey_pref) || "Never"
	else if(ui_tab == 3)
		// == GLOBAL PREFS SETTINGS BREAKER ==
		// Send title
		.["title"] = "Global belly prefs"
		// Send sprite visibility rules
		.["global_belly_visibility"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly) || FALSE
		.["global_maxsize"] = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_belly_maxsize) || 0
		// Send current sound rules
		.["global_sound_groans"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_groans) || FALSE
		.["global_sound_gurgles"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_gurgles) || FALSE
		.["global_sound_move_creaks"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_creaks) || FALSE
		.["global_sound_move_sloshes"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_sloshes) || FALSE

/datum/erp_belly_prefshelper/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	// Setup some temp variables for tracking things
	var/wrote_prefs = FALSE
	var/mob/user = ui.user
	var/obj/item/belly_function/belly = get_assoc_belly(user)

	// Sanity check: if our owner exploded or something, close the UI.
	if(belly != null)
		if(belly.lastuser == null)
			ui.close()
			return FALSE
	// Sanity check: if someone's client peaced out for whatever reason, close the UI.
	if(get_assoc_client(user) == null)
		ui.close()
		return FALSE

	/*var/all_params = ""
	for(var/a_key in params)
		all_params = "[all_params] [a_key]=[params[a_key]]"
	to_chat(belly.lastuser, "Doing a UI act [action] with the following params[all_params]")*/

	var/static/list_yesno = list("Yes", "No")
	var/ui_tab = 1
	if("[user.client?.ckey]TumsTab" in tgui_shared_states)
		ui_tab = text2num(tgui_shared_states["[user.client?.ckey]TumsTab"])

	switch(action)
		if("changeColor")
			var/new_color = get_assoc_client(user).prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
			new_color = tgui_color_picker(belly.lastuser, "Enter new color:", "Color", new_color)
			if(new_color != null || QDELETED(belly.lastuser) || QDELETED(src))
				if(params["tab"] == "2" || ui_tab == 2)
					get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/color/erp_bellyquirk_color], new_color)
					wrote_prefs = TRUE
					if(new_color != belly?.color && belly != null)
						var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
						if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
							belly.color = new_color
				else if(belly != null)
					belly.color = new_color
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
			return TRUE
		if("changeUseSkintone")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_use_skintone = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_skintone], new_use_skintone != FALSE)
				wrote_prefs = TRUE
				var/new_color = null
				if(new_use_skintone)
					var/mode_select = tgui_alert(belly.lastuser, "Auto-set color based on your skintone?", "Inherit Skintone?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						new_color = skintone2hex(get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/skin_tone)) //why this isn't in DNA hurts me
						get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/color/erp_bellyquirk_color], new_color)
						wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.use_skintone = new_use_skintone
						if(new_color != null)
							belly.color = new_color
			else if(belly != null)
				belly.use_skintone = !belly.use_skintone
				if(belly.use_skintone)
					var/mode_select = tgui_alert(belly.lastuser, "Auto-set color based on your skintone?", "Inherit Skintone?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.color = skintone2hex(belly.lastuser.skin_tone) //why this isn't in DNA hurts me
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
			return TRUE
		if("changeSizemod")
			var/new_sizemod = text2num(params["newSizemod"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod], new_sizemod)
				wrote_prefs = TRUE
				if(new_sizemod != belly?.sizemod && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.sizemod = new_sizemod
			else if(belly != null)
				belly.sizemod = new_sizemod
			return TRUE
		if("changeSizemodAutostuffed")
			var/new_sizemod_autostuffed = text2num(params["newSizemodAutostuffed"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed], new_sizemod_autostuffed)
				wrote_prefs = TRUE
				if(new_sizemod_autostuffed != belly?.sizemod_autostuffed && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.sizemod_autostuffed = new_sizemod_autostuffed
			else if(belly != null)
				belly.sizemod_autostuffed = new_sizemod_autostuffed
			return TRUE
		if("changeSizemodAudio")
			var/new_sizemod_audio = text2num(params["newSizemodAudio"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod_audio], new_sizemod_audio)
				wrote_prefs = TRUE
				if(new_sizemod_audio != belly?.sizemod_audio && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.sizemod_audio = new_sizemod_audio
			else if(belly != null)
				belly.sizemod_audio = new_sizemod_audio
			return TRUE
		if("changeSoundGroans")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_groans = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_groans], new_allow_sound_groans != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_groans = new_allow_sound_groans
			else if(belly != null)
				belly.allow_sound_groans = !belly.allow_sound_groans
			return TRUE
		if("changeSoundGurgles")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_gurgles = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_gurgles], new_allow_sound_gurgles != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_gurgles = new_allow_sound_gurgles
			else if(belly != null)
				belly.allow_sound_gurgles = !belly.allow_sound_gurgles
			return TRUE
		if("changeSoundMoveCreaks")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_move_creaks = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_move_creaks], new_allow_sound_move_creaks != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_move_creaks = new_allow_sound_move_creaks
			else if(belly != null)
				belly.allow_sound_move_creaks = !belly.allow_sound_move_creaks
			return TRUE
		if("changeSoundMoveSloshes")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_move_sloshes = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_move_sloshes], new_allow_sound_move_sloshes != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_move_sloshes = new_allow_sound_move_sloshes
			else if(belly != null)
				belly.allow_sound_move_sloshes = !belly.allow_sound_move_sloshes
			return TRUE
		if("changeMaxsize")
			var/new_maxsize = text2num(params["newMaxsize"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_maxsize], new_maxsize)
				wrote_prefs = TRUE
				if(new_maxsize != belly?.maxsize && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.maxsize = new_maxsize
			else if(belly != null)
				belly.maxsize = new_maxsize
			return TRUE
		if("changeBaseCosmetic")
			var/new_base_size_cosmetic = text2num(params["newBaseCosmetic"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_base], new_base_size_cosmetic)
				wrote_prefs = TRUE
				if(new_base_size_cosmetic != belly?.base_size_cosmetic && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.base_size_cosmetic = new_base_size_cosmetic
			else if(belly != null)
				belly.base_size_cosmetic = new_base_size_cosmetic
			return TRUE
		if("changeBaseFull")
			var/new_base_size_full = text2num(params["newBaseFull"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_full], new_base_size_full)
				wrote_prefs = TRUE
				if(new_base_size_full != belly?.base_size_full && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.base_size_full = new_base_size_full
			else if(belly != null)
				belly.base_size_full = new_base_size_full
			return TRUE
		if("changeBaseStuffed")
			var/new_base_size_stuffed = text2num(params["newBaseStuffed"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_stuffed], new_base_size_stuffed)
				wrote_prefs = TRUE
				if(new_base_size_stuffed != belly?.base_size_stuffed && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.base_size_stuffed = new_base_size_stuffed
			else if(belly != null)
				belly.base_size_stuffed = new_base_size_stuffed
			return TRUE
		if("changePredMode")
			var/new_pred_mode = params["newPredMode"]
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/choiced/erp_bellyquirk_pred_pref], new_pred_mode)
				wrote_prefs = TRUE
				if(new_pred_mode != belly?.pred_mode && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.pred_mode = new_pred_mode
			else if(belly != null)
				belly.pred_mode = new_pred_mode
			return TRUE
		if("changeEndoSize")
			var/new_endo_size = text2num(params["newEndoSize"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_endo], new_endo_size)
				wrote_prefs = TRUE
				if(new_endo_size != belly?.endo_size && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.endo_size = new_endo_size
			else if(belly != null)
				belly.endo_size = new_endo_size
			return TRUE
		if("changePreyMode")
			var/new_prey_mode = params["newPreyMode"]
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/choiced/erp_vore_prey_pref], new_prey_mode)
				wrote_prefs = TRUE
			// in-round prey mode hasn't yet been implemented
			/*	if(new_prey_mode != prey_mode)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						prey_mode = new_prey_mode
			else
				prey_mode = new_prey_mode*/
			return TRUE
		// === GLOBAL PREFS BREAKER ===
		if("changeGlobalSoundGroans")
			var/new_global_sound_groans = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_groans) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_groans], new_global_sound_groans != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalSoundGurgles")
			var/new_global_sound_gurgles = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_gurgles) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_gurgles], new_global_sound_gurgles != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalSoundMoveCreaks")
			var/new_global_sound_move_creaks = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_creaks) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_move_creaks], new_global_sound_move_creaks != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalSoundMoveSloshes")
			var/new_global_sound_move_sloshes = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_sloshes) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_move_sloshes], new_global_sound_move_sloshes != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalVisibility")
			var/new_visibility = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly], new_visibility != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalMaxsize")
			var/new_maxsize = text2num(params["newMaxsize"])
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_belly_maxsize], new_maxsize)
			wrote_prefs = TRUE
			return TRUE

	if(wrote_prefs == TRUE)
		get_assoc_client(user).prefs.save_preferences()
