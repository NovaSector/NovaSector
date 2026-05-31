/datum/voucher_set/mining/survival_capsule/New()
	description += " It also comes with a set of Kheiral Cuffs to extend the range of sensors."
	set_items += /obj/item/clothing/accessory/kheiral_cuffs

/datum/voucher_set/mining/crusher_kit
	icon = 'modular_nova/modules/mining_crushers/icons/crusher_conversion_kit.dmi'
	icon_state = "crusher_kit"
	description = "Contains a crusher conversion kit and a pocket fire extinguisher. The conversion kit will transform into a proto-kinetic crusher variant of one's choice, giving a versatile melee mining tool capable both of mining and fighting local fauna. \
		It is difficult to use effectively for anyone but most skilled and/or suicidal miners."
	set_items = list(
		/obj/item/crusher_conversion_kit,
		/obj/item/extinguisher/mini,
	)

/datum/voucher_set/mining/bunny
	name = "Bunny Conscription Kit"
	description = "Designed for Miners on the planet of Carota, this kit includes all you need to imitate them! Weapons sold seperately."
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/storage/backpack/duffelbag/mining_bunny/conscript,
	)

/obj/item/storage/backpack/duffelbag/mining_bunny/conscript/PopulateContents()
	..()
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/knife/shiv/carrot(src)
	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/knife/combat/survival(src)
	new /obj/item/storage/lunchbox/bunny/carrot(src)

/obj/item/storage/lunchbox/bunny/carrot
	name = "carrot lunchbox"
	desc = "Who needs Mesons?"

/obj/item/storage/lunchbox/bunny/carrot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/grown/carrot(src)

/datum/voucher_set/mining_suit
	blackbox_key = "suit_voucher_redeemed"

/datum/voucher_set/mining_suit/carota
	name = "Bunny Suit"
	description = "Designed for Miners on the planet of Carota, while you might get some odd looks from your co-workers, decency is a foreign word around here."
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/clothing/head/playbunnyears/miner,
		/obj/item/clothing/neck/tie/bunnytie/miner,
		/obj/item/clothing/suit/jacket/tailcoat/miner,
		/obj/item/clothing/under/rank/cargo/miner/bunnysuit,
		/obj/item/clothing/shoes/workboots/mining/heeled,
		/obj/item/clothing/mask/gas/explorer, //No bunny mask, this'll have to do.
	)

