/obj/item/clothing/accessory/webbing
	name = "webbing"
	desc = "A sturdy mess of synthetic belts and buckles, ready to share your burden."
	icon = 'modular_nova/modules/clothing_improvements/icons/clothing.dmi'
	worn_icon = 'modular_nova/modules/clothing_improvements/icons/clothing_worn.dmi'
	icon_state = "webbing"
	attachment_slot = NONE

/datum/storage/pockets/webbing
	do_rustle = TRUE
	max_slots = 3
	max_specific_storage = WEIGHT_CLASS_SMALL

/obj/item/clothing/accessory/webbing/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/webbing)

/obj/item/clothing/accessory/webbing/can_attach_accessory(obj/item/clothing/under/attach_to, mob/living/user)
	. = ..()
	if(!.)
		return

	if(!isnull(attach_to.atom_storage))
		if(user)
			attach_to.balloon_alert(user, "not compatible!")
		return FALSE
	return TRUE

/obj/item/clothing/accessory/webbing/vest
	name = "webbing vest"
	desc = "A robust vest with lots of pockets to hold whatever you need, ready to share your burdens."
	icon_state = "vest_brown"
	unique_reskin = list(
		"Brown" = "vest_brown",
		"Black" = "vest_black",
		"Medical White" = "vest_white",
	)

/obj/item/clothing/accessory/webbing/pouch
	name = "drop pouches"
	gender = PLURAL
	desc = "A robust pair of drop pouches with good capacity, ready to share your burdens."
	icon_state = "thigh_brown"
	unique_reskin = list(
		"Brown" = "thigh_brown",
		"Black" = "thigh_black",
		"White" = "thigh_white",
	)

/obj/item/clothing/accessory/webbing/pilot
	name = "storage rigging"
	icon_state = "pilot_webbing1"
	unique_reskin = list(
		"Full Rigging" = "pilot_webbing1",
		"Low Slung" = "pilot_webbing2",
	)
