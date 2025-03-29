// Interdyne survival box
/obj/item/storage/box/survival/interdyne
	name = "operation-ready survival box"
	desc = "A box with the essentials of your operation. This one is labelled to contain an extended-capacity tank."
	icon_state = "syndiebox"
	illustration = "extendedtank"
	mask_type = /obj/item/clothing/mask/neck_gaiter
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/interdyne/PopulateContents()
	..()
	. += /obj/item/crowbar/red
	. += /obj/item/screwdriver/red
	. += /obj/item/weldingtool/mini

