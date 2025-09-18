// Re-labels TG brainproblems to be more generic. There never was a tumor anyways!
/datum/quirk/item_quirk/brainproblems
	name = "Brain Degeneration"
	desc = "You have a lethal condition in your brain that is slowly destroying it. Better bring some mannitol!"
	medical_record_text = "Patient has a lethal condition in their brain that is slowly causing brain death."
	icon = FA_ICON_BRAIN
	species_quirks = list(/datum/species/synthetic = /datum/quirk/item_quirk/brainproblems/synth)

// Override of Brain Tumor quirk for species with artificial brains.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/item_quirk/brainproblems/synth
	name = "Positronic Cascade Anomaly"
	gain_text = span_danger("You feel glitchy.")
	lose_text = span_notice("You no longer feel glitchy.")
	mail_goodies = list(/obj/item/storage/pill_bottle/liquid_solder/braintumor)
	abstract_parent_type = /datum/quirk/item_quirk/brainproblems/synth

// Adds custom medical flavortext for synthetic brains.
/datum/quirk/item_quirk/brainproblems/synth/add()
	. = ..()
	var/obj/item/organ/brain/synth/synth_brain = quirk_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
	switch(synth_brain.type)
		if(/obj/item/organ/brain/synth)
			name = "Positronic Cascade Anomaly"
		if(/obj/item/organ/brain/synth/mmi)
			name = "Interface Rejection Syndrome"
		if(/obj/item/organ/brain/synth/circuit)
			name = "Processor Firmware Bug"
		if(/obj/item/organ/brain/synth/circuit/hyperboard)
			name = "Processor Firmware Bug"
		if(/obj/item/organ/brain/synth/circuit/limaengine)
			name = "Liquid Core Instability Anomaly"
		if(/obj/item/organ/brain/synth/circuit/disk)
			name = "Short-circuited Hardware"
		if(/obj/item/organ/brain/synth/circuit/neuroboard)
			name = "Neural System Malfunction"
		if(/obj/item/organ/brain/synth/circuit/condensed)
			name = "Crystal Destabilization"
		if(/obj/item/organ/brain/synth/circuit/cyberdeck)
			name = "System Destabilization"

	medical_record_text = "Patient has a malfunction in their [synth_brain.name] that is slowly causing brain death."

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
		flavour_text = "These pills will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
		notify_player = TRUE,
	)
