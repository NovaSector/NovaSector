/datum/quirk/robot_limb_detach
	name = "Cybernetic Limb Mounts"
	desc = "You are able to detach and reattach any installed robotic limbs with very little effort."
	gain_text = span_notice("Internal sensors report limb disengagement protocols are ready and waiting.")
	lose_text = span_notice("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE.")
	medical_record_text = "Patient bears quick-attach and release limb joint cybernetics."
	value = 0
	mob_trait = TRAIT_ROBOTIC_LIMBATTACHMENT
	icon = FA_ICON_HANDSHAKE_SIMPLE_SLASH
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/robot_limb_detach/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/spell/robot_self_amputation/limb_action = new /datum/action/cooldown/spell/robot_self_amputation()
	limb_action.Grant(human_holder)

/datum/quirk/robot_limb_detach/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	for (var/datum/action in quirk_holder.actions)
		if (istype(action, /datum/action/cooldown/spell/robot_self_amputation))
			var/datum/action/cooldown/spell/robot_self_amputation/unwanted_action = action
			unwanted_action.Remove(human_holder)

/datum/action/cooldown/spell/robot_self_amputation
	name = "Detach a robotic limb"
	desc = "Disengage one of your robotic limbs from your cybernetic mounts. Requires you to not be restrained or otherwise under duress."
	button_icon_state = "autotomy"

	cooldown_time = 10 SECONDS
	spell_requirements = NONE
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_HANDS_BLOCKED | AB_CHECK_INCAPACITATED

/datum/action/cooldown/spell/robot_self_amputation/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/robot_self_amputation/cast(mob/living/carbon/human/cast_on)
	. = ..()

	if(HAS_TRAIT(cast_on, TRAIT_NODISMEMBER))
		to_chat(cast_on, span_warning("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE. Seek out a maintenance technician."))
		return

	var/list/robot_parts = list()
	for (var/obj/item/bodypart/possible_part as anything in cast_on.bodyparts)
		if ((possible_part.bodytype & BODYTYPE_ROBOTIC) && possible_part.body_zone != BODY_ZONE_HEAD && possible_part.body_zone != BODY_ZONE_CHEST) //only robot limbs and only if they're not crucial to our like, ongoing life, you know?
			robot_parts += possible_part

	if (!length(robot_parts))
		to_chat(cast_on, "ERROR: Limb disengagement protocols report no compatible cybernetics currently installed. Seek out a maintenance technician.")
		return

	var/obj/item/bodypart/limb_to_detach = tgui_input_list(cast_on, "Limb to detach", "Cybernetic Limb Detachment", sort_names(robot_parts))
	if (QDELETED(src) || QDELETED(cast_on) || QDELETED(limb_to_detach))
		return

	cast_on.visible_message(span_notice("[cast_on] shuffles [cast_on.p_their()] [limb_to_detach.name] forward, actuators hissing and whirring as [cast_on.p_they()] disengage[cast_on.p_s()] the limb from its mount..."))

	if(do_after(cast_on, 5 SECONDS))
		cast_on.visible_message(span_notice("With a gentle twist, [cast_on] finally prises [cast_on.p_their()] [limb_to_detach.name] free from its socket."))
		limb_to_detach.drop_limb()
		//add some foley sfx here
	else
		cast_on.balloon_alert(cast_on, "interrupted!")
