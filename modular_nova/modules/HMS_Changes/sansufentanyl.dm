/datum/supply_pack/misc/experimentalmedicine
	name = "Sanusfentanyl Medicine Crate"
	desc = "A crate containing the medication required for living with Hereditary Manifold Sickness, Sansufentanyl."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/pill_bottle/sansufentanyl = 2)

/datum/chemical_reaction/medicine/sansufentanyl
	results = list(/datum/reagent/medicine/sansufentanyl = 10)
	required_reagents = list(/datum/reagent/medicine/sansufentanyl_base = 1, /datum/reagent/medicine/spaceacillin = 3, /datum/reagent/bluespace = 6)
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER

/datum/reagent/medicine/sansufentanyl_base
	name = "Experimental Fentanyl Base"
	description = "The secret base reagent used to create sansufentanyl. Developed by Interdyne Pharmacuticals, it is a closely held secret recipe."
	color = "#8659a6"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/sansufentanyl_base/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_confusion_up_to(3 SECONDS * REM * seconds_per_tick, 10 SECONDS)
	affected_mob.adjust_dizzy_up_to(6 SECONDS * REM * seconds_per_tick, 20 SECONDS)
	if(affected_mob.adjustStaminaLoss(4 * REM * seconds_per_tick, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH

	if(SPT_PROB(10, seconds_per_tick))
		to_chat(affected_mob, "You feel confused and disoriented.")
		if(prob(30))
			SEND_SOUND(affected_mob, sound('sound/weapons/flash_ring.ogg'))

/obj/item/paper/fluff/sansufentanyl
	name = "sansufentanyl recipe"
	default_raw_text = {"Sansufentanyl Recipe! <br>
		Within this box contains the base reagents in order to make the experimental medicine, sansufentanyl. <br>
		1. Grind the bluespace crystals into a fine powder. <br>
		2. Mix 1 part Experimental Fentanyl Base with 3 parts spaceacillin and 6 parts bluespace dust. <br>
		3. Mix the reagents together in a beaker and keep tempratue to around 350k. <br>
		4. Once the reagents have been mixed, pour the mixture into a chem master. <br>
		5. Initiate the chem masters pill press and press the pills into units of 10 per pill. <br>
		6. Once the pills have been pressed, place them into a pill bottle and store them in a cool, dark place. <br>
	"}

/obj/item/reagent_containers/cup/beaker/bluespace/sansufentanyl_base
	list_reagents = list(/datum/reagent/medicine/sansufentanyl_base = 300)

/obj/item/reagent_containers/cup/beaker/bluespace/spaceacillin
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 300)

/obj/item/storage/box/syndie_kit/sansufentanyl
	name = "sansufentanyl reagent box"
	desc = "Contains everything you'll need to create new batches of sanusfentanyl. Careful, do not spill contents."

/obj/item/storage/box/syndie_kit/sansufentanyl/PopulateContents()
	generate_items_inside(list(
		/obj/item/reagent_containers/cup/beaker/bluespace/sansufentanyl_base = 2,
		/obj/item/reagent_containers/cup/beaker/bluespace/spaceacillin = 1,
		/obj/item/stack/ore/bluespace_crystal = 15,
		/obj/item/paper/fluff/sansufentanyl = 1,
	), src)
