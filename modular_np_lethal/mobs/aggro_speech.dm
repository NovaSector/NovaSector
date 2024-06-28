/// A component that makes a mob talk on aggro
/datum/component/aggro_speech
	/// Blackboard key in which target data is stored
	var/target_key
	/// If we want to limit emotes to only play at mobs
	var/living_only
	/// List of phrases to say
	var/list/speech_list
	/// Chance to say something
	var/speech_chance
	/// Chance to subtract every time we say something
	var/subtract_chance
	/// Minimum chance to say something
	var/minimum_chance

/datum/component/aggro_speech/Initialize(target_key = BB_BASIC_MOB_CURRENT_TARGET, living_only = FALSE, list/speech_list, speech_chance = 30, minimum_chance = 2, subtract_chance = 7)
	. = ..()
	var/atom/atom_parent = parent
	if (!atom_parent?.ai_controller)
		return COMPONENT_INCOMPATIBLE

	src.target_key = target_key
	src.speech_list = speech_list
	src.speech_chance = speech_chance
	src.minimum_chance = minimum_chance
	src.subtract_chance = subtract_chance

/datum/component/aggro_speech/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key), PROC_REF(on_target_changed))

/datum/component/aggro_speech/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key))
	return ..()

/// When we get a new target, see if we want to yell at it
/datum/component/aggro_speech/proc/on_target_changed(mob/source)
	SIGNAL_HANDLER
	var/atom/new_target = source.ai_controller.blackboard[target_key]
	if (isnull(new_target) || !prob(speech_chance))
		return
	if (living_only && !isliving(new_target))
		return
	speech_chance = max(speech_chance - subtract_chance, minimum_chance)
	var/mob/living/living_parent = parent
	if (living_parent?.health >= 1)
		source.say(message = pick(speech_list))
