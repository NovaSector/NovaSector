/obj/item/paperplane
	name = "paper plane"
	desc = "Paper, folded in the shape of a plane."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "paperplane"
	base_icon_state = "paperplane"
	custom_fire_overlay = "paperplane_onfire"
	throw_range = 7
	throw_speed = 1
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 50

	///The chance of hitting a mob in the eye when thrown, in percentage.
	var/hit_probability = 2
	///Reference to the paper that's folded up in this paperplane, which we return when unfolded.
	var/obj/item/paper/internal_paper

	// NOVA EDIT START - Better paper planes
	/// How long does getting shot in the eyes knock you down for?
	var/knockdown_duration = 4 SECONDS
	/// How much eye damage does it deal at minimum on eye impact?
	var/impact_eye_damage_lower = 6
	/// How much eye damage does it deal at maximum on eye impact?
	var/impact_eye_damage_higher = 8
	/// Does it get deleted when hitting anything or landing?
	var/delete_on_impact = FALSE
	// NOVA EDIT END

/obj/item/paperplane/syndicate
	desc = "Paper, masterfully folded in the shape of a plane."
	throwforce = 20
	hit_probability = 100

/obj/item/paperplane/Initialize(mapload, obj/item/paper/paper_made_of)
	. = ..()
	pixel_x = base_pixel_x + rand(-9, 9)
	pixel_y = base_pixel_y + rand(-8, 8)
	if(paper_made_of)
		internal_paper = paper_made_of
		flags_1 = paper_made_of.flags_1
		color = paper_made_of.color
		paper_made_of.forceMove(src)
	else
		internal_paper = new(src)
	if(istype(internal_paper, /obj/item/paper/carbon_copy))
		icon_state = "[base_icon_state]_carbon"
	update_appearance(UPDATE_ICON)

/obj/item/paperplane/Exited(atom/movable/gone, direction)
	. = ..()
	if (internal_paper == gone)
		internal_paper = null
		if(!QDELETED(src))
			qdel(src)

/obj/item/paperplane/Destroy()
	internal_paper = null
	return ..()

/obj/item/paperplane/suicide_act(mob/living/user)
	var/obj/item/organ/internal/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	user.Stun(20 SECONDS)
	user.visible_message(span_suicide("[user] jams [src] in [user.p_their()] nose. It looks like [user.p_theyre()] trying to commit suicide!"))
	user.adjust_eye_blur(12 SECONDS)
	if(eyes)
		eyes.apply_organ_damage(rand(impact_eye_damage_lower, impact_eye_damage_higher)) // NOVA EDIT START - Better paper planes
	sleep(1 SECONDS)
	return BRUTELOSS

/obj/item/paperplane/update_overlays()
	. = ..()
	for(var/stamp in internal_paper.stamp_cache)
		. += "[base_icon_state]_[stamp]"

/obj/item/paperplane/attack_self(mob/user)
	balloon_alert(user, "unfolded")

	var/atom/location = drop_location()
	// Need to keep a reference to the internal paper
	// when we move it out of the plane, our ref gets set to null
	var/obj/item/paper/released_paper = internal_paper
	released_paper.forceMove(location)
	// This will as a side effect, qdel the paper plane, making the user's hands empty

	user.put_in_hands(released_paper)

/obj/item/paperplane/attackby(obj/item/attacking_item, mob/user, params)
	if(burn_paper_product_attackby_check(attacking_item, user))
		return
	if(istype(attacking_item, /obj/item/pen) || istype(attacking_item, /obj/item/toy/crayon))
		to_chat(user, span_warning("You should unfold [src] before changing it!"))
		return
	else if(istype(attacking_item, /obj/item/stamp)) //we don't randomize stamps on a paperplane
		internal_paper.attackby(attacking_item, user) //spoofed attack to update internal paper.
		update_appearance()
		add_fingerprint(user)
		return
	return ..()

