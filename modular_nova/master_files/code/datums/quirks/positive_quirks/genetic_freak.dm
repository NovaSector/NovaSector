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
	"Autotomy" = /datum/mutation/self_amputation,
	"Glowy" = /datum/mutation/glow,
	"Anti-Glowy" = /datum/mutation/glow/anti,
	"Strength" = /datum/mutation/strong,
	"Stimmed" = /datum/mutation/stimmed,
	"Geladikinesis" = /datum/mutation/geladikinesis,
	"Cindikinesis" = /datum/mutation/cindikinesis,
	"Transcendent Olfaction" = /datum/mutation/olfaction,
	"Elastic Arms" = /datum/mutation/elastic_arms,
	"Webbing" = /datum/mutation/webbing,
	"Mending Touch" = /datum/mutation/lay_on_hands,
	"Pressure Adaptation" = /datum/mutation/adaptation/pressure,
	"Cold Adaptation" = /datum/mutation/adaptation/cold,
	"Heat Adaptation" = /datum/mutation/adaptation/heat,
	"Restorative Metabolism" = /datum/mutation/restorative_metabolism,
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

	return "Genetic Mutation" in preferences.all_quirks

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
