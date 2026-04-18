// LOW COST
/datum/uplink_item/badass/guerilla_gloves
	name = "Guerilla Gloves"
	desc = "A pair of highly robust combat gripper gloves that excels at performing takedowns at close range, with an added lining of insulation. Careful not to hit a wall!"
	item = /obj/item/clothing/gloves/tackler/combat/insulated
	cost = 1
	uplink_item_flags = NONE
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/badass/combat_shoes
	name = "Combat Jackboots"
	desc = "High speed, low drag combat boots."
	item = /obj/item/clothing/shoes/combat
	cost = 1
	uplink_item_flags = NONE
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/badass/bulletproof_armor
	name = "Bulletproof Armor Vest"
	desc = "A Type III heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	item = /obj/item/clothing/suit/armor/bulletproof
	cost = /datum/uplink_item/low_cost::cost
	uplink_item_flags = NONE
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/badass/swat_helmet
	name = "Syndicate Helmet"
	desc = "An extremely robust, space-worthy helmet in a nefarious red and black stripe pattern."
	item = /obj/item/clothing/head/helmet/swat
	cost = /datum/uplink_item/low_cost::cost
	uplink_item_flags = NONE
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS


// MEDIUM COST

/datum/uplink_item/bundles_tc/bunny
	name = "Syndicate Bunny Kit"
	desc = "Straight from the dens of Carota. The Tactical Rabbit Ensemble. \
		Made for Tactical Rabbit Action, it's been adapted for use by the Syndicate, your welcome. \
		This kit contains one armor-lined rabbit costume, and one single carrot shiv. (Carrot shiv may be eaten in transit.)"
	item = /obj/item/storage/box/syndibunny
	cost = 8

/obj/item/storage/box/syndibunny
	name = "Syndicate Bunny Assassin Outfit"
	desc = "A box containing a high tech specialized syndicate... bunny suit?"
	icon_state = "syndiebox"

/obj/item/storage/box/syndibunny/PopulateContents()
	generate_items_inside(list(
		/obj/item/clothing/head/playbunnyears/syndicate = 1,
		/obj/item/clothing/under/syndicate/syndibunny = 1,
		/obj/item/clothing/suit/jacket/tailcoat/syndicate = 1,
		/obj/item/clothing/neck/tie/bunnytie/syndicate = 1,
		/obj/item/clothing/shoes/fancy_heels/syndi = 1,
	), src)

// HIGH COST
