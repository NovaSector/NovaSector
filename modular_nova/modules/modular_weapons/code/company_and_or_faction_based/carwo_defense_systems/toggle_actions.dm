/datum/action/item_action/toggle_shotgun_barrel
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	button_icon_state = "hbarrel0"
	name = "Overclock Kolben Barrel"

/datum/action/item_action/toggle_shotgun_barrel/apply_button_icon(atom/movable/screen/movable/action_button/button, force)
	var/obj/item/gun/ballistic/shotgun/riot/sol/super/blicky = target
	if(istype(blicky))
		button_icon_state = "hbarrel[blicky.amped]"

	return ..()
