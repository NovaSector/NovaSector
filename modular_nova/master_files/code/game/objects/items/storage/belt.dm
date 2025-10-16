/// restricting security storage datum to prevent hoarding multiple weapons
/datum/storage/security_belt
	/// types we're stopping ourselves from holding multiple of
	var/list/limited_hold_types = list(
		/obj/item/gun,
		/obj/item/melee/baton,
	)
	/// how many restricted items do we already have stored in this belt
	var/limited_held = 0
	/// how many restricted items do we want to keep, at maximum, in this belt (2, ideally, for a gun and baton, theoretically)
	var/max_limited_store = 2

/datum/storage/security_belt/handle_enter(datum/source, obj/item/arrived)
	. = ..()
	if(is_type_in_list(arrived, limited_hold_types))
		limited_held++

/datum/storage/security_belt/handle_exit(datum/source, obj/item/gone)
	. = ..()
	if(is_type_in_list(gone, limited_hold_types))
		limited_held = max(limited_held - 1, 0)

/datum/storage/security_belt/can_insert(obj/item/to_insert, mob/user, messages, force)
	. = ..()
	if(is_type_in_list(to_insert, limited_hold_types) && (limited_held >= max_limited_store))
		user.balloon_alert(user, "no suitable space!")
		return FALSE

// CE's roundstart toolbelt, with T2 tools
/obj/item/storage/belt/utility/chief/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver/power, src)
	SSwardrobe.provide_type(/obj/item/crowbar/power, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/experimental, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)
	SSwardrobe.provide_type(/obj/item/extinguisher/mini, src)
	SSwardrobe.provide_type(/obj/item/analyzer/ranged, src)

/obj/item/storage/belt/utility/chief/full/get_types_to_preload()
	var/list/to_preload = list()
	to_preload += /obj/item/screwdriver/power
	to_preload += /obj/item/crowbar/power
	to_preload += /obj/item/weldingtool/electric
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	to_preload += /obj/item/extinguisher/mini
	to_preload += /obj/item/analyzer/ranged
	return to_preload
