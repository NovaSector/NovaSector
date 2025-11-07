
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
	"Heart" = /obj/item/storage/lunchbox/heart,
	"White Heart" = /obj/item/storage/lunchbox/heart/monster,
	"Television" = /obj/item/storage/lunchbox/tvtime,
	"Pride" = /obj/item/storage/lunchbox/ally,
	"Spaceship" = /obj/item/storage/lunchbox/ship,
	"Ammunition" = /obj/item/storage/lunchbox/ammo,
	"Cyber" = /obj/item/storage/lunchbox/cyber,
	"Cyber (Dark)" = /obj/item/storage/lunchbox/cyber/dark,
	"Lavaland" = /obj/item/storage/lunchbox/lavaland,
	"Rainy" = /obj/item/storage/lunchbox/rainy,
	"Clock" = /obj/item/storage/lunchbox/fire_clock,
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
	"Blood Noodles" = /obj/item/food/hemophage/blood_noodles,
	"Boat Noodles" = /obj/item/food/hemophage/blood_noodles/boat_noodles,
	"Piru Pasta" = /obj/item/food/piru_pasta,
	"Sirisai Wrap" = /obj/item/food/sirisai_wrap,
	"Sweet Piru Noodles" = /obj/item/food/sweet_piru_noodles,
	"Kiri Curry" = /obj/item/food/kiri_curry,
	"Sirisai Flatbread" = /obj/item/food/sirisai_flatbread,
	"Stewed Muli" = /obj/item/food/stewed_muli,
	"Suffed Muli Pod" = /obj/item/food/stuffed_muli_pod,
	"Shreadded Lung Stirfry" = /obj/item/food/shredded_lungs,
	"Moonfish Caviar" = /obj/item/food/moonfish_caviar,
	"Desert Snail Cocleas" = /obj/item/food/lizard_escargot,
	"Eyeball and Brain Pate" = /obj/item/food/brain_pate,
	"Picoss Skewer" = /obj/item/food/kebab/picoss_skewers,
	"Murshroom Stirfy" = /obj/item/food/mushroomy_stirfry,
	"Grilled Moonfish" = /obj/item/food/grilled_moonfish,
	"Moonfish Demiglace" = /obj/item/food/moonfish_demiglace,
	"Zagosk Surf 'n' Turf Smorgasbord" = /obj/item/food/lizard_surf_n_turf,
	"Nizaya Pasta" = /obj/item/food/spaghetti/nizaya,
	"Desert Snail Nizaya" = /obj/item/food/spaghetti/snail_nizaya,
	"Garlic Nizaya" = /obj/item/food/spaghetti/garlic_nizaya,
	"Mushroom Nizaya" = /obj/item/food/spaghetti/mushroom_nizaya,
	"Rustic Flatbread" = /obj/item/food/pizza/flatbread/rustic,
	"Italic Flatbread" = /obj/item/food/pizza/flatbread/italic,
	"Imperial Flatbread" = /obj/item/food/pizza/flatbread/imperial,
	"Meatlovers Flatbread" = /obj/item/food/pizza/flatbread/rawmeat,
	"Stinging Flatbread" = /obj/item/food/pizza/flatbread/stinging,
	"Zmorgast Flatbread" = /obj/item/food/pizza/flatbread/zmorgast,
	"BBQ Fish Flatbread" = /obj/item/food/pizza/flatbread/fish,
	"Mushroom and Tomato Flatbread" = /obj/item/food/pizza/flatbread/mushroom,
	"Nut Paste Flatbread" = /obj/item/food/pizza/flatbread/nutty,
	"Demit Nizaya" = /obj/item/food/spaghetti/demit_nizaya,
	"Sauerkraut" = /obj/item/food/sauerkraut,
	"PB&J Rootwich" = /obj/item/food/rootbread_peanut_butter_jelly,
	"PB&B Rootwich" = /obj/item/food/rootbread_peanut_butter_banana,
	"Plain Rootburger" = /obj/item/food/burger/plain/korta,
	"Rat Rootburger" = /obj/item/food/burger/rat/korta,
	"Root-Guffin" = /obj/item/food/burger/rootguffin,
	"Root Rib" = /obj/item/food/burger/rootrib,
	"Chicken Rootwich" = /obj/item/food/burger/rootchicken,
	"Fish Rootwich" = /obj/item/food/burger/rootfish,
	"Herby Cheese" = /obj/item/food/herby_cheese,
	"Grilled Cheese" = /obj/item/food/grilled_cheese,
	"Mothic Salad" = /obj/item/food/mothic_salad,
	"Skeklitmischtpoppl" = /obj/item/food/squeaking_stir_fry,
	"Sweet Chili Cabbage Wrap" = /obj/item/food/sweet_chili_cabbage_wrap,
	"Ozlsettitæloskekllön Ede Pommes" = /obj/item/food/loaded_curds,
	"Green Lasagne Slice" = /obj/item/food/green_lasagne_slice,
	"Big Baked Rice" = /obj/item/food/big_baked_rice,
	"Fiesta Corn Skillet" = /obj/item/food/fiesta_corn_skillet,
	"Ratatouille" = /obj/item/food/ratatouille,
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
	"Packaged Engine Fodder" = /obj/item/food/vendor_snacks/moth_bag,
	"Honey Cheesecake Cube" = /obj/item/food/vendor_snacks/moth_bag/cheesecake/honey,
	"Chocolate Cheesecake Cube" = /obj/item/food/vendor_snacks/moth_bag/cheesecake,
	"Moffin" = /obj/item/food/vendor_tray_meal/side/moffin,
	"Cornbread" = /obj/item/food/vendor_tray_meal/side/cornbread,
	"Roasted Seeds" = /obj/item/food/vendor_tray_meal/side/roasted_seeds,
	"Packagaed Honey Roll" = /obj/item/food/vendor_snacks/lizard_box/sweet_roll,
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
	"Kessen Shinju" = /obj/item/food/hemophage/blood_rice_pearl,
	"Dinuguan" = /obj/item/food/soup/hemophage/blood_soup,
	"Blood Curd" = /obj/item/food/hemophage/blood_curd,
	"Piru Bread Slice" = /obj/item/food/breadslice/piru,
	"Spiced Jerky" = /obj/item/food/spiced_jerky,
	"Baked Kiri Fruit" = /obj/item/food/baked_kiri,
	"Baked Muli Pod" = /obj/item/food/baked_muli,
	"Piru Flatbread" = /obj/item/food/grilled_piru_flatbread,
	"Sirisai Flatbread Slice" = /obj/item/food/sirisai_flatbread_slice,
	"Bluefeather Crisps & Dip" = /obj/item/food/bluefeather_crisps_and_dip,
	"Bluefeather Crisp" = /obj/item/food/bluefeather_crisp,
	"Caramel Jelly Toast" = /obj/item/food/caramel_jelly_toast,
	"Headcheese Slice" = /obj/item/food/headcheese_slice,
	"Tsatsikh" = /obj/item/food/tsatsikh,
	"Liver Pate" = /obj/item/food/liver_pate,
	"Lizard Fries" = /obj/item/food/lizard_fries,
	"Nectar Larve" = /obj/item/food/nectar_larvae,
	"Rootroll" = /obj/item/food/rootroll,
	"Egg Rootroll" = /obj/item/food/rootroll/egg,
	"Root Flatbread" = /obj/item/food/root_flatbread,
	"Egg Root Flatbread" = /obj/item/food/root_flatbread/egg,
	"Rootbread Slice" = /obj/item/food/breadslice/root,
	"Egg Rootbread Slice" = /obj/item/food/breadslice/root/egg,
	"Honey Roll" = /obj/item/food/honey_roll,
	"Black Scrambled Eggs" = /obj/item/food/black_eggs,
	"Patzikula" = /obj/item/food/patzikula,
	"Tirizan Dumplings" = /obj/item/food/lizard_dumplings,
	"Steeped Seraka Mushrooms" = /obj/item/food/steeped_mushrooms,
	"Toasted Seeds" = /obj/item/food/toasted_seeds,
	"Engine Fodder" = /obj/item/food/engine_fodder,
	"Lil Baked Rice" = /obj/item/food/lil_baked_rice,
	"Oven Baked Corn" = /obj/item/food/oven_baked_corn,
	"Buttered Baked Corn" = /obj/item/food/buttered_baked_corn,
	"Mozzarella Sticks" = /obj/item/food/mozzarella_sticks,
	"Voltölpaprik" = /obj/item/food/stuffed_peppers,
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
	"Silly Cone's Synthanol" = /obj/item/reagent_containers/cup/soda_cans/nova/synthanolcan,
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
	"Berry Chocolate Cake Slice" = /obj/item/food/cakeslice/berry_chocolate_cake,
	"Carrot Cake Slice" = /obj/item/food/cakeslice/carrot,
	"Cheese Cake Slice" = /obj/item/food/cakeslice/cheese,
	"Lime Cake Slice" = /obj/item/food/cakeslice/lime,
	"Lemon Cake Slice" = /obj/item/food/cakeslice/lemon,
	"Chocolate Cake Slice" = /obj/item/food/cakeslice/chocolate,
	"Birthday Cake Slice" = /obj/item/food/cakeslice/birthday,
	"Energy Cake Slice" = /obj/item/food/cakeslice/birthday/energy,
	"Apple Cake Slice" = /obj/item/food/cakeslice/apple,
	"Slime Cake Slice" = /obj/item/food/cakeslice/slimecake,
	"Pumpkin Spice Cake Slice" = /obj/item/food/cakeslice/pumpkinspice,
	"Berry Vanilla Cake Slice" = /obj/item/food/cakeslice/berry_vanilla_cake,
	"Pound Cake Slice" = /obj/item/food/cakeslice/pound_cake_slice,
	"Hardware Cake Slice" = /obj/item/food/cakeslice/hardware_cake_slice,
	"Vanilla Cake Slice" = /obj/item/food/cakeslice/vanilla_slice,
	"Clown Cake Slice" = /obj/item/food/cakeslice/clown_slice,
	"Spaceman's Cake Slice" = /obj/item/food/cakeslice/trumpet,
	"Brioche Cake Slice" = /obj/item/food/cakeslice/brioche,
	"Pavlova Slice" = /obj/item/food/cakeslice/pavlova,
	"Nutty Pavlova Slice" = /obj/item/food/cakeslice/pavlova/nuts,
	"Fruit Cake Slice" = /obj/item/food/cakeslice/fruit,
	"Plum Cake Slice" = /obj/item/food/cakeslice/plum,
	"Angel Food Cake Slice" = /obj/item/food/cakeslice/holy_cake_slice,
	"Pinapple Cream Cake Slice" = /obj/item/food/cakeslice/pineapple_cream_cake,
	"Ice Cream Sandwich" = /obj/item/food/icecreamsandwich,
	"Ice Cream Sandwich (Strawberry)" = /obj/item/food/strawberryicecreamsandwich,
	"Space Freezy" = /obj/item/food/spacefreezy,
	"Matcha Mochi Balls" = /obj/item/food/vendor_snacks/mochi_ice_cream/matcha,
	"Vanilla Mochi Balls" = /obj/item/food/vendor_snacks/mochi_ice_cream,
	"Ti Hoeh Koe" = /obj/item/food/hemophage/blood_cake,
	"Kiri Jelly Puff" = /obj/item/food/kiri_jellypuff,
	"Korta Brittle Slice" = /obj/item/food/cakeslice/korta_brittle,
	"Korta Ice" = /obj/item/food/snowcones/korta_ice,
	"Candied Mushroom" = /obj/item/food/kebab/candied_mushrooms,
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

