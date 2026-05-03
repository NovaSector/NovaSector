/obj/item/belly_function
	name = "bwelly"
	desc = "You shouldn't see this, yell at an admin!!"

	icon_state = "bwelly"
	base_icon_state = "belly"
	icon = 'modular_nova/modules/tums/icons/helpers.dmi'
	worn_icon_state = "haha-no"
	worn_icon = 'modular_nova/modules/tums/icons/bellies.dmi'
	/// Worn icon used for XL sizes that require a 64x64 sprite.
	var/icon/worn_icon_64x ='modular_nova/modules/tums/icons/bellies_64x.dmi'
	worn_icon_teshari ='modular_nova/modules/tums/icons/bellies_teshari.dmi'
	/// Worn icon used for XL sizes on a teshari that require a 64x64 sprite.
	var/icon/worn_icon_teshari_64x ='modular_nova/modules/tums/icons/bellies_teshari_64x.dmi'

	w_class = WEIGHT_CLASS_TINY
	color = "#ffffff"

	/// Whether or not to use the skintone spritesheet.
	var/use_skintone = FALSE
	/// Bespoke icons used for skintone bellies.  No teshi subvariant as of yet as it's PROBABLY unneeded.
	var/icon/skintone_worn_icon = 'modular_nova/modules/tums/icons/skintone_bellies.dmi'
	var/icon/skintone_worn_icon_64x ='modular_nova/modules/tums/icons/skintone_bellies_64x.dmi'

	/// Whether or not to bump the alpha down to 155 to match the standard body alpha of slimepeople.
	var/use_slime_alpha = FALSE

	actions_types = list(
		/datum/action/item_action/belly_menu/access,
	)
	var/list/datum/action/item_action/belly_menu/belly_acts

	var/mob/living/carbon/human/lastuser = null

	/// Master tracker for guests.
	var/list/mob/living/carbon/human/nommeds = null
	/// Sizes for nommed guests (mob:number)
	var/list/nommed_sizes = null
	/// Gasmixes for nommed guests (mob:/datum/gas_mixture)
	var/list/datum/gas_mixture/nommed_gasmixes = null
	/// Escape helper actions for nommed guests (mob:/datum/action)
	var/list/datum/action/item_action/belly_menu/escape/escape_helpers = null
	/// Total combined size from all guests.
	var/total_endo_size = 0

	/// Base-size for calculating fullness/size with one occupant.
	var/endo_size = 1000
	/// Size modifier applied to ALL belly size providers.  Good for making a 3ft teshi round out faster than a 12ft oversized shork.
	var/sizemod = 1
	/// Size modifier applied to automatic stuffing calculation from get_fullness.  Good for reducing its impact when Botany is nutrimentmaxxing.
	var/sizemod_autostuffed = 1
	/// Size modifier applied to the sound system.  Multiplicative with autostuffed but NOT base sizemod.
	var/sizemod_audio = 1

	/// Maximum size for this belly to reach.
	var/maxsize = 16
	/// Baseline sizes that apply purely-cosmetic bellysize (e.g, preg/egg)
	var/base_size_cosmetic = 0
	/// Baseline endosoma size (causes creaks and such), stacks with total_endo_size
	var/base_size_full = 0
	/// Baseline actively-gurgly size for being stuffed, stacks with size gained from nutrition if applicable
	var/base_size_stuffed = 0
	/// Sound preferences for full creaks & groans (size_fullness + size_stuffed)
	var/allow_sound_groans = TRUE
	/// Sound preferences for stuffed gurgles and churns (size_fullness)
	var/allow_sound_gurgles = TRUE
	/// Sound preferences for heavier creaks, groans & gwrbles triggered by movement (size_fullness + size_stuffed)
	var/allow_sound_move_creaks = TRUE
	/// Sound preferences for active sloshes triggered by movement (size_stuffed)
	var/allow_sound_move_sloshes = TRUE
	/// Pred preferences.  QUERY throws an alert before trying, ALWAYS will always try pending on target prefs.
	var/pred_mode = "Query"

	/// Sound cooldown for fullness creaks & groans (allow_sound_groans)
	var/full_cooldown = 6
	/// Sound cooldown for minor gurgles & burbles (allow_sound_gurgles)
	var/stuff_minor_cooldown= 3
	/// Sound cooldown for major gurgles, growls & churns (allow_sound_gurgles, high size_stuffed)
	var/stuff_major_cooldown= 9
	/// Sound cooldown for movement-induced creaks & gwrbles (allow_sound_move_creaks)
	var/move_creak_cooldown = 6
	/// Sound cooldown for
	var/move_slosh_cooldown = 6

	/// Total fullness size for sounds (size_fullness + size_stuffed), including guests, nutrition, and base sizes
	var/total_fullness = 0
	/// Total stuffed fullness for sounds (size_stuffed), including nutrition & base stuffed size
	var/stuffed_temp = 0

	/// Used to avoid spamming sprite icon state changes.
	var/last_size = 0
	/// last_size but not clamped to an int, mostly a debug helper.
	var/current_size_unclamped = 0
	/// Working state tracker for generating south overlays, used to track if overlays are active; null if they aren't
	var/image/overlay_south
	/// Working state tracker for generating north overlays
	var/image/overlay_north
	/// Working state tracker for generating horizontal overlays
	var/image/overlay_horizontal
	/// All south overlays, used for cutting in remove_from_user or recalculation of overlays.
	var/list/image/overlay_south_all = list()
	/// All north overlays, used for cutting in remove_from_user or recalculation of overlays.
	var/list/image/overlay_north_all = list()
	/// All horizontal overlays, used for cutting in remove_from_user or recalculation of overlays.
	var/list/image/overlay_horizontal_all = list()

	// TODO: maybe migrate these to a GLOB at some point?  we shall see

	/// Full creaks, groans & similar (allow_sound_groans, full_cooldown)
	var/static/list/full_sounds = list("modular_nova/modules/tums/sounds/Creaks/Creak1.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak2.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak3.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak4.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak5.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak6.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak7.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak8.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak9.ogg", "modular_nova/modules/tums/sounds/Creaks/Creak10.ogg")

	/// Low-level stuffed digestion noises (allow_sound_gurgles, stuff_minor_cooldown)
	var/static/list/stuff_minor = list("modular_nova/modules/tums/sounds/Gurgles/Gurgle1.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle2.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle3.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle4.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle5.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle6.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle7.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle8.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle9.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle10.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle11.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle12.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle13.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle14.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle15.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle16.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle17.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle18.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle19.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle20.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle21.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle22.ogg", "modular_nova/modules/tums/sounds/Gurgles/Gurgle23.ogg")

	/// Noisier gurgles and churns for being very stuffed (allow_sound_gurgles, stuff_major_cooldown)
	var/static/list/stuff_major = list("modular_nova/modules/tums/sounds/Churns/Churn1.ogg", "modular_nova/modules/tums/sounds/Churns/Churn2.ogg", "modular_nova/modules/tums/sounds/Churns/Churn3.ogg", "modular_nova/modules/tums/sounds/Churns/Churn4.ogg", "modular_nova/modules/tums/sounds/Churns/Churn5.ogg", "modular_nova/modules/tums/sounds/Churns/Churn6.ogg", "modular_nova/modules/tums/sounds/Churns/Churn7.ogg", "modular_nova/modules/tums/sounds/Churns/Churn8.ogg", "modular_nova/modules/tums/sounds/Churns/Churn9.ogg")

	/// Movement noise for a full but not sloshy tummy (allow_sound_move_creaks, move_creak_cooldown)
	var/static/list/move_creaks = list("modular_nova/modules/tums/sounds/Growls/Growl1.ogg", "modular_nova/modules/tums/sounds/Growls/Growl2.ogg", "modular_nova/modules/tums/sounds/Growls/Growl3.ogg", "modular_nova/modules/tums/sounds/Growls/Growl4.ogg", "modular_nova/modules/tums/sounds/Growls/Growl5.ogg", "modular_nova/modules/tums/sounds/Growls/Growl6.ogg")

	/// Movement noise for an overfull, stuffed tummy (allow_sound_move_sloshes, move_slosh_cooldown)
	var/static/list/slosh_sounds = list("modular_nova/modules/tums/sounds/Sloshes/BigSlosh1.ogg", "modular_nova/modules/tums/sounds/Sloshes/BigSlosh2.ogg", "modular_nova/modules/tums/sounds/Sloshes/BigSlosh3.ogg", "modular_nova/modules/tums/sounds/Sloshes/BigSlosh4.ogg", "modular_nova/modules/tums/sounds/Sloshes/Slosh1.ogg", "modular_nova/modules/tums/sounds/Sloshes/Slosh2.ogg")

	/// Live editable layers in case things go scrungy.
	var/hori_layer = UNIFORM_LAYER
	var/south_layer = UNIFORM_LAYER
	var/north_layer = BODY_BEHIND_LAYER

