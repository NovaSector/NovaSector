GLOBAL_LIST_INIT(genetic_mutation_choice, list(
	"Antenna" = /datum/mutation/human/antenna,
	"Autotomy" = /datum/mutation/human/self_amputation,
	"Glowy" = /datum/mutation/human/glow,
	"Anti-Glowy" = /datum/mutation/human/glow/anti,
	"Strength" = /datum/mutation/human/strong,
	"Stimmed" = /datum/mutation/human/stimmed,
	"Chameleon" = /datum/mutation/human/chameleon,
	"Geladikinesis" = /datum/mutation/human/geladikinesis,
	"Cindikinesis" = /datum/mutation/human/cindikinesis,
	"Transcendent Olfaction" = /datum/mutation/human/olfaction,
	"Elastic Arms" = /datum/mutation/human/elastic_arms,
	"Webbing" = /datum/mutation/human/webbing,
))

/datum/quirk/genetic_mutation
	name = "Genetic Mutation"
	desc = "For some reason or another, you've got an unusual genetic mutation, the rest is up to fate."
	icon = FA_ICON_RECEIPT
	value = 6
	gain_text = "If everyone's super, no one is."
	lose_text = "You feel like everyone else might be super after all."
	medical_record_text = "Patient has unusual genetic sequences."
	/// The mutation that's applied to the mob, for ease of removal
	var/applied_mutation

/datum/quirk_constant_data/genetic_mutation
	associated_typepath = /datum/quirk/genetic_mutation
	customization_options = list(/datum/preference/choiced/genetic_mutation)

/datum/quirk/genetic_mutation/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/mutation_path = GLOB.genetic_mutation_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/genetic_mutation)]
	applied_mutation = mutation_path
	human_holder.dna.add_mutation(applied_mutation, MUT_OTHER, 0)

/datum/quirk/genetic_mutation/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.remove_mutation(applied_mutation)

/datum/preference/choiced/genetic_mutation
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "genetic_mutation"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/genetic_mutation/init_possible_values()
	return GLOB.genetic_mutation_choice

/datum/preference/choiced/genetic_mutation/create_default_value()
	return "Strength"

/datum/preference/choiced/genetic_mutation/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Genetic Mutation" in preferences.all_quirks

/datum/preference/choiced/genetic_mutation/apply_to_human(mob/living/carbon/human/target, value)
	return
