/obj/item/food/colonial_course
	name = "undefined colonial course"
	desc = "Something you shouldn't see. But it's edible."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "burger_wrapper"
	base_icon_state = "burger_wrapper"
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
	desc = "A mass-replicated take on a Balkan-style burger. The minced protein patty, assorted veggies, and sauce are sandwiched between perfectly uniform, biogenerator-produced buns. \
		<br> It's structurally sound and nutritionally complete, though it lacks the char of a real grill."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	trash_type = /obj/item/trash/pljeskavica
	icon_state = "burger_wrapper"
	tastes = list("spiced meat" = 3, "bun" = 2, "protein" = 1)
	foodtypes = VEGETABLES | GRAIN | MEAT

/obj/item/food/colonial_course/pierogi_ravioli
	name = "pierogi-ravioli fusion"
	desc = "A replicator-original fusion of Polish and Italian dumplings. Each pouch-shaped piece has an identical potato-cheese-mushroom filling. \
		<br> The texture is consistently soft and the flavor is balanced, but the geometry is a tell-tale sign of its industrial origin."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/pierogi_ravioli
	icon_state = "pierogi_bowl"
	tastes = list("dough" = 2, "potato" = 3, "cheese" = 3, "mushroom" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/colonial_course/pierogi_ravioli/attack_self(mob/user, modifiers)
	if(preserved_food)
		if(prob(20))
			preserved_food = FALSE
			icon_state = "[base_icon_state]_unwrapped_alt"
			to_chat(user, span_notice("You unpackage \the [src]."))
			to_chat(user, span_warning("<i>Wait, are they upside down?</i>"))
			name = "upside-down [initial(name)]"
			playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
		else
			return ..()

/obj/item/food/colonial_course/cevapi
	name = "cevapi sausage platter"
	desc = "Faithfully replicated small sausages, served with soft flatbread and rehydrated onions. \
		<br> The \"grill marks\" are printed on with perfect regularity, and while the seasoning is correct, the texture is a bit more uniform than the hand-made original. \
		A serviceable taste of the Balkans."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	trash_type = /obj/item/trash/cevapi
	icon_state = "cevapi_tray"
	tastes = list("grilled sausage" = 3, "flatbread" = 2, "onions" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES

/obj/item/food/colonial_course/cevapi/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "cevapi_tray_alt"
		base_icon_state = icon_state

/obj/item/food/colonial_course/sarma
	name = "sarma stuffed cabbage"
	desc = "Hearty cabbage rolls filled with spiced protein and rice, all simmered in a savory, slightly gelatinous tomato sauce. \
		<br> They're perfectly cylindrical and identically sized, nailing the comfort food vibe even if they lack a grandmother's touch."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/sarma
	icon_state = "sarma_package"
	tastes = list("spiced meat" = 3, "cabbage" = 2, "rice" = 2, "savory sauce" = 2)
	foodtypes = VEGETABLES | MEAT | GRAIN

/obj/item/reagent_containers/cup/borscht_bowl
	name = "borscht bowl"
	desc = "A reliably replicated classic. This hearty beet soup comes with uniform chunks of vegetables and protein in a rich, savory broth. \
		<br> The color is vibrantly consistent and the aroma is comforting, even if the texture of the components is a bit too perfect."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borscht_cup_closed"
	base_icon_state = "borscht_cup"
	fill_icon_thresholds = list(0,1)
	fill_icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	initial_reagent_flags = NONE
	list_reagents = list(/datum/reagent/consumable/nutriment/soup/white_beet = 50)

/obj/item/reagent_containers/cup/borscht_bowl/update_overlays()
	if(!is_drainable())
		return
	. = ..()

/obj/item/reagent_containers/cup/borscht_bowl/attack_self(mob/user)
	if(!is_drainable())
		open_soup(user)
		return
	return ..()

/obj/item/reagent_containers/cup/borscht_bowl/proc/open_soup(mob/user)
	to_chat(user, "You peel back the foil of [src].")
	icon_state = base_icon_state
	add_container_flags(OPENCONTAINER)
	update_appearance()
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)

// Side Dishes

/obj/item/food/colonial_course/chigirtma
	name = "chigirtma platter"
	desc = "A replicator's attempt at a pan-fried egg dish. The eggs have a consistent, pleasingly fluffy texture, and the protein and vegetable pieces are evenly distributed. \
	<br> It's a solid, satisfying plate, though it's clearly been steamed-cooked in its own tray rather than fried."
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
	desc = "A staple of colonial ration packs. \
		The buckwheat porridge is nutty and perfectly textured every time, while the breaded protein cutlet contains a precise burst of herb-infused butter substitute. \
		<br> It's engineered for maximum comfort, if not culinary artistry."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/kasha_kiev
	icon_state = "kiyv_container"
	tastes = list("chicken" = 3, "buckwheat" = 2, "herb butter" = 2, "comfort" = 1)
	foodtypes = GRAIN | MEAT | DAIRY

/obj/item/food/colonial_course/pickled_vegetables
	name = "pickled vegetable medley"
	desc = "A reliably crunchy and tangy mix of replicated pickles, cabbage, and beets. \
		<br> The vegetables are perfectly crisp and the brine is consistently sharp, designed to cut through the heaviness of main courses. The colors are almost unnaturally vibrant."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/salt = 2,
	)
	trash_type = /obj/item/trash/pickled_vegetables
	icon_state = "ogurets_jar"
	tastes = list("vinegar" = 3, "pickles" = 2, "cabbage" = 2, "beets" = 2)
	foodtypes = VEGETABLES

