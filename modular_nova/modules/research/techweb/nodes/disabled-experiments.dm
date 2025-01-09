/// changes required experiments to be discount instead
/datum/techweb_node/proc/make_requirements_optional()
	discount_experiments = required_experiments.Copy()
	required_experiments = list()

/datum/techweb_node/gas_compression/New()
	make_requirements_optional()
	return ..()

/datum/techweb_node/selection/New()
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
                              