/obj/item/paperplane/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(iscarbon(hit_atom) && HAS_TRAIT(hit_atom, TRAIT_PAPER_MASTER))
		var/mob/living/carbon/hit_carbon = hit_atom
		if(hit_carbon.can_catch_item(TRUE))
			hit_carbon.throw_mode_on(THROW_MODE_TOGGLE)

	. = ..()
	if(. || !ishuman(hit_atom)) //if the plane is caught or it hits a nonhuman
		return
	var/mob/living/carbon/human/hit_human = hit_atom
	var/obj/item/organ/internal/eyes/eyes = hit_human.get_organ_slot(ORGAN_SLOT_EYES)
	if(!prob(hit_probability))
		return
	if(hit_human.is_eyes_covered())
		return
	visible_message(span_danger("\The [src] hits [hit_human] in the eye[eyes ? "" : " socket"]!"))
	hit_human.adjust_eye_blur(12 SECONDS)
	eyes?.apply_organ_damage(rand(6, 8))
	hit_human.Paralyze(4 SECONDS)
	hit_human.emote("scream")

/obj/item/paperplane/throw_at(atom/target, range, speed, mob/thrower, spin=FALSE, diagonals_first = FALSE, datum/callback/callback, gentle, quickstart = TRUE)
<<<<<<< HEAD
	. = ..(target, range, speed, thrower, FALSE, diagonals_first, callback, quickstart = quickstart)

/obj/item/paperplane/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(iscarbon(hit_atom))
		var/mob/living/carbon/C = hit_atom
		if(C.can_catch_item(TRUE))
			var/datum/action/innate/origami/origami_action = locate() in C.actions
			if(origami_action?.active) //if they're a master of origami and have the ability turned on, force throwmode on so they'll automatically catch the plane.
				C.throw_mode_on(THROW_MODE_TOGGLE)

	if(..() || !ishuman(hit_atom))//if the plane is caught or it hits a nonhuman
		// NOVA EDIT START - Better paper planes
		if(delete_on_impact)
			qdel(src)
		// NOVA EDIT END
		return
	var/mob/living/carbon/human/H = hit_atom
	var/obj/item/organ/internal/eyes/eyes = H.get_organ_slot(ORGAN_SLOT_EYES)
	if(prob(hit_probability))
		if(H.is_eyes_covered())
			// NOVA EDIT START - Better paper planes
			if(delete_on_impact)
				qdel(src)
			// NOVA EDIT END
			return
		visible_message(span_danger("\The [src] hits [H] in the eye[eyes ? "" : " socket"]!"))
		H.adjust_eye_blur(12 SECONDS)
		eyes?.apply_organ_damage(rand(impact_eye_damage_lower, impact_eye_damage_higher))
		H.Knockdown(40)
		H.emote("scream")

	if(delete_on_impact)
		qdel(src)
	// NOVA EDIT END

/obj/item/paper/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click [src] to fold it into a paper plane.")

/obj/item/paper/AltClick(mob/living/user, obj/item/I)
	if(!user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS))
		return
	if(istype(src, /obj/item/paper/carbon))
		var/obj/item/paper/carbon/Carbon = src
		if(!Carbon.copied)
			to_chat(user, span_notice("Take off the carbon copy first."))
			return
	//Origami Master
	var/datum/action/innate/origami/origami_action = locate() in user.actions
	if(origami_action?.active)
		make_plane(user, I, /obj/item/paperplane/syndicate)
	else
		make_plane(user, I, /obj/item/paperplane)

/**
 * Paper plane folding
 *
 * Arguments:
 * * mob/living/user - who's folding
 * * obj/item/I - what's being folded
 * * obj/item/paperplane/plane_type - what it will be folded into (path)
 */
/obj/item/paper/proc/make_plane(mob/living/user, obj/item/I, obj/item/paperplane/plane_type = /obj/item/paperplane)
	balloon_alert(user, "folded into a plane")
	user.temporarilyRemoveItemFromInventory(src)
	I = new plane_type(loc, src)
	if(user.Adjacent(I))
		user.put_in_hands(I)
=======
	return ..(target, range, speed, thrower, FALSE, diagonals_first, callback, quickstart = quickstart)
>>>>>>> 8d14688256c (Fixes some issues with paper planes (#81453))
