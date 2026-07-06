/// Assoc list of mutation names to list of restricted species typepaths
/// Add more entries here to restrict additional mutations from specific species
GLOBAL_LIST_INIT(genetic_mutation_species_restrictions, list(
	"Restorative metabolism" = list(
		/datum/species/jelly,
		/datum/species/hemophage,
		/datum/species/pod,
		/datum/species/shadekin,
	),
	"Cold adaptation" = list(
		/datum/species/jelly,
	),
))

GLOBAL_LIST_INIT(genetic_mutation_choice, list(
	"Antenna" = /datum/mutation/antenna,
	"Anti-Glowy" = /datum/mutation/glow/anti,
	"Autotomy" = /datum/mutation/self_amputation,
	"Cindikinesis" = /datum/mutation/cindikinesis,
	"Chav" = /datum/mutation/chav,
	"Cold Adaptation" = /datum/mutation/adaptation/cold,
	"Cough" = /datum/mutation/cough,
	"Elastic Arms" = /datum/mutation/elastic_arms,
	"Geladikinesis" = /datum/mutation/geladikinesis,
	"Glowy" = /datum/mutation/glow,
	"Heat Adaptation" = /datum/mutation/adaptation/heat,
	"Medieval" = /datum/mutation/medieval,
	"Mending Touch" = /datum/mutation/lay_on_hands,
	"Nervousness" = /datum/mutation/nervousness,
	"Pressure Adaptation" = /datum/mutation/adaptation/pressure,
	"Restorative Metabolism" = /datum/mutation/restorative_metabolism,
	"Stimmed" = /datum/mutation/stimmed,
	"Strength" = /datum/mutation/strong,
	"Transcendent Olfaction" = /datum/mutation/olfaction,
	"Webbing" = /datum/mutation/webbing,
))

/datum/quirk/genetic_mutation
	name = "Genetic Mutation"
	desc = "Usually when you go one on one with another spaceman, you've got a 50/50 chance of winning. But, you've got an unusual genetic mutation, and you're not normal. Now the chance is still 50/50!"
	icon = FA_ICON_RECEIPT
	value = 6
	gain_text = "You got a 33 and 1/3 chance of winning!"
	lose_text = "The numbers don't lie, and they spell disaster for you!."
	medical_record_text = "Patient has unusual genetic sequences."
	/// The mutation that's applied to the mob, for ease of removal
	var/applied_mutation

/datum/quirk/genetic_mutation/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_GENELESS in species_traits)
		return FALSE
	return ..()

/datum/quirk_constant_data/genetic_mutation
	associated_typepath = /datum/quirk/genetic_mutation
	customization_options = list(/datum/preference/choiced/genetic_mutation)

/datum/quirk/genetic_mutation/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/mutation_path = GLOB.genetic_mutation_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/genetic_mutation)]
	applied_mutation = mutation_path
	human_holder.dna.add_mutation(applied_mutation, MUTATION_SOURCE_MUTATOR, 0)

/datum/quirk/genetic_mutation/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.remove_mutation(applied_mutation, MUTATION_SOURCE_MUTATOR)

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

	return /datum/quirk/genetic_mutation::name in preferences.all_quirks

/// Helper proc to check if a mutation is restricted for a given species
/// Returns TRUE if the mutation is restricted (not allowed), FALSE otherwise
/proc/is_mutation_restricted_for_species(mutation_name, datum/species/mob_species)
	var/list/restrictions = GLOB.genetic_mutation_species_restrictions[mutation_name]
	if(!restrictions)
		return FALSE

	for(var/restricted_type in restrictions)
		if(ispath(mob_species, restricted_type))
			return TRUE

	return FALSE

/datum/preference/choiced/genetic_mutation/is_valid(value, datum/preferences/preferences)
	// First check if the value is in the allowed choices
	if(!(value in get_choices()))
		return FALSE

	var/datum/species/mob_species = preferences.read_preference(/datum/preference/choiced/species)

	// Check if this mutation is restricted for the selected species
	if(is_mutation_restricted_for_species(value, mob_species))
		to_chat(preferences.parent, span_warning("[value] is not compatible with your current species."))
		return FALSE

	return TRUE

/datum/preference/choiced/genetic_mutation/apply_to_human(mob/living/carbon/human/target, value)
	return
