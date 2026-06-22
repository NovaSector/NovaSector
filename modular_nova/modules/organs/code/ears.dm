/obj/item/organ/ears/teshari
	name = "teshari ears"
	desc = "A set of four long rabbit-like ears, a Teshari's main tool while hunting. Naturally extremely sensitive to loud sounds."
	damage_multiplier = 1.5
	actions_types = list(/datum/action/cooldown/spell/sensitive_hearing)

/datum/action/cooldown/spell/sensitive_hearing
	name = "Toggle Sensitive Hearing"
	desc = "Listen for quiet sounds and hear whispers, but become extremely vulnerable to loud noises."
	button_icon = 'modular_nova/master_files/icons/hud/actions.dmi'
	button_icon_state = "echolocation_off"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

	cooldown_time = 1 SECONDS
	spell_requirements = NONE

/// Updates the icon on the teshari hearing action for when it's on/off
/datum/action/cooldown/spell/sensitive_hearing/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/sensitive_hearing/Remove(mob/living/remove_from)
	REMOVE_TRAIT(remove_from, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	remove_from.update_sight()
	if(remove_from.has_status_effect(/datum/status_effect/sensitive_hearing))
		// we haven't deactivated yet...
		sensitive_hearing_deactivate(remove_from)
	return ..()

/datum/action/cooldown/spell/sensitive_hearing/cast(list/targets, mob/living/carbon/human/user = usr)
	. = ..()

	if(user.has_status_effect(/datum/status_effect/sensitive_hearing))
		sensitive_hearing_deactivate(user)
		return

	sensitive_hearing_activate(user)

/// Applies the sensitive hearing status effect and updates icon
/datum/action/cooldown/spell/sensitive_hearing/proc/sensitive_hearing_activate(mob/living/carbon/human/user)
	user.apply_status_effect(/datum/status_effect/sensitive_hearing)
	update_button_state("echolocation_on")

/// Removes the sensitive hearing status effect and updates icon
/datum/action/cooldown/spell/sensitive_hearing/proc/sensitive_hearing_deactivate(mob/living/carbon/human/user)
	user.remove_status_effect(/datum/status_effect/sensitive_hearing)
	update_button_state("echolocation_off")

/// Status effect that actually manages sensitive hearing and its feedback
/datum/status_effect/sensitive_hearing
	id = "sensitive_hearing"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/sensitive_hearing/on_apply()
	ADD_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

	var/hearing_enable_message = "[owner] perks up [owner.p_their()] ears, each twitching intently!"
	var/hearing_enable_usermessage = "You perk up your ears, hunting for even the quietest sounds."
	if(HAS_TRAIT(owner, TRAIT_SENSITIVE_HEARING))
		hearing_enable_message = "[owner] starts to listen intently!"
		hearing_enable_usermessage = "You start to listen intently for quiet sounds."
	owner.visible_message(span_notice(hearing_enable_message), span_notice(hearing_enable_usermessage))

	var/obj/item/organ/ears/ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
	if(ears)
		ears.damage_multiplier *= 2

	return ..()

/datum/status_effect/sensitive_hearing/on_remove()
	REMOVE_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

	var/hearing_disable_message = "[owner] drops [owner.p_their()] ears down a bit, no longer listening as closely."
	var/hearing_disable_usermessage = "You drop your ears down, no longer paying close attention."
	if(HAS_TRAIT(owner, TRAIT_SENSITIVE_HEARING))
		hearing_disable_message = "[owner] stops listening for quiet sounds."
		hearing_disable_usermessage = "You stop listening for quiet sounds."
	owner.visible_message(span_notice(hearing_disable_message), span_notice(hearing_disable_usermessage))

	var/obj/item/organ/ears/ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
	if(ears)
		ears.damage_multiplier /= 2

	return ..()

/datum/status_effect/sensitive_hearing/get_examine_text()
	var/hearing_examine_text = "[owner.p_They()] [owner.p_have()] [owner.p_their()] ears perked up, listening closely to whisper-quiet sounds."
	if(HAS_TRAIT(owner, TRAIT_SENSITIVE_HEARING))
		hearing_examine_text = "[owner.p_Theyre()] listening intently for whisper-quiet sounds."

	return span_notice(hearing_examine_text)
