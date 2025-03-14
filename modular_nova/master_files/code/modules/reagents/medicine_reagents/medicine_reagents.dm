// Numbing effects
/datum/reagent/consumable/ethanol/drunken_espatier/New(list/data)
	metabolized_traits += list(TRAIT_ANALGESIA) // adding it this way so that should upstream ever add their own metabolized_traits, we don't override them
	return ..()

// Changeling balancing
// Allowing us to cure husks created by changeling without a brain transplant. Requires slightly more reagents to cure than a normal husk
/datum/reagent/medicine/rezadone/expose_mob(mob/living/carbon/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!istype(exposed_mob))
		return
	if(HAS_TRAIT_FROM(exposed_mob, TRAIT_HUSK, CHANGELING_DRAIN))
		var/current_volume = exposed_mob.reagents.get_reagent_amount(/datum/reagent/medicine/rezadone)

		if(methods & TOUCH)
			current_volume += reac_volume

		if(current_volume >= REZADONE_LING_UNHUSK_AMOUNT)
			exposed_mob.cure_husk(CHANGELING_DRAIN)
			exposed_mob.visible_message(span_nicegreen("A rubbery liquid coats [exposed_mob]'s tissues. [exposed_mob] looks a lot healthier!"))

// Allowing us to cure husks created by changeling. Requires 2 times more synthflesh to cure than a normal husk
/datum/reagent/medicine/c2/synthflesh/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(HAS_TRAIT_FROM(exposed_mob, TRAIT_HUSK, CHANGELING_DRAIN))
		var/current_volume = exposed_mob.reagents.get_reagent_amount(/datum/reagent/medicine/c2/synthflesh)
		var/current_purity = exposed_mob.reagents.get_reagent_purity(/datum/reagent/medicine/c2/synthflesh)

		if(methods & TOUCH)	//touch does not apply chems to blood, we want to combine the two volumes before attempting to unhusk
			current_purity = current_volume > 0 ? (current_volume * current_purity + reac_volume * creation_purity) / (current_volume + reac_volume) : creation_purity
			current_volume += reac_volume

		if(current_volume >= SYNTHFLESH_LING_UNHUSK_MAX || current_volume * current_purity >= SYNTHFLESH_LING_UNHUSK_AMOUNT)
			exposed_mob.cure_husk(CHANGELING_DRAIN)
			exposed_mob.visible_message(span_nicegreen("A rubbery liquid coats [exposed_mob]'s tissues. [exposed_mob] looks a lot healthier!"))
