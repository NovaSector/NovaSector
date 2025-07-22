/obj/item/storage/belt/webbing
	name = "webbing"
	desc = "A sturdy mess of synthetic belts and buckles, ready to share your burden."
	icon = 'modular_nova/modules/clothing_improvements/icons/clothing.dmi'
	worn_icon = 'modular_nova/modules/clothing_improvements/icons/clothing_worn.dmi'
	icon_state = "webbing"
	inhand_icon_state = "utility"
	worn_icon_state = null //Makes it default to whatever icon_state is set to, because they're identical
	storage_type = /datum/storage/webbing_belt

/datum/storage/webbing_belt
	max_slots = 5
	max_specific_storage = WEIGHT_CLASS_SMALL

/obj/item/storage/belt/webbing/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/webbing_belt)

/obj/item/storage/belt/webbing/vest
	name = "webbing vest"
	desc = "A robust vest with lots of pockets to hold whatever you need, ready to share your burdens."
	icon_state = "vest_brown"
	unique_reskin = list(
		"Brown" = "vest_brown",
		"Black" = "vest_black",
		"Medical White" = "vest_white",
	)

/obj/item/storage/belt/webbing/pouch
	name = "drop pouches"
	gender = PLURAL
	desc = "A robust pair of drop pouches with good capacity, ready to share your burdens."
	icon_state = "thigh_brown"
	unique_reskin = list(
		"Brown" = "thigh_brown",
		"Black" = "thigh_black",
		"White" = "thigh_white",
	)

/obj/item/storage/belt/webbing/pilot
	name = "storage rigging"
	icon_state = "pilot_webbing1"
	unique_reskin = list(
		"Full Rigging" = "pilot_webbing1",
		"Low Slung" = "pilot_webbing2",
	)
