/obj/item/clothing/suit/hooded/lethal_kitty_hoodie
	name = "disconcertingly twee hoodie"
	desc = "A design that originates in cheap novelty clothing, but this time made in a high quality sweatshirt fleece. The \
	way the ears were cut and sewn makes them stand up in a striking and sculptural way, which helps a playful design look \
	a little more sophisticated. This one is pleasantly scented."
	icon = 'modular_np_lethal/lethalcosmetics/icons/kitty_hoodie_obj.dmi'
	icon_state = "kitty_hoodie"
	worn_icon = 'modular_np_lethal/lethalcosmetics/icons/kitty_hoodie.dmi'
	worn_icon_state = "kitty_hoodie"
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/hooded_wintercoat
	hood_down_overlay_suffix = "_hood"
	hoodtype = /obj/item/clothing/head/hooded/lethal_kitty_hood

/obj/item/clothing/suit/hooded/lethal_kitty_hoodie/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/lighter,
		/obj/item/modular_computer/pda,
		/obj/item/radio,
		/obj/item/storage/bag/books,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
	)

/obj/item/clothing/head/hooded/lethal_kitty_hood
	name = "disconcertingly twee hood"
	desc = "It makes you look smaller and cuter, but it takes a bold personality to wear it outside."
	icon = 'modular_np_lethal/lethalcosmetics/icons/kitty_hoodie_obj.dmi'
	icon_state = "kitty_hoodie_hood_worn"
	worn_icon = 'modular_np_lethal/lethalcosmetics/icons/kitty_hoodie.dmi'
	worn_icon_state = "kitty_hoodie_hood_worn"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor_type = /datum/armor/hooded_winterhood
