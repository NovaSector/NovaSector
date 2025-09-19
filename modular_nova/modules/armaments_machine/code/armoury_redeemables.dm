/obj/machinery/equipment_vendor/security
	name = "Security Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_security"
	accepted_token = /obj/item/equipment_token/armoury

/obj/item/equipment_token/armoury
	name = "Standard Armoury Token"
	desc = "Valued worth one point!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 1,
	)

/obj/item/equipment_token/armoury/warden
	name = "Warden Armoury Token"
	desc = "Valued worth one point!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 3,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 2,
	)

/obj/item/equipment_token/armoury/high_alert
	name = "High Alert Armoury Token"
	desc = "Valued worth one point!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 3,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 3,
	)

/datum/vendor_equipment/primary/jager
	name = "Jager"
	product_path = /obj/item/storage/box
	description = "A heavily robust type of shotgun."
	cost = 4

/datum/vendor_equipment/primary/shotgun
	name = "M64 Shotgun"
	product_path = /obj/item/storage/box
	description = "A simple rather robust flashbang."
	cost = 2

/datum/vendor_equipment/primary/smg
	name = "Smg"
	product_path = /obj/item/storage/box
	description = "A simple rather robust flashbang."
	cost = 2

/datum/vendor_equipment/secondary/smg
	name = "Jager"
	product_path = /obj/item/storage/box
	description = "A simple rather robust flashbang."
	cost = 2
