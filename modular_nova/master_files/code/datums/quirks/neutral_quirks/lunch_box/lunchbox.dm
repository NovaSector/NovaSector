
/datum/quirk/item_quirk/lunchbox_owner
	name = "Lunchbox User"
	desc = "You brought a lunch, homemade or not, you decided to pack one for yourself!"
	icon = FA_ICON_BOX
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN
	mob_trait = TRAIT_LUNCHBOX_OWNER
	gain_text = span_notice("You brought your lunchbox with you, yippee!.")
	lose_text = span_danger("The feeling... the love... the passion for a home made meal leaves you... a tear sheds down your face, a weep... a sorrow... an apology as you say goodbye to your delicious homemade delectables.")
	medical_record_text = "Patient mentions their fondness for exterior foods and drinks."
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
		/datum/preference/choiced/lunchbox_desert_choice,
	)

/datum/quirk/item_quirk/lunchbox_owner/add_unique(client/client_source)

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

	var/lunchbox_design = client_source?.prefs.read_preference(/datum/preference/choiced/lunchbox_design) || "Regular"
	var/obj/item/storage/lunchbox/lunchbox_base

	lunchbox_design = lunchbox_design == "Random" ? pick(GLOB.possible_player_lunchbox_design_choice) : lunchbox_design
	var/lunchbox_type = GLOB.possible_player_lunchbox_design_choice[lunchbox_design]
	lunchbox_base = new lunchbox_type(get_turf(quirk_holder))

	// Spawn items directly inside the lunchbox
	new lunchbox_meal_choice(lunchbox_base)
	new lunchbox_first_snack_choice(lunchbox_base)
	new lunchbox_second_snack_choice(lunchbox_base)
	new lunchbox_drink_choice(lunchbox_base)
	new lunchbox_dessert_choice(lunchbox_base)

	lunchbox_base.name = "[quirk_holder.real_name]'s lunchbox"
	give_item_to_holder(
		lunchbox_base,
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
	should_generate_icons = TRUE

GLOBAL_LIST_INIT(possible_player_lunchbox_design_choice, list(
	"Dark" = /obj/item/storage/lunchbox/dark,
	"Blank" = /obj/item/storage/lunchbox/light,
	"Nanotrasen" = /obj/item/storage/lunchbox,
	"Nanotrasen (Gold)" = /obj/item/storage/lunchbox/nt_gold,
	"Syndicate" = /obj/item/storage/lunchbox/syndicate,
	"Interdyne" = /obj/item/storage/lunchbox/interdyne,
	"SolFed" = /obj/item/storage/lunchbox/solfed,
	"Space" = /obj/item/storage/lunchbox/space,
	"Hearts" = /obj/item/storage/lunchbox/hearts,
	"Gold" = /obj/item/storage/lunchbox/gold,
))

/datum/preference/choiced/lunchbox_design/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_design_choice)

/datum/preference/choiced/lunchbox_design/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_design/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else
		var/obj/item/storage/toolbox/selected_type = GLOB.possible_player_lunchbox_design_choice[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)

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
	should_generate_icons = TRUE

/datum/preference/choiced/lunchbox_meal_choice/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_lunchbox_meal_choice)

/datum/preference/choiced/lunchbox_meal_choice/create_default_value()
	return "Random"

/datum/preference/choiced/lunchbox_meal_choice/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else
		var/obj/item/food/selected_type = GLOB.possible_player_lunchbox_meal_choice[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)

