//==MIRROR OF ALT_APPEARANCE/BASIC==
/datum/atom_hud/alternate_appearance/erp
	var/atom/target
	/// The final mixdown image including layered overlays via BLEND_INSET_OVERLAY.
	var/image/image
	/// The original image that was provided for this, before edits for BLEND_INSET_OVERLAY support.
	var/image/original_image
	/// The base key for this ERP part's series of appearances.
	var/base_key = ""
	/// The size of this ERP part.  Bellies, et al.
	var/size

	uses_global_hud_category = FALSE
	/// List of hooked signals, as per basic alt_appearances.
	var/list/signals_registering = list(
		COMSIG_MOB_ANTAGONIST_REMOVED,
		COMSIG_MOB_GHOSTIZED,
		COMSIG_MOB_MIND_TRANSFERRED_INTO,
		COMSIG_MOB_MIND_TRANSFERRED_OUT_OF,
	)

/datum/atom_hud/alternate_appearance/erp/New(key, image/I, options = AA_TARGET_SEE_APPEARANCE, in_target, in_basekey, in_size)
	target = in_target
	base_key = in_basekey
	size = in_size
	..()
	transfer_overlays = options & AA_MATCH_TARGET_OVERLAYS
	image = I
	original_image = image(I)
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

/datum/atom_hud/alternate_appearance/erp/mobShouldSee(mob/M)
	if(target == null)
		return FALSE
	if(!islist(target.alternate_appearances)) //what
		return FALSE
	var/key = "[base_key][(size+1)]"
	if(isnull(key)) //*what*
		return FALSE
	var/maxsize = get_max_size(M)
	//if we're already above the viewer's maximum size pref, return false
	if(size > maxsize)
		return FALSE
	//there is a higher size to render, but...
	if(target.alternate_appearances[key] != null)
		//if it's too big for the user we won't render, so don't layer
		if(size + 1 > maxsize)
			return TRUE
		//otherwise hide this to avoid wasted draw calls
		return FALSE
	else
		//this is the top layer and nothing else says no: go ahead and render
		return TRUE

/// REMEMBER TO OVERRIDE THIS IN YOUR IMPLEMENTATIONS!
/datum/atom_hud/alternate_appearance/erp/proc/get_max_size(mob/M)
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

/datum/atom_hud/alternate_appearance/erp/add_atom_to_hud(atom/A)
	LAZYINITLIST(A.hud_list)
	A.hud_list[appearance_key] = image
	. = ..()

/datum/atom_hud/alternate_appearance/erp/remove_atom_from_hud(atom/A)
	. = ..()
	LAZYREMOVE(A.hud_list, appearance_key)
	A.set_hud_image_inactive(appearance_key)
	if(. && !QDELETED(src))
		qdel(src)

/datum/atom_hud/alternate_appearance/erp/copy_overlays(atom/other, cut_old)
	var/list/cached_other = target.overlays
	if(length(image.overlays) != length(cached_other) + 1)
		image.overlays -= image.overlays
		for(var/an_overlay in cached_other)
			var/image/over = image(an_overlay)
			over.blend_mode = BLEND_INSET_OVERLAY
			over.pixel_x -= image.pixel_x
			over.pixel_y -= image.pixel_y
			if(an_overlay:layer >= image.layer)
				image.overlays += over
		image.overlays += original_image



//==ACTUAL ALTERNATE APPEARANCE FOR BELLIES==
/datum/atom_hud/alternate_appearance/erp/belly/get_max_size(mob/M)
	return M.client?.prefs?.read_preference(/datum/preference/numeric/erp_belly_maxsize)

/datum/atom_hud/alternate_appearance/erp/belly/mobShouldSee(mob/M)
	if((M.client?.prefs?.read_preference(/datum/preference/toggle/erp/belly) == TRUE))
		return ..()
	return FALSE



//==BREAKER FOR MAIN PREFERENCES==
/datum/preference/toggle/erp/belly_master
	savefile_key = "erp_enable_belly"

/datum/preference/toggle/erp/belly
	savefile_key = "erp_belly_base"
	//This WAS just a helper but now acts as the master pref for belly visibility.

/datum/preference/toggle/erp/belly/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/erp/belly_master)

/datum/preference/toggle/erp/belly/deserialize(input, datum/preferences/preferences)
	if(!preferences.read_preference(/datum/preference/toggle/erp/belly_master))
		return FALSE
	return ..()

