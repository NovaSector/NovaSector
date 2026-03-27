// Interdyne Pharmaceuticals — Medicine Recipes
// All require Dynexil as a precursor (consumed in the reaction).

/datum/chemical_reaction/medicine/interdyne
	reaction_tags = REACTION_TAG_HEALING | REACTION_TAG_EASY

/datum/chemical_reaction/medicine/interdyne/bicardyne
	results = list(/datum/reagent/medicine/interdyne/bicardyne = 3)
	required_reagents = list(
		/datum/reagent/medicine/interdyne/dynexil = 1,
		/datum/reagent/medicine/sal_acid = 1,
		/datum/reagent/iron = 1,
	)
	mix_message = "The solution thickens into a lavender-tinted gel."

/datum/chemical_reaction/medicine/interdyne/thermapyne
	results = list(/datum/reagent/medicine/interdyne/thermapyne = 3)
	required_reagents = list(
		/datum/reagent/medicine/interdyne/dynexil = 1,
		/datum/reagent/medicine/oxandrolone = 1,
		/datum/reagent/medicine/c2/aiuri = 1,
	)
	mix_message = "The solution warms noticeably and turns a vivid orange-red."

/datum/chemical_reaction/medicine/interdyne/omnidyne
	results = list(/datum/reagent/medicine/interdyne/omnidyne = 3)
	required_reagents = list(
		/datum/reagent/medicine/interdyne/dynexil = 1,
		/datum/reagent/medicine/omnizine = 1,
		/datum/reagent/carbon = 1,
	)
	mix_message = "The mixture glows briefly with a faint green luminescence."

// Exotic drug recipes

/datum/chemical_reaction/drug/interdyne
	reaction_tags = REACTION_TAG_DRUG | REACTION_TAG_EASY

/datum/chemical_reaction/drug/interdyne/panaclarinz
	results = list(/datum/reagent/drug/interdyne/panaclarinz = 3)
	required_reagents = list(
		/datum/reagent/medicine/interdyne/dynexil = 1,
		/datum/reagent/medicine/omnizine = 1,
		/datum/reagent/drug/mushroomhallucinogen = 1,
	)
	mix_message = "The mixture shimmers with an otherworldly purple iridescence."

/datum/chemical_reaction/drug/interdyne/velocitol
	results = list(/datum/reagent/drug/interdyne/velocitol = 3)
	required_reagents = list(
		/datum/reagent/medicine/interdyne/dynexil = 1,
		/datum/reagent/medicine/epinephrine = 1,
		/datum/reagent/nitrogen = 1,
	)
	mix_message = "The solution crackles briefly and turns a vivid cyan."

/datum/chemical_reaction/drug/interdyne/neurophrene
	results = list(/datum/reagent/drug/interdyne/neurophrene = 3)
	required_reagents = list(
		/datum/reagent/medicine/interdyne/dynexil = 1,
		/datum/reagent/medicine/mannitol = 1,
		/datum/reagent/mercury = 1,
	)
	mix_message = "The mixture sparks with a faint chartreuse glow and emits a sharp chemical odor."
