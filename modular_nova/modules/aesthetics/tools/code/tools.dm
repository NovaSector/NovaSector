/obj/item/weldingtool
	icon = 'modular_nova/modules/aesthetics/tools/icons/tools.dmi'

/obj/item/construction/plumbing //This icon override NEEDS to be here for the subtypes
	icon = 'modular_nova/modules/aesthetics/tools/icons/tools.dmi'

/obj/item/construction/rcd/arcd
	icon = 'modular_nova/modules/aesthetics/tools/icons/tools.dmi'

/obj/item/crowbar/power/Initialize(mapload)
	. = ..()
	if(type == /obj/item/crowbar/power) // (the exact type of the item, so it doesn't apply to subtype)
		icon = 'modular_nova/modules/aesthetics/tools/icons/tools.dmi'
		righthand_file = 'modular_nova/modules/aesthetics/tools/icons/tools_righthand.dmi'
		lefthand_file = 'modular_nova/modules/aesthetics/tools/icons/tools_lefthand.dmi'
	return ..()

/obj/item/inducer
	icon = 'modular_nova/modules/aesthetics/tools/icons/tools.dmi'
