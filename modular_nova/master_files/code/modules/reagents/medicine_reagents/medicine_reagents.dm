// Numbing effects
/datum/reagent/consumable/ethanol/drunken_espatier/New(list/data)
	metabolized_traits += list(TRAIT_ANALGESIA) // adding it this way so that should upstream ever add their own metabolized_traits, we don't override them
	return ..()

//Changeling balancing
/datum/reagent/medicine/rezadone/expose_mob(mob/living/carbon/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!istype(exposed_mob))
		return
	if(HAS_TRAIT_FROM(exposed_mob, TRAIT_HUSK, CHANGELING_DRAIN) && (exposed_mob.reagents.get_reagent_amount(/datum/reagent/medicine/rezadone) + reac_volume >= SYNTHFLESH_LING_UNHUSK_AMOUNT))//Costs a little more than a normal husk
		exposed_mob.cure_husk(CHANGELING_DRAIN)
		exposed_mob.visible_message("<span class='nicegreen'>A rubbery liquid coats [exposed_mob]'s tissues. [exposed_mob] looks a lot healthier!")

/datum/reagent/medicine/regen_jelly/expose_mob(mob/living/carbon/human/exposed_mob, reac_volume)
	. = ..()
	if(!istype(exposed_mob) || (reac_volume < 0.5))
		return

	exposed_mob.update_mutant_bodyparts(force_update=TRUE)
