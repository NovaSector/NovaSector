/obj/machinery/equipment_vendor/destwo
	name = "Deepspace Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_destwo"
	accepted_token = /obj/item/equipment_token/security
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
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 3,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 2,
	)


/datum/vendor_equipment/primary/debug1
	name = "ITEM ONE!"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 1

/datum/vendor_equipment/primary/debug2
	name = "ITEM TWO! (VENDLIMIT TESTING)"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 2
	vend_limit = 1

/datum/vendor_equipment/primary/debug3
	name = "ITEM THREE! (PERMIT CHECKING)"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 3
	permit_required = TRUE

/datum/vendor_equipment/primary/debug4
	name = "ITEM FOUR! (ACCESS CHECKING)"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 4
	access_required = list(ACCESS_CAPTAIN)

/datum/vendor_equipment/primary/debug5
	name = "ITEM FIVE!"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 5

/datum/vendor_equipment/primary/debug6
	name = "ITEM SIX!"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 6

/datum/vendor_equipment/primary/debug7
	name = "ITEM SEVEN!"
	equipment_path = /obj/item/storage/box
	description = "DEBUGGING TIME!"
	cost = 7

