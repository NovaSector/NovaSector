/obj/item/storage/box/erp/portal_fleshlight
	name = "Portal Device and Underwear"
	desc = "A small silver box with LustWish Co embossed."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/portal.dmi'
	icon_state = "box"
	illustration = null
	custom_price = 15

/obj/item/storage/box/portal_fleshlight/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 10
	atom_storage.max_slots = 3

/obj/item/storage/box/portal_fleshlight/PopulateContents()
	new /obj/item/clothing/sextoy/portal_fleshlight(src)
	new /obj/item/clothing/sextoy/portal_panties(src)
	new /obj/item/paper/fluff/portal_fleshlight(src)

/obj/item/paper/fluff/portal_fleshlight
	name = "Portal Device Instructions"
	default_raw_text = {"Thank you for purchasing the Lustwish Portal Fleshlight / Dildo!<br>\
	To use, simply register your new portal device with the provided underwear to link them together. Then ask your lover to wear the underwear receiver.<br>\
	The portal device can be used to target different body parts by right-clicking it to cycle through available targets.<br>\
	Both the fleshlight and underwear can be toggled to anonymous mode by right-clicking them.<br>\
	Have fun lovers,<br>\
	<br>\
	LustWish Corporation."}
