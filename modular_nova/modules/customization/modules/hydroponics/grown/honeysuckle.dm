// Honeysuckle
/obj/item/seeds/honeysuckle
	name = "honeysuckle seed pack"
	desc = "These seeds grow into honeysuckle flowers."
	icon = 'modular_nova/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-honeysuckle"
	species = "honeysuckle"
	plantname = "Honeysuckle Bush"
	product = /obj/item/food/grown/honeysuckle
	lifespan = 50
	endurance = 10
	growthstages = 3
	growing_icon = 'modular_nova/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "honeysuckle-grow"
	icon_dead = "honeysuckle-dead"
	genes = list(/datum/plant_gene/trait/preserved, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/honey = 0.2, /datum/reagent/consumable/nutriment = 0.05)

/obj/item/food/grown/honeysuckle
	seed = /obj/item/seeds/honeysuckle
	name = "honeysuckle"
	desc = "The conical end of this flower contains a sweet, honey-like nectar."
	icon = 'modular_nova/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "honeysuckle"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES | SUGAR
	distill_reagent = /datum/reagent/consumable/ethanol/mead
