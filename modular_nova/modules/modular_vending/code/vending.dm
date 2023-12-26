#define MINIMUM_CLOTHING_STOCK 5

/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/nova_products
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/nova_product_categories
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/nova_premium
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/nova_contraband

/obj/machinery/vending/Initialize(mapload)
	if(nova_products)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in nova_products)
			products[item_to_add] = nova_products[item_to_add]

	if(nova_product_categories)
		for(var/category in nova_product_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(nova_premium)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in nova_premium)
			premium[item_to_add] = nova_premium[item_to_add]

	if(nova_contraband)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in nova_contraband)
			contraband[item_to_add] = nova_contraband[item_to_add]

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

	QDEL_NULL(nova_products)
	QDEL_NULL(nova_product_categories)
	QDEL_NULL(nova_premium)
	QDEL_NULL(nova_contraband)
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
