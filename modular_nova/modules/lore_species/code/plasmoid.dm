/datum/species/plasmaman
	name = "\improper Plasmoid"
	wikilink = "Lore:Plasmamen"

/datum/species/plasmaman/get_species_description()
	return "A sentient fungal colony wrapped around the supporting of a humanoid form (either skeletal or living) for structural integrity, the Plasmoid are an enigmatic myconid species that are especially alien, even amongst aliens. Many are hardly visible beneath their envirosuits, as the high-plasma atmosphere needed for them to survive is also their greatest complication in a spacefaring setting."

/datum/species/plasmaman/get_species_lore()
	return list(
		"Discovered almost entirely by accident, the first Plasmoid colony was recorded as a result of an unnamed NanoTrasen scientist who fell into a vat of liquified plasma upon a distant outpost. After the vat's subsequent ignition, what was recovered from the vat was observed to have a peculiar fungus subsisting on and attempting to reconfigure the mostly skeletal remains. After extensive study, it was determined that the colony was capable of complex thought, and with sufficient mass and arrangement, could achieve levels of sapience enough to be classified as their own distinct species.",

		"A networked morass of single-celled myconids, the gestalt consciousness that emerges between individual Plasmoid myconids communicating with one another takes enough of a shape to resemble a fully living creature, though with distinct differences in cognition compared to most other races. Depending on how quickly the colony chooses to consume the humanoid remains they require for stability, they may emerge either as a completely alien mind (if said remains are devoured quickly), or with fragmented memories and behavioural patterns of their original host (if devoured slowly).",

		"In certain rare cases, a body may be consumed slowly enough that the colony takes on an almost completely identical nature to its hosts. Some still-living creatures infected with Plasmoid colonies have even brokered arrangements with their gestalt consciousnesses, the colony agreeing to support their waning frame until its original host expires naturally, then fully taking over what is left.",

		"Though uncommon, it is not unusual to see Plasmoids hired as working personnel on many space stations, especially in research divisions as experimental subjects, guards, or even scientists themselves. Being relatively few in number, they possess little political presence, and are protected almost solely by their scientific novelty and ongoing efforts from many corporations to research their peculiar existence."
	)

/datum/species/plasmaman/create_pref_unique_perks()
	return list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "user-shield",
			SPECIES_PERK_NAME = "Myconid Resistance",
			SPECIES_PERK_DESC = "Plasmoids are unaffected by radiation, poisions, and practically all known diseases (save for deliberately engineered samples).",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Fungal Ligaments",
			SPECIES_PERK_DESC = "Plasmoid colonies can resist wounding damage that would otherwise cripple their host ordinarily.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wind",
			SPECIES_PERK_NAME = "Plasma Metabolism",
			SPECIES_PERK_DESC = "Plasmoids can heal themselves and their host by consuming plasma.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "hard-hat",
			SPECIES_PERK_NAME = "Envirosuit Integration",
			SPECIES_PERK_DESC = "Galactic standards dictate that Plasmoid envirosuits contain welding shields and an inbuilt flashlight.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Combustible",
			SPECIES_PERK_DESC = "The plasma-adjacent biology of a Plasmoid causes it to spontaneously ignite upon contact with oxygen. This can be lethal.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "briefcase-medical",
			SPECIES_PERK_NAME = "Complex Biology",
			SPECIES_PERK_DESC = "Plasmoids are highly unusual lifeforms and require special medical setups in order to revive and resuscitate - if revival is even available as an option at all."
		),
	)
