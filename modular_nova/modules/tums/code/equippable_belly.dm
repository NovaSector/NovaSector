/obj/item/belly_function
	name = "bwelly"
	desc = "You shouldn't see this, yell at an admin!!"
	icon_state = "bwelly"
	base_icon_state = "belly"
	icon = 'modular_nova/modules/tums/icons/items.dmi'
	worn_icon_state = "haha-no" //wish us luck
	worn_icon = 'modular_nova/modules/tums/icons/bellies.dmi'
	var/icon/worn_icon_64x ='modular_nova/modules/tums/icons/bellies_64x.dmi'
	worn_icon_teshari ='modular_nova/modules/tums/icons/bellies_teshari.dmi'
	var/icon/worn_icon_teshari_64x ='modular_nova/modules/tums/icons/bellies_teshari_64x.dmi'
	//skintone variants
	var/use_skintone = FALSE
	var/icon/skintone_worn_icon = 'modular_nova/modules/tums/icons/skintone_bellies.dmi'
	var/icon/skintone_worn_icon_64x ='modular_nova/modules/tums/icons/skintone_bellies_64x.dmi'
	w_class = WEIGHT_CLASS_TINY
	color = "#ffffff"

	actions_types = list(
		/datum/action/item_action/belly_menu/access,
	)
	var/list/datum/action/item_action/belly_menu/belly_acts = list()

	var/mob/living/carbon/human/lastuser = null

	/// Tracks whoever got gobbled.
	/*var/mob/living/carbon/human/nommed
	var/nommed_size = 0
	var/mob/living/carbon/human/nommed_2
	var/nommed_size_2 = 0*/
	var/list/mob/living/carbon/human/nommeds = list()
	var/list/nommed_sizes = list()
	var/list/nommed_gasmixes = list()
	var/list/datum/action/item_action/belly_menu/escape/escape_helpers = list()
	var/total_endo_size = 0

	/// Base-size for calculating fullness/size with one occupant.
	var/endo_size = 1000
	/// Size modifier applied to ALL belly size providers.  Good for making a 3ft teshi round out faster than a 12ft oversized shork.
	var/sizemod = 1
	var/sizemod_audio = 1
	var/maxsize = 16
	/// Baseline sizes that apply purely-cosmetic bellysize (e.g, preg/egg), a baseline endosoma size (causes creaks and such), and a baseline actively-gwurgly size for being stuffed without actually being stuffed.
	var/base_size_cosmetic = 0
	var/base_size_endo = 0
	var/base_size_stuffed = 0
	/// Sound preferences.
	var/allow_sound_groans = TRUE
	var/allow_sound_gurgles = TRUE
	var/allow_sound_move_creaks = TRUE
	var/allow_sound_move_sloshes = TRUE
	/// Pred preferences.
	var/pred_mode = "Query"

	/// Sound cooldowns.
	var/full_cooldown = 6
	var/stuffLo_cooldown = 3
	var/stuffHi_cooldown = 9
	var/moveCreak_cooldown = 6
	var/moveSlosh_cooldown = 6

	var/total_fullness = 0
	var/stuffed_temp = 0

	/// Used to avoid spamming sprite icon state changes.
	var/last_size = 0
	var/current_size_unclamped = 0
	var/last_gasmix = ""
	/// Tracks overlay images generated and used in HUDs
	var/image/overlay_south
	var/image/overlay_north
	var/image/overlay_hori
	/// Tracks all overlays for cutting
	var/list/image/overlay_south_all = list()
	var/list/image/overlay_north_all = list()
	var/list/image/overlay_hori_all = list()

	/// Sound lists setup as local vars because we aren't spawning enough of these for memory to be a worry & this makes it easier to fix broken sound lists during gameplay
	// Used for full creaks and similar
	var/full_sounds = list("modular_nova/modules/tums/sounds/Fullness/digest (36).ogg", "modular_nova/modules/tums/sounds/Fullness/digest (47).ogg", "modular_nova/modules/tums/sounds/Fullness/Gurgle6.ogg", "modular_nova/modules/tums/sounds/Fullness/Gurgle8.ogg", "modular_nova/modules/tums/sounds/Fullness/Gurgle14.ogg", "modular_nova/modules/tums/sounds/Fullness/digest (8).ogg", "modular_nova/modules/tums/sounds/Fullness/digest (9).ogg", "modular_nova/modules/tums/sounds/Fullness/digest (13).ogg", "modular_nova/modules/tums/sounds/Fullness/digest (15).ogg", "modular_nova/modules/tums/sounds/Fullness/digest (18).ogg")
	// Low-level stuffed digestion noises
	var/stuff_minor = list("modular_nova/modules/tums/sounds/StuffMinor/digest (25).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (26).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (28).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (29).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (31).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (33).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (34).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (37).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (48).ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle1.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle2.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle3.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle9.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle10.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle11.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle12.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle13.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle15.ogg", "modular_nova/modules/tums/sounds/StuffMinor/Gurgle16.ogg", "modular_nova/modules/tums/sounds/StuffMinor/stomach-burble.ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (3).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (11).ogg", "modular_nova/modules/tums/sounds/StuffMinor/digest (17).ogg")
	// Noisier gurgles and churns for being very stuffed
	var/stuff_major = list("modular_nova/modules/tums/sounds/StuffMajor/digest_10.ogg", "modular_nova/modules/tums/sounds/StuffMajor/digest_12.ogg", "modular_nova/modules/tums/sounds/StuffMajor/digest_17.ogg", "modular_nova/modules/tums/sounds/StuffMajor/Gurgle4.ogg", "modular_nova/modules/tums/sounds/StuffMajor/Gurgle5.ogg", "modular_nova/modules/tums/sounds/StuffMajor/Gurgle7.ogg", "modular_nova/modules/tums/sounds/StuffMajor/digest_02.ogg", "modular_nova/modules/tums/sounds/StuffMajor/digest_04.ogg", "modular_nova/modules/tums/sounds/StuffMajor/digest_05.ogg", "modular_nova/modules/tums/sounds/Growls/digest (46).ogg", "modular_nova/modules/tums/sounds/Growls/growl1.ogg", "modular_nova/modules/tums/sounds/Growls/growl2.ogg", "modular_nova/modules/tums/sounds/Growls/stomach-clench.ogg", "modular_nova/modules/tums/sounds/Growls/digest (5).ogg", "modular_nova/modules/tums/sounds/Growls/digest (12).ogg")
	// Movement noise for a full but not sloshy tummy
	var/move_creaks = list("modular_nova/modules/tums/sounds/Growls/digest (5).ogg", "modular_nova/modules/tums/sounds/Growls/digest (12).ogg", "modular_nova/modules/tums/sounds/Growls/digest (46).ogg", "modular_nova/modules/tums/sounds/Growls/growl1.ogg", "modular_nova/modules/tums/sounds/Growls/growl2.ogg", "modular_nova/modules/tums/sounds/Growls/stomach-clench.ogg")
	// Movement noise for an overfull, stuffed tummy
	var/slosh_sounds = list("modular_nova/modules/tums/sounds/SloshMinor/digest (20).ogg", "modular_nova/modules/tums/sounds/SloshMinor/slurslosh.ogg", "modular_nova/modules/tums/sounds/SloshMajor/blorbsquish.ogg", "modular_nova/modules/tums/sounds/SloshMajor/walkslosh3.ogg", "modular_nova/modules/tums/sounds/SloshMajor/walkslosh4.ogg", "modular_nova/modules/tums/sounds/SloshMajor/walkslosh7.ogg")

	/// Live editable layers in case things go scrungy.
	var/hori_layer = UNIFORM_LAYER
	var/south_layer = UNIFORM_LAYER
	var/north_layer = BODY_BEHIND_LAYER

