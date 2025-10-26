/obj/item/food/colonial_course
	name = "undefined colonial course"
	desc = "Something you shouldn't see. But it's edible."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borgir"
	base_icon_state = "borgir"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("crayon powder" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE

/obj/item/food/colonial_course/Initialize(mapload)
	. = ..()
	base_icon_state = icon_state

/obj/item/food/colonial_course/attack_self(mob/user, modifiers)
	if(preserved_food)
		preserved_food = FALSE
		icon_state = "[base_icon_state]_unwrapped"
		to_chat(user, span_notice("You unpackage \the [src]."))
		playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)

/obj/item/food/colonial_course/attack(mob/living/target, mob/user, def_zone)
	if(preserved_food)
		to_chat(user, span_warning("[src] is still packaged!"))
		return FALSE

	return ..()

// Main Courses

/obj/item/food/colonial_course/pljeskavica
	name = "pljeskavica"
	desc = "A freshly-replicated Balkan-style burger featuring a minced meat patty with various vegetables and sauces between biogenerator-produced buns. \
		<br> It looks surprisingly decent for mass-produced replicated food, with all the nutritional information printed in Pan-Slavic."
	trash_type = /obj/item/trash/pljeskavica
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "spiced meat" = 10, "death of veganism" = 3)
	foodtypes = VEGETABLES | GRAIN | MEAT
	icon_state = "burger_wrapper"

/obj/item/food/colonial_course/pierogi_ravioli
	name = "pierogi-ravioli fusion"
	desc = "A curious blend of Polish pierogi and Italian ravioli with a potato-cheese-mushroom filling. The fusion dish manages to be both hearty and surprisingly delicate. \
		<br> Mass-produced yet satisfying, with the familiar comfort of Eastern European cuisine meeting Mediterranean flair."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/pierogi_ravioli
	icon_state = "pierogi_bowl"
	tastes = list("dough" = 2, "potato" = 3, "cheese" = 3, "mushroom" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/colonial_course/cevapi
	name = "cevapi sausage platter"
	desc = "Small grilled Balkan sausages served with soft flatbread and fresh onions. The cevapi are perfectly seasoned and have that characteristic grilled texture. \
		<br> A taste of the Balkans that's been faithfully replicated for colonial consumption."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	trash_type = /obj/item/trash/cevapi
	icon_state = "cevapi_tray"
	tastes = list("grilled sausage" = 5, "flatbread" = 3, "onions" = 2)
	foodtypes = MEAT | GRAIN | VEGETABLES

/obj/item/food/colonial_course/sarma
	name = "sarma stuffed cabbage"
	desc = "Cabbage rolls filled with spiced meat and rice, simmered in a savory tomato-based sauce. The dish is hearty and substantial, exactly what you'd expect from traditional Slavic cuisine. \
		<br> Perfect colonial comfort food that sticks to your ribs during long shifts."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/sarma
	icon_state = "golubets_package"
	tastes = list("cabbage" = 2, "spiced meat" = 4, "rice" = 2, "savory sauce" = 2)
	foodtypes = VEGETABLES | MEAT | GRAIN

/obj/item/food/colonial_course/borscht
	name = "borscht bowl with meat"
	desc = "Hearty beet soup with generous chunks of meat and vegetables in a rich, savory broth. The vibrant red color comes from the beets, and the aroma is deeply comforting. \
		<br> A complete meal that's both nourishing and familiar, exactly what you need after a hard day's work."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/soup/white_beet = 25,
	)
	trash_type = /obj/item/trash/borscht
	icon_state = "borscht_cup"
	tastes = list("beets" = 3, "meat" = 2, "vegetables" = 2, "savory broth" = 2)
	foodtypes = VEGETABLES | MEAT

// Side Dishes

/obj/item/food/colonial_course/chigirtma
	name = "chigirtma platter"
	desc = "A traditional Azerbaijani dish of pan-fried eggs with meat and vegetables. The eggs are fluffy and perfectly cooked, while the meat and vegetables add substance and flavor. \
		<br> Surprisingly satisfying for replicated food, though opening the packaging requires some determination."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/chigirtma
	icon_state = "chigirtma_container"
	tastes = list("eggs" = 3, "meat" = 2, "vegetables" = 2, "spices" = 1)
	foodtypes = MEAT | VEGETABLES | BREAKFAST

/obj/item/food/colonial_course/kasha_kiev
	name = "kasha porridge with chicken kiev"
	desc = "A substantial combination of buckwheat porridge and breaded chicken cutlet filled with herb butter. The kasha is nutty and comforting, while the chicken kiev bursts with flavor. \
		<br> Exactly the kind of hearty meal that keeps colonists going through tough shifts."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/kasha_kiev
	icon_state = "kiyv_container"
	tastes = list("buckwheat" = 3, "chicken" = 4, "herb butter" = 2, "comfort" = 1)
	foodtypes = GRAIN | MEAT | DAIRY

