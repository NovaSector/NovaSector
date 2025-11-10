// Grants additional music instruments to synthetic humanoids
/obj/item/disk/neuroware/synthesizer
	name = "blank instruments neuroware"
	desc = "A neuroware chip containing additional musical instruments to be played via a synthetic humanoid's built-in audio synthesizer."
	icon_state = "/obj/item/disk/neuroware/synthesizer"
	post_init_icon_state = "chip_nt"
	success_message = "instruments upgraded"
	manufacturer_tag = NEUROWARE_NT
	can_hack = FALSE
	var/list/add_instrument_ids

/obj/item/disk/neuroware/synthesizer/install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	var/datum/action/sing_tones/sing_action = locate(/datum/action/sing_tones) in target.actions
	// Mob has robotic brain, but isn't synthetic humanoid species
	if(isnull(sing_action))
		balloon_alert(user, "chip incompatible!")
		return FALSE
	var/datum/song/song = sing_action.song
	// Prevent installing multiple times
	if(song.allowed_instrument_ids.Find(add_instrument_ids[1]))
		balloon_alert(user, "already installed!")
		return FALSE
	// Add the new instrments
	song.allowed_instrument_ids += add_instrument_ids
	song.set_instrument(add_instrument_ids[1])
	return TRUE

/obj/item/disk/neuroware/synthesizer/brass
	name = "brass & wind instruments neuroware"
	desc = "A neuroware chip containing wind and brass synthesizer instruments to be played via a synthetic person's built-in audio synthesizer."
	add_instrument_ids = list("harmonica", "crharmony", "crbrass", "trombone", "saxophone", "crtrumpet", "trombone", "crtrombone")
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/disk/neuroware/synthesizer/guitar
	name = "guitar & strings instruments neuroware"
	desc = "A neuroware chip containing guitar and string synthesizer instruments to be played via a synthetic person's built-in audio synthesizer. Includes bonus banjo instrument!"
	add_instrument_ids = list("banjo", "guitar", "eguitar", "csteelgt", "cnylongt", "ccleangt", "cmutedgt", "violin")
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/disk/neuroware/synthesizer/percussion
	name = "percussion instruments neuroware"
	desc = "A neuroware chip containing percussion synthesizer instruments to be played via a synthetic person's built-in audio synthesizer."
	add_instrument_ids = list("xylophone", "glockenspiel", "crvibr", "sgmmbox", "r3celeste")
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/disk/neuroware/synthesizer/piano
	name = "piano instruments neuroware"
	desc = "A neuroware chip containing piano synthesizer instruments to be played via a synthetic person's built-in audio synthesizer."
	add_instrument_ids = list("piano", "r3grand", "r3harpsi", "crharpsi", "crgrand1", "crbright1", "crichugan", "crihamgan", "crack")
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

///Neuroware which spawns in maintenance and have random reagent contents
/obj/item/disk/neuroware/maintenance
	name = "unlabeled neuroware"
	desc = "A strange neuroware chip found in the depths of maintenance."
	icon_state = "/obj/item/disk/neuroware/maintenance"
	post_init_icon_state = "chip_generic"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	can_hack = FALSE
	var/static/list/maint_neuroware_names = list(
		"trashed neuroware",
		"unlabeled neuroware",
		"strange neuroware",
		"hacked neuroware",
		"upgraded neuroware",
		"ominous neuroware",
		"homebrew neuroware"
	)
	var/static/list/maint_neuroware_descs = list(
		"Your feeling is telling you no, but...",
		"Neuroware is expensive, you can't afford not to try any that you find.",
		"Surely, there's no way this could go bad.",
		"You wouldn't download a random- oh what the heck!",
		"Free neuroware? At no cost, how could I lose?"
	)
	var/static/list/maint_neuroware_casings = list("chip_maint", "chip_caseless", "chip_generic")
	var/static/list/maint_neuroware_colors = list(
		CIRCUIT_COLOR_GENERIC,
		CIRCUIT_COLOR_COMMAND,
		CIRCUIT_COLOR_SECURITY,
		CIRCUIT_COLOR_SCIENCE,
		CIRCUIT_COLOR_SERVICE,
		CIRCUIT_COLOR_MEDICAL,
		CIRCUIT_COLOR_ENGINEERING,
		CIRCUIT_COLOR_SUPPLY
	)

/obj/item/disk/neuroware/maintenance/Initialize(mapload)
	name = pick(maint_neuroware_names)
	var/datum/reagent/random_reagent = get_random_neuroware()
	list_reagents = list()
	list_reagents[random_reagent] = rand(10, initial(random_reagent.overdose_threshold) - 1)
	if(prob(30))
		desc = pick(maint_neuroware_descs)
		icon_state = pick(maint_neuroware_casings)
		greyscale_colors = pick(maint_neuroware_colors)
	return ..()
