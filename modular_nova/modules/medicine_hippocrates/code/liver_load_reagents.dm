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


//******MIXED AND PANACEAS******//

// Heals a bit of everything, so it lands in every pool and is a poor thing to pad a cocktail with.
/datum/reagent/medicine/omnizine
	liver_load = 1
	liver_load_flags = LIVER_LOAD_ALL

/datum/reagent/medicine/omnizine/godblood
	liver_load = 0
	liver_load_flags = NONE

/datum/reagent/medicine/granibitaluri
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

/datum/reagent/medicine/salglu_solution
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

/datum/reagent/medicine/regen_jelly
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

/datum/reagent/medicine/rezadone
	liver_load = 0.5
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

//******TOPICAL******//

// Synthflesh heals from expose_mob() rather than on_mob_life(), so compute_metabolization() never
// sees it. Patching still puts it in the bloodstream, so it feeds the pools normally.
/datum/reagent/medicine/c2/synthflesh
	liver_load = 1
	liver_load_flags = LIVER_LOAD_BRUTE|LIVER_LOAD_BURN

/datum/reagent/medicine/c2/synthflesh/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	// The parent scales its brute/burn heal and nothing else by (1 - touch_protection), so folding
	// efficiency in here dampens the healing without touching wound treatment or the unhusk threshold.
	if(CONFIG_GET(flag/medicine_hippocrates) && iscarbon(exposed_mob) && (methods & (PATCH|TOUCH|VAPOR)))
		var/mob/living/carbon/carbon_mob = exposed_mob
		touch_protection = 1 - ((1 - touch_protection) * get_liver_load_efficiency(carbon_mob, carbon_mob.reagents))
	return ..(exposed_mob, methods, reac_volume, show_message, touch_protection)
