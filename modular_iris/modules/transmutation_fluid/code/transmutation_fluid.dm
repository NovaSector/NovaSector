//Transmutation fluid, a chem that makes some reagents into certain base reagents!
/datum/reagent/transmutation_fluid
	name = "Transmutation Fluid"
	description = "An odd fluid that can turn one reagent into a different base reagent. Commonly found with tribal chemists."
	ph = 5
	color = "#CC8899"
	taste_description = "fruity transfiguration"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	metabolization_rate = 0.5 // fast

/datum/chemical_reaction/transmutation_fluid
	results = list(/datum/reagent/transmutation_fluid = 3)
	required_reagents = list(/datum/reagent/consumable/entpoly = 1, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/tinlux = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

//Oil and hydrogen makes welding fuel
/datum/chemical_reaction/transmutation/fuel
	results = list(/datum/reagent/fuel = 2)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/hydrogen = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/transmutation/iodine
	results = list(/datum/reagent/iodine = 1)
	required_reagents = list(/datum/reagent/water/salt = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/transmutation/bromine
	results = list(/datum/reagent/bromine = 2)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/chlorine = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/transmutation/sulfur
	results = list(/datum/reagent/sulfur = 2)
	required_reagents = list(/datum/reagent/phosphorus = 1, /datum/reagent/hydrogen = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/transmutation/fluorine
	results = list(/datum/reagent/fluorine = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/chlorine = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/transmutation/copper
	results = list(/datum/reagent/copper = 2)
	required_reagents = list(/datum/reagent/iron = 1, /datum/reagent/gold = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/transmutation/acid
	results = list(/datum/reagent/toxin/acid = 2)
	required_reagents = list(/datum/reagent/sulfur = 1, /datum/reagent/uranium/radium = 1)
	required_catalysts = list(/datum/reagent/transmutation_fluid = 1)
	optimal_ph_min = 0
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_OTHER
