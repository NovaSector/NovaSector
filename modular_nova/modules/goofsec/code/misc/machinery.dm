/obj/machinery/vending/access/solfed
	name = "\improper Solfed Outfitting Station"
	desc = "A vending machine for specialised clothing for members of the Federation."
	product_ads = "File paperwork in style!;Glory To the Federation!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!;Remember Its not a crime to be fashionable!"
	icon = 'modular_nova/modules/command_vendor/icons/vending.dmi'
	icon_state = "solfeddrobe"
	icon_deny = "solfeddrobe-deny"
	light_mask = "wardrobe-light-mask"
	vend_reply = "Thank you for using the CommDrobe!"
	auto_build_products = TRUE
	payment_department = null
	shut_up = TRUE

	refill_canister = /obj/item/vending_refill/wardrobe/solfed_wardrobe
	light_color = COLOR_BRIGHT_BLUE

/obj/item/vending_refill/wardrobe/solfed_wardrobe
	machine_name = "SolfedDrobe"

/obj/machinery/vending/access/solfed/build_access_list(list/access_lists)
	access_lists[ACCESS_CENT_CAPTAIN] = list(
		// Solfed has CC and station AA but this is the highest access possible so no one but feds can get it. Hopefully
		/obj/item/clothing/accessory/nova/solfedribbon = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official = 8,

		/obj/item/storage/box/flashbangs = 2,
		/obj/item/storage/box/handcuffs = 4,
		/obj/item/storage/box/nri_flares = 16,
	)