/obj/item/food/colonial_course/draniki
	name = "potato pancakes with sauces"
	desc = "These potato pancakes have a perfectly uniform golden-brown exterior, achieved through precise replication rather than frying. \
		<br> They're consistently soft inside and come with portion-controlled cups of sour cream and jam. A versatile, if slightly sterile, side."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	trash_type = /obj/item/trash/draniki
	icon_state = "draniki_tray"
	tastes = list("crispy potato" = 3, "sour cream" = 1, "jam" = 1)
	foodtypes = VEGETABLES | FRIED | DAIRY | SUGAR

/obj/item/food/colonial_course/mushroom_barley
	name = "mushroom and barley pilaf"
	desc = "A stick-to-your-ribs grain dish. The barley is always perfectly al dente and the mushroom pieces are identical in size and flavor. \
		<br> It's a hearty, earthy, and utterly reliable side that provides bulk and nutrition with zero surprises."
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
	desc = "Mass-produced crepes filled with an intensely sweet, creamy condensed milk substitute. \
		<br> The crepes are thin and roll perfectly every time, though they lack the slight variation of a hand-poured batter. A sugar rush in a standardized package."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/milk = 4,
	)
	trash_type = /obj/item/trash/blins
	icon_state = "blin_package"
	tastes = list("insane amount of sweetness" = 3, "crepes" = 2)
	foodtypes = SUGAR | GRAIN | DAIRY | BREAKFAST

/obj/item/food/colonial_course/kolache
	preserved_food = FALSE

