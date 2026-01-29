/obj/machinery/equipment_vendor/destwo
	name = "Deepspace Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_destwo"
	accepted_token = /obj/item/equipment_token/destwo
	equipment_stock = list(
		/datum/vendor_equipment/primary/debug1,
		/datum/vendor_equipment/primary/debug2,
		/datum/vendor_equipment/primary/debug3,
		/datum/vendor_equipment/primary/debug4,
		/datum/vendor_equipment/primary/debug5,
		/datum/vendor_equipment/primary/debug6,
		/datum/vendor_equipment/primary/debug7,
	)

/obj/item/equipment_token/destwo
	name = "DS-2 Crew Equipment Token"
	desc = "A token with a rather suspicious snake with 3 heads on it."
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 2,
		EQUIPMENT_VENDOR_CATEGORY_UTILITIES = 1,
	)

/obj/item/equipment_token/destwo/security
	name = "DS-2 Security Equipment Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to feel like it could bite."
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 2,
		EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT = 2,
	)

/obj/item/equipment_token/destwo/command
	name = "DS-2 Command Equipment Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to have a special glimmer to it."
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 2,
		EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT = 2,
		EQUIPMENT_VENDOR_CATEGORY_UNIFORM = 1,
		EQUIPMENT_VENDOR_CATEGORY_UTILITIES = 2,
	)

/obj/item/equipment_token/destwo/primary
	name = "DS-2 Primary Weapon Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to be preloaded with only 1 point"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
	)

/obj/item/equipment_token/destwo/secondary
	name = "DS-2 Secondary Weapon Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to be preloaded with only 1 point"
	icon_state = "token_secondary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 1,
	)

/obj/item/equipment_token/destwo/uniform
	name = "DS-2 Uniform Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to be preloaded with only 1 point"
	icon_state = "token_uniform"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_UNIFORM = 1,
	)

/obj/item/equipment_token/destwo/equipment
	name = "DS-2 Equipment Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to be preloaded with only 1 point"
	icon_state = "token_equipment"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT = 1,
	)

/obj/item/equipment_token/destwo/utilities
	name = "DS-2 Utilities Token"
	desc = "A token with a rather suspicious snake with 3 heads on it. It seems to be preloaded with only 1 point"
	icon_state = "token_heavy"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_UTILITIES = 1,
	)

/datum/vendor_equipment/primary/debug1
	name = "ITEM ONE!"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 1

/datum/vendor_equipment/primary/debug2
	name = "ITEM TWO! (VENDLIMIT TESTING)"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 2
	vend_limit = 1

/datum/vendor_equipment/primary/debug3
	name = "ITEM THREE! (PERMIT CHECKING)"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 3
	permit_required = TRUE

/datum/vendor_equipment/primary/debug4
	name = "ITEM FOUR! (ACCESS CHECKING)"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 4
	access_required = list(ACCESS_CAPTAIN)

/datum/vendor_equipment/primary/debug5
	name = "ITEM FIVE!"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 5

/datum/vendor_equipment/primary/debug6
	name = "ITEM SIX!"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 6

/datum/vendor_equipment/primary/debug7
	name = "ITEM SEVEN!"
	product_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 7

