/// the storage type for storage rigs gained from the loadout
/datum/storage/loadout_belt
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_slots = 7

/datum/storage/loadout_belt/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	//Has size exceptions for some larger items in toolbelts & mining webbing
	set_holdable(exception_hold_list = list(
		/obj/item/construction, //RCD, RLD, RTD
		/obj/item/inducer,
		/obj/item/pickaxe/mini, //Despite being Mini, it's NORMAL (not SMALL). The base pickaxe is BULKY.
		/obj/item/pipe_painter,
		/obj/item/plunger,
		/obj/item/resonator,
		/obj/item/shovel,
		/obj/item/stack/ore,
		/obj/item/stack/sheet/animalhide,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
		/obj/item/storage/bag/ore,
	))

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
	if(is_type_in_list(arrived, limited_hold_types) && (arrived.w_class > WEIGHT_CLASS_SMALL)) // weight class check for small guns/telebatons
		limited_held++
		if(isgun(arrived))
			playsound(parent, 'modular_nova/modules/sec_haul/sound/holsterin.ogg', 50, rustle_vary, -5)

/datum/storage/security_belt/handle_exit(datum/source, obj/item/gone)
	. = ..()
	if(is_type_in_list(gone, limited_hold_types))
		limited_held = max(limited_held - 1, 0)
		if(isgun(gone))
			playsound(parent, 'modular_nova/modules/sec_haul/sound/holsterout.ogg', 50, rustle_vary, -5)

/datum/storage/security_belt/can_insert(obj/item/to_insert, mob/user, messages, force)
	. = ..()
	if(is_type_in_list(to_insert, limited_hold_types) && (limited_held >= max_limited_store) && (to_insert.w_class > WEIGHT_CLASS_SMALL))
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
