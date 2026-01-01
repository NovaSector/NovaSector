GLOBAL_LIST_EMPTY(aaerp_maskcache)

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
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
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
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
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
