/**
 *	# WITHOUT THIS POWER:
 *
 *	- Mid-Blood: SHOW AS PALE
 *	- Low-Blood: SHOW AS DEAD
 *	- No Heartbeat
 *  - Examine shows actual blood
 *	- Thermal homeostasis (ColdBlooded)
 * 		WITH THIS POWER:
 *	- Normal body temp -- remove Cold Blooded (return on deactivate)
 */

/datum/action/cooldown/bloodsucker/masquerade
	name = "Mimic"
	desc = "Suppress your metabolic signature and feign normal vital signs, escaping both casual and medical notice."
	button_icon_state = "power_human"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_STATIC_COOLDOWN|BP_AM_COSTLESS_UNCONSCIOUS
	check_flags = NONE
	bloodsucker_check_flags = BP_CANT_USE_IN_FERAL
	purchase_flags = BLOODSUCKER_DEFAULT_POWER
	bloodcost = 10
	level_current = -1
	cooldown_time = 5 SECONDS
	constant_bloodcost = 0.1

/datum/action/cooldown/bloodsucker/masquerade/get_power_explanation_extended()
	. = list()
	. += "Mimic will suppress your symbiont markers, making you practically identical to a normal human."
	. += "- You lose nearly all Bloodsucker benefits, including healing, sleep, radiation, crit, virus, gutting and cold immunity."
	. += "- Your eyes return to normal as your heart begins to beat."
	. += "- You gain a Genetic sequence, and appear to have 100% blood when scanned by a Health Analyzer."
	. += "- You will not appear as Pale when examined. Anything further than Pale, however, will not be hidden."
	. += "Deactivating Mimic restores your symbiont abilities and purges any diseases contracted while mimicking."

/datum/action/cooldown/bloodsucker/masquerade/ActivatePower(atom/target)
	var/mob/living/carbon/user = owner
	owner.balloon_alert(owner, "mimic activated.")
	to_chat(user, span_notice("Your heart beats falsely within your chest as the symbiont suppresses its markers. You may yet pass for uninfected."))
	to_chat(user, span_warning("Symbiont regeneration is halted while mimicking normal vitals."))

	// Give status effect
	user.apply_status_effect(/datum/status_effect/masquerade)

	// Handle Traits
	user.remove_traits(bloodsuckerdatum_power.bloodsucker_traits, BLOODSUCKER_TRAIT)

	ADD_TRAIT(user, TRAIT_MIMIC, BLOODSUCKER_TRAIT)
	var/obj/item/bodypart/chest/target_chest = user.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest)
		target_chest.bodypart_flags &= ~BODYPART_UNREMOVABLE
	// Handle organs
	var/obj/item/organ/heart/vampheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	if(vampheart)
		vampheart.Restart()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = initial(eyes.flash_protect)
		eyes.color_cutoffs = initial(eyes.color_cutoffs)
		eyes.sight_flags = initial(eyes.sight_flags)
		user.update_sight()
	return TRUE

/datum/action/cooldown/bloodsucker/masquerade/DeactivatePower(deactivate_flags)
	. = ..() // activate = FALSE
	if(!.)
		return
	var/mob/living/carbon/user = owner
	owner.balloon_alert(owner, "mimic deactivated.")

	// Remove status effect, mutations & diseases that you got while mimicking.
	user.remove_status_effect(/datum/status_effect/masquerade)
	for(var/datum/disease/diseases as anything in user.diseases)
		diseases.cure()

	// Handle Traits
	user.add_traits(bloodsuckerdatum_power.bloodsucker_traits, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_MIMIC, BLOODSUCKER_TRAIT)
	var/obj/item/bodypart/chest/target_chest = user.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest)
		target_chest.bodypart_flags |= BODYPART_UNREMOVABLE
	// Handle organs
	var/obj/item/organ/heart/vampheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	if(vampheart)
		vampheart.Stop()
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = max(initial(eyes.flash_protect) - 1, FLASH_PROTECTION_SENSITIVE)
		eyes.color_cutoffs = BLOODSUCKER_SIGHT_COLOR_CUTOFF
		eyes.sight_flags = SEE_MOBS
		user.update_sight()
	to_chat(user, span_notice("Your heart beats one final time as the symbiont reasserts control. Your skin dries and your pallor returns."))

/**
 * # Status effect
 *
 * This is what the Mimic power gives, handles their bonuses and gives them a neat icon to tell them Mimic is active.
 */

/datum/status_effect/masquerade
	id = "masquerade"
	duration = STATUS_EFFECT_PERMANENT
	duration = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/masquerade

/atom/movable/screen/alert/status_effect/masquerade
	name = "Mimic"
	desc = "You are suppressing your metabolic signature using Mimic. Symbiont regeneration is halted."
	icon = 'modular_nova/modules/bloodsucker/icons/bloodsucker_actions.dmi'
	icon_state = "power_human"
	alerttooltipstyle = "cult"

/atom/movable/screen/alert/status_effect/masquerade/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()
