/datum/species/golem/weak
	id = SPECIES_GOLEMWEAK
	var/static/list/blacklisted_materials = list(
		/datum/golem_food_buff/bluespace,
		/datum/golem_food_buff/gibtonite,
		/datum/golem_food_buff/bananium,
		/datum/golem_food_buff/titanium,
		/datum/golem_food_buff/plasma,
	)

/datum/golem_food_buff/can_consume(mob/living/carbon/human/consumer)
	var/datum/species/golem/weak/golem_snacker = consumer.dna.species
	if(istype(golem_snacker) && (type in golem_snacker.blacklisted_materials))
		return FALSE
	return ..()

