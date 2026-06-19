/datum/psionic_power/telepathy
	action_type = /datum/action/cooldown/psionic/pointed/telepathy

/datum/psionic_rank_variant/telepathy
	rank = PSIONIC_RANK_EPSILON
	variant_name = "whisper"
	description = "A private thought sent to one nearby mind."
	block_charge_cost = 1
	block_message = "thought blocked!"

/datum/action/cooldown/psionic/pointed/telepathy
	name = "Telepathic Whisper"
	desc = "Send a private thought to a nearby living target. Right-click repeats your last target."
	button_icon_state = "psi_whisper"
	cooldown_time = 3 SECONDS
	cast_range = 7
	point_cost = 1
	strain_gain = 5
	psionic_flags = PSIONIC_INTRUSIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	rank_variant_types = list(
		/datum/psionic_rank_variant/telepathy,
	)
	/// Last living target contacted by this action.
	var/datum/weakref/last_target_ref
	/// Message being projected for this activation.
	var/message

/datum/action/cooldown/psionic/pointed/telepathy/Trigger(mob/clicker, trigger_flags, atom/target)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		if(!IsAvailable(feedback = TRUE))
			return FALSE

		var/mob/living/last_target = last_target_ref?.resolve()
		if(!last_target)
			last_target_ref = null
			owner.balloon_alert(owner, "no last target!")
			return FALSE
		return PreActivate(last_target)

	return ..()

/datum/action/cooldown/psionic/pointed/telepathy/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(target))
		to_chat(owner, span_warning("There are no thoughts there to reach."))
		owner.balloon_alert(owner, "no thoughts!")
		return FALSE

	var/mob/living/living_target = target
	if(living_target.stat == DEAD)
		owner.balloon_alert(owner, "no living mind!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/telepathy/before_psionic(atom/target)
	message = tgui_input_text(owner, "What do you wish to whisper to [target]?", "[src]", max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(target) || !message)
		return FALSE

	message = autopunct_bare(capitalize(message))
	if(!length(message))
		return FALSE
	if(!is_valid_target(target))
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/telepathy/psionic_activate(atom/target)
	var/mob/living/living_target = target
	return send_thought(owner, living_target, message)

/datum/action/cooldown/psionic/pointed/telepathy/proc/send_thought(mob/living/caster, mob/living/target, thought)
	log_directed_talk(caster, target, thought, LOG_SAY, tag = "psionic whisper")
	last_target_ref = WEAKREF(target)

	to_chat(caster, span_boldnotice("You impress a thought on [target]: \"[span_purple(thought)]\""))
	to_chat(target, span_boldnotice("A thought presses into your mind: \"[span_purple(thought)]\""))

	if(caster.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		caster.create_chat_message(caster, caster.get_selected_language(), thought, list("italics"))
	if(target.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		target.create_chat_message(target, target.get_selected_language(), thought, list("italics"))

	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue

		var/from_link = FOLLOW_LINK(ghost, caster)
		var/to_link = FOLLOW_LINK(ghost, target)
		to_chat(ghost, "[from_link] [span_purple("<b>\[Psionics\]</b> [caster] impresses, \"[thought]\" on [target]")] [to_link]")

	return TRUE
