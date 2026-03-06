/// Undoes SANITIZE_PATH so we can treat these strings as typepaths again
#define DESANITIZED_PATH(str) ( \
	istext(str) ? "/obj/item/[replacetext(str, "-", "/")]" : null \
)

/**
 * This vending machine supports a list of items that changes based on the user/card's access.
 */
/obj/machinery/vending/access
	name = "access-based vending machine"
	/// Internal variable to store our access list
	var/list/access_lists
	/// Should we auto build our product list? 0 means no
	var/auto_build_products = 0

/**
 * This is where you generate the list to store what items each access grants.
 * Should be an assosciative list where the key is the access as a string and the value is the items typepath.
 * You can also set it to TRUE instead of a list to allow them to purchase anything.
 */
/obj/machinery/vending/access/proc/build_access_list(list/access_lists)
	return

/obj/machinery/vending/access/Initialize(mapload)
	var/list/_list = new
	build_access_list(_list)

	// Normalize access_lists to accept both numeric and string keys.
	// This avoids building "[access]" strings in hot loops.
	access_lists = new
	for (var/access_key in _list)
		var/value = _list[access_key]
		access_lists[access_key] = value // original (numeric key if caller used numbers)
		access_lists["[access_key]"] = value // stringified mirror

	if (auto_build_products)
		products = list()
		for (var/access in access_lists)
			var/list/access_list = access_lists[access]
			if (isnum(access_list))
				continue
			for (var/item in access_list)
				if (!ispath(item) || (item in products))
					continue
				products[item] = auto_build_products

	return ..()

/obj/machinery/vending/access/ui_static_data(mob/user)
	. = ..()
	if (issilicon(user)) // Silicons get to view all items regardless
		return

	var/list/_records = .["product_records"]
	if (!length(_records))
		return

	// If emagged or not on station, access checks are bypassed upstream.
	if (obj_flags & EMAGGED || !onstation)
		return

	var/list/product_records = _records.Copy()
	_records.Cut()

	if (!iscarbon(user))
		return

	var/mob/living/carbon/carbon_user = user
	var/obj/item/card/id/user_id = carbon_user.get_idcard(TRUE)

	if (onstation && !user_id && !(obj_flags & EMAGGED))
		return

	var/list/user_access = user_id?.access
	if (!length(user_access))
		return

	var/list/filtered = list()
	for (var/list/product_record as anything in product_records)
		// Cache a real typepath once per record so we never re-text2path
		var/product_path = product_record["path_cache"]
		if (!product_path)
			var/product_string = DESANITIZED_PATH(product_record["path"])
			if (product_string)
				product_path = text2path(product_string)
				product_record["path_cache"] = product_path  // cache for all future UI opens

		if (product_path && allow_purchase(user_access, product_path))
			filtered += list(product_record)

	.["product_records"] = filtered

/// Check if the list of given access is allowed to purchase the given product
/obj/machinery/vending/access/proc/allow_purchase(list/user_access, product_path)
	if (obj_flags & EMAGGED || !onstation)
		return TRUE

	for (var/access_type in user_access)
		// O(1) lookups thanks to dual-key map in Initialize()
		var/access_list = access_lists[access_type]
		if (!access_list)
			continue
		if (access_list == TRUE) // allow-all bucket
			return TRUE
		if (product_path in access_list)
			return TRUE

	return FALSE

/// Debug version to verify access checking is working and functional
/obj/machinery/vending/access/debug
	auto_build_products = TRUE

/obj/machinery/vending/access/debug/build_access_list(list/access_lists)
	access_lists[ACCESS_ENGINEERING] = TRUE
	access_lists[ACCESS_EVA] = list(/obj/item/crowbar)
	access_lists[ACCESS_SECURITY] = list(/obj/item/wrench, /obj/item/gun/ballistic/revolver/mateba)

#undef DESANITIZED_PATH
