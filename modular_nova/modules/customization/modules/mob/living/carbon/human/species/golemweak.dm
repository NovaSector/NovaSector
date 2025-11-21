/datum/species/golem/weak
	id = SPECIES_GOLEMWEAK
	nova_stars_only = TRUE
	var/static/list/blacklisted_materials = list(
		/datum/golem_food_buff/bluespace,
		/datum/golem_food_buff/gibtonite,
		/datum/golem_food_buff/bananium,
		/datum/golem_food_buff/titanium,
		/datum/golem_food_buff/plasma,
	)
	mutantstomach = /obj/item/organ/stomach/golem/weak

/datum/golem_food_buff/can_consume(mob/living/carbon/human/consumer)
	var/datum/species/golem/weak/golem_snacker = consumer.dna.species
	if(istype(golem_snacker) && (type in golem_snacker.blacklisted_materials))
		return FALSE
	return ..()

/obj/item/organ/stomach/golem/weak
	hunger_modifier = 1