/obj/item/belly_function/item_action_slot_check(slot, mob/user, datum/action/action)
	var/datum/quirk/belly/bellyquirk
	var/obj/item/belly_function/a_belly
	var/mob/living/carbon/human/source = user
	if(!istype(source))
		return FALSE
	for(var/datum/quirk/some_quirk in source.quirks)
		bellyquirk = some_quirk
		if(istype(bellyquirk))
			break
		else
			bellyquirk = null
	if(bellyquirk != null)
		a_belly = bellyquirk.the_bwelly
	if(a_belly == src)
		return TRUE
	return FALSE

/obj/item/belly_function/Destroy()
	. = ..()
	for(var/mob/living/carbon/human/nommed in nommeds)
		free_target(nommed)
	for(var/datum/action/item_action/belly_menu/belly_act in belly_acts)
		belly_acts -= belly_act
		belly_act.Destroy()
		belly_act.my_belly = null
	belly_acts = null

/obj/item/belly_function/proc/on_step()
	SIGNAL_HANDLER
	if(total_fullness >= 3)
		moveCreak_cooldown = moveCreak_cooldown - (0.05 * total_fullness)
	if(stuffed_temp >= 2)
		moveSlosh_cooldown = moveSlosh_cooldown - (0.05 * (stuffed_temp + (total_fullness/10)))

