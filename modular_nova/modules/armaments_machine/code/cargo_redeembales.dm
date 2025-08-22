/obj/machinery/equipment_vendor/cargo
	name = "Command Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_command"
	accepted_token = /obj/item/equipment_token/cargo
	equipment_stock = list(

	)

/obj/item/equipment_token/cargo
	name = "Standard Command Token"
	desc = "Valued worth one point!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
	)

