/obj/machinery/vending/ashclothingvendor
	name = "\improper Ashland Clothing Storage"
	desc = "A large container, filled with various clothes for the Ash Walkers."
	product_ads = "Praise the Necropolis"
	icon = 'modular_nova/modules/ashwalkers/icons/vending.dmi'
	icon_state = "ashclothvendor"
	icon_deny = "necrocrate"

	onstation = FALSE // we don't ever want these to be targetable by the brand intelligence event.
	all_products_free = TRUE // we don't want them to charge anything either. it's a box.

	products = list( //Relatively normal to have, I GUESS
		/obj/item/clothing/under/costume/gladiator/ash_walker/tribal = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/chestwrap = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/robe = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/shaman = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/chiefrags = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/yellow = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/caesar_clothes = 15,
		/obj/item/clothing/under/costume/gladiator/ash_walker/legskirt_d = 15,
		/obj/item/clothing/suit/ashwalkermantle = 12,
		/obj/item/clothing/suit/ashwalkermantle/cape = 12,
		/obj/item/clothing/shoes/jackboots/ashwalker = 12,
		/obj/item/clothing/shoes/jackboots/ashwalker/legate = 12,
		/obj/item/clothing/shoes/wraps/ashwalker/mundanewraps = 15,
		/obj/item/clothing/shoes/wraps/ashwalker = 10,
		/obj/item/clothing/shoes/wraps/ashwalker/tribalwraps = 2,
		/obj/item/clothing/shoes/colorable_sandals = 10,
		/obj/item/clothing/head/shamanash = 3,
		/obj/item/clothing/head/standalone_hood = 10,
		/obj/item/clothing/neck/mantle = 15,
		/obj/item/clothing/neck/cloak/tribalmantle = 2,
		/obj/item/clothing/neck/mantle/recolorable = 10,
		/obj/item/clothing/gloves/military/claw = 5,
		/obj/item/clothing/gloves/military/ashwalk = 10,
		/obj/item/clothing/accessory/skilt = 5,
		/obj/item/clothing/accessory/skullcodpiece = 5,
		/obj/item/clothing/accessory/talisman = 5,
	)
