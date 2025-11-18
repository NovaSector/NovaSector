//no ID versions of job corpses if they spawn in lavaland/icemoon

/obj/effect/mob_spawn/corpse/human/cargo_tech/Initialize(mapload)
	if(mapload && is_mining_level(z))
		outfit = /datum/outfit/consumed_cargotech

	return ..()

/obj/effect/mob_spawn/corpse/human/cook/Initialize(mapload)
	if(mapload && is_mining_level(z))
		outfit = /datum/outfit/consumed_cook

	return ..()

/obj/effect/mob_spawn/corpse/human/doctor/Initialize(mapload)
	if(mapload && is_mining_level(z))
		outfit = /datum/outfit/consumed_doctor

	return ..()

/obj/effect/mob_spawn/corpse/human/engineer/Initialize(mapload)
	if(mapload && is_mining_level(z))
		outfit = /datum/outfit/consumed_engineer

	return ..()

/obj/effect/mob_spawn/corpse/human/scientist/Initialize(mapload)
	if(mapload && is_mining_level(z))
		outfit = /datum/outfit/consumed_scientist

	return ..()

/obj/effect/mob_spawn/corpse/human/miner/Initialize(mapload)
	if(mapload && is_mining_level(z))
		outfit = /datum/outfit/consumed_miner

	return ..()
