// ETHEREAL LORE OVERRIDES

/datum/species/ethereal
	wikilink = "Lore:Ethereals"

/datum/species/ethereal/get_species_description()
	return "Translucent, biovoltaic creatures with glassy skin, luminescent electron-heavy blood, crystalline bones and geode-like organs. Reproduces mostly via fission (splitting into two), sometimes resulting in entire lineages sharing traits, preferences, and even skills they may never remember actively learning. Functionally immortal, retreating into a central 'core' upon death for self-revival."

/datum/species/ethereal/get_species_lore()
	return list("Rising out the scenic and lethal vistas of their homeworld Where All Is Found, Ethereals came into existence as one of the most truly 'alien' lifeforms in the Orion Spur. The environment of their homeworld is a highly lethal one, presenting as a tropical biosphere wracked by energy storms and harsh, extreme temperatures pumping enough energy into the planet itself to create astounding levels of tectonic activity.",

	"Spawned by monumental bioelectric floral growths known as 'Worldtrees', a nascent Ethereal may be born by a rare fruiting event, or created via fission from an existing Ethereal quite literally, splitting into two.",

	"Developing without the concept of war and conflict, and presiding largely at the apex of the food chain in their hyper-lethal homeworld, the Ethereals have developed into a culture without overarching drives and ambition. Most (but not all) are content to proliferate their values of harmony and cooperation amongst the stars, even as they enter a universe every bit as alien to them as their physiology and way of life is to others."
	)

/datum/species/ethereal/create_pref_unique_perks()
	return list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bolt",
			SPECIES_PERK_NAME = "Biovioltaic Metabolism",
			SPECIES_PERK_DESC = "Ethereals can feed on electricity from APCs and other sources, and do not otherwise need to eat. Normally harmful shocks will feed them instead.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "lightbulb",
			SPECIES_PERK_NAME = "Luminescent Blood",
			SPECIES_PERK_DESC = "Colloquially designated as 'liquid electricity', a Ethereal's blood casts its own ever-present light as a glowstick might.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "gem",
			SPECIES_PERK_NAME = "Crystalline Regenerative Stasis",
			SPECIES_PERK_DESC = "True death is rare among the Ethereal, as they retreat inwardly into a regenerative crystalline stasis upon critical damage, though the process is mentally draining and highly traumatic for some.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "fist-raised",
			SPECIES_PERK_NAME = "Contact Discharge",
			SPECIES_PERK_DESC = "Ethereals deal burn damage with their punches instead of brute.",
		),
	)