/// Sanity checks & required edits to make the belly action get properly granted.
/obj/item/belly_function/item_action_slot_check(slot, mob/user, datum/action/action)
	var/datum/quirk/belly/bellyquirk
	var/obj/item/belly_function/a_belly
	var/mob/living/carbon/human/source = user
	if(!istype(source))
		return FALSE
	bellyquirk = locate() in source.quirks
	if(bellyquirk != null)
		a_belly = bellyquirk.the_bwelly
	if(a_belly == src)
		return TRUE
	return FALSE

/// Handles all sanity checks during destruction.
/// Frees everyone, tries to avoid any hanging refs, destroys acts, etc.
/obj/item/belly_function/Destroy()
	. = ..()
	for(var/mob/living/carbon/human/nommed in nommeds)
		free_target(nommed)
	LAZYNULL(nommeds)
	QDEL_LAZYLIST(nommed_sizes)
	QDEL_LAZYLIST(nommed_gasmixes)
	QDEL_LAZYLIST(belly_acts)
	QDEL_LAZYLIST(escape_helpers)

/// Signal handler that allows for the various movement/jostling sounds to play.
/obj/item/belly_function/proc/on_step()
	SIGNAL_HANDLER
	if(total_fullness >= 3)
		move_creak_cooldown = move_creak_cooldown - (0.05 * total_fullness)
	if(stuffed_temp >= 2)
		move_slosh_cooldown = move_slosh_cooldown - (0.05 * (stuffed_temp + (total_fullness/10)))

