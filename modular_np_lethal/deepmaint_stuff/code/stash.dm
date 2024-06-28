GLOBAL_LIST_EMPTY(ckey_to_storage_box)

// Stash storage datum

/datum/storage/stash_storage
	max_slots = 6
	max_specific_storage = WEIGHT_CLASS_NORMAL
	max_total_storage = WEIGHT_CLASS_BULKY * 6
	numerical_stacking = FALSE
	rustle_sound = TRUE
	screen_max_columns = 3
	/// What ckey this storage is linked to
	var/linked_ckey

/datum/storage/stash_storage/open_storage(mob/to_show)
	if(to_show.client.ckey != linked_ckey)
		parent.balloon_alert(to_show, "you cannot access this!")
		return FALSE

	return ..()

// Storage item

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/secure_container
	name = "Secure Container"
	desc = "A thick yellow case with a seemingly impenetrable outer shell and locking mechanism. \
		It uses a mysterous lock that seems to read not a passcode or DNA, but rather the user's \
		resonance to detect if it should open."
	storage_type = /datum/storage/stash_storage
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/secure_container/Initialize(mapload, storage_linked_ckey)
	. = ..()
	atom_storage.max_total_storage = WEIGHT_CLASS_BULKY * 6
	atom_storage.max_slots = 6
	if(!storage_linked_ckey)
		message_admins("[src] tried to spawn without a linked ckey, don't do that")
		return INITIALIZE_HINT_QDEL
	var/datum/storage/stash_storage/our_storage = atom_storage
	our_storage.linked_ckey = storage_linked_ckey
	if(!GLOB.ckey_to_storage_box[storage_linked_ckey])
		GLOB.ckey_to_storage_box[storage_linked_ckey] = src
	else if(GLOB.ckey_to_storage_box[storage_linked_ckey])
		atom_storage.set_real_location(GLOB.ckey_to_storage_box[storage_linked_ckey])
	else
		message_admins("Peep the horror in secure container code, because it broke. Control-F this exact line to see why!")

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/secure_container/examine(mob/user)
	. = ..()
	var/datum/storage/stash_storage/our_storage = atom_storage
	if(user.client.ckey == our_storage.linked_ckey)
		. += span_engradio("This secure container is linked to you, and only you can open it.")
	else
		. += span_engradio("This secure container is inaccessible to you.")
	return .

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/secure_container/PopulateContents()
	return
