/obj/item/folder/cargo_contract/old
	name = "folder- 'NT-FTU Cargo Agreement'"
	desc = "A folder stamped \"Nanotrasen - Free Trade Union Agreement. Unauthorized distribution or attempted alteration is punishable financially.\""
	bg_color = "#b88f3d"
	icon = 'modular_nova/modules/paperwork/icons/bureaucracy.dmi'
	icon_state = "folder_cblue"

/obj/item/folder/cargo_contract/old/Initialize(mapload)
	. = ..()
	new /obj/item/paper/lore/cargo_old/c00(src)
	new /obj/item/paper/lore/cargo_old/c01(src)
	new /obj/item/paper/lore/cargo_old/c02(src)
	new /obj/item/paper/lore/cargo_old/c03(src)
	new /obj/item/paper/lore/cargo_old/c04(src)
	new /obj/item/paper/lore/cargo_old/c05(src)
	new /obj/item/paper/lore/cargo_old/c06(src)
	new /obj/item/paper/lore/cargo_old/c07(src)
	new /obj/item/paper/lore/cargo_old/c08(src)
	new /obj/item/paper/lore/cargo_old/c09(src)
	new /obj/item/paper/lore/cargo_old/c10(src)
	new /obj/item/paper/lore/cargo_old/c11(src)
	update_appearance()