/obj/item/belly_function/proc/release_menu(mob/user)
	if(length(nommeds) > 0)
		var/opt_list = list()

		for(var/mob/living/carbon/human/nommed in nommeds)
			opt_list["Release [nommed.name]"] = nommed

		var/release_target = tgui_input_list(user, "Release ", "Belly Control", opt_list)
		if(release_target)
			var/mob/living/carbon/human/nommed = opt_list[release_target]
			if(istype(nommed))
				free_target(nommed)

/obj/item/belly_function/proc/free_target(mob/living/carbon/human/nommed)
	nommed.forceMove(drop_location())
	nommeds -= nommed
	nommed_sizes -= nommed
	nommed_gasmixes -= nommed
	if(escape_helpers[nommed] in belly_acts)
		belly_acts -= escape_helpers[nommed]
	escape_helpers[nommed].Remove(remove_from = nommed)
	escape_helpers -= nommed
	recalculate_guest_sizes()

/obj/item/belly_function/proc/config_menu(mob/living/user)
	var/opt_list = list("Change Color", "Toggle Skintone",
	"Set Size Modifier", "Set Size Modifier for Audio",
	"Toggle Belly Groans", "Toggle Belly Gurgles", "Toggle Belly Movement Creaks", "Toggle Belly Movement Sloshes",
	"Set Baseline Cosmetic Size", "Set Baseline Endo Size", "Set Baseline Stuffed Size",
	"Adjust Pred Mode", "Set Guest Size")
	var/list/mob/living/carbon/human/extra_size_list = list()

	for(var/mob/living/carbon/human/nommed in nommeds)
		extra_size_list["Set Size of [nommed.name]"] = nommed

	for(var/text in extra_size_list)
		opt_list += text

	var/adjustment_mode = tgui_input_list(user, "Select ", "Belly Control", opt_list)
	var/list_yesno = list("Yes", "No")
	if(adjustment_mode)
		if(adjustment_mode == "Change Color")
			var/temp_col = input("Enter new color:", "Color", src.color) as color|null
			if(temp_col != null || QDELETED(user) || QDELETED(src))
				src.color = temp_col
		else if(adjustment_mode == "Toggle Skintone")
			var/mode_select = tgui_alert(user, "Use skintone spritesheets?  Current state: [(use_skintone == TRUE) ? "yes" : "no"]", "Toggle Skintone", list_yesno)
			if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
				return
			use_skintone = (mode_select == "Yes") ? TRUE : FALSE
		else if(adjustment_mode == "Set Size Modifier")
			var/temp_size = tgui_input_number(user, "Set a size multiplier (0.00-10.00) - all size sources are multiplied by this.", "Sizemod", sizemod, 10, 0, round_value = FALSE)
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			sizemod = temp_size
		else if(adjustment_mode == "Set Size Modifier for Audio")
			var/temp_size = tgui_input_number(user, "Set a size divider (0.00-10.00) - all size sources are multiplied by this for determining audio.", "Audio Sizemod", sizemod_audio, 10, 0, round_value = FALSE)
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			sizemod_audio = temp_size
		else if(adjustment_mode == "Toggle Belly Groans")
			var/mode_select = tgui_alert(user, "Allow full groans & creaks to play from your belly?  Current state: [(allow_sound_groans == TRUE) ? "yes" : "no"]", "Allow Groans", list_yesno)
			if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
				return
			allow_sound_groans = (mode_select == "Yes") ? TRUE : FALSE
		else if(adjustment_mode == "Toggle Belly Gurgles")
			var/mode_select = tgui_alert(user, "Allow stuffed gurgles and churns to play from your belly?  Current state: [(allow_sound_gurgles == TRUE) ? "yes" : "no"]", "Allow Gurgles", list_yesno)
			if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
				return
			allow_sound_gurgles = (mode_select == "Yes") ? TRUE : FALSE
		else if(adjustment_mode == "Toggle Belly Movement Creaks")
			var/mode_select = tgui_alert(user, "Allow full creaks to play from your belly when jostled?  Current state: [(allow_sound_move_creaks == TRUE) ? "yes" : "no"]", "Allow Movement Creaks", list_yesno)
			if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
				return
			allow_sound_move_creaks = (mode_select == "Yes") ? TRUE : FALSE
		else if(adjustment_mode == "Toggle Belly Movement Sloshes")
			var/mode_select = tgui_alert(user, "Allow stuffed sloshes to play from your belly when jostled?  Current state: [(allow_sound_move_sloshes == TRUE) ? "yes" : "no"]", "Allow Movement Sloshes", list_yesno)
			if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
				return
			allow_sound_move_sloshes = (mode_select == "Yes") ? TRUE : FALSE
		else if(adjustment_mode == "Set Baseline Cosmetic Size")
			var/temp_size = tgui_input_number(user, "What purely cosmetic baseline belly size do you want?", "Base Size")
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			base_size_cosmetic = temp_size
		else if(adjustment_mode == "Set Baseline Endo Size")
			var/temp_size = tgui_input_number(user, "What gently-noisy, cosmetic endosoma-induced belly size do you want?", "Base Endo Size")
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			base_size_endo = temp_size
		else if(adjustment_mode == "Set Baseline Stuffed Size")
			var/temp_size = tgui_input_number(user, "What gurgly, cosmetic stuffing-induced belly size do you want?", "Base Stuffed Size")
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			base_size_stuffed = temp_size
		else if(adjustment_mode == "Adjust Pred Mode")
			var/list/pred_options = list("Never", "Query", "Always")
			var/mode_select = tgui_input_list(user, "Determines whether or not you can vore people as a pred with the belly.  Never means you can never be a pred, query means you always get queried before trying, always means you always try.", "Pred Prefs", pred_options)
			if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
				return
			pred_mode = mode_select
		else if(adjustment_mode == "Set Guest Size")
			var/temp_size = tgui_input_number(user, "What size do you want your eaten bellyguests to be?  (0.0-infinity, 1000 is typically same-sizeish)", "Endo Size")
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			endo_size = temp_size
		else if(adjustment_mode in extra_size_list)
			var/temp_size = tgui_input_number(user, "What size do you want [extra_size_list[adjustment_mode].name] to be?  (0.0-infinity, 1000 is typically same-sizeish)", "Endo Size")
			if(isnull(temp_size) || QDELETED(user) || QDELETED(src))
				return
			nommed_sizes[extra_size_list[adjustment_mode]] = temp_size
			recalculate_guest_sizes()

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

