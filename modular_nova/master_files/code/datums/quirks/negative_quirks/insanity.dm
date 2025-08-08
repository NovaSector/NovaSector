/datum/quirk/insanity
	mail_goodies = list(/obj/item/storage/pill_bottle/lsdpsych/quirk)
	species_quirks = list(/datum/species/synthetic = /datum/quirk/insanity/synth)
	///The medication given when the quirk is added
	var/insanity_medication = /obj/item/storage/pill_bottle/lsdpsych/quirk

/datum/quirk/insanity/add_unique(client/client_source)
	give_item_to_holder_nova(
		insanity_medication,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "These will keep your brain stable until you can secure a supply of medication.",
		notify_player = TRUE,
	)

// Override of insanity quirk for synthetic humanoids
/datum/quirk/insanity/synth
	name = "Sensory Processing Fault"
	medical_record_text = "Patient is malfunctioning in a manner similar to Reality Dissociation Syndrome and experiences vivid hallucinations, and may have trouble speaking."
	mail_goodies = list(/obj/item/storage/box/flat/neuroware/mindbreaker)
	insanity_medication = /obj/item/storage/box/flat/neuroware/mindbreaker
	abstract_parent_type = /datum/quirk/insanity/synth
