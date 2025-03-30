#define MINIMUM_CLOTHING_STOCK 5

/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/products_nova
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/product_categories_nova
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/premium_nova
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/contraband_nova

/obj/machinery/vending/Initialize(mapload)
	if(products_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in products_nova)
			products[item_to_add] = products_nova[item_to_add]

	if(product_categories_nova)
		for(var/category in product_categories_nova)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += list(category)

	if(premium_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in premium_nova)
			premium[item_to_add] = premium_nova[item_to_add]

	if(contraband_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in contraband_nova)
			contraband[item_to_add] = contraband_nova[item_to_add]

	// Time to make clothes amounts consistent!
	for (var/obj/item/clothing/item in products)
		if(products[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			products[item] = MINIMUM_CLOTHING_STOCK

	for (var/category in product_categories)
		for(var/obj/item/clothing/item in category["products"])
			if(category["products"][item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
				category["products"][item] = MINIMUM_CLOTHING_STOCK

	for (var/obj/item/clothing/item in premium)
		if(premium[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			premium[item] = MINIMUM_CLOTHING_STOCK

	products_nova?.Cut()
	product_categories_nova?.Cut()
	premium_nova?.Cut()
	contraband_nova?.Cut()
	return ..()

/obj/machinery/vending/spawn_frame(disassembled)
	if(ai_controller) // Vendor uprising, vending machines that are jumping around shouldn't be anchored
		set_anchored(FALSE)
	return ..()

/// This proc checks for forbidden traits cause it'd be pretty bad to have 5 insuls available to assistants roundstart at the vendor!
/obj/machinery/vending/proc/allow_increase(obj/item/clothing/clothing_path)
	var/obj/item/clothing/clothing = new clothing_path()

	// Ignore earmuffs!
	if(TRAIT_DEAF in clothing.clothing_traits)
		return FALSE
	// Don't touch sunglasses or welding helmets!
	if(clothing.flash_protect == FLASH_PROTECTION_WELDER)
		return FALSE
	// Don't touch bodyarmour!
	if(ispath(clothing, /obj/item/clothing/suit/armor))
		return FALSE
	// Don't touch protective helmets, like riot helmets!
	if(ispath(clothing, /obj/item/clothing/head/helmet))
		return FALSE
	// Ignore all gloves, because it's almost impossible to check what they do...
	if(ispath(clothing, /obj/item/clothing/gloves))
		return FALSE
	return TRUE

#undef MINIMUM_CLOTHING_STOCK