GLOBAL_LIST_INIT(possible_player_lunchbox_meal_choice, list(
	"Burger" = /obj/item/food/burger,
	"Tofu" = /obj/item/food/bread/tofu,
	"Baguette" = /obj/item/food/baguette,
	"Pesto Pizza" = /obj/item/food/vendor_tray_meal/pesto_pizza,
	"Baked Rice and Grilled Cheese" = /obj/item/food/vendor_tray_meal/baked_rice,
	"Fueljack's Tray" = /obj/item/food/vendor_tray_meal/fueljack,
	"Moonfish and Nizaya" = /obj/item/food/vendor_tray_meal/moonfish_nizaya,
	"Emperor Roll" = /obj/item/food/vendor_tray_meal/emperor_roll,
	"Mushroom Stirfry" = /obj/item/food/vendor_tray_meal/mushroom_fry,
	"Hotdog" = /obj/item/food/hotdog,
	"Pig in a Blanket" = /obj/item/food/pigblanket,
	"Danish Hotdog" = /obj/item/food/danish_hotdog,
	"Little Hawaii Dog" = /obj/item/food/little_hawaii_hotdog,
	"Butterdog" = /obj/item/food/butterdog,
	"Plasmadog Supreme" = /obj/item/food/plasma_dog_supreme,
	"Sausage" = /obj/item/food/sausage,
	"Tirizan Blood Sausage" = /obj/item/food/tiziran_sausage,
	"Fried Blood Sausage" = /obj/item/food/fried_blood_sausage,
	"Homestyle Noodles" = /obj/item/food/vendor_tray_meal/ramen,
	"Fresh Carp Rolls" = /obj/item/food/vendor_tray_meal/sushi,
	"Beef and Fried Rice" = /obj/item/food/vendor_tray_meal/beef_rice,
	"BBQ Ribs" = /obj/item/food/bbqribs,
	"Beef Wellington" = /obj/item/food/beef_wellington_slice,
	"Korta Wellington" = /obj/item/food/korta_wellington_slice,
	"Philly Cheesesteak" = /obj/item/food/sandwich/philly_cheesesteak,
	"Steak" = /obj/item/food/meat/steak,
	"Lasagna" = /obj/item/food/lasagna,
))

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
	should_generate_icons = TRUE

/datum/preference/choiced/lunchbox_first_snack_choice/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else
		var/obj/item/food/selected_type = GLOB.possible_player_lunchbox_snack_choice[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)

