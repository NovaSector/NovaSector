/obj/item/storage/box/flat
	name = "flat box"
	desc = "A cardboard box folded in a manner that is optimal for concealment, rather than for stowing your belongings."
	icon = 'modular_nova/modules/box_extra/_icon/box.dmi'
	icon_state = "flat"
	illustration = null

/obj/item/storage/box/flat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, INVISIBILITY_MAXIMUM, use_anchor = TRUE)
	atom_storage.max_slots = 3