//real simple one to avoid hanging onto lastuser & clear things if this gets nullspaced
/obj/item/belly_function/proc/on_user_deleted()
	remove_from_user(lastuser)
	if(loc == null)
		Destroy()

/obj/item/belly_function/proc/do_alt_appearance(mob/living/carbon/human/target, do_cut, size)
	if(isnull(target))
		return
	else if(isdummy(target))
		if(do_cut == TRUE)
			target.cut_overlay(overlay_south)
			target.cut_overlay(overlay_north)
			target.cut_overlay(overlay_hori)
			last_size = -1
			overlay_south = null //we use this overlay as an indicator that the overlays are present, so axe it
		else
			target.add_overlay(overlay_south)
			target.add_overlay(overlay_north)
			target.add_overlay(overlay_hori)
	else
		if(do_cut == TRUE)
			for(var/i in 1 to size)
				target.remove_alt_appearance("erp_belly_south-[i]")
				target.remove_alt_appearance("erp_belly_north-[i]")
				target.remove_alt_appearance("erp_belly_hori-[i]")
			last_size = -1
			overlay_south = null //we use this overlay as an indicator that the overlays are present, so axe it
		else
			target.add_alt_appearance(/datum/atom_hud/alternate_appearance/erp/belly, "erp_belly_south-[size]", image(overlay_south, loc=target, layer=overlay_south.layer), AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS, target, "erp_belly_south-", size)
			target.add_alt_appearance(/datum/atom_hud/alternate_appearance/erp/belly, "erp_belly_north-[size]", image(overlay_north, loc=target, layer=overlay_north.layer), AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS, target, "erp_belly_north-", size)
			target.add_alt_appearance(/datum/atom_hud/alternate_appearance/erp/belly, "erp_belly_hori-[size]", image(overlay_hori, loc=target, layer=overlay_hori.layer), AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS, target, "erp_belly_hori-", size)

