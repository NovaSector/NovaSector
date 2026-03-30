/// Basetype for belly actions.
/datum/action/item_action/belly_menu
	name = "Belly Action Core"
	desc = "You shouldn't see this! Yell at an admin!"
	button_icon = 'modular_nova/modules/tums/icons/helpers.dmi'
	button_icon_state = "bwelly"
	/// Local reference to our connected belly helper object.
	var/obj/item/belly_function/my_belly

/datum/action/item_action/belly_menu/New(Target)
	. = ..()
	if(!istype(Target, /obj/item/belly_function))
		qdel(src)
		return
	else
		my_belly = Target
		LAZYADD(my_belly.belly_acts, src)

/datum/action/item_action/belly_menu/Destroy(force)
	. = ..()
	if(src in my_belly.belly_acts)
		LAZYREMOVE(my_belly.belly_acts, src)
	my_belly = null


/// Access helper for the belly-haver.  This lets them configure it & interact with guests.
/datum/action/item_action/belly_menu/access
	name = "Belly Access Helper"
	desc = "LMB: Activate the belly-config menu without needing to alt-click. RMB: Access the config menu for your guests."

/datum/action/item_action/belly_menu/access/Trigger(mob/clicker, trigger_flags)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		my_belly.release_menu(owner)
	else
		my_belly.config_menu(owner)
	return TRUE

/// Escape helper for belly-dwellers.  This lets them jostle around to make noise or immediately leave.
/datum/action/item_action/belly_menu/escape
	name = "Belly Escape Helper"
	desc = "LMB: Squirm around and make your host's belly noisy. RMB: Escape immediately."
	button_icon_state = "escape_icon"

	// TODO: we probably want to make these editable from the UI later

	/// Squirm interact messages, displayed to the guest.
	var/list/squirm_messages_owner = list(
		"You press into %USER%'s bellywalls!",
		"You knead into %USER%'s bellywalls!",
		"You squish into %USER%'s bellywalls!",
		"You squirm around in %USER%'s belly!",
		"You shift about in %USER%'s belly!",
		"You jostle %USER%'s belly from within!"
	)
	/// Squirm interact messages, displayed to the host.
	var/list/squirm_messages_host = list(
		"You feel %USER% pressing into your bellywalls!",
		"You feel %USER% kneading into your bellywalls!",
		"You feel %USER% squishing into your bellywalls!",
		"You feel %USER% squirming around in your belly!",
		"You feel %USER% shifting about in your belly!",
		"You feel %USER% jostling your belly about from within!"
	)

