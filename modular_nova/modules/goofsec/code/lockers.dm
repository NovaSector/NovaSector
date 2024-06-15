// Departmental guard lockers
/obj/structure/closet/secure_closet/security/cargo
	name = "\proper customs agent's locker"
	req_access = list(ACCESS_BRIG_ENTRANCE, ACCESS_CARGO)
	icon_state = "qm"
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/security/cargo/PopulateContents()
	new /obj/item/ammo_box/advanced/pepperballs(src)
	new /obj/item/restraints/handcuffs/cable/orange(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/bag/garment/customs_agent(src)

/obj/structure/closet/secure_closet/security/engine
	name = "\proper engineering guard's locker"
	req_access = list(ACCESS_BRIG_ENTRANCE, ACCESS_ENGINEERING)
	icon_state = "eng_secure"
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/security/engine/PopulateContents()
	new /obj/item/ammo_box/advanced/pepperballs(src)
	new /obj/item/restraints/handcuffs/cable/yellow(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/bag/garment/engineering_guard(src)

/obj/structure/closet/secure_closet/security/science
	name = "\proper science guard's locker"
	req_access = list(ACCESS_BRIG_ENTRANCE, ACCESS_RESEARCH)
	icon_state = "science"
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/security/science/PopulateContents()
	new /obj/item/ammo_box/advanced/pepperballs(src)
	new /obj/item/restraints/handcuffs/cable/pink(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/bag/garment/science_guard(src)

/obj/structure/closet/secure_closet/security/med
	name = "\proper orderly's locker"
	req_access = list(ACCESS_BRIG_ENTRANCE, ACCESS_MEDICAL)
	icon_state = "med_secure"
	icon = 'icons/obj/storage/closet.dmi'

/obj/structure/closet/secure_closet/security/med/PopulateContents()
	new /obj/item/ammo_box/advanced/pepperballs(src)
	new /obj/item/restraints/handcuffs/cable/blue(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/bag/garment/orderly(src)
