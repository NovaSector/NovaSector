/obj/item/hierophant_club
	var/static/active_clubs = null

/obj/item/hierophant_club/Initialize(mapload)
	. = ..()
	active_clubs++
	if(active_clubs > 3)
		return INITIALIZE_HINT_QDEL

/obj/item/hierophant_club/Destroy(force)
	if(active_clubs > 3)
		new /obj/item/clothing/accessory/pandora_hope(loc)

	active_clubs--
	return ..()

/obj/item/lava_staff
	var/static/active_staffs = null

/obj/item/lava_staff/Initialize(mapload)
	. = ..()
	active_staffs++
	if(active_staffs > 2)
		return INITIALIZE_HINT_QDEL

/obj/item/lava_staff/Destroy(force)
	if(active_staffs > 2)
		if(prob(50))
			new /obj/item/crusher_trophy/legionnaire_spine(loc)
		else
			new /obj/item/crusher_trophy/broodmother_tongue(loc)

	active_staffs--
	return ..()
