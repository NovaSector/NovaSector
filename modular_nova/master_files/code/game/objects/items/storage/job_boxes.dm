// Interdyne survival box
/obj/item/storage/box/survival/interdyne
	name = "operation-ready survival box"
	desc = "A box with the essentials of your operation. This one is labelled to contain an extended-capacity tank."
	icon_state = "syndiebox"
	illustration = "extendedtank"
	mask_type = /obj/item/clothing/mask/gas/sechailer/syndicate // neck gaiter
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/interdyne/PopulateContents()
	..()
	new /obj/item/crowbar/red(src)
	new /obj/item/screwdriver/red(src)
	new /obj/item/weldingtool/mini(src)