/obj/item/food/colonial_course/kolache/apricot
	name = "apricot kolache"
	desc = "One of five standardized kolache varieties. \
		The dough is consistently soft and pillowy, enveloping a precise dollop of apricot jam that has the perfect, unchanging balance of tart and sweet. \
		<br> A testament to replicator consistency."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_apricot"
	tastes = list("pastry" = 2, "sweet apricot" = 3, "comfort" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/colonial_course/kolache/strawberry
	name = "strawberry kolache"
	desc = "A perfectly round pastry bun with a vibrant, sweet strawberry filling. \
		<br> The \"berry\" flavor is bright and consistent, though it lacks the complexity of real, seasonal fruit. A reliably sweet treat."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_strawberry"
	tastes = list("pastry" = 2, "sweet strawberry" = 3, "berry" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/colonial_course/kolache/blueberry
	name = "blueberry kolache"
	desc = "This kolache features a deep purple blueberry filling that always peeks through the dough in the exact same way. \
		<br> The jam is rich and sweet, with a flavor profile that is more \"idealized blueberry\" than the real thing."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_blueberry"
	tastes = list("pastry" = 2, "sweet blueberry" = 3, "berry" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/colonial_course/kolache/cream_cheese
	name = "cream cheese kolache"
	desc = "Features a rich, sweetened cream cheese substitute filling that is impossibly smooth and creamy. \
		<br> The hint of vanilla is always present in the same concentration, making for a decadent, if slightly artificial-tasting, pastry."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 4,
	)
	icon_state = "kolache_cream_cheese"
	tastes = list("pastry" = 2, "sweet cream cheese" = 3, "vanilla" = 1)
	foodtypes = GRAIN | SUGAR | DAIRY

/obj/item/food/colonial_course/kolache/glazing
	name = "glazed chocolate kolache"
	desc = "Topped with a crackly-white sugar glaze and filled with a smooth, rich chocolate paste. \
		<br> The contrast between sweet glaze and mild chocolate is engineered to be universally appealing, a hallmark of mass-produced confections."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/coco = 2,
	)
	icon_state = "kolache_glazing"
	tastes = list("pastry" = 2, "chocolate" = 2, "sweet glaze" = 2)
	foodtypes = GRAIN | SUGAR | DAIRY

/obj/item/food/colonial_course/medovik
	name = "honey-nut cake slice"
	desc = "A perfectly cube-shaped slice of layered cake. The honey flavor is distinct, the cream is smooth, and the nut pieces provide a standardized crunch. \
		<br> Its geometric perfection is a dead giveaway of its replicated origins, but it's comfortingly sweet."
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
	desc = "Soft, sweet pancakes made from a cultured protein-and-dairy blend, extruded into a convenient tube. \
		<br> They have a pleasant tang and are perfectly edible, though the form factor and uniform texture are a far cry from pan-fried syrniki."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	trash_type = /obj/item/trash/syrniki
	icon_state = "syrniki_tube"
	tastes = list("sweet cheese" = 4, "pancake" = 2, "vanilla" = 1)
	foodtypes = DAIRY | SUGAR | GRAIN | BREAKFAST

/obj/item/storage/pouch/fruit_dumplings
	name = "fruit dumplings pouch"
	desc = "A sealed pouch containing five fruit dumplings. The fruits vary by what the replicator determines is 'seasonally appropriate.'"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "fruit_dumplings_pouch"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/pouch/fruit_dumplings

/datum/storage/pouch/fruit_dumplings
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = WEIGHT_CLASS_SMALL * 5
	max_slots = 5
	locked = TRUE

/datum/storage/pouch/fruit_dumplings/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(list(
		/obj/item/food/colonial_course/fruit_dumpling,
		/obj/item/food/khinkali,
		/obj/item/food/rawkhinkali,
	))

/obj/item/storage/pouch/fruit_dumplings/update_overlays()
	. = ..()
	if(!atom_storage.locked)
		var/contents_count = length(contents)
		if(contents_count > 0)
			// Add an overlay showing the number of items
			var/mutable_appearance/appearance = mutable_appearance(icon, "fruit_dumpling[contents_count]")
			. += appearance

/obj/item/storage/pouch/fruit_dumplings/PopulateContents()
	. = ..()
	for(var/i in 1 to 5)
		new /obj/item/food/colonial_course/fruit_dumpling(src)

/obj/item/storage/pouch/fruit_dumplings/attack_self(mob/user)
	if(user)
		if(atom_storage.locked == TRUE)
			atom_storage.locked = FALSE
			icon_state = "fruit_dumplings_pouch_open"
			balloon_alert(user, "unsealed!")
			update_appearance()
		else
			atom_storage.locked = TRUE
			atom_storage.close_all()
			icon_state = "fruit_dumplings_pouch"
			balloon_alert(user, "resealed!")
			update_appearance()

/obj/item/food/colonial_course/fruit_dumpling
	name = "fruit dumpling"
	desc = "A soft, boiled dough pocket filled with a \"seasonal\" fruit puree that the replicator determines is most efficient. \
		Topped with a dusting of butter-flavored powder and breadcrumb analogs. \
		<br> It's a comforting, if simple and standardized, sweet bite."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "fruit_dumpling"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("sweet fruit" = 3, "dough" = 2, "melted butter" = 1, "breadcrumbs" = 1)
	preserved_food = FALSE
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
	icon_state = "burger_wrapper_trash"

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
	icon_state = "sarma_package_trash"

/obj/item/trash/chigirtma
	name = "empty chigirtma tray"
	desc = "A plastic food tray that once held an egg and meat dish, now empty except for some stubborn food particles. It's probably best to dispose of it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "chigirtma_container_trash"

/obj/item/trash/kasha_kiev
	name = "empty kasha and kiev tray"
	desc = "A divided plastic tray that once held porridge and chicken, now empty. It's probably best to dispose of it or recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "kiyv_container_trash"

/obj/item/trash/pickled_vegetables
	name = "empty pickled vegetable jar"
	desc = "A small empty plastic jar that once held pickled vegetables, still smelling faintly of vinegar. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.7,
	)
	icon_state = "ogurets_jar_trash"

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
	icon_state = "plov_bowl_trash"