/// Secondary menu that, for now, is only used for releasing people.
/// In the future this is likely where per-guest size edits will go...
/// ...alongside the ability to do certain interactions, like open a target's Ctrl-Shift-Click menu.
/obj/item/belly_function/proc/release_menu(mob/user)
	if(LAZYLEN(nommeds) > 0)
		var/opt_list = list()

		for(var/mob/living/carbon/human/nommed in nommeds)
			opt_list["Release [nommed.name]"] = nommed

		var/release_target = tgui_input_list(user, "Release ", "Belly Control", opt_list)
		if(release_target)
			var/mob/living/carbon/human/nommed = opt_list[release_target]
			if(istype(nommed))
				free_target(nommed)

/// Helper function that handles everything needed to free someone & do all associated sanity checks.
/obj/item/belly_function/proc/free_target(mob/living/carbon/human/nommed)
	nommed.forceMove(drop_location())
	LAZYREMOVE(nommeds, nommed)
	LAZYREMOVE(nommed_sizes, nommed)
	LAZYREMOVE(nommed_gasmixes, nommed)
	var/datum/action/item_action/belly_menu/escape/helper = LAZYACCESS(escape_helpers, nommed)
	if(helper in belly_acts)
		LAZYREMOVE(belly_acts, helper)
	helper.Remove(remove_from = nommed)
	LAZYREMOVE(escape_helpers, nommed)
	recalculate_guest_sizes()

