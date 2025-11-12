/**
 * Bitey quirk - allows toggling bite attacks without needing felenid tongue
 */
/datum/action/innate/toggle_bite
	name = "Go Feral"
	desc = "Toggle whether you bite instead of doing unarmed attacks."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "feral_mode_off"
	check_flags = AB_CHECK_CONSCIOUS
	/// List of random names for the action
	var/list/ability_name = list("Go Feral", "Bite the Hand that Feeds", "Unleash Id", "Activate Catbrain", "Gremlin Mode", "Nom Mode", "Dehumanize Yourself", "Misbehave")
	/// Whether or not bite bonuses were applied (so we don't stack with cat tongues)
	var/bite_bonuses_applied = FALSE

/// Randomly picks a name from the ability_name list for flavor
/datum/action/innate/toggle_bite/New(Target)
	name = pick(ability_name)
	return ..()

/**
 * Activates bite mode, enabling biting attacks instead of normal unarmed attacks.
 * Applies damage bonuses matching cat tongue if no cat tongue is present.
 * Registers signals to handle dynamic organ changes (tongue implants/removals).
 */
/datum/action/innate/toggle_bite/Activate()
	var/mob/living/carbon/human/human_owner = owner
	if(!ishuman(human_owner))
		return

	// Can't bite without a head
	var/obj/item/bodypart/head/head = human_owner.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		to_chat(human_owner, span_warning("You need a head in order to bite!"))
		return

	// The tricky part: we need to match cat tongue bonuses (+4/+7 damage, +10 effectiveness, +0.5 pummeling, sharpness)
	// But we can't stack them if someone already has a cat tongue. So we check first.
	var/obj/item/organ/tongue/cat/cat_tongue = human_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!istype(cat_tongue))
		// No cat tongue? We gotta provide the bonuses ourselves then
		add_bite_bonuses(head)
		RegisterSignal(human_owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(check_added_organ))
	else
		// They already have a cat tongue, so it's handling the bonuses. We just need to know when it's gone
		RegisterSignal(human_owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(check_removed_organ))

	ADD_TRAIT(human_owner, TRAIT_FERAL_BITER, REF(src))

	active = TRUE
	background_icon_state = "bg_default_on"
	button_icon_state = "feral_mode_on"
	to_chat(human_owner, span_notice("You will bite when making an unarmed attack."))
	build_all_button_icons()

/**
 * Deactivates bite mode, restoring normal unarmed attacks.
 */
/datum/action/innate/toggle_bite/Deactivate()
	UnregisterSignal(owner, list(COMSIG_CARBON_GAIN_ORGAN, COMSIG_CARBON_LOSE_ORGAN))
	var/mob/living/carbon/human/human_owner = owner
	if(!ishuman(human_owner))
		return

	var/obj/item/bodypart/head/head = human_owner.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		return

	// Remove any bonuses we added (if we added any)
	remove_bite_bonuses(head)

	// Stop forcing head attacks, go back to normal unarmed
	REMOVE_TRAIT(human_owner, TRAIT_FERAL_BITER, REF(src))

	active = FALSE
	background_icon_state = "bg_default"
	button_icon_state = "feral_mode_off"
	to_chat(human_owner, span_notice("You will make unarmed attacks normally."))
	build_all_button_icons()

/**
 * Cleanup proc - ensures bite mode is deactivated before the action is destroyed
 */
/datum/action/innate/toggle_bite/Destroy(force)
	// Make sure we clean up properly if we're being deleted while active
	if(HAS_TRAIT_FROM(owner, TRAIT_FERAL_BITER, REF(src)))
		Deactivate()
	return ..()

/**
 * Signal handler for when an organ is added to the mob.
 * If a cat tongue is implanted while bite mode is active with our bonuses,
 * remove our bonuses (cat tongue provides them) and switch to listening for organ loss.
 */
/datum/action/innate/toggle_bite/proc/check_added_organ(mob/living/carbon/human/recipient, obj/item/organ/organ_gained)
	SIGNAL_HANDLER

	// Only care if we're active and we actually applied bonuses
	if(!active || !bite_bonuses_applied)
		return
	var/obj/item/bodypart/head/head = recipient.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		return

	// Oh shit, they got a cat tongue implanted! It'll handle the bonuses now
	if(istype(organ_gained, /obj/item/organ/tongue/cat))
		// Remove our bonuses since the cat tongue is providing them now (no stacking!)
		remove_bite_bonuses(head)
		// Now we need to watch for when the cat tongue gets removed instead
		UnregisterSignal(recipient, COMSIG_CARBON_GAIN_ORGAN)
		RegisterSignal(recipient, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(check_removed_organ))

/**
 * Signal handler for when an organ is removed from the mob.
 * If a cat tongue is removed while bite mode is active,
 * apply our bonuses (since cat tongue is no longer providing them) and switch to listening for organ gain.
 *
 * Arguments:
 * * loser - The mob that lost the organ
 * * organ_lost - The organ that was removed
 */