/obj/item/food/colonial_course/pickled_vegetables
	name = "pickled vegetable medley"
	desc = "A mix of pickled cucumbers, cabbage, and beets that provides a tangy, crunchy contrast to heavier meals. The vegetables retain their crispness and vibrant colors. \
		<br> The perfect accompaniment to rich colonial dishes, cutting through the heaviness with bright acidity."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/salt = 2,
	)
	trash_type = /obj/item/trash/pickled_vegetables
	icon_state = "ogurets_jar"
	tastes = list("pickles" = 3, "cabbage" = 2, "beets" = 2, "vinegar" = 1)
	foodtypes = VEGETABLES

/obj/item/food/colonial_course/draniki
	name = "potato pancakes with sauces"
	desc = "Crispy potato pancakes served with both sour cream and sweet jam. The pancakes have that perfect golden-brown exterior with a soft, flavorful interior. \
		<br> A versatile side that works equally well as breakfast, snack, or accompaniment to main courses."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/draniki
	icon_state = "draniki_tray"
	tastes = list("potato" = 4, "crispy" = 2, "sour cream" = 1, "jam" = 1)
	foodtypes = VEGETABLES | FRIED | DAIRY | SUGAR

/obj/item/food/colonial_course/mushroom_barley
	name = "mushroom and barley pilaf"
	desc = "A hearty grain dish combining earthy mushrooms with nutty barley. The pilaf is substantial and flavorful, with herbs adding depth to the simple ingredients. \
		<br> Exactly the kind of stick-to-your-ribs meal that colonial life demands."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	trash_type = /obj/item/trash/mushroom_barley
	icon_state = "plov_bowl"
	tastes = list("barley" = 3, "mushrooms" = 3, "herbs" = 1, "earthiness" = 1)
	foodtypes = VEGETABLES | GRAIN

// Desserts

/obj/item/food/colonial_course/blins
	name = "condensed milk crepes"
	desc = "Russian-style crepes filled with sweet condensed milk. The crepes are thin and delicate, while the filling is irresistibly sweet and creamy. \
		<br> Surprisingly tasty for mass-produced replicated dessert, though definitely not for those watching their sugar intake."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/milk = 4,
	)
	trash_type = /obj/item/trash/blins
	icon_state = "blin_package"
	tastes = list("insane amount of sweetness" = 10, "crepes" = 3)
	foodtypes = SUGAR | GRAIN | DAIRY | BREAKFAST

/obj/item/food/colonial_course/kolache
	preserved_food = FALSE

