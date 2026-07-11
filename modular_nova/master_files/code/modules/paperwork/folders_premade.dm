/obj/item/folder/ancient_paperwork/five
	name = "packed dusty folder"
	desc = "You're pretty sure folders shouldn't be packed this full, especially if they look this old."

/obj/item/folder/ancient_paperwork/five/Initialize(mapload)
	. = ..()
	// as we inherit the previous init, which generates one ancient paperwork, we initialize 4 more for 5 total
	new /obj/item/paperwork/ancient(src)
	new /obj/item/paperwork/ancient(src)
	new /obj/item/paperwork/ancient(src)
	new /obj/item/paperwork/ancient(src)
	update_appearance()
