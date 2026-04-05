#ifndef UNIT_TESTS
/mob/living/carbon/gib(drop_bitflags = NONE) // Makes it so gibbing causes all the mobs blood/reagents to spill on the floor
	var/datum/blood_type/blood_type = get_bloodtype()
	if(HAS_TRAIT(src, TRAIT_NOBLOOD) || isnull(blood_type))
		return ..()

	var/turf/pool_location = get_turf(src)
	var/list/reagents_to_splash = list()
	reagents_to_splash[blood_type.reagent_type] = blood_volume
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagents_to_splash[reagent.type] = reagent.volume

	pool_location.add_liquid_list(reagents_to_splash, chem_temp = bodytemperature)
	return ..()
#endif