/obj/item/food/colonial_course/kolache/apricot
	name = "apricot kolache"
	desc = "A sweet pastry with a soft, pillowy dough filled with sweet apricot jam. The filling has just the right balance of tartness and sweetness. \
		<br> One of five varieties in the traditional Czech pastry assortment adapted for colonial replication."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_apricot"
	tastes = list("pastry" = 2, "sweet apricot" = 3, "comfort" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/colonial_course/kolache/strawberry
	name = "strawberry kolache"
	desc = "A soft pastry bun filled with vibrant strawberry jam. The berries taste surprisingly fresh for replicated filling. \
		<br> One of five varieties in the traditional Czech pastry assortment adapted for colonial replication."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_strawberry"
	tastes = list("pastry" = 2, "sweet strawberry" = 3, "berry" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/colonial_course/kolache/blueberry
	name = "blueberry kolache"
	desc = "A pillowy pastry filled with rich blueberry jam. The deep purple filling peeks through the delicate dough. \
		<br> One of five varieties in the traditional Czech pastry assortment adapted for colonial replication."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_blueberry"
	tastes = list("pastry" = 2, "sweet blueberry" = 3, "berry" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/colonial_course/kolache/cream_cheese
	name = "cream cheese kolache"
	desc = "A soft pastry filled with sweetened cream cheese. The filling is rich and creamy with just a hint of vanilla. \
		<br> One of five varieties in the traditional Czech pastry assortment adapted for colonial replication."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_cream_cheese"
	tastes = list("pastry" = 2, "sweet cream cheese" = 3, "vanilla" = 1)
	foodtypes = GRAIN | SUGAR | DAIRY

/obj/item/food/colonial_course/kolache/glazed_chocolate
	name = "glazed chocolate kolache"
	desc = "A pastry bun with white glazing and chocolate filling. The combination of sweet glaze and rich chocolate is irresistible. \
		<br> One of five varieties in the traditional Czech pastry assortment adapted for colonial replication."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/coco = 2,
	)
	icon_state = "kolache_glazed_chocolate"
	tastes = list("pastry" = 2, "chocolate" = 2, "sweet glaze" = 2, "rich" = 1)
	foodtypes = GRAIN | SUGAR | DAIRY

/obj/item/food/colonial_course/medovik
	name = "honey-nut cake slice"
	desc = "A cube-shaped slice of layered honey cake with nuts. The layers are thin and delicate, with just the right amount of sweetness from the honey and crunch from the nuts. \
		<br> The geometric presentation is oddly satisfying, and the aroma is irresistibly sweet and comforting."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/honey = 3,
	)
	icon_state = "medovik_pouch"
	tastes = list("honey" = 3, "nuts" = 2, "layers" = 2, "sweet cream" = 2)
	foodtypes = GRAIN | SUGAR | NUTS

/obj/item/food/colonial_course/syrniki
	name = "cheese pancakes tube"
	desc = "Sweet pancakes made from farmer's cheese, perfect for breakfast or dessert. The syrniki are soft, slightly tangy from the cheese, and delicately sweet. \
		<br> Meant to be served with sour cream or jam, though the tube packaging is... an interesting choice for pancake storage."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	trash_type = /obj/item/trash/syrniki
	icon_state = "syrniki_tube"
	tastes = list("sweet cheese" = 4, "pancake" = 2, "vanilla" = 1)
	foodtypes = DAIRY | SUGAR | GRAIN | BREAKFAST

/obj/item/food/colonial_course/fruit_dumplings
	name = "fruit dumplings pouch"
	desc = "Boiled dumplings filled with seasonal fruits, ready to be topped with melted butter and breadcrumbs. The fruits vary by what the replicator determines is 'seasonally appropriate.' \
		<br> Sweet, comforting, and surprisingly versatile - perfect for when you need a taste of something fruity and familiar."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/fruit_dumplings
	icon_state = "fruit_dumplings_pouch"
	tastes = list("dough" = 2, "sweet fruit" = 3, "melted butter" = 1, "breadcrumbs" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR

// Beverages

/obj/item/reagent_containers/cup/glass/coffee/colonial
	name = "colonial thermocup"
	desc = "A sturdy cup for hot beverages, prefilled with a single serving of coffee powder. The instructions on the side explain how to prepare various drinks with the food replicator. \
		<br> It's the standard issue cup design, functional if not particularly elegant."
	special_desc = "A small instruction on the side reads: <i>\"For use in food replicators; mix water and powdered solutions in one-to-one proportions. \
		<br> For cocoa, mix milk and powdered solution in one-to-one proportion.\"</i>"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	list_reagents = list(/datum/reagent/consumable/powdered_coffee = 25)

/obj/item/reagent_containers/cup/glass/coffee/colonial/empty
	desc = "A sturdy cup for hot beverages, ready to be filled with your preferred replicated drink. The instructions on the side explain preparation methods."
	list_reagents = null

// Trash Items

/obj/item/trash/pljeskavica
	name = "pljeskavica wrapping paper"
	desc = "Covered in sauce smearings and smaller pieces of the dish on the inside, crumpled into a ball. It's probably best to dispose of it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borgir_trash"

/obj/item/trash/cevapi
	name = "empty cevapi tray"
	desc = "A rectangular plastic tray with peel-back foil, now empty except for some grease stains. It's probably best to dispose of it or recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "cevapi_tray_trash"

/obj/item/trash/pierogi_ravioli
	name = "empty pierogi-ravioli bowl"
	desc = "An empty biodegradable styrofoam bowl that once held some fusion cuisine. It's probably best to dispose of it properly."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "pierogi_bowl_trash"

/obj/item/trash/sarma
	name = "empty sarma wrapper"
	desc = "The torn remains of a cabbage roll wrapper, slightly stained with tomato sauce. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	icon_state = "sarma_pack_trash"

/obj/item/trash/borscht
	name = "empty borscht bowl"
	desc = "An empty soup cup that once held borscht, now stained reddish-purple from the beet soup. It's probably best to dispose of it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borscht_bowl_trash"

/obj/item/trash/chigirtma
	name = "empty chigirtma tray"
	desc = "A plastic food tray that once held an egg and meat dish, now empty except for some stubborn food particles. It's probably best to dispose of it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "chigirtma_tray_trash"

/obj/item/trash/kasha_kiev
	name = "empty kasha and kiev tray"
	desc = "A divided plastic tray that once held porridge and chicken, now empty. It's probably best to dispose of it or recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "kasha_kiev_tray_trash"

/obj/item/trash/pickled_vegetables
	name = "empty pickled vegetable jar"
	desc = "A small empty plastic jar that once held pickled vegetables, still smelling faintly of vinegar. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.7,
	)
	icon_state = "pickle_jar_trash"

/obj/item/trash/draniki
	name = "empty draniki tray"
	desc = "A multi-compartment plastic tray that once held potato pancakes and sauces, now empty. It's probably best to dispose of it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "draniki_tray_trash"

/obj/item/trash/mushroom_barley
	name = "empty mushroom barley bowl"
	desc = "An empty bowl that once held mushroom and barley pilaf, with some grain particles still clinging to the sides. It's probably best to dispose of it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "mushroom_barley_bowl_trash"

/obj/item/trash/blins
	name = "empty crepes wrapper"
	desc = "Empty torn wrapper that used to hold something ridiculously sweet. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "blin_package_trash"

/obj/item/trash/kolache
	name = "empty kolache wrapper"
	desc = "A torn wrapper that once held sweet pastries, now empty and slightly greasy. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.3,
	)
	icon_state = "kolache_wrap_trash"