GLOBAL_LIST_INIT(possible_player_lunchbox_snack_choice, list(
	"Space Twinkie" = /obj/item/food/spacetwinkie,
	"Cheesy Honkers" = /obj/item/food/cheesiehonkers,
	"Candy" = /obj/item/food/candy,
	"Chips" = /obj/item/food/chips,
	"Shrimp Chips" = /obj/item/food/chips/shrimp,
	"Scaredy's Beef Jerky" = /obj/item/food/sosjerky,
	"Boritos Chips" = /obj/item/food/cornchips/random,
	"4no rasins" = /obj/item/food/no_raisin,
	"Gallery's Peanuts" = /obj/item/food/peanuts,
	"Gallery's Everyflavor Peanuts" = /obj/item/food/peanuts/random,
	"C&Ds" = /obj/item/food/cnds,
	"Mystery C&Ds" = /obj/item/food/cnds/random,
	"Semki Sunflower Seeds" = /obj/item/food/semki,
	"Dry Ramen" = /obj/item/reagent_containers/cup/glass/dry_ramen,
	"Bubblegum" = /obj/item/storage/box/gum,
	"High-Power Energy Bars" = /obj/item/food/energybar,
	"Hot Shots" = /obj/item/food/hot_shots,
	"Sticko Classic" = /obj/item/food/sticko,
	"Sticko Mystery" = /obj/item/food/sticko/random,
	"Shok-roks - Stormcloud Candy" = /obj/item/food/shok_roks,
	"Shok-roks - Hidden Hurricane" = /obj/item/food/shok_roks/random,
	"Spacer's Sidekick" = /obj/item/food/spacers_sidekick,
	"Pistachios" = /obj/item/food/pistachios,
	"Lollipop" = /obj/item/food/swirl_lollipop,
	"Mothmallow" = /obj/item/food/vendor_snacks/mothmallow,
	"Fuel Jack" = /obj/item/food/vendor_snacks/moth_bag/fuel_jack,
	"Engine Fodder" = /obj/item/food/vendor_snacks/moth_bag,
	"Honey Cheesecake Cube" = /obj/item/food/vendor_snacks/moth_bag/cheesecake/honey,
	"Chocolate Cheesecake Cube" = /obj/item/food/vendor_snacks/moth_bag/cheesecake,
	"Moffin" = /obj/item/food/vendor_tray_meal/side/moffin,
	"Cornbread" = /obj/item/food/vendor_tray_meal/side/cornbread,
	"Roasted Seeds" = /obj/item/food/vendor_tray_meal/side/roasted_seeds,
	"Honey Roll" = /obj/item/food/vendor_snacks/lizard_box/sweet_roll,
	"Tirizan Dumplings" = /obj/item/food/vendor_snacks/lizard_box,
	"Candied Mushroom" = /obj/item/food/vendor_snacks/lizard_bag,
	"Moonfish Jerky" = /obj/item/food/vendor_snacks/lizard_bag/moon_jerky,
	"Korta Brittle" = /obj/item/food/vendor_tray_meal/side/korta_brittle,
	"Rootbread Crackers and Pate" = /obj/item/food/vendor_tray_meal/side/root_crackers,
	"Crisped Headcheese" = /obj/item/food/vendor_tray_meal/side/crispy_headcheese,
	"Rice Crackers" = /obj/item/food/vendor_snacks/rice_crackers,
	"Ramen" = /obj/item/reagent_containers/cup/glass/dry_ramen/prepared,
	"Spicy Ramen" = /obj/item/reagent_containers/cup/glass/dry_ramen/prepared/hell,
	"Miso Soup" = /obj/item/food/vendor_tray_meal/side/miso,
	"White Rice" = /obj/item/food/vendor_tray_meal/side/rice,
	"Pickled Vegetables" = /obj/item/food/vendor_tray_meal/side/pickled_vegetables,
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
	should_generate_icons = TRUE

/datum/preference/choiced/lunchbox_second_snack_choice/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else
		var/obj/item/food/selected_type = GLOB.possible_player_lunchbox_snack_choice[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)

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
	should_generate_icons = TRUE

/datum/preference/choiced/lunchbox_drink_choice/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else
		var/obj/item/food/selected_type = GLOB.possible_player_lunchbox_drink_choice[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)


GLOBAL_LIST_INIT(possible_player_lunchbox_drink_choice, list(
	"Space Cola" = /obj/item/reagent_containers/cup/soda_cans/cola,
	"Space Mountain Wind" = /obj/item/reagent_containers/cup/soda_cans/space_mountain_wind,
	"Dr. Gibb" = /obj/item/reagent_containers/cup/soda_cans/dr_gibb,
	"Star Kist" = /obj/item/reagent_containers/cup/soda_cans/starkist,
	"Space-Up!" = /obj/item/reagent_containers/cup/soda_cans/space_up,
	"Pwr Game" = /obj/item/reagent_containers/cup/soda_cans/pwr_game,
	"Orange Soda" = /obj/item/reagent_containers/cup/soda_cans/lemon_lime,
	"Sol Dry" = /obj/item/reagent_containers/cup/soda_cans/sol_dry,
	"Bottle of Water" = /obj/item/reagent_containers/cup/glass/waterbottle,
	"Solzara Mushi Kombucha" = /obj/item/reagent_containers/cup/glass/bottle/mushi_kombucha,
	"24-Volt Energy" = /obj/item/reagent_containers/cup/soda_cans/volt_energy,
	"Two Time Rootbeer" = /obj/item/reagent_containers/cup/glass/bottle/rootbeer,
	"LubriCola" = /obj/item/reagent_containers/cup/soda_cans/nova/lubricola,
	"Welding Fizz" = /obj/item/reagent_containers/cup/soda_cans/nova/welding_fizz,
	"Orchard Green" = /obj/item/reagent_containers/cup/soda_cans/thc,
	"Gyárhajó 1023: Lemonade" = /obj/item/reagent_containers/cup/soda_cans/nova/lemonade,
	"Gyárhajó 1506: Navy Rum" = /obj/item/reagent_containers/cup/soda_cans/nova/navy_rum,
	"Gyárhajó 1023: Soda Water" = /obj/item/reagent_containers/cup/soda_cans/nova/soda_water_moth,
	"Gyárhajó 1023: Ginger Beer" = /obj/item/reagent_containers/cup/soda_cans/nova/ginger_beer,
	"Mushroom Tea" = /obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom,
	"Korta" = /obj/item/reagent_containers/cup/soda_cans/nova/kortara,
	"Astra Tea" = /obj/item/reagent_containers/cup/glass/waterbottle/tea/astra,
	"Tea" = /obj/item/reagent_containers/cup/glass/waterbottle/tea,
	"Strawberry Tea" = /obj/item/reagent_containers/cup/glass/waterbottle/tea/strawberry,
	"Catnip Tea" = /obj/item/reagent_containers/cup/glass/waterbottle/tea/nip,
	"Beekhof Blauw Curacao" = /obj/item/reagent_containers/cup/glass/bottle/curacao,
	"Buckin' Bronco's Applejack" = /obj/item/reagent_containers/cup/glass/bottle/applejack,
	"Voltaic Yellow Wine" = /obj/item/reagent_containers/cup/glass/bottle/wine_voltaic,
	"Caccavo Tequila" = /obj/item/reagent_containers/cup/glass/bottle/tequila,
	"Captain Pete's Rum" = /obj/item/reagent_containers/cup/glass/bottle/rum,
	"Chateu De Baton Premium Cognac" = /obj/item/reagent_containers/cup/glass/bottle/cognac,
	"Bearded Special Wine" = /obj/item/reagent_containers/cup/glass/bottle/wine,
	"Extra Strong Absinthe" = /obj/item/reagent_containers/cup/glass/bottle/absinthe,
	"Goldeneye Vermouth" = /obj/item/reagent_containers/cup/glass/bottle/vermouth,
	"Griffeater Gin" = /obj/item/reagent_containers/cup/glass/bottle/gin,
	"Jester Grenadine" = /obj/item/reagent_containers/cup/glass/bottle/grenadine,
	"Jian Hard Cider" = /obj/item/reagent_containers/cup/glass/bottle/hcider,
	"Luini Arametto" = /obj/item/reagent_containers/cup/glass/bottle/amaretto,
	"Magm-Ale" = /obj/item/reagent_containers/cup/glass/bottle/ale,
	"Phillipes Grappa" = /obj/item/reagent_containers/cup/glass/bottle/grappa,
	"Navy Strength Rum" = /obj/item/reagent_containers/cup/glass/bottle/navy_rum,
	"Rapid Beer Malt Liquor" = /obj/item/reagent_containers/cup/glass/bottle/maltliquor,
	"Robert Robust's Coffee Liqueur" = /obj/item/reagent_containers/cup/glass/bottle/kahlua,
	"Ryo's Traditional Sake" = /obj/item/reagent_containers/cup/glass/bottle/sake,
	"Space Beer" = /obj/item/reagent_containers/cup/glass/bottle/beer,
	"Tunguska Triple Distilled" = /obj/item/reagent_containers/cup/glass/bottle/vodka,
	"Uncle Git's Special Reserve" = /obj/item/reagent_containers/cup/glass/bottle/whiskey,
	"Breezy Shoals Coconut Rum" = /obj/item/reagent_containers/cup/glass/bottle/coconut_rum,
	"Moonlabor Yuyake" = /obj/item/reagent_containers/cup/glass/bottle/yuyake,
	"Shu-Kuoba Straight Shochu" = /obj/item/reagent_containers/cup/glass/bottle/shochu,
	"Space Beer (Canned)" = /obj/item/reagent_containers/cup/soda_cans/beer,
	"Rice Beer" = /obj/item/reagent_containers/cup/soda_cans/beer/rice,
	"Silly Cone's Synthahol" = /obj/item/reagent_containers/cup/soda_cans/nova/synthanolcan
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
	should_generate_icons = TRUE

/datum/preference/choiced/lunchbox_desert_choice/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else
		var/obj/item/food/selected_type = GLOB.possible_player_lunchbox_desert_choice[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)

GLOBAL_LIST_INIT(possible_player_lunchbox_desert_choice, list(
	"Banana Nut Bread" = /obj/item/food/breadslice/banana,
	"Plain Cake Slice" = /obj/item/food/cakeslice/plain,
	"Chocolate Cake Slice" = /obj/item/food/cakeslice/berry_chocolate_cake,
	"Ice Cream Sandwich" = /obj/item/food/icecreamsandwich,
	"Ice Cream Sandwich (Strawberry)" = /obj/item/food/strawberryicecreamsandwich,
	"Space Freezy" = /obj/item/food/spacefreezy,
	"Matcha Mochi Balls" = /obj/item/food/vendor_snacks/mochi_ice_cream/matcha,
	"Vanilla Mochi Balls" = /obj/item/food/vendor_snacks/mochi_ice_cream,
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

