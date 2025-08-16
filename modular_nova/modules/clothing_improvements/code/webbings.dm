/datum/storage/loadout_belt
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_slots = 7

/datum/storage/loadout_belt/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	//Has size exceptions for some larger items in toolbelts & mining webbing
	set_holdable(exception_hold_list = list(
		/obj/item/construction, //RCD, RLD, RTD
		/obj/item/inducer,
		/obj/item/pickaxe/mini, //Despite being Mini, it's NORMAL (not SMALL). The base pickaxe is BULKY.
		/obj/item/pipe_painter,
		/obj/item/plunger,
		/obj/item/resonator,
		/obj/item/shovel,
		/obj/item/stack/ore,
		/obj/item/stack/sheet/animalhide,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
		/obj/item/storage/bag/ore,
	))

/obj/item/storage/belt/webbing
	name = "webbing"
	desc = "A sturdy mess of synthetic belts and buckles, ready to share your burden."
	icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "webbing"
	worn_icon_state = null //inherits from icon_state
	storage_type = /datum/storage/loadout_belt

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

/obj/item/storage/belt/webbing/vest
	name = "webbing vest"
	desc = "A robust vest with lots of pockets to hold whatever you need, ready to share your burdens."
	icon_state = "vest_brown"
	unique_reskin = list(
		"Brown" = "vest_brown",
		"Black" = "vest_black",
		"Medical White" = "vest_white",
	)
