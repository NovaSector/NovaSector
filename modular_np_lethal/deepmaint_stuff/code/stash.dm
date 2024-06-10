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
	var/user_ckey = to_show.client.ckey
	if(!linked_ckey)
		if(!GLOB.ckey_to_storage_box[user_ckey])
			GLOB.ckey_to_storage_box[user_ckey] = src
		else if(GLOB.ckey_to_storage_box[user_ckey])
			set_real_location(GLOB.ckey_to_storage_box[user_ckey])
		else
			message_admins("Peep the horror in secure container code, because it broke. Control-F this exact line to see why!")
			return
		linked_ckey = user_ckey
	if(user_ckey != linked_ckey)
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

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/secure_container/examine(mob/user)
	. = ..()
	var/datum/storage/stash_storage/our_storage = atom_storage
	if(!our_storage.linked_ckey)
		. += span_engradio("This secure container has not been linked to anyone yet, open it to do so.")
	else if(user.client.ckey == our_storage.linked_ckey)
		. += span_engradio("This secure container is linked to you, and only you can open it.")
	else
		. += span_engradio("This secure container is inaccessible to you.")
	return .

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/secure_container/PopulateContents()
	return
