/datum/psionic_power/intimate_whisper
	required_powers = list(/datum/action/cooldown/psionic/pointed/telepathy)
	action_type = /datum/action/cooldown/psionic/pointed/telepathy/intimate

/datum/psionic_rank_variant/intimate_whisper
	rank = PSIONIC_RANK_EPSILON
	variant_name = "intimate whisper"
	description = "A private, sensual thought pressed against one nearby mind."
	cooldown_time = 3 SECONDS
	cast_range = 7
	strain_gain = 6
	block_charge_cost = 1
	block_message = "thought blocked!"

/datum/action/cooldown/psionic/pointed/telepathy/intimate
	name = "Intimate Whisper"
	desc = "Send a private, sensual thought to a nearby living target. Right-click repeats your last target."
	point_cost = 1
	lewd = TRUE
	rank_variant_types = list(
		/datum/psionic_rank_variant/intimate_whisper,
	)

/datum/action/cooldown/psionic/pointed/telepathy/intimate/send_thought(mob/living/caster, mob/living/target, thought)
	log_directed_talk(caster, target, thought, LOG_SAY, tag = "psionic intimate whisper")
	last_target_ref = WEAKREF(target)

	to_chat(caster, span_boldnotice("You press a sensual thought against [target]'s mind: \"[span_purple(thought)]\""))
	to_chat(target, span_boldnotice("A sensual thought presses into your mind: \"[span_purple(thought)]\""))

	if(caster.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		caster.create_chat_message(caster, caster.get_selected_language(), thought, list("italics"))
	if(target.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		target.create_chat_message(target, target.get_selected_language(), thought, list("italics"))

	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue
		// Erotic content must never reach observers whose own ERP preference is off.
		if(!ghost.client?.prefs?.read_preference(/datum/preference/toggle/erp))
			continue

		var/from_link = FOLLOW_LINK(ghost, caster)
		var/to_link = FOLLOW_LINK(ghost, target)
		to_chat(ghost, "[from_link] [span_purple("<b>\[Psionics\]</b> [caster] intimately whispers, \"[thought]\" to [target]")] [to_link]")

	return TRUE