/datum/preference/toggle/erp/belly/sound_groans
	savefile_key = "erp_belly_sound_groans"

/datum/preference/toggle/erp/belly/sound_gurgles
	savefile_key = "erp_belly_sound_gurgles"

/datum/preference/toggle/erp/belly/sound_move_creaks
	savefile_key = "erp_belly_sound_move_creaks"

/datum/preference/toggle/erp/belly/sound_move_sloshes
	savefile_key = "erp_belly_sound_move_sloshes"

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

	return preferences.read_preference(/datum/preference/toggle/erp/belly_master)

/datum/preference/choiced/erp_vore_prey_pref/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

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

	return preferences.read_preference(/datum/preference/toggle/erp/belly)


//==BREAKER FOR QUIRK PREFERENCES==
/datum/quirk/belly
	name = "Big Boned"
	desc = "Your midriff just stands out more than others'..."
	icon = FA_ICON_PERSON_PREGNANT
	value = 0
	mob_trait = TRAIT_PREDATORY
	gain_text = span_notice("You feel like you could eat a horse!")
	lose_text = span_danger("You feel uncomfortable about the sensation of fullness again.")
	medical_record_text = "Patient's midriff is well defined." //Why does QUIRK_HIDE_FROM_SCAN not cut this from medical records too?
	quirk_flags = QUIRK_PROCESSES | QUIRK_CHANGES_APPEARANCE | QUIRK_HIDE_FROM_SCAN
	maximum_process_stat = null
	erp_quirk = TRUE
	//We need this to handle processing.
	var/obj/item/belly_function/the_bwelly

/datum/quirk/belly/add_unique(client/client_source)
	the_bwelly = new /obj/item/belly_function(quirk_holder)
	if(client_source == null)
		//What the fuck?
		return
	if(client_source.prefs == null)
		//Damn you, CI suite.
		return

	//color
	var/the_color = client_source.prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) //this makes the (potentially dangerous) assumption this is valid
	if(the_color == null)
		the_color = "#FFFFFF"
	the_bwelly.color = the_color
	//skintone toggle
	var/use_skintone = client_source.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone)
	if(use_skintone == null)
		use_skintone = FALSE
	the_bwelly.use_skintone = use_skintone

	//size modifier
	var/sizemod = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod)
	if(sizemod == null)
		sizemod = 1
	the_bwelly.sizemod = sizemod
	//size modifier - audio
	var/sizemod_audio = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_audio)
	if(sizemod_audio == null)
		sizemod_audio = 1
	the_bwelly.sizemod_audio = sizemod_audio
	//maximum display size
	var/sizemod_max = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_maxsize)
	if(sizemod_max == null)
		sizemod_max = 16
	the_bwelly.maxsize = sizemod_max

	//base cosmetic size
	var/size_base = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_base)
	if(size_base == null)
		size_base = 0
	the_bwelly.base_size_cosmetic = size_base
	//endosoma size
	var/size_endo = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_endo)
	if(size_endo == null)
		size_endo = 0
	the_bwelly.base_size_endo = size_endo;
	//stuffed size
	var/size_stuffed = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_stuffed)
	if(size_stuffed == null)
		size_stuffed = 0
	the_bwelly.base_size_stuffed = size_stuffed

	//sound toggle: full groans
	var/allow_groans = client_source.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans)
	if(allow_groans == null)
		allow_groans = FALSE
	the_bwelly.allow_sound_groans = allow_groans
	//sound toggle: stuffed gurgles
	var/allow_gurgles = client_source.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles)
	if(allow_gurgles == null)
		allow_gurgles = FALSE
	the_bwelly.allow_sound_gurgles = allow_gurgles
	//sound toggle: full creaks when moving
	var/allow_move_creaks = client_source.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks)
	if(allow_move_creaks == null)
		allow_move_creaks = FALSE
	the_bwelly.allow_sound_move_creaks = allow_move_creaks
	//sound toggle: stuffed sloshes when moving
	var/allow_move_sloshes = client_source.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes)
	if(allow_move_sloshes == null)
		allow_move_sloshes = FALSE
	the_bwelly.allow_sound_move_sloshes = allow_move_sloshes

	//pred prefs mode
	var/pred_prefs = client_source.prefs.read_preference(/datum/preference/choiced/erp_bellyquirk_pred_pref)
	if(pred_prefs == null)
		pred_prefs = "Query"
	the_bwelly.pred_mode = pred_prefs

	//manually run add() for dummies so we get preview
	if(isdummy(quirk_holder))
		add()