/obj/item/trash/blins
	name = "empty crepes wrapper"
	desc = "Empty torn wrapper that used to hold something ridiculously sweet. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "blin_package_trash"

/obj/item/trash/syrniki
	name = "empty cheese pancakes tube"
	desc = "An empty plastic can-tube that once held cheese pancakes - a packaging choice that will confuse archaeologists for centuries. It's probably best to recycle it."
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.6,
	)
	icon_state = "syrniki_tube_trash"

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
	desc = "A freshly printed civilian MRE, or more specifically a lunchtime food package, for use in the early colonization times by the first settlers of what is now known as the HC. <br>\
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
	// Randomly pick one from each category
	new /obj/effect/spawner/random/food_or_drink/colonial_main(src)
	new /obj/effect/spawner/random/food_or_drink/colonial_side(src)
	new /obj/effect/spawner/random/food_or_drink/colonial_dessert(src)

	// Add standard items
	new /obj/item/reagent_containers/cup/glass/coffee/colonial(src)
	new /obj/item/storage/box/gum/colonial(src)
	new /obj/item/storage/box/utensils(src)

/obj/effect/spawner/random/food_or_drink/colonial_main
	name = "replicator main course spawner"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "burger_wrapper_unwrapped"
	loot = list(
		/obj/item/food/colonial_course/pljeskavica,
		/obj/item/food/colonial_course/pierogi_ravioli,
		/obj/item/food/colonial_course/cevapi,
		/obj/item/food/colonial_course/sarma,
		/obj/item/reagent_containers/cup/borscht_bowl,
	)

/obj/effect/spawner/random/food_or_drink/colonial_side
	name = "replicator side dish spawner"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "chigirtma_container_unwrapped"
	loot = list(
		/obj/item/food/colonial_course/chigirtma,
		/obj/item/food/colonial_course/kasha_kiev,
		/obj/item/food/colonial_course/pickled_vegetables,
		/obj/item/food/colonial_course/draniki,
		/obj/item/food/colonial_course/mushroom_barley,
	)

/obj/effect/spawner/random/food_or_drink/colonial_dessert
	name = "replicator dessert spawner"
	icon = 'modular_nova/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "blin_package_unwrapped"
	loot = list(
		/obj/item/food/colonial_course/blins,
		/obj/item/food/colonial_course/kolache/apricot,
		/obj/item/food/colonial_course/kolache/strawberry,
		/obj/item/food/colonial_course/kolache/blueberry,
		/obj/item/food/colonial_course/kolache/cream_cheese,
		/obj/item/food/colonial_course/kolache/glazing,
		/obj/item/food/colonial_course/medovik,
		/obj/item/storage/pouch/fruit_dumplings,
		/obj/item/food/colonial_course/syrniki,
	)
