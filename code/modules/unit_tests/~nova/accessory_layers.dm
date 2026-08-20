/// Gets all the layer postfixes for this bodypart overlay
/datum/bodypart_overlay/proc/get_layer_postfixes()
	var/list/result = list()
	for(var/postfix in layers)
		result += postfix
	return result

/// Ensures SSaccessories.all_layer_postfixes matches the postfixes actually declared across every bodypart_overlay's layers list, in both directions.
/datum/unit_test/accessory_layers

/datum/unit_test/accessory_layers/Run()
	var/list/declared = list() // postfix -> first type that declares it, for error messages
	for(var/overlay_path in subtypesof(/datum/bodypart_overlay))
		var/datum/bodypart_overlay/overlay = new overlay_path()
		for(var/postfix in overlay.get_layer_postfixes())
			if(isnull(declared[postfix]))
				declared[postfix] = overlay_path
		qdel(overlay)

	for(var/postfix in declared)
		if(!(postfix in SSaccessories.all_layer_postfixes))
			TEST_FAIL("[declared[postfix]] declares layer postfix \"[postfix]\" which is missing from SSaccessories.all_layer_postfixes - add it to the list.")

	for(var/postfix in SSaccessories.all_layer_postfixes)
		if(isnull(declared[postfix]))
			TEST_FAIL("SSaccessories.all_layer_postfixes contains \"[postfix]\" but no bodypart_overlay declares it in a layers list - remove it, or add the overlay layer that should use it.")