/obj/item/trash/syrniki
	name = "empty cheese pancakes tube"
	desc = "An empty plastic can-tube that once held cheese pancakes - a packaging choice that will confuse archaeologists for centuries. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.6,
	)
	icon_state = "syrniki_tube_trash"

/obj/item/trash/fruit_dumplings
	name = "empty fruit dumplings pouch"
	desc = "An empty flexible pouch that once held fruit-filled dumplings, slightly greasy from the butter coating. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.4,
	)
	icon_state = "fruit_dumplings_pouch_trash"

// Other Items

/obj/item/storage/box/gum/colonial
	name = "mixed bubblegum packet"
	desc = "The packaging is entirely written in Pan-Slavic, with a small blurb of Sol Common. You would need to take a better look to read it, though, as it is written quite small."
	special_desc = "Examining the small text reveals the following: <i>\"Foreign colonization ration, model J: mixed origin, adult. Bubblegum package, medicinal, recreational. <br>\
		Do not overconsume. Certain strips contain nicotine.\"</i>"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "bubblegum"

/obj/item/storage/box/gum/colonial/PopulateContents()
	new /obj/item/food/bubblegum(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/food/bubblegum/nicotine(src)
	new /obj/item/food/bubblegum/nicotine(src)

/obj/item/storage/box/utensils
	name = "utensils package"
	desc = "A small package containing various utensils required for <i>human</i> consumption of various foods. \
	In a normal situation contains a plastic fork, a plastic spoon, and two serviettes."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "utensil_box"
	w_class = WEIGHT_CLASS_TINY
	illustration = null
	foldable_result = null
	storage_type = /datum/storage/box/utensils

/datum/storage/box/utensils
	max_slots = 4

/datum/storage/box/utensils/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(list(
		/obj/item/kitchen/spoon/plastic,
		/obj/item/kitchen/fork/plastic,
		/obj/item/serviette,
	))

/obj/item/storage/box/utensils/PopulateContents()
	new /obj/item/kitchen/spoon/plastic(src)
	new /obj/item/kitchen/fork/plastic(src)
	new /obj/item/serviette/colonial(src)
	new /obj/item/serviette/colonial(src)

/obj/item/serviette/colonial
	name = "colonial napkin"
	desc = "To clean all the mess. Comes with a custom <i>combined</i> design of red and blue."
	icon_state = "napkin_unused"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	used_serviette = /obj/item/serviette_used/colonial

/obj/item/serviette_used/colonial
	name = "dirty colonial napkin"
	desc = "No longer useful, super dirty, or soaked, or otherwise unrecognisable."
	icon_state = "napkin_used"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'

/obj/item/storage/box/colonial_rations
	name = "foreign colonization ration"
	desc = "A freshly printed civilian MRE, or more specifically a lunchtime food package, for use in the early colonization times by the first settlers of what is now known as the NRI. <br>\
		The lack of any imprinted dates, as well as its origin, <i>the food replicator</i>, should probably give you a good enough hint at its short, if reasonable, expiry time."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "mre_package"
	foldable_result = null
	illustration = null

/obj/item/storage/box/colonial_rations/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 6
	atom_storage.locked = TRUE

/obj/item/storage/box/colonial_rations/attack_self(mob/user, modifiers)
	if(user)
		if(atom_storage.locked == TRUE)
			atom_storage.locked = FALSE
			icon_state = "mre_package_open"
			balloon_alert(user, "unsealed!")
			return ..()
		else
			atom_storage.locked = TRUE
			atom_storage.close_all()
			icon_state = "mre_package"
			balloon_alert(user, "resealed!")
			return

/obj/item/storage/box/colonial_rations/PopulateContents()
	new /obj/item/food/colonial_course/pljeskavica(src)
	new /obj/item/food/colonial_course/chigirtma(src)
	new /obj/item/food/colonial_course/kolache(src)
	new /obj/item/reagent_containers/cup/glass/coffee/colonial(src)
	new /obj/item/storage/box/gum/colonial(src)
	new /obj/item/storage/box/utensils(src)
