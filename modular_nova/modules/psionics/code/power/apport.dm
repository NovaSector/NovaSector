/datum/psionic_power/apport
	action_type = /datum/action/cooldown/psionic/pointed/apport

/datum/psionic_rank_variant/apport
	rank = PSIONIC_RANK_EPSILON
	variant_name = "apport"
	description = "Fold one visible loose item through bluespace into your hand."
	strain_gain = 12
	cooldown_time = 15 SECONDS
	cast_range = 7

/datum/action/cooldown/psionic/pointed/apport
	name = "Apport"
	desc = "Fold a nearby loose item through bluespace directly into your hand, ignoring anything in the way."
	button_icon_state = "psi_apport"
	point_cost = 1
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	needs_hands = TRUE
	active_msg = "You trace an item's position through bluespace..."
	deactive_msg = "You let the fold collapse."
	rank_variant_types = list(/datum/psionic_rank_variant/apport)
	/// Heaviest item class this power can fold through bluespace.
	var/max_item_class = WEIGHT_CLASS_NORMAL

/datum/action/cooldown/psionic/pointed/apport/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/obj/item/item_target = target
	if(!istype(item_target))
		living_owner.balloon_alert(living_owner, "not an item!")
		return FALSE
	if(!isturf(item_target.loc))
		living_owner.balloon_alert(living_owner, "not loose!")
		return FALSE
	if(item_target.anchored || item_target.move_resist >= MOVE_FORCE_STRONG)
		living_owner.balloon_alert(living_owner, "too heavy!")
		return FALSE
	if(item_target.w_class > max_item_class)
		living_owner.balloon_alert(living_owner, "too bulky!")
		return FALSE
	if(HAS_TRAIT(item_target, TRAIT_UNCATCHABLE) || !living_owner.can_hold_items(item_target))
		living_owner.balloon_alert(living_owner, "can't hold it!")
		return FALSE
	if(!length(living_owner.get_empty_held_indexes()))
		living_owner.balloon_alert(living_owner, "free a hand!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/apport/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/obj/item/apported_item = target
	var/turf/item_turf = get_turf(apported_item)
	var/turf/owner_turf = get_turf(living_owner)
	if(!istype(living_owner) || !istype(apported_item) || !item_turf || !owner_turf)
		return FALSE

	if(!do_teleport(apported_item, owner_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE))
		living_owner.balloon_alert(living_owner, "fold fails!")
		return FALSE

	living_owner.put_in_hands(apported_item)
	playsound(item_turf, 'sound/effects/magic/wand_teleport.ogg', 45, TRUE)
	playsound(owner_turf, 'sound/effects/magic/wand_teleport.ogg', 45, TRUE)
	new /obj/effect/temp_visual/psionic/spatial_slip(item_turf, get_manifestation_color())
	living_owner.visible_message(
		span_notice("[apported_item] folds out of sight and into [living_owner]'s hand."),
		span_purple("You fold [apported_item] through bluespace and into your hand."),
	)
	return TRUE
