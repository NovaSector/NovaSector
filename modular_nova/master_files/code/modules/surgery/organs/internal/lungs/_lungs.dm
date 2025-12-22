/obj/item/organ/lungs/
	var/safe_water_level = 16

/obj/item/organ/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/goblin, while_present = PROC_REF(consume_goblin))

/obj/item/organ/lungs/proc/consume_goblin(mob/living/carbon/breather, datum/gas_mixture/breath, goblin_pp, old_goblin_pp)

	if(goblin_pp >= 5)
		switch(rand(1,3))
			if(1)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_medicine, min(goblin_pp*0.25,10))
			if(2)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_toxic, min(goblin_pp*0.25,10))
			if(3)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_drug, min(goblin_pp*0.25,10))

/obj/item/organ/lungs/plasmaman
	compatible_biotypes = MOB_MINERAL

/obj/item/organ/lungs/pod
	compatible_biotypes = MOB_PLANT

/obj/item/organ/lungs/ethereal
	compatible_species = SPECIES_ETHEREAL
