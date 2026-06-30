/datum/psionic_power/mind_read
	required_powers = list(/datum/action/cooldown/psionic/pointed/telepathy)
	action_type = /datum/action/cooldown/psionic/pointed/mind_read

/datum/psionic_rank_variant/mind_read
	rank = PSIONIC_RANK_GAMMA
	variant_name = "surface read"
	description = "A close intrusive read of recent speech and surface identity."
	block_charge_cost = 2
	block_message = "thoughts guarded!"

/datum/action/cooldown/psionic/pointed/mind_read
	name = "Mind Read"
	desc = "Touch a living target and read surface thoughts, recent speech, and identity impressions."
	button_icon_state = "psi_mind_read"
	cooldown_time = 30 SECONDS
	cast_range = 1
	point_cost = 2
	strain_gain = 16
	psionic_flags = PSIONIC_INTRUSIVE|PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	rank_variant_types = list(/datum/psionic_rank_variant/mind_read)
	active_msg = "You press your thoughts toward a nearby mind..."
	deactive_msg = "You withdraw your intrusive focus."

/datum/action/cooldown/psionic/pointed/mind_read/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(target))
		owner.balloon_alert(owner, "no living mind!")
		return FALSE
	var/mob/living/living_target = target
	if(living_target.stat == DEAD)
		owner.balloon_alert(owner, "mind silent!")
		return FALSE
	return TRUE

/datum/action/cooldown/psionic/pointed/mind_read/psionic_activate(atom/target)
	var/mob/living/reader = owner
	var/mob/living/read_target = target
	reader.visible_message(
		span_notice("[reader] rests [reader.p_their()] focus on [read_target]."),
		span_purple("You press into [read_target]'s surface thoughts."),
		ignored_mobs = read_target,
	)
	to_chat(read_target, span_warning("A pressure brushes against your thoughts."))
	if(!do_after(reader, 8 SECONDS, target = read_target, timed_action_flags = IGNORE_HELD_ITEM))
		reader.balloon_alert(reader, "focus broken!")
		return FALSE
	if(QDELETED(read_target) || read_target.stat == DEAD || get_dist(reader, read_target) > cast_range)
		reader.balloon_alert(reader, "mind lost!")
		return FALSE

	var/list/readout = list()
	var/list/recent_speech = read_target.copy_recent_speech(copy_amount = 4, line_chance = 80)
	if(length(recent_speech))
		readout += span_notice("<b>Recent speech:</b> [english_list(recent_speech)]")
	else
		readout += span_notice("<b>Recent speech:</b> silence.")

	var/datum/mind/target_mind = read_target.mind
	readout += span_notice("<b>Surface identity:</b> [target_mind?.name || read_target.real_name || read_target.name].")
	if(target_mind?.assigned_role)
		readout += span_notice("<b>Role impression:</b> [target_mind.assigned_role.title].")
	if(target_mind?.enslaved_to)
		var/mob/enslaver = target_mind.enslaved_to.resolve()
		readout += span_warning("<b>Compulsion:</b> loyalty bends toward [enslaver || "someone"].")
	if(target_mind?.has_antag_datum(/datum/antagonist/hypnotized) || target_mind?.has_antag_datum(/datum/antagonist/obsessed))
		readout += span_warning("<b>Compulsion:</b> an anomalous fixation is present.")

	to_chat(reader, boxed_message(jointext(readout, "<br>")))
	return TRUE
