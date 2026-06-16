/datum/quirk/psionic_gift
	name = "Psionic Gift"
	desc = "Your mind resonates with anomalous psionic potential. You awaken with imprint points to spend on psionic disciplines. Ranks above Gamma are unsafe around guns and sensitive technology."
	icon = FA_ICON_BRAIN
	value = 4
	gain_text = span_purple("A latent pressure unfolds behind your eyes.")
	lose_text = span_notice("The pressure behind your eyes falls silent.")
	medical_record_text = "Patient presents with abnormal neural resonance consistent with latent psionic expression."

	/// Imprint points granted when this quirk awakens the holder.
	var/psionic_points = PSIONIC_DEFAULT_POINTS
	/// Rank chosen by the player in character preferences.
	var/psionic_rank = PSIONIC_DEFAULT_RANK
	/// Restored if this quirk is removed while another psionic source remains.
	var/original_max_strain
	/// Limiter implant granted to Delta-or-higher roundstart psions.
	var/datum/weakref/limiter_ref

/datum/quirk/psionic_gift/add(client/client_source)
	if(!isliving(quirk_holder))
		return

	psionic_rank = client_source?.prefs?.read_preference(/datum/preference/choiced/psionic_rank) || PSIONIC_DEFAULT_RANK
	if(isnull(GLOB.psionic_rank_points[psionic_rank]))
		psionic_rank = PSIONIC_DEFAULT_RANK

	var/full_points = get_psionic_rank_points(psionic_rank)
	psionic_points = full_points
	var/max_strain = GLOB.psionic_rank_max_strain[psionic_rank]
	var/datum/component/psionic_profile/profile = quirk_holder.awaken_psionics(full_points, source = PSIONIC_SOURCE_QUIRK)
	if(profile && !isnull(max_strain))
		original_max_strain = profile.max_strain
		if(full_points > PSIONIC_ROUNDSTART_LIMIT_POINTS)
			var/limited_points = get_psionic_rank_points(PSIONIC_ROUNDSTART_LIMIT_RANK)
			profile.set_rank(PSIONIC_ROUNDSTART_LIMIT_RANK, psionic_rank, TRUE, PSIONIC_DEFAULT_MAX_STRAIN)
			profile.set_source_points(PSIONIC_SOURCE_QUIRK, limited_points, TRUE)
			profile.reset_imprints(profile.get_total_source_points(), TRUE)
			grant_limiter_implant(full_points, max_strain)
		else
			profile.set_rank(psionic_rank, psionic_rank, FALSE, max_strain)

	gain_text = span_purple("Your latent psionic rating resolves as [psionic_rank].")

/datum/quirk/psionic_gift/proc/grant_limiter_implant(potential_points, potential_max_strain)
	var/obj/item/implant/psionic_limiter/limiter = new(quirk_holder)
	limiter.potential_points = potential_points
	limiter.limited_rank = PSIONIC_ROUNDSTART_LIMIT_RANK
	limiter.potential_rank = psionic_rank
	limiter.potential_max_strain = potential_max_strain
	if(!limiter.implant(quirk_holder, null, TRUE, TRUE))
		qdel(limiter)
		return

	limiter_ref = WEAKREF(limiter)
	to_chat(quirk_holder, span_warning("A psionic limiter implant hums beneath your skin, holding your excess potential in check."))

/datum/quirk/psionic_gift/remove()
	if(!isliving(quirk_holder))
		return

	var/obj/item/implant/psionic_limiter/limiter = limiter_ref?.resolve()
	if(limiter?.imp_in == quirk_holder)
		qdel(limiter)
	limiter_ref = null

	var/datum/component/psionic_profile/profile = quirk_holder.get_psionic_profile()
	if(profile && !isnull(original_max_strain))
		profile.max_strain = original_max_strain
		profile.strain = min(profile.strain, profile.max_strain)

	quirk_holder.revoke_psionics(PSIONIC_SOURCE_QUIRK)

/datum/preference/choiced/psionic_rank
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "psionic_rank"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/psionic_rank/init_possible_values()
	return list(
		PSIONIC_RANK_LAMBDA,
		PSIONIC_RANK_EPSILON,
		PSIONIC_RANK_GAMMA,
		PSIONIC_RANK_DELTA,
		PSIONIC_RANK_BETA,
		PSIONIC_RANK_ALPHA,
	)

/datum/preference/choiced/psionic_rank/create_default_value()
	return PSIONIC_DEFAULT_RANK

/datum/preference/choiced/psionic_rank/is_accessible(datum/preferences/preferences)
	if(!..())
		return FALSE

	return /datum/quirk/psionic_gift::name in preferences.all_quirks

/datum/preference/choiced/psionic_rank/compile_constant_data()
	var/list/data = ..()

	var/list/rank_data = list()
	for(var/rank in GLOB.psionic_rank_points)
		rank_data[rank] = list(
			"points" = GLOB.psionic_rank_points[rank],
			"max_strain" = GLOB.psionic_rank_max_strain[rank],
			"blurb" = GLOB.psionic_rank_descriptions[rank],
		)

	data["extra_quirk_data"] = rank_data
	return data

/datum/preference/choiced/psionic_rank/apply_to_human(mob/living/carbon/human/target, value)
	return
