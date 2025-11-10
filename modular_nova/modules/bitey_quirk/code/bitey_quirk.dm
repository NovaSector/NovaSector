// Bitey quirk - allows toggling bite attacks without needing Feline Traits
/datum/action/innate/toggle_bite
	name = "Toggle Bite"
	desc = "Toggle whether you bite instead of doing unarmed attacks."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "feral_mode_off"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/innate/toggle_bite/New(Target)
	..()
	var/list/ability_name = list("Toggle Bite", "Bite Mode", "Chomp Toggle", "Nom Mode")
	name = pick(ability_name)

/datum/action/innate/toggle_bite/Activate()
	var/mob/living/carbon/human/human_owner = owner
	if(!ishuman(human_owner))
		return

	var/obj/item/bodypart/head/head = human_owner.get_bodypart(BODY_ZONE_HEAD)
	if(!head)
		to_chat(human_owner, span_warning("You need a head to bite!"))
		return

	// Enable bite mode - set sharpness, increase damage to match punches, and add trait
	head.unarmed_sharpness = SHARP_EDGED
	head.unarmed_damage_low = 5
	head.unarmed_damage_high = 10
	ADD_TRAIT(human_owner, TRAIT_FERAL_BITER, QUIRK_TRAIT)

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

	// Check if they have a cat tongue that would keep the modifications
	var/obj/item/organ/tongue/cat/cat_tongue = human_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!istype(cat_tongue) || !cat_tongue.feral_mode)
		head.unarmed_sharpness = NONE
		head.unarmed_damage_low = 1
		head.unarmed_damage_high = 3

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
		bite_action.Remove(quirk_holder)
		QDEL_NULL(bite_action)

	// Make sure to restore bite mode if it was active
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(ishuman(human_holder))
		// Check if this is from the bitey quirk (not from cat tongue)
		var/obj/item/organ/tongue/cat/cat_tongue = human_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
		if(!istype(cat_tongue) || !cat_tongue.feral_mode)
			var/obj/item/bodypart/head/head = human_holder.get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.unarmed_sharpness = NONE
				head.unarmed_damage_low = 1
				head.unarmed_damage_high = 3
			REMOVE_TRAIT(human_holder, TRAIT_FERAL_BITER, QUIRK_TRAIT)

