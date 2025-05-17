// Re-labels TG brainproblems to be more generic. There never was a tumor anyways!
/datum/quirk/item_quirk/brainproblems
	name = "Brain Degeneration"
	desc = "You have a lethal condition in your brain that is slowly destroying it. Better bring some mannitol!"
	medical_record_text = "Patient has a lethal condition in their brain that is slowly causing brain death."
	icon = FA_ICON_BRAIN

// If brainproblems is added to a synth, this detours to the brainproblems/synth quirk.
/datum/quirk/item_quirk/brainproblems/add(client/client_source)
	if(issynthetic(quirk_holder))
		name = "Positronic Cascade Anomaly"
		desc = "Your positronic brain is slowly corrupting itself due to a cascading anomaly. Better bring some liquid solder!"
		gain_text = span_danger("You feel glitchy.")
		lose_text = span_notice("You no longer feel glitchy.")
		medical_record_text = "Patient has a cascading anomaly in their brain that is slowly causing brain death."
		mail_goodies = list(/obj/item/storage/pill_bottle/liquid_solder/braintumor)
	return ..()

// Synthetics get liquid_solder with Brain Tumor instead of mannitol.
/datum/quirk/item_quirk/brainproblems/add_unique(client/client_source)
	if(!issynthetic(quirk_holder))
		return ..()
	give_item_to_holder(
		/obj/item/storage/pill_bottle/liquid_solder/braintumor,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
	)
