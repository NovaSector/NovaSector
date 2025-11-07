// Detective weapon beacon with alternative choice: knuckleduster

/obj/item/choice_beacon/detective
	name = "detective equipment beacon"
	desc = "A single-use beacon to deliver an alternative sidearm for investigative duties. Please only call this in your office!"
	icon_state = "sec_beacon"
	inhand_icon_state = "electronic"
	icon = 'modular_nova/modules/modular_items/icons/remote.dmi'
	company_source = "Nanotrasen Rapid Equipment Deployment Division"
	company_message = span_bold("Supply Pod incoming, please stand by.")

/obj/item/choice_beacon/detective/generate_display_names()
	var/static/list/selectable_types = list(
		"Knuckleduster" = /obj/item/melee/knuckleduster,
		"Police Baton" = /obj/item/melee/baton
	)
	return selectable_types

