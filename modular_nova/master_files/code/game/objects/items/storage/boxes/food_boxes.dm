// Themed ingredient boxes that were removed upstream in tgstation/tgstation#97939. Some of them are still placed on our maps.

/obj/item/storage/box/ingredients/fiesta
	theme_name = "fiesta"

/obj/item/storage/box/ingredients/fiesta/PopulateContents()
	new /obj/item/food/tortilla(src)
	for(var/i in 1 to 2)
		new /obj/item/food/grown/chili(src)
		new /obj/item/food/grown/corn(src)
		new /obj/item/food/grown/soybeans(src)

/obj/item/storage/box/ingredients/italian
	theme_name = "italian"

/obj/item/storage/box/ingredients/italian/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/grown/tomato(src)
		new /obj/item/food/meatball(src)
	new /obj/item/reagent_containers/cup/glass/bottle/wine(src)

/obj/item/storage/box/ingredients/vegetarian
	theme_name = "vegetarian"

/obj/item/storage/box/ingredients/vegetarian/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/carrotlike/carrot(src)
	new /obj/item/food/grown/apple(src)
	new /obj/item/food/grown/corn(src)
	new /obj/item/food/grown/eggplant(src)
	new /obj/item/food/grown/potato(src)
	new /obj/item/food/grown/tomato(src)

/obj/item/storage/box/ingredients/fruity
	theme_name = "fruity"

/obj/item/storage/box/ingredients/fruity/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/apple(src)
		new /obj/item/food/grown/citrus/orange(src)
	new /obj/item/food/grown/citrus/lemon(src)
	new /obj/item/food/grown/citrus/lime(src)
	new /obj/item/food/grown/melonlike/watermelon(src)

/obj/item/storage/box/ingredients/sweets
	theme_name = "sweets"

/obj/item/storage/box/ingredients/sweets/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/cherries(src)
		new /obj/item/food/grown/banana(src)
	new /obj/item/food/chocolatebar(src)
	new /obj/item/food/grown/apple(src)
	new /obj/item/food/grown/cocoapod(src)

/obj/item/storage/box/ingredients/delights
	theme_name = "delights"

/obj/item/storage/box/ingredients/delights/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/bluecherries(src)
		new /obj/item/food/grown/potato/sweet(src)
	new /obj/item/food/grown/berries(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/food/grown/vanillapod(src)

/obj/item/storage/box/ingredients/grains
	theme_name = "grains"

/obj/item/storage/box/ingredients/grains/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/grown/oat(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/food/grown/wheat(src)
	new /obj/item/food/honeycomb(src)
	new /obj/item/seeds/poppy(src)

/obj/item/storage/box/ingredients/carnivore
	theme_name = "carnivore"

/obj/item/storage/box/ingredients/carnivore/PopulateContents()
	new /obj/item/food/meat/slab/bear(src)
	new /obj/item/food/meat/slab/corgi(src)
	new /obj/item/food/meat/slab/penguin(src)
	new /obj/item/food/meat/slab/spider(src)
	new /obj/item/food/meat/slab/xeno(src)
	new /obj/item/food/meatball(src)
	new /obj/item/food/spidereggs(src)

/obj/item/storage/box/ingredients/exotic
	theme_name = "exotic"

/obj/item/storage/box/ingredients/exotic/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/fishmeat/carp(src)
		new /obj/item/food/grown/cabbage(src)
		new /obj/item/food/grown/soybeans(src)
	new /obj/item/food/grown/chili(src)

/obj/item/storage/box/ingredients/seafood
	theme_name = "seafood"

/obj/item/storage/box/ingredients/seafood/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/fishmeat/armorfish(src)
		new /obj/item/food/fishmeat/carp(src)
		new /obj/item/food/fishmeat/moonfish(src)
	new /obj/item/food/fishmeat/gunner_jellyfish/supply(src)

/obj/item/storage/box/ingredients/salads
	theme_name = "salads"

/obj/item/storage/box/ingredients/salads/PopulateContents()
	new /obj/item/food/grown/cabbage(src)
	new /obj/item/food/grown/carrotlike/carrot(src)
	new /obj/item/food/grown/olive(src)
	new /obj/item/food/grown/onion/red(src)
	new /obj/item/food/grown/onion/red(src)
	new /obj/item/food/grown/tomato(src)
	new /obj/item/reagent_containers/condiment/olive_oil(src)

/obj/item/storage/box/ingredients/random
	theme_name = "random"
	desc = "This box should not exist, contact the proper authorities."

/obj/item/storage/box/ingredients/random/Initialize(mapload)
	. = ..()
	var/chosen_box = pick(subtypesof(/obj/item/storage/box/ingredients) - /obj/item/storage/box/ingredients/random)
	new chosen_box(loc)
	return INITIALIZE_HINT_QDEL
