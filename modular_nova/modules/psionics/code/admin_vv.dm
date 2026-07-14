/mob/living/proc/vv_give_psionics()
	if(!check_rights(R_ADMIN))
		return

	var/static/list/psionic_rank_choices = list(
		PSIONIC_RANK_LAMBDA,
		PSIONIC_RANK_EPSILON,
		PSIONIC_RANK_GAMMA,
		PSIONIC_RANK_DELTA,
		PSIONIC_RANK_BETA,
		PSIONIC_RANK_ALPHA,
	)
	var/psionic_rank = tgui_input_list(usr, "Select psionic rank to give [src].", "Give Psionics", psionic_rank_choices)
	if(!psionic_rank)
		return

	var/datum/component/psionic_profile/profile = awaken_psionics(get_psionic_rank_points(psionic_rank), source = PSIONIC_SOURCE_ADMIN)
	if(!profile)
		to_chat(usr, span_warning("Failed to awaken [src]'s psionics."))
		return

	profile.apply_rank(psionic_rank)

	var/msg = span_notice("[key_name_admin(usr)] gave [key_name(src)] [psionic_rank]-rank psionics.")
	message_admins(msg)
	admin_ticket_log(src, msg)
	log_admin("[key_name(usr)] gave [key_name(src)] [psionic_rank]-rank psionics.")
	BLACKBOX_LOG_ADMIN_VERB("Give Psionics")
