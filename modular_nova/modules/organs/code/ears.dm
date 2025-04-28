/// Teshari ears, but as a quirk/organ
/obj/item/organ/ears/sensitive
	name = "sensitive ears"
	desc = "Highly sensitive ears capable of detecting even the smallest noises."
	damage_multiplier = 2
	actions_types = list(/datum/action/cooldown/spell/teshari_hearing)

/obj/item/organ/ears/sensitive/on_mob_remove(mob/living/carbon/ear_owner)
	. = ..()
	// Prevents sensitive hearing from being broken without admin intervention if the quirk/organ is removed while active
	if(ear_owner.has_status_effect(/datum/status_effect/teshari_hearing))
		ear_owner.remove_status_effect(/datum/status_effect/teshari_hearing)

	ear_owner.remove_traits(list(TRAIT_GOOD_HEARING, TRAIT_SENSITIVE_HEARING), ORGAN_TRAIT)

/obj/item/organ/ears/sensitive/on_mob_insert(mob/living/carbon/ear_owner)
	. = ..()
	// TRAIT_SENSITIVE_HEARING is important for the flavor text distinction
	ADD_TRAIT(ear_owner, TRAIT_SENSITIVE_HEARING, ORGAN_TRAIT)

/obj/item/organ/ears/teshari
	name = "teshari ears"
	desc = "A set of four long rabbit-like ears, a Teshari's main tool while hunting. Naturally extremely sensitive to loud sounds."
	damage_multiplier = 1.5
	actions_types = list(/datum/action/cooldown/spell/teshari_hearing)

/obj/item/organ/ears/teshari/on_mob_remove(mob/living/carbon/ear_owner)
	. = ..()
	// Prevents teshari hearing from being broken without admin intervention if the organ is removed while active
	if(ear_owner.has_status_effect(/datum/status_effect/teshari_hearing))
		ear_owner.remove_status_effect(/datum/status_effect/teshari_hearing)

	REMOVE_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

/datum/action/cooldown/spell/teshari_hearing
	name = "Toggle Sensitive Hearing"
	desc = "Listen for quiet sounds, useful for picking up whispering."
	button_icon = 'modular_nova/master_files/icons/hud/actions.dmi'
	button_icon_state = "echolocation_off"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

	cooldown_time = 1 SECONDS
	spell_requirements = NONE

/// Updates the icon on the teshari hearing action for when it's on/off
/datum/action/cooldown/spell/teshari_hearing/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/teshari_hearing/Remove(mob/living/remove_from)
	REMOVE_TRAIT(remove_from, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	remove_from.update_sight()
	return ..()

/datum/action/cooldown/spell/teshari_hearing/cast(list/targets, mob/living/carbon/human/user = usr)
	. = ..()

	if(user.has_status_effect(/datum/status_effect/teshari_hearing))
		teshari_hearing_deactivate(user)
		return

	var/hearing_enable_message = "[user] perks up [user.p_their()] four ears, each twitching intently!"
	var/hearing_enable_usermessage = "You perk up all four of your ears, hunting for even the quietest sounds."
	if(HAS_TRAIT(user, TRAIT_SENSITIVE_HEARING))
		hearing_enable_message = "[user] starts to listen intently!"
		hearing_enable_usermessage = "You start to listen intently for quiet sounds."

	user.apply_status_effect(/datum/status_effect/teshari_hearing)
	user.visible_message(span_notice(hearing_enable_message), span_notice(hearing_enable_usermessage))
	update_button_state("echolocation_on")

	var/obj/item/organ/ears/ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	if(ears)
		ears.damage_multiplier = 3

/// Called when you cast teshari hearing again after enabling it, thereby making it a one-button toggle
/datum/action/cooldown/spell/teshari_hearing/proc/teshari_hearing_deactivate(mob/living/carbon/human/user)
	var/hearing_disable_message = "[user] drops [user.p_their()] ears down a bit, no longer listening as closely."
	var/hearing_disable_usermessage = "You drop your ears down, no longer paying close attention."
	if(HAS_TRAIT(user, TRAIT_SENSITIVE_HEARING))
		hearing_disable_message = "[user] stops listening for quiet sounds."
		hearing_disable_usermessage = "You stop listening for quiet sounds."

	user.remove_status_effect(/datum/status_effect/teshari_hearing)
	user.visible_message(span_notice(hearing_disable_message), span_notice(hearing_disable_usermessage))
	update_button_state("echolocation_off")

	var/obj/item/organ/ears/ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	if(ears)
		// Sensitive Hearing users take more hearing damage when they're not listening
		ears.damage_multiplier = HAS_TRAIT(user, TRAIT_SENSITIVE_HEARING) ? 2 : 1.5

/datum/status_effect/teshari_hearing
	id = "teshari_hearing"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/teshari_hearing/on_apply()
	ADD_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	return ..()

/datum/status_effect/teshari_hearing/on_remove()
	REMOVE_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	return ..()

/datum/status_effect/teshari_hearing/get_examine_text()
	var/hearing_examine_text = "[owner.p_They()] [owner.p_have()] [owner.p_their()] ears perked up, listening closely to whisper-quiet sounds."
	if(HAS_TRAIT(owner, TRAIT_SENSITIVE_HEARING))
		hearing_examine_text = "[owner.p_Theyre()] listening intently for whisper-quiet sounds."

	return span_notice(hearing_examine_text)
