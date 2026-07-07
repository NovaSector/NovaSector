/datum/action/cooldown/spell/touch/mime_grayscale
	name = "Monochrome Touch"
	desc = "The mime's performance channels their hand to turn things monochromatic"
	background_icon_state = "bg_mime"
	overlay_icon_state = "bg_mime_border"
	button_icon = 'modular_nova/modules/mime_monochrome/icons/mime_assets.dmi'
	button_icon_state = "mime_grayscale"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	sound = null

	school = SCHOOL_MIME
	cooldown_time = 15 SECONDS

	invocation_type = INVOCATION_NONE

	spell_requirements = SPELL_REQUIRES_HUMAN|SPELL_REQUIRES_MIME_VOW

	hand_path = /obj/item/melee/touch_attack/monochrome
	draw_message = span_notice("You channel the power of silence to your hand.")
	drop_message = span_notice("You let the silence dissipate from your hand.")

/datum/action/cooldown/spell/touch/mime_grayscale/is_valid_target(atom/cast_on)
	return !ismob(cast_on)

/datum/action/cooldown/spell/touch/mime_grayscale/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	victim.add_atom_colour(color_transition_filter(COLOR_WHITE, SATURATION_MULTIPLY), WASHABLE_COLOUR_PRIORITY)
	caster.visible_message(
		span_danger("[caster.name] reaches out and drains the color from [victim.name], turning it monochrome!"),
		span_danger("You unleash the power of silence upon [victim.name]!")
	)
	if(isitem(victim) && isliving(victim.loc))
		var/obj/item/target_item = victim
		var/mob/living/holder = victim.loc
		if(holder.is_holding(target_item))
			holder.update_held_items()
		else
			holder.update_clothing(target_item.slot_flags)
	return TRUE

/obj/item/melee/touch_attack/monochrome
	name = "monochrome touch"
	desc = "The station is far too noisy, thankfully you have these hands to wash the colors away."
	icon = 'modular_nova/modules/mime_monochrome/icons/mime_assets.dmi'
	icon_state = "mime"
	inhand_icon_state = ""
