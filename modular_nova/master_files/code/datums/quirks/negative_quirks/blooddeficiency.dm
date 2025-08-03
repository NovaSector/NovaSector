// Override of Blood Deficiency quirk for jelly species.
/datum/quirk/blooddeficiency/add(client/client_source)
	if(isjellyperson(quirk_holder))
		name = "Jelly Desiccation"
		desc = "Your body can't produce enough jelly to sustain itself."
		medical_record_text = "Patient requires regular treatment for slime jelly loss."
		mail_goodies = list(/obj/item/reagent_containers/blood/toxin)
	return ..()

/datum/quirk/blooddeficiency/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/reagent_containers/blood/blood_bag = /obj/item/reagent_containers/blood/o_minus
	if(!isnull(human_holder.dna.species.exotic_bloodtype))
		blood_bag = new()
		var/blood_type = human_holder.dna.species.exotic_bloodtype
		var/datum/blood_type/unique_blood = get_blood_type(blood_type)
		var/datum/reagent/blood_reagent = unique_blood::reagent_type
		blood_bag.blood_type = blood_type
		blood_bag.unique_blood = blood_reagent
		blood_bag.reagents.add_reagent(blood_reagent ? blood_reagent : /datum/reagent/blood, 200, list("viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null))
		blood_bag.update_appearance()
	give_item_to_holder_nova(
		blood_bag,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
		notify_player = TRUE,
	)