/datum/quirk/belly/add()
	. = ..()
	if(the_bwelly != null)
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
		the_bwelly.loc = quirk_holder
		the_bwelly.apply_to_user(quirk_holder)
		the_bwelly.belly_process(0)

//Redundance, just in case add errors out.
/datum/quirk/belly/post_add()
	. = ..()
	if(the_bwelly != null)
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
		the_bwelly.loc = quirk_holder
		the_bwelly.apply_to_user(quirk_holder)
		the_bwelly.belly_process(0)

/datum/quirk/belly/process(seconds_per_tick)
	if(the_bwelly == null)
		return
	//if something has gone catastrophically wrong, stash the helper in pseudo-nullspace before anyone can see it
	if(the_bwelly.loc != quirk_holder || quirk_holder == null)
		the_bwelly.loc = src
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
	//search for the client connected to the mob- and if it doesn't have the quirk, do NOT keep treating this as active
	if(quirk_holder?.client?.prefs)
		if(!(src.name in quirk_holder.client.prefs.all_quirks))
			if(the_bwelly.loc != src)
				the_bwelly.loc = src
				if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
					the_bwelly.remove_from_user(the_bwelly.lastuser)
		else
			//if the helper was nullspaced or otherwise messed with, reapply it to the associated mob once things are clear
			if(the_bwelly.loc != quirk_holder && quirk_holder != null)
				the_bwelly.loc = quirk_holder
				the_bwelly.apply_to_user(quirk_holder)
	//if the helper is where it should be, only then do we actually let it process
	if(the_bwelly.loc == quirk_holder)
		the_bwelly.belly_process(seconds_per_tick)

/datum/quirk/belly/remove()
	. = ..()
	the_bwelly.loc = src
	if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
		the_bwelly.remove_from_user(the_bwelly.lastuser)

/datum/quirk/belly/Destroy()
	. = ..()
	qdel(the_bwelly)

/datum/preference/color/erp_bellyquirk_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_color"

/datum/preference/color/erp_bellyquirk_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/erp_bellyquirk_skintone
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_skintone"
	default_value = FALSE

/datum/preference/toggle/erp_bellyquirk_skintone/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

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
	return 0

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

/datum/preference/toggle/erp_bellyquirk_groans
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_groans"

/datum/preference/toggle/erp_bellyquirk_groans/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/erp_bellyquirk_gurgles
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_gurgles"

/datum/preference/toggle/erp_bellyquirk_gurgles/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/erp_bellyquirk_move_creaks
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_move_creaks"

/datum/preference/toggle/erp_bellyquirk_move_creaks/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/erp_bellyquirk_move_sloshes
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_bellyquirk_sound_move_sloshes"

/datum/preference/toggle/erp_bellyquirk_move_sloshes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

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

	return preferences.read_preference(/datum/preference/toggle/erp/belly_master)

/datum/preference/choiced/erp_bellyquirk_pred_pref/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

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



/datum/quirk_constant_data/stuffable
	associated_typepath = /datum/quirk/belly

/datum/quirk_constant_data/stuffable/New()
	customization_options = list(/datum/preference/color/erp_bellyquirk_color, /datum/preference/toggle/erp_bellyquirk_skintone,
	/datum/preference/numeric/erp_bellyquirk_sizemod, /datum/preference/numeric/erp_bellyquirk_sizemod_audio, /datum/preference/numeric/erp_bellyquirk_maxsize,
	/datum/preference/numeric/erp_bellyquirk_size_base, /datum/preference/numeric/erp_bellyquirk_size_endo, /datum/preference/numeric/erp_bellyquirk_size_stuffed,
	/datum/preference/toggle/erp_bellyquirk_groans, /datum/preference/toggle/erp_bellyquirk_gurgles, /datum/preference/toggle/erp_bellyquirk_move_creaks, /datum/preference/toggle/erp_bellyquirk_move_sloshes,
	/datum/preference/choiced/erp_bellyquirk_pred_pref)

	return ..()



// shunting this in here to avoid merge conflicts
/obj/item/organ/tongue/teshari/Initialize(mapload)
	. = ..()
	disliked_foodtypes = disliked_foodtypes & (!GRAIN)
