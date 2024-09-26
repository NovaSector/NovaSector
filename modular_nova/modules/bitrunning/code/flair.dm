/datum/orderable_item/bitrunning_flair/cornchips
	item_path = /obj/item/food/cornchips/random
	cost_per_order = 25

/datum/orderable_item/bitrunning_flair/donkpockets
	item_path = /obj/effect/spawner/random/food_or_drink/donkpockets
	cost_per_order = 100

/datum/orderable_item/bitrunning_flair/readydonk
	item_path = /obj/effect/spawner/random/food_or_drink/readydonk
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/pizza
	item_path = /obj/item/pizzabox/random
	cost_per_order = 100

/datum/orderable_item/bitrunning_flair/mountain_wind
	item_path = /obj/item/reagent_containers/cup/soda_cans/space_mountain_wind
	cost_per_order = 25

/datum/orderable_item/bitrunning_flair/pwr_game
	item_path = /obj/item/reagent_containers/cup/soda_cans/pwr_game
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/grey_bull
	item_path = /obj/item/reagent_containers/cup/soda_cans/grey_bull
	cost_per_order = 100

/datum/orderable_item/bitrunning_flair/monkey_energy
	item_path = /obj/item/reagent_containers/cup/soda_cans/monkey_energy
	cost_per_order = 100

/datum/orderable_item/bitrunning_flair/volt_energy
	item_path = /obj/item/reagent_containers/cup/soda_cans/volt_energy
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/four_twenty_blaze_it
	item_path = /obj/item/cigarette/rollie/cannabis
	desc = "FTU Bitrunning Division recommends you to fill out a prescription form before using this."
	cost_per_order = 50

/datum/orderable_item/bitrunning_flair/candy_flipper
	item_path = /obj/item/storage/pill_bottle/lsd
	desc = "Allegedly utilised to counter post-marathon hallucinations among the more 'hardened' bitrunners."
	cost_per_order = 150

/obj/effect/spawner/random/food_or_drink/readydonk
	name = "ready donk spawner"
	icon_state = "donkpocket"
	loot = list(
		/obj/item/food/ready_donk,
		/obj/item/food/ready_donk/mac_n_cheese,
		/obj/item/food/ready_donk/donkhiladas,
		/obj/item/food/ready_donk/nachos_grandes,
		/obj/item/food/ready_donk/donkrange_chicken,
	)
