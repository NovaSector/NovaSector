
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
		lunchbox_design = pick(assoc_to_values(GLOB.possible_player_lunchbox_design_choice))

	/// What meal is this character CRAVING for?
	var/desired_meal = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_meal_choice) || "Random"
	/// picks a random lunchox from the list
	if(desired_meal != "Random")
		lunchbox_meal_choice = GLOB.possible_player_lunchbox_meal_choice[desired_meal]
	/// If no box design is picked WE'RE PICKIN FOR EM!!!
	if(lunchbox_meal_choice == NONE)
		lunchbox_meal_choice = pick(assoc_to_values(GLOB.possible_player_lunchbox_meal_choice))

	/// What snack does this character desire?
	var/desired_snack = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_first_snack_choice) || "Random"
	if(desired_snack != "Random")
		lunchbox_first_snack_choice = GLOB.possible_player_lunchbox_snack_choice[desired_snack]
	/// If no snack choice, WE PICKIN FOR EM!!
	if(lunchbox_first_snack_choice == NONE)
		lunchbox_first_snack_choice = pick(assoc_to_values(GLOB.possible_player_lunchbox_snack_choice))

	/// What snack does this character desire?
	var/desired_snack_2 = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_second_snack_choice) || "Random"
	if(desired_snack_2 != "Random")
		lunchbox_second_snack_choice = GLOB.possible_player_lunchbox_snack_choice[desired_snack_2]
	/// If no snack choice, WE PICKIN FOR EM!!
	if(lunchbox_second_snack_choice == NONE)
		lunchbox_second_snack_choice = pick(assoc_to_values(GLOB.possible_player_lunchbox_snack_choice))

	/// What are they thirsty for?
	var/desired_drink = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_drink_choice) || "Random"
	if(desired_drink != "Random")
		lunchbox_drink_choice = GLOB.possible_player_lunchbox_drink_choice[desired_drink]
	/// If no snack choice, WE PICKIN FOR EM!!
	if(lunchbox_drink_choice == NONE)
		lunchbox_drink_choice = pick(assoc_to_values(GLOB.possible_player_lunchbox_drink_choice))

	/// Got room for desert?
	var/desired_desert = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_desert_choice) || "Random"
	if(desired_desert != "Random")
		lunchbox_dessert_choice = GLOB.possible_player_lunchbox_desert_choice[desired_desert]
	/// If no snack choice, WE PICKIN FOR EM!!
	if(lunchbox_dessert_choice == NONE)
		lunchbox_dessert_choice = pick(assoc_to_values(GLOB.possible_player_lunchbox_desert_choice))

	var/obj/item/storage/toolbox/lunchbox = new /obj/item/storage/toolbox/lunchbox(get_turf(quirk_holder))

	// Spawn items directly inside the lunchbox
	lunchbox.icon_state = lunchbox_design
	new lunchbox_meal_choice(lunchbox)
	new lunchbox_first_snack_choice(lunchbox)
	new lunchbox_second_snack_choice(lunchbox)
	new lunchbox_drink_choice(lunchbox)
	new lunchbox_dessert_choice(lunchbox)

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
	"Dark" = "dark",
	"Nanotrasen" = "nanotrasen",
	"Nanotrasen (gold)" = "nanotrasen_gold",
	"Syndicate" = "syndicate",
	"SolFed" = "solfed",
	"Interdyne" = "interdyne",
	"Space" = "space",
	"Hearts" = "hearts",
	"Golden" = "gold",
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
	"Burger" = /obj/item/food/burger,
	"Tofu" = /obj/item/food/bread/tofu,
	"Baguette" = /obj/item/food/baguette,
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
	"Candy" = /obj/item/food/candy,
	"South Bronx Paradise bar" = /obj/item/food/candy/bronx,
	"Scaredy's Private Reserve Beef Jerky" = /obj/item/food/sosjerky,
	"Homemade Beef Jerky" = /obj/item/food/sosjerky/healthy,
	"Chips" = /obj/item/food/chips,
	"Shrimp Chips" = /obj/item/food/chips/shrimp,
	"4no raisins" = /obj/item/food/no_raisin,
	"Homemade Rasins" = /obj/item/food/no_raisin/healthy,
	"Space Twinky" = /obj/item/food/spacetwinkie,
	"Cheesie Honkers" = /obj/item/food/cheesiehonkers,
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
	"Cola" = /obj/item/reagent_containers/cup/soda_cans/cola,
	"Dr. Gibb" = /obj/item/reagent_containers/cup/soda_cans/dr_gibb,
	"Lemon Lime" = /obj/item/reagent_containers/cup/soda_cans/lemon_lime,
	"Pwr Game" = /obj/item/reagent_containers/cup/soda_cans/pwr_game,
	"Space Mountain Wind" = /obj/item/reagent_containers/cup/soda_cans/space_mountain_wind,
	"Space Up" = /obj/item/reagent_containers/cup/soda_cans/space_up,
	"Starkist" = /obj/item/reagent_containers/cup/soda_cans/starkist,
	"Robust Coffee" = /obj/item/reagent_containers/cup/glass/coffee,
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
	"Banana Nut Bread" = /obj/item/food/breadslice/banana,
	"Plain Cake Slice" = /obj/item/food/cakeslice/plain,
	"Chocolate Cake Slice" = /obj/item/food/cakeslice/berry_chocolate_cake,
	"Ice Cream Sandwich" = /obj/item/food/icecreamsandwich,
	"Ice Cream Sandwich (Strawberry)" = /obj/item/food/strawberryicecreamsandwich,
	"Space Freezy" = /obj/item/food/spacefreezy,
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

