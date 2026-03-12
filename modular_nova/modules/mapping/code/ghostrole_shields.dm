/obj/machinery/button/door/indestructible/blackmarket_trader
	name = "Stasis shield controller"
	desc = "Button that disables the long-term stasis field surrounding your environment.."
	id = "bmt_control"

/obj/machinery/button/door/indestructible/blackmarket_trader/Initialize(mapload, ndir, built)
	. = ..()

/obj/machinery/button/door/indestructible/blackmarket_trader/screwdriver_act()
	return

/obj/machinery/button/door/indestructible/blackmarket_trader/crowbar_act()
	return

/obj/machinery/button/door/indestructible/blackmarket_trader/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	return

/obj/machinery/button/door/indestructible/blackmarket_trader/emag_act()
	return

/obj/machinery/button/door/indestructible/blackmarket_trader/attack_hand()
	. = ..()
	if(.)
		return
	qdel(src)

/obj/machinery/door/poddoor/blackmarket_trader
	name = "stasis shield"
	desc = "Keeps those pesky tiders out, but also prevents you from leaving!"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "dimensional_overlay"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/blackmarket_trader/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/machinery/door/poddoor/blackmarket_trader/screwdriver_act()
	return

/obj/machinery/button/door/indestructible/blackmarket_trader/crowbar_act()
	return

/obj/machinery/door/poddoor/blackmarket_trader/welder_act()
	return

/obj/machinery/door/poddoor/blackmarket_trader/open()
	qdel(src)