/obj/item/belly_function/proc/remove_from_user(mob/user)
	for(var/datum/action/action_item_has as anything in actions)
		action_item_has.Remove(user)
	if(overlay_south != null)
		do_alt_appearance(user, TRUE, last_size)
	lastuser = null

/obj/item/belly_function/proc/refresh_overlays(mob/living/carbon/human/user, inbound_size)
	// cut out-of-date overlays
	if(overlay_south != null)
		do_alt_appearance(user, TRUE, last_size)
	overlay_hori_all -= overlay_hori_all
	overlay_south_all -= overlay_south_all
	overlay_north_all -= overlay_north_all

	// setup working variables
	var/oldstate = worn_icon_state
	var/iconfile = inbound_size > 10 ? worn_icon_64x : worn_icon
	if(use_skintone == TRUE)
		iconfile = inbound_size > 10 ? skintone_worn_icon_64x : skintone_worn_icon
	else if(user.dna.species.id == SPECIES_TESHARI)
		iconfile = inbound_size > 10 ? worn_icon_teshari_64x : worn_icon_teshari

	var/i = inbound_size
	var/max = inbound_size
	if(isdummy(user))
		max = 1
	for(var/counter in 1 to max)
	//for(var/i in inbound_size to 1)
		// generate the appearances
		var/icon_state_wew = "[base_icon_state]-[i]"
		worn_icon_state = "[icon_state_wew]_HORI"
		overlay_hori = src.build_worn_icon(default_layer = (hori_layer), default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = "[icon_state_wew]_FRONT"
		overlay_south = src.build_worn_icon(default_layer = (south_layer), default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = "[icon_state_wew]_BACK"
		overlay_north = src.build_worn_icon(default_layer = (north_layer), default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = oldstate

		if(i > 10)
			overlay_hori.pixel_x -= 16
			overlay_hori.pixel_y -= 16
			overlay_south.pixel_x -= 16
			overlay_south.pixel_y -= 16
			overlay_north.pixel_x -= 16
			overlay_north.pixel_y -= 16

		if(user.dna.species.id == SPECIES_TESHARI)
			overlay_hori.pixel_y -= 3
			overlay_south.pixel_y -= 3
			overlay_north.pixel_y -= 3

		overlay_hori = image(overlay_hori, loc = user, layer = overlay_hori.layer)
		overlay_south = image(overlay_south, loc = user, layer = overlay_south.layer)
		overlay_north = image(overlay_north, loc = user, layer = overlay_north.layer)
		overlay_hori_all += overlay_hori
		overlay_south_all += overlay_south
		overlay_north_all += overlay_north

		// add the overlays
		do_alt_appearance(user, FALSE, i)
		i -= 1

/obj/item/belly_function/proc/recalculate_guest_sizes()
	total_endo_size = 0
	for(var/nommed_friendo in nommeds)
		total_endo_size += nommed_sizes[nommed_friendo]

/obj/item/belly_function/proc/belly_process(seconds_per_tick)
	//to_chat(world, "screem - process is running")
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		user = lastuser
	if(!istype(user))
		lastuser = null
		return

	// TODO: calculate fullness on the fly
	// formula should be pow(pow(food_units, 1.5) / (4/3) / PI, 1/3)
	// endo size should PROLLY be changed to be in food_units rather than overall size to avoid complications

	//var/guest_temp = istype(nommed) ? (endo_size + base_size_endo) : base_size_endo

	var/guest_temp = base_size_endo + total_endo_size

	var/stuffed_temp_orig = (user.get_fullness() - (user.nutrition * 0.6) - 500) //nutrition 6500 == maximum fullness
	if(stuffed_temp_orig < 0)
		stuffed_temp_orig = 0
	stuffed_temp_orig += base_size_stuffed
	var/total_fullness_orig = guest_temp + stuffed_temp_orig //maximum creaks from overfilled belly
	var/total_size_orig = total_fullness_orig + base_size_cosmetic
	var/total_size = total_size_orig / 10 * sizemod

	total_size = (((total_size)**1.5) / (4/3) / PI)**(1/3)

	current_size_unclamped = total_size

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

	// clamps these to previous scales for noise, more or less
	total_fullness = total_fullness_orig / 10 * sizemod_audio
	stuffed_temp = stuffed_temp_orig / 10 * sizemod_audio

	total_fullness = (((total_fullness)**1.5) / (4/3) / PI)**(1/3)
	stuffed_temp = (((stuffed_temp)**1.5) / (4/3) / PI)**(1/3)

	total_fullness = (total_fullness/3) + (total_fullness_orig / 1000)
	stuffed_temp = (stuffed_temp/3) + (stuffed_temp_orig / 1000)

	if(total_fullness >= 1 && allow_sound_groans)
		full_cooldown = full_cooldown - (seconds_per_tick * total_fullness)
		if(full_cooldown < 0)
			full_cooldown = rand(6, 36)
			playsound_if_pref(user, pick(full_sounds), min(10 + round(total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_groans)
	if(stuffed_temp >= 1 && allow_sound_gurgles)
		stuffLo_cooldown = stuffLo_cooldown - (seconds_per_tick * (stuffed_temp + (total_fullness/5)))
		if(stuffLo_cooldown < 0)
			stuffLo_cooldown = rand(3, 6)
			playsound_if_pref(user, pick(stuff_minor), min(12 + round(total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_gurgles)
	if(stuffed_temp >= 3 && allow_sound_gurgles)
		stuffHi_cooldown = stuffHi_cooldown - (seconds_per_tick * (stuffed_temp + (total_fullness/10)))
		if(stuffHi_cooldown < 0)
			stuffHi_cooldown = rand(9, 60)
			playsound_if_pref(user, pick(stuff_major), min(20 + round(total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_gurgles)
	if(moveCreak_cooldown < 0 && allow_sound_move_creaks)
		moveCreak_cooldown = rand(15, 60)
		playsound_if_pref(user, pick(move_creaks), min(10 + round(total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_creaks)
	if(moveSlosh_cooldown < 0 && allow_sound_move_sloshes)
		moveSlosh_cooldown = rand(15, 60)
		playsound_if_pref(user, pick(slosh_sounds), min(20 + round(total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_sloshes)

/obj/item/belly_function/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	try_nom(target, user)

/obj/item/belly_function/proc/try_nom(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!ishuman(target) || (target.stat == DEAD) || !ishuman(user) || user == target) //sanity check
		return
	var/consent_pred = FALSE
	var/consent_prey = FALSE
	var/list_yesno = list("Yes", "No")

	if(pred_mode == "Query")
		var/mode_select = tgui_alert(user, "Try to vore [target]?", "Nomnom?", list_yesno)
		if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
			return
		consent_pred = (mode_select == "Yes") ? TRUE : FALSE
	else if(pred_mode == "Always")
		consent_pred = TRUE

	var/prey_mode = target.client?.prefs?.read_preference(/datum/preference/choiced/erp_vore_prey_pref)
	if(consent_pred == TRUE)
		if(prey_mode == "Query")
			var/mode_select = tgui_alert(target, "Allow [user] to vore you?", "Nomnom?", list_yesno)
			if(isnull(mode_select) || QDELETED(target) || QDELETED(src))
				return
			consent_prey = (mode_select == "Yes") ? TRUE : FALSE
		else if(prey_mode == "Always")
			consent_prey = TRUE

	if(consent_pred == TRUE && consent_prey == TRUE)
		do_nom(target, user)
	else if(consent_pred == TRUE && consent_prey == FALSE)
		to_chat(user, span_danger("[target] doesn't want you to do that."))

/obj/item/belly_function/proc/do_nom(mob/living/carbon/human/target, mob/living/carbon/human/user)
	//Step 1: put them in the list (your belly)
	to_chat(target, span_danger("[user] gulps you down!"))
	to_chat(user, span_danger("You gulp down [target]!"))
	nommeds += target
	nommed_sizes[target] = endo_size
	//Step 2: scan their lungs to determine what air of yours this fool is breathing
	var/obj/item/organ/lungs/hopefully_lungs = target.organs_slot["lungs"]
	if(hopefully_lungs)
		//user.visible_message("Debugging: [target]'s lungs were found; they are [hopefully_lungs]")
		last_gasmix = ""
		for(var/something_in_list in hopefully_lungs.breathe_always)
			var/datum/gas/a_gas = new something_in_list()
			if(istype(a_gas))
				last_gasmix = "[last_gasmix][a_gas.id]=100;"
		last_gasmix = "[last_gasmix]TEMP=293.15"
	else
		last_gasmix = "o2=5;n2=10;TEMP=293.15"
	//Step 3: save that air
	nommed_gasmixes[target] = last_gasmix
	//Step 4: tell the user it's in a "machine" (your belly)- this lets your belly provide the previously calculated airmix - see below in handle_internal_lifeform
	SEND_SIGNAL(user, COMSIG_MACHINERY_SET_OCCUPANT, target)
	//Step 5: finally, move them into the belly, give escape action, and recalculate everything
	target.forceMove(src)
	escape_helpers[target] = new /datum/action/item_action/belly_menu/escape(src)
	escape_helpers[target].Grant(grant_to = target)
	recalculate_guest_sizes()

/obj/item/belly_function/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	if(lifeform_inside_me in nommed_gasmixes)
		//to_chat(world, "Debugging: [lifeform_inside_me] is inside [src]")
		if(breath_request <= 0)
			//to_chat(world, "Debugging: [lifeform_inside_me] didn't request breath")
			return null
		//to_chat(world, "Debugging: breath was requested, parsing gas string [last_gasmix]")
		var/datum/gas_mixture/mm_life = SSair.parse_gas_string(nommed_gasmixes[lifeform_inside_me])
		//to_chat(world, "Debugging: generated [mm_life] from gasmix string")
		var/breath_percentage = breath_request / mm_life.volume
		//to_chat(world, "Debugging: breath percentage will be [breath_percentage]")
		var/removed = mm_life.remove(mm_life.total_moles() * breath_percentage)
		//to_chat(world, "Debugging: removed [removed] from breathmix")
		return removed
	else
		return ..()
