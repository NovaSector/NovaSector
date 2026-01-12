/obj/item/crowbar/power/science
	name = "hybrid cutters" // hybrid between crowbar and wirecutters
	desc = "Quite similar to the jaws of life, this tool combines the utility of a crowbar and a set of wirecutters without the hydraulic force required to pry open doors."
	icon = 'modular_nova/modules/aesthetics/tools/icons/tools.dmi'
	icon_state = "jaws_sci"
	lefthand_file = 'modular_nova/modules/aesthetics/tools/icons/tools_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/tools/icons/tools_righthand.dmi'
	inhand_icon_state = "jaws_sci"
	force_opens = FALSE

/obj/item/screwdriver/power/science
	icon_state = "drill_sci"

/obj/item/screwdriver/power/science/Initialize(mapload)
	. = ..()

	desc += " This one sports a nifty science paintjob, but is otherwise normal."
