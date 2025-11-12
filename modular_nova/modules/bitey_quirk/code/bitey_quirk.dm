// Bitey quirk - allows toggling bite attacks without needing Feline Traits
/datum/action/innate/toggle_bite
	name = "Go Feral"
	desc = "Toggle whether you bite instead of doing unarmed attacks."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "feral_mode_off"
	check_flags = AB_CHECK_CONSCIOUS
	var/list/ability_name = list("Go Feral", "Bite the Hand that Feeds", "Unleash Id", "Activate Catbrain", "Gremlin Mode", "Nom Mode", "Dehumanize Yourself", "Misbehave")

/datum/action/innate/toggle_bite/New(Target)
	..()
	name = pick(ability_name)

/datum/action/innate/toggle_bite/Activate()
	var/mob/living/carbon/human/human_owner = owner
	if(!ishuman(human_owner))
		return

	var/obj/item/bodypart/head/head = human_owner.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		to_chat(human_owner, span_warning("You need a head in order to bite!"))
		return

	// Enable bite mode - match cat tongue bonuses: +4/+7 damage, +10 effectiveness, +0.5 pummeling, sharpness
	// Check if cat tongue is present, so we do not stack bonuses, and register to organ signals in case our tongues change while this is active
	var/obj/item/organ/tongue/cat/cat_tongue = human_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!istype(cat_tongue))
		add_bite_bonuses(head)
		RegisterSignal(human_owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(check_added_organ))
	else
		RegisterSignal(human_owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(check_removed_organ))
	ADD_TRAIT(human_owner, TRAIT_FERAL_BITER, REF(src))

	active = TRUE
	background_icon_state = "bg_default_on"
	button_icon_state = "feral_mode_on"
	to_chat(human_owner, span_notice("You will bite when making an unarmed attack."))
	build_all_button_icons()

/datum/action/innate/toggle_bite/Deactivate()
	var/mob/living/carbon/human/human_owner = owner
	if(!ishuman(human_owner))
		return

	var/obj/item/bodypart/head/head = human_owner.get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		return

	// Check if cat tongue is keeping these bonuses active
	var/obj/item/organ/tongue/cat/cat_tongue = human_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!istype(cat_tongue) || !cat_tongue.feral_mode)
		head.unarmed_damage_low -= 4
		head.unarmed_damage_high -= 7
		head.unarmed_effectiveness -= 10
		head.unarmed_pummeling_bonus -= 0.5
		head.unarmed_sharpness = NONE

	REMOVE_TRAIT(human_owner, TRAIT_FERAL_BITER, QUIRK_TRAIT)

	active = FALSE
	background_icon_state = "bg_default"
	button_icon_state = "feral_mode_off"
	to_chat(human_owner, span_notice("You will make unarmed attacks normally."))
	build_all_button_icons()

/datum/action/innate/toggle_bite/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return active

/datum/quirk/bitey
	name = "Bitey"
	desc = "You can toggle whether you bite instead of doing unarmed attacks. This ability is independent of other feline traits."
	gain_text = span_notice("You feel like you could bite someone if you wanted to.")
	lose_text = span_notice("You no longer feel the urge to bite.")
	medical_record_text = "Patient has the ability to toggle biting behavior."
	value = 0
	icon = FA_ICON_TOOTH
	var/datum/action/innate/toggle_bite/bite_action

/datum/quirk/bitey/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!ishuman(human_holder))
		return

	bite_action = new(human_holder)
	bite_action.Grant(human_holder)

/datum/quirk/bitey/remove()
	if(bite_action)
		QDEL_NULL(bite_action)

