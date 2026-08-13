/datum/psionic_power/sultry_suggestion
	required_school_points = 2
	required_powers = list(/datum/action/cooldown/psionic/pointed/telepathy/intimate)
	action_type = /datum/action/cooldown/psionic/pointed/living_target/sultry_suggestion

/datum/psionic_rank_variant/sultry_suggestion
	rank = PSIONIC_RANK_GAMMA
	variant_name = "sultry suggestion"
	description = "A hypnotic, sensual urge planted in a nearby mind."
	cooldown_time = 45 SECONDS
	cast_range = 3
	strain_gain = 14
	block_charge_cost = 2
	block_message = "will guarded!"

/datum/action/cooldown/psionic/pointed/living_target/sultry_suggestion
	name = "Sultry Suggestion"
	desc = "Plant a sensual, hypnotic urge in a nearby mind. The suggestion compels nothing; how the target answers it is theirs to decide."
	button_icon_state = "psi_mind_read"
	point_cost = 2
	lewd = TRUE
	psionic_flags = PSIONIC_INTRUSIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	rank_variant_types = list(
		/datum/psionic_rank_variant/sultry_suggestion,
	)
	active_msg = "You shape a honeyed compulsion..."
	deactive_msg = "You let the compulsion unravel."
	/// Suggestion being projected for this activation.
	var/suggestion

/datum/action/cooldown/psionic/pointed/living_target/sultry_suggestion/before_psionic(atom/target)
	suggestion = tgui_input_text(owner, "What do you urge [target] to desire?", "[src]", max_length = MAX_MESSAGE_LEN)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(target) || !suggestion)
		return FALSE

	suggestion = autopunct_bare(capitalize(suggestion))
	if(!length(suggestion))
		return FALSE
	if(!is_valid_target(target))
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/sultry_suggestion/psionic_activate(atom/target)
	var/mob/living/suggester = owner
	var/mob/living/living_target = target
	to_chat(living_target, span_warning("A honeyed pressure coils against the edge of your thoughts."))
	if(!do_after(suggester, 3 SECONDS, target = living_target, timed_action_flags = IGNORE_HELD_ITEM, interaction_key = REF(src)))
		suggester.balloon_alert(suggester, "focus broken!")
		return FALSE
	var/datum/component/psionic_profile/profile = suggester.get_psionic_profile()
	if(!profile || profile.is_burned_out() || !suggester.can_cast_psionics(psionic_flags))
		suggester.balloon_alert(suggester, "mind lost!")
		return FALSE
	if(QDELETED(living_target) || living_target.stat == DEAD || get_dist(suggester, living_target) > get_variant_value(profile, "cast_range"))
		suggester.balloon_alert(suggester, "mind lost!")
		return FALSE

	log_directed_talk(suggester, living_target, suggestion, LOG_SAY, tag = "psionic erotic suggestion")
	to_chat(suggester, span_purple("You press a sultry urge into [living_target]'s mind: \"[suggestion]\""))
	to_chat(living_target, span_boldwarning("A sultry voice curls through your thoughts, urging: \"[span_purple(suggestion)]\""))
	to_chat(living_target, span_purple("The urge is only a suggestion"))
	if(ishuman(living_target))
		var/mob/living/carbon/human/human_target = living_target
		human_target.adjust_arousal(6)

	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue
		// Erotic content must never reach observers whose own ERP preference is off.
		if(!ghost.client?.prefs?.read_preference(/datum/preference/toggle/erp))
			continue

		var/from_link = FOLLOW_LINK(ghost, suggester)
		var/to_link = FOLLOW_LINK(ghost, living_target)
		to_chat(ghost, "[from_link] [span_purple("<b>\[Psionics\]</b> [suggester] plants the urge, \"[suggestion]\" in [living_target]")] [to_link]")

	return TRUE
