// Detective weapon beacon with alternative choice: knuckleduster

/obj/item/choice_beacon/detective
	name = "weaponry beacon"
	desc = "A single-use beacon to deliver an alternative sidearm for investigative duties. Please only call this in your office!"
	icon_state = "cc_becon"
	inhand_icon_state = "cc_becon"
	icon = 'modular_nova/modules/modular_items/icons/remote.dmi'
	lefthand_file = 'modular_nova/modules/modular_items/icons/inhand/mobs/lefthand_remote.dmi'
	righthand_file = 'modular_nova/modules/modular_items/icons/inhand/mobs/righthand_remote.dmi'
	company_source = "Nanotrasen Rapid Equipment Deployment Division"
	company_message = span_bold("Supply Pod incoming, please stand by.")

/obj/item/choice_beacon/detective/generate_display_names()
	var/static/list/selectable_types = list(
		"Knuckleduster" = /obj/item/melee/knuckleduster,
		"Police Baton" = /obj/item/melee/baton
	)
	return selectable_types

