/datum/action/innate/toggle_bite
	name = "Go Feral"
	desc = "Toggle whether you bite instead of doing unarmed attacks."
	button_icon = 'modular_nova/master_files/icons/mob/actions/actions_items.dmi'
	button_icon_state = "bite_off"
	check_flags = AB_CHECK_CONSCIOUS
	var/list/ability_name = list("Go Feral", "Show Your Rage", "Shred Them", "Gremlin Mode", "Nom Mode", "Dehumanize Yourself", "Misbehave")
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

	var/obj/item/organ/tongue/cat/cat_tongue = human_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!istype(cat_tongue))
		add_bite_bonuses(head)
		RegisterSignal(human_owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(check_added_organ))
	else
		RegisterSignal(human_owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(check_removed_organ))

	ADD_TRAIT(human_owner, TRAIT_FERAL_BITER, REF(src))

	active = TRUE
	background_icon_state = "bg_default_on"
	button_icon_state = "bite_on"
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

	remove_bite_bonuses(head)

	REMOVE_TRAIT(human_owner, TRAIT_FERAL_BITER, REF(src))

	active = FALSE
	background_icon_state = "bg_default"
	button_icon_state = "bite_off"
	to_chat(human_owner, span_notice("You will make unarmed attacks normally."))
	build_all_button_icons()

/**
 * Cleanup proc - ensures bite mode is deactivated before the action is destroyed
 */
/datum/action/innate/toggle_bite/Destroy(force)
	// Make sure we clean up properly if we're being deleted while active
	if(owner && HAS_TRAIT_FROM(owner, TRAIT_FERAL_BITER, REF(src)))
		Deactivate()
	return ..()

/datum/quirk/bitey/proc/handle_random_bite(mob/living/carbon/human/source, mob/living/target, datum/martial_art/attacker_style)
SIGNAL_HANDLER

    // If the toggle is already ON, don't do anything (they are already biting)
    if(bite_action?.active)
        return

    // 10% chance to "snap" and bite instead of punching
    if(prob(10))
        // Briefly apply the biter trait so the combat system processes this attack as a bite
        ADD_TRAIT(source, TRAIT_FERAL_BITER, "random_bite_snap")

        // We use a timer to remove it immediately after the attack cycle finishes
        addtimer(CALLBACK(GLOBAL_PROC, .proc/_remove_random_bite, source), 1)

        // Optional: Add a little flavor message so the player knows why they bit
        if(prob(50))
            source.visible_message(span_danger("[source] snaps their teeth at [target]!"), \
                span_danger("You feel a sudden urge to bite [target]!"))

/proc/_remove_random_bite(mob/living/carbon/human/source)
    REMOVE_TRAIT(source, TRAIT_FERAL_BITER, "random_bite_snap")
/**
 * Signal handler for when an organ is added to the mob.
 * If a cat tongue is implanted while bite mode is active with our bonuses,
 * remove our bonuses (cat tongue provides them) and switch to listening for organ loss.
 */
/datum/action/innate/toggle_bite/proc/check_added_organ(mob/living/carbon/human/recipient, obj/item/organ/organ_gained)
	SIGNAL_HANDLER

	if(!active || !bite_bonuses_applied)
		return
	var/obj/item/bodypart/head/head = recipient.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		return

	if(istype(organ_gained, /obj/item/organ/tongue/cat))
		remove_bite_bonuses(head)
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

	if(!active)
		return
	var/obj/item/bodypart/head/head = loser.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		return

	if(istype(organ_lost, /obj/item/organ/tongue/cat))
		add_bite_bonuses(head)
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
	// These numbers match what the cat tongue does - we want to be equivalent
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

/*
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
	var/datum/action/innate/toggle_bite/bite_action

/datum/quirk/bitey/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE, announce = TRUE)
	if(!new_holder)
		return FALSE
	var/mob/living/carbon/human/human_holder = new_holder
	if(!ishuman(human_holder))
		return FALSE

	// Avoid giving this quirk to someone who already has built-in feline biting.
	if(istype(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/cat) || isfelinid(human_holder))
		return FALSE

	return ..(new_holder, quirk_transfer = quirk_transfer, client_source = client_source, unique = unique, announce = announce)

/*
 * Called when the quirk is first added to a mob.
 * Checks if the holder already has a cat tongue and removes the quirk if so.
 */
/datum/quirk/bitey/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!ishuman(human_holder))
		return

	var/obj/item/organ/tongue/cat/cat_tongue = human_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(istype(cat_tongue) || isfelinid(human_holder))
		return

	// Give them the action button to toggle bite mode
	bite_action = new(human_holder)
	bite_action.Grant(human_holder)
	// Watch out in case they get a cat tongue implanted later - we'll remove ourselves then too
	RegisterSignal(human_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(check_cat_tongue_gained))
	RegisterSignal(human_holder, COMSIG_MOB_ATTACK_HAND, PROC_REF(handle_random_bite))

/*
 * Called when the quirk is removed from a mob.
 * Cleans up signals and deletes the bite action.
 */
/datum/quirk/bitey/remove()
	UnregisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN)
	UnregisterSignal(quirk_holder, COMSIG_MOB_ATTACK_HAND)
	if(bite_action)
		QDEL_NULL(bite_action)

/**
 * Signal handler for when an organ is added to the quirk holder.
 * If a cat tongue is implanted, automatically removes this quirk
 * since felinids already have the biting ability.
 */
/datum/quirk/bitey/proc/check_cat_tongue_gained(mob/living/carbon/human/recipient, obj/item/organ/organ_gained)
	SIGNAL_HANDLER

	if(istype(organ_gained, /obj/item/organ/tongue/cat))
		qdel(src)

/*
 * Override for cat tongue's go_feral action to prevent stacking with bitey quirk.
 * If the bitey quirk already has TRAIT_FERAL_BITER active, prevents the cat tongue
 * from also enabling feral mode to avoid duplicate abilities.
 */
/datum/action/item_action/organ_action/go_feral/do_effect(trigger_flags)
	var/obj/item/organ/tongue/cat/cat_tongue = target

	if(!cat_tongue.feral_mode && HAS_TRAIT_NOT_FROM(cat_tongue.owner, TRAIT_FERAL_BITER, REF(cat_tongue)))
		return FALSE

	return ..()
