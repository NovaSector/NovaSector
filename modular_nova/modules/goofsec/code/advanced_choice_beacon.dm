/// Placing these here for now until a permanent place is made

/obj/item/advanced_choice_beacon/solfed
	name = "Sol Federation Infantryman Equipment Beacon"
	desc = "An authorized assortment of equipment granted to you by the federation, use it wisely."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "self_delivery"
	inhand_icon_state = null

	possible_choices = list(
		/obj/structure/closet/crate/secure/weapon/nri/solfed,
		/obj/structure/closet/crate/secure/weapon/nri/solfed/military_police,
		/obj/structure/closet/crate/secure/weapon/nri/solfed/rifleman,)

/// Different from military engineer
// This carries stuff to put the station back together.
/obj/item/advanced_choice_beacon/solfed/civil_engi
	name = "Sol Federation Engineering Supply Beacon"
	desc = "For all your engineering supply based needs! Use it well and use it wise!"

	possible_choices = list(
		/obj/structure/closet/crate/secure/weapon/nri/solfed,
		/obj/structure/closet/crate/secure/weapon/nri/solfed/military_police,
		/obj/structure/closet/crate/secure/weapon/nri/solfed/rifleman,)


/// Different from military corpsman
// This carries more safe care, field hospital equipment, stuff to get you back to being alive instead of horizontal.
/obj/item/advanced_choice_beacon/solfed/civil_medic
	name = "Sol Federation Engineering Supply Beacon"
	desc = "For all your medical supply needs! A field hospital on the go!"


/*
	SolFed military
*/

/obj/item/advanced_choice_beacon/solfed/squadleader
	name = "Sol Federation Squad-Leader Equipment Beacon"

/obj/item/advanced_choice_beacon/solfed/squadleader/grand

/// Different from civil paramedic
// This carries more rapid trauma care, stuff to get you in the fight, but not provide in depth aid.
/obj/item/advanced_choice_beacon/solfed/corpsman
	name = "Sol Federation Corpsman Equipment Beacon"

/obj/item/advanced_choice_beacon/solfed/corpsman/grand
	name = "Sol Federation Corpsman Equipment Beacon"


/// Different from civil engineer
// This carries stuff to make ghetto defenses, forts, turrets, etc.
/obj/item/advanced_choice_beacon/solfed/engineer
	name = "Sol Federation Engineer Equipment Beacon"

/obj/item/advanced_choice_beacon/solfed/engineer/grand

/// Specialist is a jack of all trades kind of role, A more HIGH threat active role (2nd wave spawn)
// Breacher, Flame thrower, JTAC, Etc (This guy is a dude who FUCKs)
/obj/item/advanced_choice_beacon/solfed/specialist
	name = "Sol Federation Specialist Equipment Beacon"

/obj/item/advanced_choice_beacon/solfed/specialist/grand

/// Smartgunner, an "If all else fails" role, ADMIN-SPAWN ONLY (cannot be spawned in any other way)
// Breacher,
/obj/item/advanced_choice_beacon/solfed/smartgunner
	name = "Sol Federation Smartgunner Equipment Beacon"
	desc = "A questionably authorized assortment of weapons granted to you by the federation, may god have mercy."
/obj/item/choice_beacon/solfed
	name = "Sol Federation Weapon Beacon"
	desc = "A beacon that carries primary class weaponry of solfed soldiers"
	icon = 'modular_nova/modules/modular_items/icons/remote.dmi'
	icon_state = "solfed_firearm_beacon"
	inhand_icon_state = "electronic"
	company_source = "Sol Federation Primary Weaapon Requisitions"
	company_message = span_bold("Request recieved, dropping shipment on location.")

/obj/item/choice_beacon/solfed/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Krijgspaard Marksman Rifle Gunset" = /obj/item/storage/toolbox/guncase/nova/solfedspec/marksman,
		"MMR Assault Rifle Gunset" = /obj/item/storage/toolbox/guncase/nova/solfedspec/mmr,
		"Jager Trench Shotgun Gunset" = /obj/item/storage/toolbox/guncase/nova/solfedspec/jager,
		"M64 Shotgun Gunset" = /obj/item/storage/toolbox/guncase/nova/solfedspec/m64,
		"Renopard Rifle Gunset" = /obj/item/storage/toolbox/guncase/nova/solfedspec/renopard,
	)
	return selectable_gun_types
