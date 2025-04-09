/datum/orderable_item/bitrunning_flair/cornchips
	purchase_path = /obj/effect/spawner/random/food_or_drink/cornchips
	desc = "Boritos-brand corn chips, most famously known for the most recent contributions to the 'Time of Valor 4'-based VR sports tournament."
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/donkpockets
	purchase_path = /obj/effect/spawner/random/food_or_drink/donkpockets/bitrunning
	desc = "Singular discounted serving of donkpockets provided by Waffle Corp. counter-bitrunning division; to hinder their competitors. \
	Waffle Corp. representatives would like us to not inquire in the matters of product acquisition."
	cost_per_order = 150

/datum/orderable_item/bitrunning_flair/readydonk
	purchase_path = /obj/effect/spawner/random/food_or_drink/readydonk
	desc = "Ready-Donk brand meal subsidized by the dietary experts of Donk Co."
	cost_per_order = 100

/datum/orderable_item/bitrunning_flair/pizza
	purchase_path = /obj/effect/spawner/random/food_or_drink/pizza
	desc = "Recently performed survey on the bitrunners' diet and the following partnership with a local pizza chain allows us to \
	supply you with freshly made pizza, at close to no cost."
	cost_per_order = 150

/datum/orderable_item/bitrunning_flair/mountain_wind
	purchase_path = /obj/item/reagent_containers/cup/soda_cans/space_mountain_wind
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/pwr_game
	purchase_path = /obj/item/reagent_containers/cup/soda_cans/pwr_game
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/grey_bull
	purchase_path = /obj/item/reagent_containers/cup/soda_cans/grey_bull
	cost_per_order = 150

/datum/orderable_item/bitrunning_flair/monkey_energy
	purchase_path = /obj/item/reagent_containers/cup/soda_cans/monkey_energy
	cost_per_order = 150

/datum/orderable_item/bitrunning_flair/volt_energy
	purchase_path = /obj/item/reagent_containers/cup/soda_cans/volt_energy
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/six_soda
	purchase_path = /obj/item/storage/cans/sixsoda
	cost_per_order = 150

/datum/orderable_item/bitrunning_flair/four_twenty_blaze_it
	purchase_path = /obj/item/cigarette/rollie/cannabis
	desc = "FTU Bitrunning Division recommends you to fill out a prescription form before using this."
	cost_per_order = 100

/datum/orderable_item/bitrunning_flair/candy_flipper
	purchase_path = /obj/item/storage/pill_bottle/lsd
	desc = "Allegedly utilised to counter post-marathon hallucinations among the more 'hardened', or traumatised, bitrunners."
	cost_per_order = 200

/obj/effect/spawner/random/food_or_drink/cornchips
	name = "boritos delivery"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "boritos"
	loot = list(
		/obj/item/food/cornchips,
		/obj/item/food/cornchips/blue,
		/obj/item/food/cornchips/green,
		/obj/item/food/cornchips/red,
		/obj/item/food/cornchips/purple,
	)

/obj/effect/spawner/random/food_or_drink/donkpockets/bitrunning
	name = "donk pocket delivery"
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "donkpocketbox"

/obj/effect/spawner/random/food_or_drink/readydonk
	name = "ready donk delivery"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "ready_donk_mac"
	loot = list(
		/obj/item/food/ready_donk,
		/obj/item/food/ready_donk/mac_n_cheese,
		/obj/item/food/ready_donk/donkhiladas,
		/obj/item/food/ready_donk/nachos_grandes,
		/obj/item/food/ready_donk/donkrange_chicken,
	)

/obj/effect/spawner/random/food_or_drink/pizza
	name = "pizza delivery"
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "pizzamargherita"
	loot = list(
		/obj/item/pizzabox/margherita,
		/obj/item/pizzabox/vegetable,
		/obj/item/pizzabox/mushroom,
		/obj/item/pizzabox/meat,
		/obj/item/pizzabox/sassysage,
		/obj/item/pizzabox/pineapple,
	)
