// Lets cyborgs move dragged objects onto tables
/obj/structure/table/attack_robot(mob/user, list/modifiers)
	if(!in_range(src, user))
		return
	return attack_hand(user, modifiers)

/obj/structure/table/reinforced/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/liquids_height, 20)

/obj/structure/table/wood/fancy/kinaris
	name = "regal kinaris table"
	desc = "A standard metal table frame covered with an amazingly fancy, patterned cloth."
	icon_state = "kinaris_table-0"
	base_icon_state = "kinaris_table"
	buildstack = /obj/item/stack/tile/carpet/kinaris
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table.dmi'
	flipped_table_icon = 'modular_nova/master_files/icons/obj/flipped_tables.dmi'

/obj/structure/table/wood/fancy/kinaris/red
	icon_state = "kinaris_table_red-0"
	base_icon_state = "kinaris_table_red"
	buildstack = /obj/item/stack/tile/carpet/kinaris/red
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_red.dmi'

/obj/structure/table/wood/fancy/kinaris/orange
	icon_state = "kinaris_table_orange-0"
	base_icon_state = "kinaris_table_orange"
	buildstack = /obj/item/stack/tile/carpet/kinaris/orange
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_orange.dmi'

/obj/structure/table/wood/fancy/kinaris/yellow
	icon_state = "kinaris_table_yellow-0"
	base_icon_state = "kinaris_table_yellow"
	buildstack = /obj/item/stack/tile/carpet/kinaris/yellow
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_yellow.dmi'

/obj/structure/table/wood/fancy/kinaris/green
	icon_state = "kinaris_table_green-0"
	base_icon_state = "kinaris_table_green"
	buildstack = /obj/item/stack/tile/carpet/kinaris/green
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_green.dmi'

/obj/structure/table/wood/fancy/kinaris/purple
	icon_state = "kinaris_table_purple-0"
	base_icon_state = "kinaris_table_purple"
	buildstack = /obj/item/stack/tile/carpet/kinaris/purple
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_purple.dmi'

/obj/structure/table/wood/fancy/kinaris/blacktrim
	icon_state = "kinaris_table_blacktrim-0"
	base_icon_state = "kinaris_table_blacktrim"
	buildstack = /obj/item/stack/tile/carpet/kinaris/blacktrim
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_blacktrim.dmi'

/obj/structure/table/wood/fancy/kinaris/black
	icon_state = "kinaris_table_black-0"
	base_icon_state = "kinaris_table_black"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black.dmi'

/obj/structure/table/wood/fancy/kinaris/black/red
	icon_state = "kinaris_table_black_red-0"
	base_icon_state = "kinaris_table_black_red"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black/red
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black_red.dmi'

/obj/structure/table/wood/fancy/kinaris/black/orange
	icon_state = "kinaris_table_black_orange-0"
	base_icon_state = "kinaris_table_black_orange"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black/orange
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black_orange.dmi'

/obj/structure/table/wood/fancy/kinaris/black/yellow
	icon_state = "kinaris_table_black_yellow-0"
	base_icon_state = "kinaris_table_black_yellow"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black/yellow
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black_yellow.dmi'

/obj/structure/table/wood/fancy/kinaris/black/green
	icon_state = "kinaris_table_black_green-0"
	base_icon_state = "kinaris_table_black_green"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black/green
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black_green.dmi'

/obj/structure/table/wood/fancy/kinaris/black/purple
	icon_state = "kinaris_table_black_purple-0"
	base_icon_state = "kinaris_table_black_purple"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black/purple
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black_purple.dmi'

/obj/structure/table/wood/fancy/kinaris/black/whitetrim
	icon_state = "kinaris_table_black_white-0"
	base_icon_state = "kinaris_table_black_white"
	buildstack = /obj/item/stack/tile/carpet/kinaris/black/whitetrim
	icon = 'modular_nova/master_files/icons/obj/smooth_structures/kinaris_table_black_white.dmi'
