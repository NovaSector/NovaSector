/// Tiny ability datum just to get vampies a voice of god power
/datum/action/cooldown/vampire/voice_of_domination
	name = "Voice of Domination"
	desc = "Speak with an overwhelmingly dominant voice, forcing mortals to briefly obey your command."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "voice_of_god"
	power_explanation = "Activate this power to speak a command using the Voice of God.\n\
		Listeners will be compelled to obey simple commands such as 'stop', 'drop', 'sleep', 'come here', etc.\n\
		This is a weaker version of the divine Voice of God, granted passively by your mastery of Dominate."
	vampire_power_flags = NONE
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_IN_FRENZY | BP_CANT_USE_WHILE_STAKED | BP_CANT_USE_WHILE_INCAPACITATED | BP_CANT_USE_WHILE_UNCONSCIOUS
	vitaecost = 75
	cooldown_time = 60 SECONDS

/datum/action/cooldown/vampire/voice_of_domination/can_use()
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner.get_organ_slot(ORGAN_SLOT_TONGUE))
		owner.balloon_alert(owner, "you have no tongue!")
		return FALSE
	if(carbon_owner.is_mouth_covered() || !isturf(carbon_owner.loc))
		owner.balloon_alert(owner, "your mouth is blocked.")
		return FALSE
	if(HAS_TRAIT(carbon_owner, TRAIT_MUTE))
		owner.balloon_alert(owner, "you cannot speak!")
		return FALSE
	return TRUE

/datum/action/cooldown/vampire/voice_of_domination/activate_power()
	. = ..()
	var/command = tgui_input_text(owner, "Speak with the Voice of Domination", "Command", max_length = MAX_MESSAGE_LEN, encode = FALSE)
	if(QDELETED(src) || QDELETED(owner) || !command || !currently_active)
		vampiredatum_power.adjust_blood_volume(vitaecost) // refund the blood
		deactivate_power()
		StartCooldown(0)
		return
	playsound(get_turf(owner), 'sound/effects/magic/clockwork/invoke_general.ogg', 100, TRUE, 3)
	var/command_cooldown = voice_of_god(command, owner, list("colossus", "commands"), base_multiplier = 2)
	cooldown_time = max(command_cooldown, 60 SECONDS)
	deactivate_power()
