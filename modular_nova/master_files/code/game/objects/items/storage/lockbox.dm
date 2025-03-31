// Syndicate Admiral's Medals box
/obj/item/storage/lockbox/medal/nova/synd
	name = "syndicate medal box"
	desc = "A locked box used to store medals of honor."
	icon = 'modular_nova/master_files/icons/obj/box.dmi'
	icon_state = "syndbox+l"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	req_access = list(ACCESS_SYNDICATE_LEADER)
	icon_locked = "syndbox+l"
	icon_closed = "syndbox"
	icon_broken = "syndbox+b"
	icon_open = "syndboxopen"

/obj/item/storage/lockbox/medal/nova/synd/PopulateContents()
	return list(
		/obj/item/clothing/accessory/medal/nova/syndicate,
		/obj/item/clothing/accessory/medal/nova/syndicate/espionage,
		/obj/item/clothing/accessory/medal/nova/syndicate/interrogation,
		/obj/item/clothing/accessory/medal/nova/syndicate/intelligence,
		/obj/item/clothing/accessory/medal/nova/syndicate/diligence,
		/obj/item/clothing/accessory/medal/nova/syndicate/communications,
	)
