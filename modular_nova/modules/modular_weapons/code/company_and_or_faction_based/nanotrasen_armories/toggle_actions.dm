/datum/action/item_action/toggle_38rev_barrel
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	button_icon_state = "hbarrel0"
	name = "Toggle Revolver Charger"

/datum/action/item_action/toggle_38rev_barrel/apply_button_icon(atom/movable/screen/movable/action_button/button, force)
	var/obj/item/gun/ballistic/revolver/c38/super/blicky = target
	if(istype(blicky))
		button_icon_state = "hbarrel[blicky.amped]"

	return ..()
