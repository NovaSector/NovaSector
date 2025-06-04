/datum/quirk/item_quirk/narcolepsy
	species_quirks = list(/datum/species/synthetic = /datum/quirk/item_quirk/narcolepsy/synth)
	/// Used in [/datum/quirk/item_quirk/narcolepsy/add_unique()]
	/// Handled by an edit in [code\datums\quirks\negative_quirks\narcolepsy.dm]
	var/stim_medication = /obj/item/storage/pill_bottle/prescription_stimulant

/datum/quirk/item_quirk/narcolepsy/synth
	name = "Spurious Interrupt Error"
	medical_record_text = "Patient is malfunctioning and may involuntarily reboot during normal operation."
	mail_goodies = list(
		/obj/item/food/energybar,
		/obj/item/disk/neuroware/pumpup,
		/obj/item/disk/neuroware/synaptizine,
	)
	hidden_quirk = TRUE
	stim_medication = /obj/item/storage/box/flat/neuroware/synaptizine
