ADMIN_VERB_AND_CONTEXT_MENU(admin_stasis, R_ADMIN|R_FUN, "Toggle Admin Stasis", "Toggle admin stasis for a living mob.", ADMIN_CATEGORY_FUN, mob/living/target in world)
	var/has_effect = !isnull(target.has_status_effect_from_source(/datum/status_effect/grouped/stasis, STASIS_ADMIN))
	if(has_effect)
		target.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_ADMIN)
	else
		target.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_ADMIN)
	var/stasis_status = has_effect ? "OFF" : "ON"
	to_chat(user, "You toggled admin stasis [stasis_status] for [target].", confidential = TRUE)
	message_admins("[key_name_admin(user)] has toggled admin stasis [stasis_status] for [target].")
	log_admin("[key_name(user)] has toggled admin stasis [stasis_status] for [target].")
