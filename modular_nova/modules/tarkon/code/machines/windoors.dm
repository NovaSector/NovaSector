/////////////////// Tarkon Access Windoors ///////////////////
/////////////////// Yes i know these aren't machines ///////////////////

/obj/machinery/door/window/brigdoor/tarkon
	name = "reinforced glass door"
	desc = "For keeping a secure view."
	req_access = list(ACCESS_TARKON)

/obj/machinery/door/window/brigdoor/tarkon/right
	icon_state = "rightsecure"
	base_state = "rightsecure"

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/brigdoor/tarkon/left, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/brigdoor/tarkon/right, 0)
