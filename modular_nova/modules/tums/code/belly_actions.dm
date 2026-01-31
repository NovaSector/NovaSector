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
		my_belly.belly_acts += src

/datum/action/item_action/belly_menu/Destroy(force)
	. = ..()
	if(src in my_belly.belly_acts)
		my_belly.belly_acts -= src
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
