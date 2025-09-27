/obj/machinery/equipment_vendor/security
	name = "Security Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_security"
	accepted_token = /obj/item/equipment_token/security

/obj/item/equipment_token/security
	name = "Standard Security Token"
	desc = "Valued worth one point!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
	)

/obj/item/equipment_token/security/warden
	name = "Warden Security Token"
	desc = "A special security pre-loaded for the warden!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 3,
	)

/datum/vendor_equipment/primary/flashbangs
	name = "Flashbang"
	product_path = /obj/item/storage/box
	description = "A simple rather robust flashbang."
	cost = 1

/datum/vendor_equipment/primary/seclight
	name = "Security Flashlight"
	product_path = /obj/item/storage/box
	description = "A Seclight, useful in dark areas. Try to not forget it."
	cost = 1

/datum/vendor_equipment/primary/disabler
	name = "Security Flashlight"
	product_path = /obj/item/storage/box
	description = "A Seclight, useful in dark areas. Try to not forget it."
	cost = 1
