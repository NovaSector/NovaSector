/datum/reagent/drug/aphrodisiac/dapoxetine
	name = "Dapoxetine"
	description = "Naphthalene and benzene rings linked via a propyl chain which contains a dimethylamine group. Prevents ejaculation by inhibiting the reuptake of serotonin."
	taste_description = "intense bitterness"
	color = "#e5e5e5"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_NO_RANDOM_RECIPE
	life_pref_datum = /datum/preference/toggle/erp/aphro
	added_traits = list(TRAIT_NO_CLIMAX)

/datum/chemical_reaction/dapoxetine
	results = list(/datum/reagent/drug/aphrodisiac/dapoxetine = 10)
	required_reagents = list(
		/datum/reagent/diethylamine = 1,
		/datum/reagent/acetone = 1,
		/datum/reagent/phenol = 2,
	)
	required_temp = 379
	mix_message = "The solution bubbles into a white powdery substance..."
	erp_reaction = TRUE
