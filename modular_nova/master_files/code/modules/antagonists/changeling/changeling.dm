/datum/antagonist/changeling
	dna_max = 8 // changed from 6
	chem_recharge_rate = 0.5
	/// The time that the horror form died.
	var/true_form_death
	/// Any quirks that we don't want to be mimicked when transforming
	var/list/mimicable_quirks_list = list(
		"Bad Touch",
		"Sensitive Snout",
		"Ash aspect (Emotes)",
		"Canidae Traits",
		"Excitable!",
		"Feline Traits",
		"Floral aspect (Emotes)",
		"Heterochromatic",
		"Hydra Heads",
		"Oversized",
		"Personal Space",
		"Pseudobulbar Affect",
		"Shifty Eyes",
		"Smooth-Headed",
		"Sparkle aspect (Emotes)",
		"Water aspect (Emotes)",
		"Webbing aspect (Emotes)",
		"Friendly",
		"Avian Traits",
	)

/datum/antagonist/changeling/forge_objectives()
	return

/datum/changeling_profile
	/// The bra worn by the profile source
	var/bra
	/// The color of the undershirt used by the profile source
	var/undershirt_color
	/// The color of the socks used by the profile source
	var/socks_color
	/// The color of the bra used by the profile source
	var/bra_color
	/// The profile source's left eye color
	var/eye_color_left
	/// The profile source's right eye color
	var/eye_color_right
	/// Does the profile source's eyes glow
	var/emissive_eyes
	/// Profile source digi leg icons
	var/list/worn_icon_digi_list = list()
	/// profile source monkey icons
	var/list/worn_icon_monkey_list = list()
	/// Profile source vox icons
	var/list/worn_icon_teshari_list = list()
	/// The bra worn by the profile source
	var/list/worn_icon_vox_list = list()
	/// Support variation flags used by the profile source
	var/list/supports_variations_flags_list = list()
	/// The profile source scream type
	var/scream_type
	/// The profile source laugh type
	var/laugh_type
	/// The profile source mob height scaling
	var/target_height
	/// the profile source mob's size
	var/target_mob_size
