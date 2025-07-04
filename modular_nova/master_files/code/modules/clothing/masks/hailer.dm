/obj/item/clothing/mask/whistle/lifeguard
	name = "Lifeguard Whistle"
	desc = "A whistle for when you need to make sure people hear you to stop running."
	icon_state = "whistle"
	inhand_icon_state = null
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_NECK
	custom_price = PAYCHECK_COMMAND * 1.5
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/halt/lifeguard)
	action_slots = ALL
	
/obj/item/clothing/mask/whistle/lifeguard/ui_action_click(mob/user, action)
	if(!COOLDOWN_FINISHED(src, whistle_cooldown))
		return
	COOLDOWN_START(src, whistle_cooldown, 10 SECONDS)
	user.audible_message("<font color='red' size='5'><b>NO RUNNING!</b></font>")
	playsound(src, 'sound/items/whistle/whistle.ogg', 50, FALSE, 4)

/datum/action/item_action/halt/lifeguard
	name = "NO RUNNING!"
