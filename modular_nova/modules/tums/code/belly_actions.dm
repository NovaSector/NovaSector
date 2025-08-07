/datum/action/item_action/belly_menu
	name = "Belly Action Core"
	desc = "You shouldn't see this! Yell at an admin!"
	button_icon = 'modular_nova/modules/tums/icons/items.dmi'
	button_icon_state = "bwelly"
	var/obj/item/belly_function/my_belly

/datum/action/item_action/belly_menu/New(Target)
	. = ..()
	if(!istype(Target, /obj/item/belly_function))
		qdel(src)
		return
	else
		my_belly = Target
		my_belly.belly_acts += src

/datum/action/item_action/belly_menu/Destroy()
	. = ..()
	if(src in my_belly.belly_acts)
		my_belly.belly_acts -= src


/datum/action/item_action/belly_menu/access
	name = "Belly Access Helper"
	desc = "LMB: Activate the belly-config menu without needing to alt-click. RMB: Access the config menu for your guests."

/datum/action/item_action/belly_menu/access/Trigger(trigger_flags)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		my_belly.release_menu(usr)
	else
		my_belly.config_menu(usr)
	return TRUE



/datum/action/item_action/belly_menu/escape
	name = "Belly Escape Helper"
	desc = "LMB: Squirm around and make your host's belly noisy. RMB: Escape immediately."
	button_icon_state = "escape_icon"
	var/list/squirm_messages_usr = list(
		"You press into %USER%'s bellywalls!",
		"You knead into %USER%'s bellywalls!",
		"You squish into %USER%'s bellywalls!",
		"You squirm around in %USER%'s belly!",
		"You shift about in %USER%'s belly!",
		"You jostle %USER%'s belly from within!"
	)
	var/list/squirm_messages_host = list(
		"You feel %USER% pressing into your bellywalls!",
		"You feel %USER% kneading into your bellywalls!",
		"You feel %USER% squishing into your bellywalls!",
		"You feel %USER% squirming around in your belly!",
		"You feel %USER% shifting about in your belly!",
		"You feel %USER% jostling your belly about from within!"
	)

/datum/action/item_action/belly_menu/escape/Trigger(trigger_flags)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		if(usr in my_belly.nommeds)
			my_belly.free_target(usr)
		else
			to_chat(usr, span_danger("You're not supposed to be able to use this action!"))
			src.Remove(usr)
	else
		if(my_belly.lastuser != null)
			var/message_index = rand(1, length(squirm_messages_usr))
			to_chat(usr, span_notice(replacetext(squirm_messages_usr[message_index], "%USER%", my_belly.lastuser.name)))
			to_chat(my_belly.lastuser, span_notice(replacetext(squirm_messages_host[message_index], "%USER%", usr.name)))
			if(my_belly.allow_sound_move_creaks)
				playsound_if_pref(my_belly.lastuser, pick(my_belly.move_creaks), min(10 + round(my_belly.total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000))
			if(my_belly.stuffed_temp > 1 && prob(100) <= my_belly.stuffed_temp * 100 && my_belly.allow_sound_move_sloshes)
				playsound_if_pref(my_belly.lastuser, pick(my_belly.slosh_sounds), min(20 + round(my_belly.total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000))
		else
			if(my_belly.allow_sound_move_creaks)
				playsound_if_pref(my_belly, pick(my_belly.move_creaks), min(10 + round(my_belly.total_fullness/40, 1), 30), TRUE, frequency=rand(40000, 50000))
			if(my_belly.stuffed_temp > 1 && prob(100) <= my_belly.stuffed_temp * 100 && my_belly.allow_sound_move_sloshes)
				playsound_if_pref(my_belly, pick(my_belly.slosh_sounds), min(20 + round(my_belly.total_fullness/32, 1), 50), TRUE, frequency=rand(40000, 50000))
	return TRUE

/datum/action/item_action/belly_menu/escape/Destroy()
	. = ..()
	if(usr in my_belly.nommeds)
		my_belly.free_target(usr)
