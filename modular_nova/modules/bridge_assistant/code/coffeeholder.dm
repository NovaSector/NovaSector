/obj/item/storage/box/coffee_tray
	name = "coffee tray"
	desc = "An intern's best friend."
	icon = 'modular_nova/modules/bridge_assistant/icons/coffeeholder.dmi'
	icon_state = "holder"
	inhand_icon_state = "cawfeeinhand"
	lefthand_file = 'modular_nova/modules/bridge_assistant/icons/coffeeholder_lefthand.dmi'
	righthand_file = 'modular_nova/modules/bridge_assistant/icons/coffeeholder_righthand.dmi'
	drop_sound = 'sound/items/handling/cardboard_box/cardboardbox_drop.ogg'
	pickup_sound = 'sound/items/handling/cardboard_box/cardboardbox_pickup.ogg'
	foldable_result = /obj/item/stack/sheet/cardboard
	storage_type = /datum/storage/box/coffee_tray

	illustration = null
	max_integrity = 500

/obj/item/storage/box/coffee_tray/update_icon_state()
	icon_state = "[initial(icon_state)][contents.len]"
	return ..()

/datum/storage/box/coffee_tray
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = 4
	max_slots = 4

/datum/storage/box/coffee_tray/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(/obj/item/reagent_containers/cup/glass/coffee)

/obj/item/storage/box/coffee_tray/full
	name = "coffee 4-pack"
	desc = "For the enterprising and suffering worker!"

/obj/item/storage/box/coffee_tray/full/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/cup/glass/coffee(src)