/// The great wall of ingame config options.
/// This mirrors what you can access from the quirk prefs, but able to be edited ingame.
/obj/item/belly_function/proc/config_menu(mob/living/user)
	var/opt_list = list("Edit Settings")
	var/list/mob/living/carbon/human/extra_size_list = list()

	for(var/mob/living/carbon/human/nommed in nommeds)
		extra_size_list["Set Size of [nommed.name]"] = nommed

	for(var/text in extra_size_list)
		opt_list += text

	var/adjustment_mode = tgui_input_list(user, "Select ", "Belly Control", opt_list)
	switch(adjustment_mode)
		if("Edit Settings")
			GLOB.erp_belly_prefshelper.ui_interact(user)
		else
			if(adjustment_mode in extra_size_list)
				var/temp_size = tgui_input_number(user, "What size do you want [extra_size_list[adjustment_mode].name] to be?  (0.0-infinity, 1000 is typically same-sizeish)", "Endo Size")
				if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
					return
				LAZYSET(nommed_sizes, extra_size_list[adjustment_mode], temp_size)
				recalculate_guest_sizes()
			else
				return

/// Helper for activating the belly.
/// Culls old appearances as needed and registers signals & actions.
/obj/item/belly_function/proc/apply_to_user(mob/living/carbon/human/user)
	if(lastuser != user && overlay_south != null && lastuser != null)
		do_alt_appearance(lastuser, TRUE, last_size)
		UnregisterSignal(lastuser, COMSIG_GENERAL_STEP_ACTION)
		UnregisterSignal(lastuser, COMSIG_QDELETING)
		lastuser = null
	if(!istype(user))
		return
	lastuser = user
	for(var/datum/action/action as anything in actions)
		give_item_action(action, user, null)
	RegisterSignal(lastuser, COMSIG_GENERAL_STEP_ACTION, PROC_REF(on_step), TRUE)
	RegisterSignal(lastuser, COMSIG_QDELETING, PROC_REF(on_user_deleted), TRUE)

/// Simple little signal to avoid hanging onto lastuser & clear things if this gets nullspaced.
/// Part of the CI Sacrifice Suite.
/obj/item/belly_function/proc/on_user_deleted()
	remove_from_user(lastuser)
	if(!QDELETED(src))
		qdel(src)

/// Strip the action & appearance from a user if needed.
/// This is non-destructive; the quirk can be temporarily disabled by pref changes, body swaps, etc to reduce prefbreak risk.
/// This means that when the user is back in their body & in a valid state, the quirk re-enables itself nondestructively.
/obj/item/belly_function/proc/remove_from_user(mob/user)
	for(var/datum/action/action_item_has as anything in actions)
		action_item_has.Remove(user)
	if(overlay_south != null)
		do_alt_appearance(user, TRUE, last_size)
	lastuser = null

/// Helper function that recalculates the total endo size from nommed guests.
/obj/item/belly_function/proc/recalculate_guest_sizes()
	total_endo_size = 0
	for(var/nommed_friendo in nommeds)
		total_endo_size += LAZYACCESS(nommed_sizes, nommed_friendo)

