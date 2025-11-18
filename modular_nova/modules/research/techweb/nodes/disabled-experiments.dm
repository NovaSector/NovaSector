/// changes required experiments to be discount instead
/datum/techweb_node/proc/make_requirements_optional()
	for(var/experiment in required_experiments)
		discount_experiments[experiment] = research_costs[TECHWEB_POINT_TYPE_GENERIC]

	required_experiments = list()

/datum/techweb_node/gas_compression/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/selection/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/xenobiology/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/parts_adv/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/mech_combat/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/medbay_equip_adv/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/explosives/New()
	make_requirements_optional()
	return ..()
