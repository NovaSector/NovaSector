/obj/item/storage/lockbox/medal
	icon = 'modular_nova/master_files/icons/obj/box.dmi'
	icon_state = "cmdbox+l"
	icon_locked = "cmdbox+l"
	icon_closed = "cmdbox"
	icon_broken = "cmdbox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/hop
	icon_state = "hopbox+l"
	icon_locked = "hopbox+l"
	icon_closed = "hopbox"
	icon_broken = "hopbox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/service
	icon_state = "srvbox+l"
	icon_locked = "srvbox+l"
	icon_closed = "srvbox"
	icon_broken = "srvbox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/cargo
	icon_state = "cargobox+l"
	icon_locked = "cargobox+l"
	icon_closed = "cargobox"
	icon_broken = "cargobox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/sci
	icon_state = "scibox+l"
	icon_locked = "scibox+l"
	icon_closed = "scibox"
	icon_broken = "scibox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/med
	icon_state = "medbox+l"
	icon_locked = "medbox+l"
	icon_closed = "medbox"
	icon_broken = "medbox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/sec
	icon_state = "secbox+l"
	icon_locked = "secbox+l"
	icon_closed = "secbox"
	icon_broken = "secbox+b"
	icon_open = "medalcaseopen"

/obj/item/storage/lockbox/medal/engineering
	icon_state = "engbox+l"
	icon_locked = "engbox+l"
	icon_closed = "engbox"
	icon_broken = "engbox+b"
	icon_open = "medalcaseopen"

// Syndicate Admiral's Medals box
/obj/item/storage/lockbox/medal/synd
	name = "\improper syndicate medal box"

	req_access = list(ACCESS_SYNDICATE_LEADER)

	icon_state = "syndbox+l"
	icon_locked = "syndbox+l"
	icon_closed = "syndbox"
	icon_broken = "syndbox+b"
	icon_open = "syndboxopen"

/obj/item/storage/lockbox/medal/synd/PopulateContents()
	new /obj/item/clothing/accessory/medal/nova/syndicate(src)
	new /obj/item/clothing/accessory/medal/nova/syndicate/espionage(src)
	new /obj/item/clothing/accessory/medal/nova/syndicate/interrogation(src)
	new /obj/item/clothing/accessory/medal/nova/syndicate/intelligence(src)
	new /obj/item/clothing/accessory/medal/nova/syndicate/diligence(src)
	new /obj/item/clothing/accessory/medal/nova/syndicate/communications(src)

/obj/item/storage/lockbox/medal/interdyne
	name = "\improper interdyne pharmaceuticals medal box"

	req_access = list(ACCESS_SYNDICATE_LEADER)

	icon_state = "dynebox+l"
	icon_locked = "dynebox+l"
	icon_closed = "dynebox"
	icon_broken = "dynebox+b"
	icon_open = "dyneboxopen"

/obj/item/storage/lockbox/medal/interdyne/PopulateContents()
	new /obj/item/clothing/accessory/medal/nova/interdyne(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/profit(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/excellency(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/services(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/engineering(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/search_rescue(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/xenobio(src)
	new /obj/item/clothing/accessory/medal/nova/interdyne/chemistry(src)