/// This is where the magic happens for calculating sizes, triggering noise, etc.
/obj/item/belly_function/proc/belly_process(seconds_per_tick)
	/// Sanity checks and user acquisition happen here.
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		user = lastuser
	if(!istype(user))
		lastuser = null
		return

	/// Fullness calculation formula.  This is based off sphere volume to produce a nice exponential curve.
	/// pow(pow(size, 1.5) / (4/3) / PI, 1/3)

	var/guest_temp = base_size_full + total_endo_size

	/// Baseline @ 1x: 1250 nutrition.
	/// Size 16 @ 1x: 17890 nutrition.
	/// 1 unit of Nutriment counts as about 22.5 nutrition.
	/// Exact volume gained from reagents varies due to varying metabolism rates & other things.
	/// get_fullness is very scrungly.
	var/stuffed_temp_orig = (user.get_fullness() - (user.nutrition * 0.6) - 500) * sizemod_autostuffed
	if(stuffed_temp_orig < 0)
		stuffed_temp_orig = 0
	stuffed_temp_orig += base_size_stuffed

	/// Calculate the baseline, nonexponential sizes...
	var/total_fullness_orig = guest_temp + stuffed_temp_orig
	var/total_size_orig = total_fullness_orig + base_size_cosmetic
	var/total_size = total_size_orig / 10 * sizemod

	/// Then calculate the sprite size using the volume equation above.
	total_size = (((total_size)**1.5) / (4/3) / PI)**(1/3)
	current_size_unclamped = total_size
	/// Finally, pick a sprite size to use & apply it.
	var/spr_size = FLOOR(total_size, 1)
	if(spr_size > 16)
		spr_size = 16
	if(spr_size > maxsize)
		spr_size = maxsize
	if(spr_size < 0)
		spr_size = 0
	update_icon_state()
	update_icon()
	if(last_size != spr_size)
		refresh_overlays(user, spr_size)
		last_size = spr_size

	/// Calculations for sound sizes here.  The divisor of 10 is used to stop these from getting obscenely loud.
	total_fullness = total_fullness_orig / 10 * sizemod_audio
	stuffed_temp = stuffed_temp_orig / 10 * sizemod_audio
	/// Apply the volume equation.
	total_fullness = (((total_fullness)**1.5) / (4/3) / PI)**(1/3)
	stuffed_temp = (((stuffed_temp)**1.5) / (4/3) / PI)**(1/3)
	/// And finally apply some minor nonexponential additions.
	/// Just because it doesn't increase radius much doesn't mean it's not adding volume.
	total_fullness = (total_fullness/3) + (total_fullness_orig / 1000)
	stuffed_temp = (stuffed_temp/3) + (stuffed_temp_orig / 1000)

	/// Play random sounds as applicable.
	if(total_fullness >= 1 && allow_sound_groans)
		full_cooldown = full_cooldown - (seconds_per_tick * total_fullness)
		if(full_cooldown < 0)
			full_cooldown = rand(6, 36)
			playsound_if_pref(user, pick(full_sounds), min(10 + round(total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_groans)
	if(stuffed_temp >= 1 && allow_sound_gurgles)
		stuff_minor_cooldown= stuff_minor_cooldown- (seconds_per_tick * (stuffed_temp + (total_fullness/5)))
		if(stuff_minor_cooldown< 0)
			stuff_minor_cooldown= rand(3, 6)
			playsound_if_pref(user, pick(stuff_minor), min(12 + round(total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_gurgles)
	if(stuffed_temp >= 3 && allow_sound_gurgles)
		stuff_major_cooldown= stuff_major_cooldown- (seconds_per_tick * (stuffed_temp + (total_fullness/10)))
		if(stuff_major_cooldown< 0)
			stuff_major_cooldown= rand(9, 60)
			playsound_if_pref(user, pick(stuff_major), min(20 + round(total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_gurgles)
	if(move_creak_cooldown < 0 && allow_sound_move_creaks)
		move_creak_cooldown = rand(15, 60)
		playsound_if_pref(user, pick(move_creaks), min(10 + round(total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_creaks)
	if(move_slosh_cooldown < 0 && allow_sound_move_sloshes)
		move_slosh_cooldown = rand(15, 60)
		playsound_if_pref(user, pick(slosh_sounds), min(20 + round(total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_sloshes)

/// This is what provides healthy air for occupants to breathe.
/obj/item/belly_function/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	if(lifeform_inside_me in nommed_gasmixes)
		if(breath_request <= 0)
			return null
		return nommed_gasmixes[lifeform_inside_me].copy()
	else
		return ..()