/datum/action/item_action/belly_menu/escape/Trigger(mob/clicker, trigger_flags)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		if(owner in my_belly.nommeds)
			my_belly.free_target(owner)
		else
			to_chat(owner, span_danger("You're not supposed to be able to use this action!"))
			src.Remove(owner)
	else
		if(my_belly.lastuser != null)
			var/message_index = rand(1, length(squirm_messages_owner))
			to_chat(owner, span_notice(replacetext(squirm_messages_owner[message_index], "%USER%", my_belly.lastuser.name)))
			to_chat(my_belly.lastuser, span_notice(replacetext(squirm_messages_host[message_index], "%USER%", owner.name)))
			if(my_belly.allow_sound_move_creaks)
				playsound_if_pref(my_belly.lastuser, pick(my_belly.move_creaks), min(10 + round(my_belly.total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_creaks)
			if(my_belly.stuffed_temp > 1 && prob(100) <= my_belly.stuffed_temp * 100 && my_belly.allow_sound_move_sloshes)
				playsound_if_pref(my_belly.lastuser, pick(my_belly.slosh_sounds), min(20 + round(my_belly.total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_sloshes)
		else
			if(my_belly.allow_sound_move_creaks)
				playsound_if_pref(my_belly, pick(my_belly.move_creaks), min(10 + round(my_belly.total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_creaks)
			if(my_belly.stuffed_temp > 1 && prob(100) <= my_belly.stuffed_temp * 100 && my_belly.allow_sound_move_sloshes)
				playsound_if_pref(my_belly, pick(my_belly.slosh_sounds), min(20 + round(my_belly.total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000), pref_to_check = /datum/preference/toggle/erp/belly/sound_move_sloshes)
	return TRUE

/datum/action/item_action/belly_menu/escape/Destroy()
	. = ..()
	if(owner in my_belly.nommeds)
		my_belly.free_target(owner)

/// This isn't an action button, persay, but it is an action.
/// This is the main helper function for handling pref & consent checks before nomming someone.
/// Call this, not do_nom, unless you are *debugging on local* and don't have two clients to work with.
/obj/item/belly_function/proc/try_nom(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!ishuman(target) || (target.stat == DEAD) || !ishuman(user) || user == target) //sanity check
		return
	/// Tracks the pred's (our user's) consent state.
	var/consent_pred = FALSE
	/// Tracks the prey's (our target's) consent state.
	var/consent_prey = FALSE
	/// Helper for tgui_alert to provide standard yes or no.
	var/list_yesno = list("Yes", "No")

	/// Query the host if applicable.  This belly has to be configured to QUERY or ALWAYS mode; otherwise we exit early as the pred doesn't want this.
	if(pred_mode == "Query")
		var/mode_select = tgui_alert(user, "Try to vore [target]?", "Nomnom?", list_yesno)
		if(isnull(mode_select) || QDELETED(user) || QDELETED(src))
			return
		consent_pred = (mode_select == "Yes") ? TRUE : FALSE
	else if(pred_mode == "Always")
		consent_pred = TRUE

	/// Query the target if applicable.  Their client has to be present, with this character opted in to be a prey, and the pred has to have already consented.
	var/prey_mode = target.client?.prefs?.read_preference(/datum/preference/choiced/erp_vore_prey_pref)
	if(consent_pred == TRUE)
		if(prey_mode == "Query")
			var/mode_select = tgui_alert(target, "Allow [user] to vore you?", "Nomnom?", list_yesno)
			if(isnull(mode_select) || QDELETED(target) || QDELETED(src))
				return
			consent_prey = (mode_select == "Yes") ? TRUE : FALSE
		else if(prey_mode == "Always")
			consent_prey = TRUE

	/// If everybody consents, go ahead and try to nom...
	if(consent_pred == TRUE && consent_prey == TRUE)
		do_nom(target, user)
	/// ...or if the target says no, display the standard interact deny message.
	else if(consent_pred == TRUE && consent_prey == FALSE)
		to_chat(user, span_danger("[target] doesn't want you to do that."))

/// This is where the magic happens to actually nom someone.
/// *Do not call this outside of debug*, it doesn't have consent checks.
/obj/item/belly_function/proc/do_nom(mob/living/carbon/human/target, mob/living/carbon/human/user)
	// Step 0: backup sanity check.  adminbussing inception might be funny but the consequences could fold reality like tissue paper
	if((target.loc in user.contents) || (user.loc in target.contents) || (target.loc.loc == user) || (user.loc.loc == target) || (user == target))
		return FALSE
	// Step 1: put them in the list (your belly)
	to_chat(target, span_danger("[user] gulps you down!"))
	to_chat(user, span_danger("You gulp down [target]!"))
	LAZYADD(nommeds, target)
	LAZYSET(nommed_sizes, target, endo_size)

	// Step 2: scan their lungs to determine what air of yours this fool is breathing
	/// Track the target's lungs, if they have them, so we can extract their expected breath types.
	var/obj/item/organ/lungs/hopefully_lungs = target.organs_slot["lungs"]
	/// String where a gasmix is assembled to be parsed.
	var/last_gasmix = ""
	if(hopefully_lungs)
		for(var/something_in_list in hopefully_lungs.breathe_always)
			var/datum/gas/a_gas = new something_in_list()
			if(istype(a_gas))
				last_gasmix = "[last_gasmix][a_gas.id]=20;"
		last_gasmix = "[last_gasmix]TEMP=[(hopefully_lungs.heat_level_1_threshold + hopefully_lungs.cold_level_1_threshold) / 2]]"
	else
		last_gasmix = "o2=5;n2=10;TEMP=293.15"

	// Step 3: save that air in workable gasmix form.  handle_internal_lifeform is nominally assumed to already remove air, this prevents it from being an issue.
	LAZYSET(nommed_gasmixes, target, SSair.parse_gas_string(last_gasmix))
	/// Step 4: tell the user it's in a "machine" (your belly)- this lets your belly provide the previously calculated airmix - see below in handle_internal_lifeform
	SEND_SIGNAL(user, COMSIG_MACHINERY_SET_OCCUPANT, target)
	/// Step 5: finally, move them into the belly, give escape action, and recalculate everything
	target.forceMove(src)
	var/datum/action/item_action/belly_menu/escape/helper = new /datum/action/item_action/belly_menu/escape(src)
	helper.Grant(grant_to = target)
	LAZYSET(escape_helpers, target, helper)
	recalculate_guest_sizes()
