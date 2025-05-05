/obj/item/storage/lockbox/timeclock
	name = "crew equipment lockbox"
	desc = "Holds a crew's restricted equipment while they are temporarily assigned off-duty. Nanotrasen contracts stipulate that company issued batons, masks, restraints, and other equipment are not to be used for recreational purposes. The lockbox may be unlocked to retrieve restricted items after punch in."
	icon = 'modular_nova/modules/plexagon_selfserve/icons/shame_box.dmi'
	icon_state = "crewbox+l"
	icon_locked = "crewbox+l"
	icon_closed = "crewbox"
	icon_broken = "crewbox+b"
	w_class = WEIGHT_CLASS_NORMAL
	req_access = list(ACCESS_ALL_PERSONAL_LOCKERS)
	/// The ID card associated with the box
	var/obj/item/card/id/associated_card
	/// A display formatted list of the locked contents
	var/locked_contents = null
	item_flags = ABSTRACT | DROPDEL

/obj/item/storage/lockbox/timeclock/Initialize(mapload, obj/item/card/id/crew_id)
	. = ..()
	if(!isnull(loc))
		return INITIALIZE_HINT_QDEL // These should never be spawned in realspace
	atom_storage.allow_big_nesting = TRUE
	atom_storage.max_slots = 99
	atom_storage.max_specific_storage = WEIGHT_CLASS_GIGANTIC
	atom_storage.max_total_storage = 99
	if(!isnull(crew_id) || !istype(crew_id))
		associated_card = crew_id
	if(associated_card?.registered_name)
		name = "[initial(name)] - [associated_card.registered_name]"

/obj/item/storage/lockbox/timeclock/examine(mob/user)
	. = ..()
	if(!isnull(locked_contents))
		. += span_notice("The contents label reads: [locked_contents].")

/obj/item/storage/lockbox/timeclock/can_unlock(mob/living/user, obj/item/card/id/id_card)
	. = ..()
	if(!.)
		to_chat(user, span_warning("[src] can only be unlocked while on-duty or by the HoP, HoS, or Captain!"))

/// Timeclock boxes can only be opened while the crew member is on duty, or by a command member with the proper access.
/obj/item/storage/lockbox/timeclock/check_access(obj/item/crew_id)
	if(isnull(crew_id))
		return FALSE

	var/obj/item/card/id/access_card
	if(istype(crew_id, /obj/item/modular_computer/pda))
		var/obj/item/modular_computer/pda/crew_pda = crew_id
		access_card = crew_pda.computer_id_slot
	else
		access_card = crew_id

	if(isnull(access_card))
		return FALSE
	if(!istype(access_card))
		return FALSE
	if(check_access_list(access_card.GetAccess()))
		release_contents()
		return TRUE
	if(access_card != associated_card)
		return FALSE

	var/datum/id_trim/job/current_trim = access_card.trim
	if(isnull(current_trim))
		return FALSE
	if(istype(current_trim, /datum/id_trim/job/assistant))
		return FALSE

	release_contents()
	return TRUE

/// Timeclock boxes are one time use. When unlocked, release the contents and go away.
/obj/item/storage/lockbox/timeclock/proc/release_contents()
	emptyStorage()
	usr.visible_message(span_notice("[usr] activates the lockbox mechanism, releasing its contents before vanishing in a puff of bluespace smoke!"))
	associated_card = null
	qdel(src)
