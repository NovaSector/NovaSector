
/datum/quirk/item_quirk/lunchbox_owner
	name = "Lunchbox User"
	desc = "You brought a lunch, homemade or not, you decided to pack one for yourself!"
	icon = FA_ICON_BOX
	value = 2
	mob_trait = TRAIT_LUNCHBOX_OWNER
	gain_text = span_notice("You brought your lunchbox with you, yippee!.")
	lose_text = span_danger("The feeling... the love... the passion for a home made meal leaves you... a tear sheds down your face, a weep... a sorrow... an apology as you say goodbye to your delicious homemade delectables.")
	medical_record_text = "Patient mentions their fondness from exterior foods and drinks."
	mail_goodies = list()

	/// What design of lunchbox does the player want?
	var/lunchbox_design = NONE

	/// What meal does the player want?
	var/lunchbox_meal_choice = NONE

	/// What is the first snack player wants?
	var/lunchbox_first_snack_choice = NONE

	/// What is the second snack players want
	var/lunchbox_second_snack_choice = NONE

	/// What is the drink players want?
	var/lunchbox_drink_choice = NONE

	/// What is the dessert players want?
	var/lunchbox_dessert_choice = NONE

/datum/quirk_constant_data/lunchbox_owner
	associated_typepath = /datum/quirk/item_quirk/lunchbox_owner
	customization_options = list(
		/datum/preference/choiced/lunchbox_design,
		/datum/preference/choiced/lunchbox_meal_choice,
		/datum/preference/choiced/lunchbox_first_snack_choice,
		/datum/preference/choiced/lunchbox_second_snack_choice,
		/datum/preference/choiced/lunchbox_drink_choice,
		/datum/preference/choiced/lunchbox_desert_choice
		)

/datum/quirk/item_quirk/lunchbox_owner/add_unique(client/client_source)

	/// What design does this character have for their
	var/desired_design = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_design) || "Random"

	/// if NOT random, this lunchbox will pick the desired lunchbox
	if(desired_design != "Random")
		lunchbox_design = GLOB.possible_player_lunchbox_design_choice[desired_design]

	/// If no box design is picked WE'RE PICKIN FOR EM!!!
	if(lunchbox_design == NONE)
		lunchbox_design = pick(flatten_list(GLOB.possible_player_lunchbox_design_choice))

	/// What meal is this character CRAVING for?
	var/desired_meal = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_meal_choice) || "Random"
	/// picks a random lunchox from the list
	if(desired_meal != "Random")
		lunchbox_meal_choice = GLOB.possible_player_lunchbox_meal_choice[desired_meal]
	/// If no box design is picked WE'RE PICKIN FOR EM!!!
	if(lunchbox_meal_choice == NONE)
		lunchbox_meal_choice = pick(flatten_list(GLOB.possible_player_lunchbox_meal_choice))

	/// What snack does this character desire?
	var/desired_snack

	/// You get two snackies
	var/desired_snack_2

	/// What are they thirsty for?
	var/desired_drink

	/// Got room for desert?
	var/desired_desert

	var/obj/item/storage/toolbox/lunchbox = new /obj/item/storage/toolbox/lunchbox(get_turf(quirk_holder))

	lunchbox.PopulateContents(list(desired_meal,))


	give_item_to_holder(
		lunchbox,
		list(
			LOCATION_HANDS,
		),
		flavour_text = "Looks well packed... delicious!",
		notify_player = TRUE,
	)

/datum/preference/choiced/lunchbox_design
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_design"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(possible_player_lunchbox_design_choice, list(
	"NT Branded Lunchbox" = /mob/living/basic/axolotl,
))

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

GLOBAL_LIST_INIT(possible_player_lunchbox_meal_choice, list(
	"DEBUG" = list(/mob/living/basic/pet/penguin/baby/permanent),
))

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

/// Snack choice

/datum/preference/choiced/lunchbox_first_snack_choice
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_first_snack_choice"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(possible_player_lunchbox_snack_choice, list(
	"DEBUG" = list(/mob/living/basic/pet/penguin/baby/permanent),
))

/datum/preference/choiced/lunchbox_first_snack_choice/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_snack_choice)

/datum/preference/choiced/lunchbox_first_snack_choice/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_first_snack_choice/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Lunchbox User" in preferences.all_quirks

/datum/preference/choiced/lunchbox_first_snack_choice/apply_to_human(mob/living/carbon/human/target, value)
	return

/// Snack choice 2 Electric Boogaloo

/datum/preference/choiced/lunchbox_second_snack_choice
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_second_snack_choice"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(lunchbox_second_snack_choice, list(
	"DEBUG" = list(/mob/living/basic/pet/penguin/baby/permanent),
))

/datum/preference/choiced/lunchbox_second_snack_choice/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_snack_choice)

/datum/preference/choiced/lunchbox_second_snack_choice/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_second_snack_choice/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Lunchbox User" in preferences.all_quirks

/datum/preference/choiced/lunchbox_second_snack_choice/apply_to_human(mob/living/carbon/human/target, value)
	return

/// Drink Choice

/datum/preference/choiced/lunchbox_drink_choice
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_drink_choice"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(possible_player_lunchbox_drink_choice, list(
	"DEBUG" = list(/mob/living/basic/pet/penguin/baby/permanent),
))

/datum/preference/choiced/lunchbox_drink_choice/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_drink_choice)

/datum/preference/choiced/lunchbox_drink_choice/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_drink_choice/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Lunchbox User" in preferences.all_quirks

/datum/preference/choiced/lunchbox_drink_choice/apply_to_human(mob/living/carbon/human/target, value)
	return

/// Dessert Choice

/datum/preference/choiced/lunchbox_desert_choice
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "lunchbox_desert_choice"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(possible_player_lunchbox_desert_choice, list(
	"DEBUG" = list(/mob/living/basic/pet/penguin/baby/permanent),
))

/datum/preference/choiced/lunchbox_desert_choice/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_desert_choice)

/datum/preference/choiced/lunchbox_desert_choice/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_desert_choice/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Lunchbox User" in preferences.all_quirks
/datum/preference/choiced/lunchbox_desert_choice/apply_to_human(mob/living/carbon/human/target, value)
	return

