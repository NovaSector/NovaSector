/// Toggle: spawns or retracts an organic blade in-hand.
/datum/action/cooldown/spell/hiveless/arm_blade
	name = "Arm Blade"
	desc = "Reshape one of your arms into a deadly blade of bone and sinew. Costs protein."
	button_icon_state = "arm_blade"
	cooldown_time = 1.5 SECONDS
	protein_cost = HIVELESS_COST_BLADE
	/// Blade item type spawned in-hand.
	var/weapon_type = /obj/item/melee/arm_blade

/datum/action/cooldown/spell/hiveless/arm_blade/can_cast_spell(feedback = TRUE)
	if(!ishuman(owner))
		return FALSE
	return ..()

/// Returns the held arm blade, or FALSE if none.
/datum/action/cooldown/spell/hiveless/arm_blade/proc/has_existing_blade()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/user = owner
	for(var/obj/item/held in user.held_items)
		if(istype(held, weapon_type))
			return held
	return FALSE

/datum/action/cooldown/spell/hiveless/arm_blade/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/user = owner
	var/obj/item/existing = has_existing_blade()
	if(existing)
		if(!spend_protein())
			return FALSE
		user.temporarilyRemoveItemFromInventory(existing, TRUE)
		spray_cast_blood(user)
		playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
		user.visible_message(
			span_warning("With a sickening crunch, [user] reforms [user.p_their()] blade back into an arm!"),
			span_notice("We assimilate our blade back into our body."),
			span_hear("You hear organic matter ripping and tearing!"),
		)
		return TRUE
	if(!spend_protein())
		return FALSE
	var/obj/item/held = user.get_active_held_item()
	if(held && !user.dropItemToGround(held))
		user.balloon_alert(user, "hand occupied!")
		return FALSE
	var/obj/item/blade = new weapon_type(user)
	user.put_in_active_hand(blade)
	spray_cast_blood(user)
	playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	user.visible_message(
		span_warning("A grotesque blade forms around [user]'s arm!"),
		span_warning("Our arm twists and mutates, transforming it into a deadly blade."),
		span_hear("You hear organic matter ripping and tearing!"),
	)
	return TRUE
