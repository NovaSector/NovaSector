// Synthetic humanoid equivalent of the sleepy pen
/obj/item/disk/neuroware/sleepy
	name = "suspicious neuroware"
	desc = "A suspicious looking neuroware chip, it contains unknown programs..."
	icon_state = "/obj/item/disk/neuroware/sleepy"
	post_init_icon_state = "chip_syndie"
	greyscale_colors = "#474747"
	list_reagents = list(
		/datum/reagent/toxin/chloralhydrate/synth = 20,
		/datum/reagent/toxin/mutetoxin/synth = 15,
		/datum/reagent/toxin/staminatoxin/synth = 10,
	)
	manufacturer_tag = NEUROWARE_SYNDIE
	// Can be used on the target instantly
	external_delay = 0
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "This Syndicate neuroware chip contains CrypSys, a package of ransomware viruses targeting synthetic humanoids. Designed to temporarily render the target mute, immobile, and unconscious."
