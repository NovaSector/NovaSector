// Peach
/obj/item/seeds/peach
	name = "peach pit pack"
	desc = "You're much less likely to bite into one of these on accident."
	icon = 'modular_nova/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-peach"
	species = "peach"
	plantname = "Peach Tree"
	product = /obj/item/food/grown/peach
	lifespan = 35
	endurance = 35
	growing_icon = 'modular_nova/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "peach-grow"
	icon_dead = "peach-dead"
	icon_harvest = "peach-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(
		/datum/reagent/consumable/nutriment/vitamin = 0.04,
		/datum/reagent/consumable/nutriment = 0.1,
	)

/obj/item/food/grown/peach
	seed = /obj/item/seeds/peach
	name = "peach"
	desc = "Things are peachy keen."
	icon = 'modular_nova/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "peach"
	foodtypes = FRUIT | SUGAR

/obj/item/food/grown/peach/juice_typepath()
	return /datum/reagent/consumable/peachjuice