/datum/action/innate/toggle_bite/proc/check_removed_organ(mob/living/carbon/human/loser, obj/item/organ/organ_lost)
	SIGNAL_HANDLER

	// Only do something if we're actually active
	if(!active)
		return
	var/obj/item/bodypart/head/head = loser.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		return

	// They lost their cat tongue! Now we gotta step up and provide the bonuses ourselves
	if(istype(organ_lost, /obj/item/organ/tongue/cat))
		// Apply our bonuses since the cat tongue isn't around to do it anymore
		add_bite_bonuses(head)
		// Now watch for if they get another cat tongue implanted
		UnregisterSignal(loser, COMSIG_CARBON_LOSE_ORGAN)
		RegisterSignal(loser, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(check_added_organ))

/**
 * Applies bite bonuses to the head, matching cat tongue bonuses.
 * These bonuses are: +4/+7 damage, +10 effectiveness, +0.5 pummeling, and sharpness.
 *
 * Arguments:
 * * head - The head bodypart to apply bonuses to
 */
/datum/action/innate/toggle_bite/proc/add_bite_bonuses(obj/item/bodypart/head/head)
	// These numbers match what the cat tongue does - we want to be equivalent, not better or worse
	head.unarmed_damage_low += 4
	head.unarmed_damage_high += 7
	head.unarmed_effectiveness += 10
	head.unarmed_pummeling_bonus += 0.5
	head.unarmed_sharpness = SHARP_EDGED
	bite_bonuses_applied = TRUE

/**
 * Removes bite bonuses from the head if they were applied by this action.
 *
 * Arguments:
 * * head - The head bodypart to remove bonuses from
 */
/datum/action/innate/toggle_bite/proc/remove_bite_bonuses(obj/item/bodypart/head/head)
	// Only remove bonuses if we actually added them (safety check)
	if(bite_bonuses_applied)
		head.unarmed_damage_low -= 4
		head.unarmed_damage_high -= 7
		head.unarmed_effectiveness -= 10
		head.unarmed_pummeling_bonus -= 0.5
		head.unarmed_sharpness = NONE
		bite_bonuses_applied = FALSE

/**
 * Bitey quirk - allows toggling bite attacks without needing Feline Traits or cat tongue.
 * Provides the same biting ability as felinids, but as a standalone neutral quirk.
 * Automatically removes itself if the holder has or gains a cat tongue organ.
 */
/datum/quirk/bitey
	name = "Bitey"
	desc = "You can toggle whether you bite instead of doing unarmed attacks. This ability is independent of other feline traits."
	gain_text = span_notice("You feel like you could bite someone if you wanted to.")
	lose_text = span_notice("You no longer feel the urge to bite.")
	medical_record_text = "Patient has the ability to toggle biting behavior."
	value = 0
	icon = FA_ICON_TOOTH
	/// The action button that allows toggling bite mode
	var/datum/action/innate/toggle_bite/bite_action

/**
 * Called when the quirk is first added to a mob.
 * Checks if the holder already has a cat tongue and removes the quirk if so.
 * Otherwise, grants the toggle bite action and registers signals for organ changes.
 *
 * Arguments:
 * * client_source - The client that owns the mob (if any)
 */
/datum/quirk/bitey/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!ishuman(human_holder))
		return

	// Felinids already have this ability built-in, so don't give them a duplicate
	var/obj/item/organ/tongue/cat/cat_tongue = human_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(istype(cat_tongue))
		// Just remove ourselves quietly - they don't need us
		human_holder.remove_quirk(/datum/quirk/bitey)
		return

	// Give them the action button to toggle bite mode
	bite_action = new(human_holder)
	bite_action.Grant(human_holder)
	// Watch out in case they get a cat tongue implanted later - we'll remove ourselves then too
	RegisterSignal(human_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(check_cat_tongue_gained))

/**
 * Called when the quirk is removed from a mob.
 * Cleans up signals and deletes the bite action.
 */
/datum/quirk/bitey/remove()
	UnregisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN)
	if(bite_action)
		QDEL_NULL(bite_action)

/**
 * Signal handler for when an organ is added to the quirk holder.
 * If a cat tongue is implanted, automatically removes this quirk
 * since felinids already have the biting ability.
 */
/datum/quirk/bitey/proc/check_cat_tongue_gained(mob/living/carbon/human/recipient, obj/item/organ/organ_gained)
	SIGNAL_HANDLER

	// Someone got a cat tongue implanted? They don't need us anymore
	if(istype(organ_gained, /obj/item/organ/tongue/cat))
		recipient.remove_quirk(/datum/quirk/bitey)

/**
 * Override for cat tongue's go_feral action to prevent stacking with bitey quirk.
 * If the bitey quirk already has TRAIT_FERAL_BITER active, prevents the cat tongue
 * from also enabling feral mode to avoid duplicate abilities.
 */
/datum/action/item_action/organ_action/go_feral/do_effect(trigger_flags)
	var/obj/item/organ/tongue/cat/cat_tongue = target

	// If someone with the bitey quirk already has feral mode active, don't let the cat tongue also enable it
	// This prevents having two "Go Feral" buttons doing the same thing
	if(!cat_tongue.feral_mode && HAS_TRAIT_NOT_FROM(cat_tongue.owner, TRAIT_FERAL_BITER, REF(cat_tongue)))
		return FALSE

	// Otherwise, do the normal thing
	return ..()

