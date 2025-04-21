/datum/quirk/blooddeficiency
	species_quirks = list(
		/datum/species/synthetic = /datum/quirk/blooddeficiency/synth,
		/datum/species/jelly/slime = /datum/quirk/blooddeficiency/jelly,
	)
	var/obj/item/reagent_containers/blood/blood_bag = /obj/item/reagent_containers/blood/o_minus

/datum/quirk/blooddeficiency/is_species_appropriate(datum/species/mob_species)
	if(ispath(mob_species, /datum/species/jelly) || ispath(mob_species, /datum/species/synthetic))
		return TRUE
	return ..()

/datum/quirk/blooddeficiency/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!isnull(human_holder.dna.species.exotic_blood))
		blood_bag = new()
		var/blood_type = human_holder.dna.species.exotic_blood.name
		var/unique_blood = human_holder.dna.species.exotic_blood
		blood_bag.blood_type = blood_type
		blood_bag.unique_blood = unique_blood
		blood_bag.reagents.add_reagent(unique_blood ? unique_blood : /datum/reagent/blood, 200, list("viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null))
		blood_bag.update_appearance()
	give_item_to_holder_nova(
		blood_bag,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
	)

// Override of Blood Deficiency quirk for robotic/synthetic species.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/blooddeficiency/synth
	name = "Hydraulic Leak"
	desc = "Your body's hydraulic fluids are leaking through their seals."
	medical_record_text = "Patient requires regular treatment for hydraulic fluid loss."
	mail_goodies = list(/obj/item/reagent_containers/blood/oil)
	hidden_quirk = TRUE
	blood_bag = /obj/item/reagent_containers/blood/oil

// Override of Blood Deficiency quirk for jelly/slime species.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/blooddeficiency/jelly
	name = "Jelly Desiccation"
	desc = "Your body can't produce enough jelly to sustain itself."
	medical_record_text = "Patient requires regular treatment for slime jelly loss."
	mail_goodies = list(/obj/item/reagent_containers/blood/toxin)
	hidden_quirk = TRUE
	blood_bag = /obj/item/reagent_containers/blood/toxin

// Omits the NOBLOOD check for jelly/slime species.
/datum/quirk/blooddeficiency/jelly/lose_blood(datum/source, seconds_per_tick, times_fired)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(human_holder.stat == DEAD || human_holder.blood_volume <= min_blood)
		return
	human_holder.blood_volume = max(min_blood, human_holder.blood_volume - human_holder.dna.species.blood_deficiency_drain_rate * seconds_per_tick)
