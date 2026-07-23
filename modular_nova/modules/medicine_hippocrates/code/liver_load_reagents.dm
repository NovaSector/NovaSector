/*
 * liver load assignments
 */

//******BRUTE******//

/datum/reagent/medicine/c2/libital
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BRUTE

/datum/reagent/medicine/c2/probital
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BRUTE

/datum/reagent/medicine/c2/helbital
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BRUTE

/datum/reagent/medicine/sal_acid
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BRUTE

/datum/reagent/medicine/mine_salve
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE

//******BURN******//

/datum/reagent/medicine/c2/lenturi
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BURN

/datum/reagent/medicine/c2/aiuri
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BURN

/datum/reagent/medicine/oxandrolone
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BURN

/datum/reagent/medicine/c2/hercuri
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BURN

//******TOXIN******//

/datum/reagent/medicine/c2/multiver
	liver_load = 1
	liver_load_flags = LIVER_LOAD_TOXIN

/datum/reagent/medicine/c2/syriniver
	liver_load = 1
	liver_load_flags = LIVER_LOAD_TOXIN

/datum/reagent/medicine/c2/musiver
	liver_load = 1
	liver_load_flags = LIVER_LOAD_TOXIN

/datum/reagent/medicine/c2/seiver
	liver_load = 1
	liver_load_flags = LIVER_LOAD_TOXIN

/datum/reagent/medicine/pen_acid
	liver_load = 1
	liver_load_flags = LIVER_LOAD_TOXIN

/datum/reagent/medicine/calomel
	liver_load = 1
	liver_load_flags = LIVER_LOAD_TOXIN

//******OXYGEN******//

/datum/reagent/medicine/salbutamol
	liver_load = 1
	liver_load_flags = LIVER_LOAD_OXYGEN

/datum/reagent/medicine/c2/convermol
	liver_load = 1
	liver_load_flags = LIVER_LOAD_OXYGEN

/datum/reagent/medicine/epinephrine
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_OXYGEN

/datum/reagent/medicine/albuterol
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_OXYGEN

//******MIXED AND PANACEAS******//

// Heals a bit of everything, so it lands in every pool and is a poor thing to pad a cocktail with.
/datum/reagent/medicine/omnizine
	liver_load = 1
	liver_load_flags = LIVER_LOAD_ALL

/datum/reagent/medicine/granibitaluri
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

/datum/reagent/medicine/salglu_solution
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

/datum/reagent/medicine/regen_jelly
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN
