
/datum/quirk/item_quirk/lunchbox_owner
	name = "Lunchbox User"
	desc = "You brought a lunch, homemade or not, you decided to pack one for yourself!"
	icon = FA_ICON_BOX_OPEN
	value = 2
	mob_trait = TRAIT_LUNCHBOX_OWNER
	gain_text = span_notice("You brought your lunchbox with you, yippee!.")
	lose_text = span_danger("The feeling... the love... the passion for a home made meal leaves you... a tear sheds down your face, a weep... a sorrow... an apology as you say goodbye to your delicious homemade delectables.")
	medical_record_text = "Patient mentions their fondness from exterior foods and drinks."
	mail_goodies = list()
	var/lunchbox_design = NONE
	var/lunchbox_meal_choice = NONE

/datum/quirk_constant_data/lunchbox_owner
	associated_typepath = /datum/quirk/item_quirk/lunchbox_owner
	customization_options = list(/datum/quirk/item_quirk/lunchbox_owner, /datum/preference/choiced/lunchbox_design, /datum/preference/choiced/lunchbox_meal_choice)

/datum/quirk/item_quirk/lunchbox_owner/add_unique(client/client_source)
	var/desired_design = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_design) || "Random"
	var/desired_meal = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_meal_choice) || "Random"

	/// picks a random lunchox from the list
	if(desired_design != "Random")
		lunchbox_design = GLOB.possible_player_lunchbox_design_choice[desired_design]
	/// If no box design is picked WE'RE PICKIN FOR EM!!!
	if(lunchbox_design == NONE)
		lunchbox_design = pick(flatten_list(GLOB.possible_player_lunchbox_design_choice))

	/// picks a random lunchox from the list
	if(desired_meal != "Random")
		lunchbox_meal_choice = GLOB.possible_player_lunchbox_design_choice[desired_meal]
	/// If no box design is picked WE'RE PICKIN FOR EM!!!
	if(lunchbox_meal_choice == NONE)
		lunchbox_meal_choice = pick(flatten_list(GLOB.possible_player_lunchbox_design_choice))

	/// Gives the item to the user
	var/obj/item/pet_carrier/carrier = new /obj/item/pet_carrier(get_turf(quirk_holder))
	give_item_to_holder(
		carrier,
		list(
			LOCATION_HANDS,
		),
		flavour_text = "Looks tightly packed - you might not be able to put the pet back in once they're out.",
		notify_player = TRUE,
	)


// Lunchbox_options
GLOBAL_LIST_INIT(possible_player_lunchbox_design_choice, list(
	"NT Branded Lunchbox" = /mob/living/basic/axolotl,
))

GLOBAL_LIST_INIT(possible_player_lunchbox_meal_choice, list(
	"DEBUG" = list(/mob/living/basic/pet/penguin/baby/permanent,/mob/living/basic/pet/penguin/baby/permanent,/mob/living/basic/pet/penguin/baby/permanent),
))

/// Lunchbox Design

/datum/preference/choiced/lunchbox_design
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_design"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/lunchbox_design/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_design_choice)

/datum/preference/choiced/lunchbox_design/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_design/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Lunchbox User" in preferences.all_quirks

/datum/preference/choiced/lunchbox_design/apply_to_human(mob/living/carbon/human/target, value)
	return

/// Meal choice

/datum/preference/choiced/lunchbox_meal_choice
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_meal_choice"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/lunchbox_meal_choice/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_meal_choice)

/datum/preference/choiced/lunchbox_meal_choice/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_meal_choice/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Lunchbox User" in preferences.all_quirks

/datum/preference/choiced/lunchbox_meal_choice/apply_to_human(mob/living/carbon/human/target, value)
	return





