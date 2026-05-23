GLOBAL_LIST_EMPTY(tribal_den_holes)

/obj/structure/tribal_den_hole
	name = "hole in the ground"
	desc = "A fortified hole leading into a sheltered den below."
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "hole"
	anchored = TRUE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	/// Shared id with linked den holes.
	var/id
	/// Time spent entering or leaving the den.
	var/travel_time = 3 SECONDS
	/// Non-tribals need an attuned translator necklace or this trait.
	var/requires_den_access = TRUE

/obj/structure/tribal_den_hole/Initialize(mapload)
	. = ..()
	GLOB.tribal_den_holes += src

/obj/structure/tribal_den_hole/Destroy()
	GLOB.tribal_den_holes -= src
	return ..()

/obj/structure/tribal_den_hole/examine(mob/user)
	. = ..()
	if(requires_den_access)
		. += span_notice("The route is watched. Tribals and invited guests can pass through.")

/obj/structure/tribal_den_hole/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	try_enter(user)

/obj/structure/tribal_den_hole/proc/try_enter(mob/living/user)
	if(!istype(user) || !user.can_interact_with(src))
		return FALSE

	if(!can_use_den_hole(user))
		to_chat(user, span_warning("Something about this route rejects you."))
		return FALSE

	var/turf/destination = get_destination_turf(user)
	if(!istype(destination))
		to_chat(user, span_warning("[src] leads nowhere right now."))
		return FALSE

	user.visible_message(span_notice("[user] starts climbing into [src]."), span_notice("You start climbing into [src]."))
	if(!do_after(user, travel_time, target = src))
		return FALSE

	if(!can_use_den_hole(user) || !user.can_interact_with(src))
		return FALSE

	playsound(src, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	. = do_teleport(user, destination, no_effects = TRUE, channel = TELEPORT_CHANNEL_FREE, forced = TRUE)
	if(.)
		playsound(destination, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/structure/tribal_den_hole/proc/get_destination_turf(mob/living/user)
	if(!id)
		return

	var/list/possible_holes = list()
	for(var/obj/structure/tribal_den_hole/other_hole as anything in GLOB.tribal_den_holes)
		if(other_hole == src || other_hole.id != id)
			continue

		possible_holes += other_hole

	if(!length(possible_holes))
		return

	var/obj/structure/tribal_den_hole/chosen_hole
	if(length(possible_holes) == 1)
		chosen_hole = possible_holes[1]
	else
		chosen_hole = tgui_input_list(user, "Which den hole would you travel to?", "Den Hole Choice", possible_holes)

	if(!istype(chosen_hole))
		return

	return get_turf(chosen_hole)

/obj/structure/tribal_den_hole/proc/can_use_den_hole(mob/living/user)
	if(!requires_den_access)
		return TRUE

	if(istribal(user) || HAS_TRAIT(user, TRAIT_TRIBAL_DEN_ACCESS))
		return TRUE

	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user))
		return FALSE

	var/obj/item/clothing/neck/necklace/translator/pass = human_user.wear_neck
	return istype(pass) && pass.is_attuned()
