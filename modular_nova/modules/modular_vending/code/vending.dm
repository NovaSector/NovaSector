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
		for(var/list/category in product_categories_nova)
			var/already_exists = FALSE
			for(var/list/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] |= category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories |= category

	if(premium_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in premium_nova)
			premium[item_to_add] = premium_nova[item_to_add]

	if(contraband_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in contraband_nova)
			contraband[item_to_add] = contraband_nova[item_to_add]

	// Time to make clothes amounts consistent!
	for(var/obj/item/clothing/item_path as anything in products)
		if(!ispath(item_path, /obj/item/clothing))
			continue
		if(products[item_path] < MINIMUM_CLOTHING_STOCK && allow_increase(item_path))
			products[item_path] = MINIMUM_CLOTHING_STOCK

	for(var/list/category in product_categories)
		for(var/obj/item/clothing/item_path as anything in category["products"])
			if(!ispath(item_path, /obj/item/clothing))
				continue
			if(category["products"][item_path] < MINIMUM_CLOTHING_STOCK && allow_increase(item_path))
				category["products"][item_path] = MINIMUM_CLOTHING_STOCK

	for(var/obj/item/clothing/item_path as anything in premium)
		if(!ispath(item_path, /obj/item/clothing))
			continue
		if(premium[item_path] < MINIMUM_CLOTHING_STOCK && allow_increase(item_path))
			premium[item_path] = MINIMUM_CLOTHING_STOCK

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
	// Don't touch bodyarmour!
	if(ispath(clothing_path, /obj/item/clothing/suit/armor))
		return FALSE
	// Don't touch protective helmets, like riot helmets!
	if(ispath(clothing_path, /obj/item/clothing/head/helmet))
		return FALSE
	// Ignore all gloves, because it's almost impossible to check what they do...
	if(ispath(clothing_path, /obj/item/clothing/gloves))
		return FALSE
	// Don't touch sunglasses or welding helmets!
	if(clothing_path::flash_protect == FLASH_PROTECTION_WELDER)
		return FALSE
	// Ignore earmuffs!
	var/obj/item/clothing/clothing = new clothing_path() // need to instantiate one to check for this, no initial() on lists
	if(TRAIT_DEAF in clothing.clothing_traits)
		return FALSE
	qdel(clothing)
	return TRUE

#undef MINIMUM_CLOTHING_STOCK
