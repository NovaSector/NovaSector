/obj/item/storage/belt/security
	// new storage type with a thing to catch "do we have too many normal-sized items"
	storage_type = /datum/storage/size_restricted

/obj/item/storage/belt/security/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing/shotgun,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/flashlight/seclite,
		/obj/item/food/donut,
		/obj/item/grenade,
		/obj/item/gun,
		/obj/item/holosign_creator/security,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/radio,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/restraints/legcuffs/bola,
		))

/datum/storage/size_restricted
	/// w_class we're checking for
	var/limited_size = WEIGHT_CLASS_NORMAL
	/// how many normal items do we already have stored in this belt
	var/limited_size_stored = 0
	/// how mnay normal items do we want to keep, at maximum, in this belt (2, ideally, for a gun and baton, theoretically)
	var/max_limited_size = 2

/datum/storage/size_restricted/handle_enter(datum/source, obj/item/arrived)
	. = ..()
	count_normals()

/datum/storage/size_restricted/handle_exit(datum/source, obj/item/gone)
	. = ..()
	count_normals()

/datum/storage/size_restricted/can_insert(obj/item/to_insert, mob/user, messages, force)
	if((to_insert.w_class >= limited_size) && (limited_size_stored >= max_limited_size))
		if(messages && user)
			user.balloon_alert(user, "no suitable space!")
		return FALSE
	. = ..()

/datum/storage/size_restricted/proc/count_normals()
	limited_size_stored = 0
	for(var/obj/item/thing in real_location)
		if(thing.w_class >= limited_size)
			limited_size_stored++
