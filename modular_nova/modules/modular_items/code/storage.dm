/obj/item/storage/backpack/duffelbag/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/fancy/nugget_box
	spawn_count = 7

/datum/storage/box/bandages
	max_slots = 14

/datum/storage/pillbottle
	max_slots = 21
	max_total_storage = WEIGHT_CLASS_TINY * 21

/datum/storage/katana_sheath/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
			/obj/item/katana,
			/obj/item/forging/reagent_weapon/katana,
		)
	)
