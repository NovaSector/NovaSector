/datum/quirk/psionic_gift
	name = "Psionic Gift"
	desc = "Your mind resonates with anomalous psionic potential. You awaken with imprint points to spend on psionic disciplines. Ranks above Gamma are unsafe around guns and sensitive technology."
	icon = FA_ICON_ATOM
	value = 4
	gain_text = span_purple("Your psionic potential stirs.")
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
	var/strain_decay = GLOB.psionic_rank_strain_decay[psionic_rank]
	var/manifestation_color = client_source?.prefs?.read_preference(/datum/preference/color/psionic_color)
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR
	var/datum/component/psionic_profile/profile = quirk_holder.awaken_psionics(full_points, source = PSIONIC_SOURCE_QUIRK)
	if(profile)
		profile.psionic_color = manifestation_color
	if(profile && !isnull(max_strain))
		original_max_strain = profile.max_strain
		// Limiter grant may fail (non-carbon, insert refused); fall back to applying the rank directly.
		var/limiter_granted = full_points > PSIONIC_ROUNDSTART_LIMIT_POINTS && grant_limiter_implant(full_points, max_strain)
		if(!limiter_granted)
			profile.set_rank(
				rank = psionic_rank,
				latent_rank = psionic_rank,
				limited = FALSE,
				new_max_strain = max_strain,
				new_strain_decay = strain_decay,
			)

	gain_text = span_purple("Your latent psionic rating resolves as [psionic_rank].")

/datum/quirk/psionic_gift/proc/grant_limiter_implant(potential_points, potential_max_strain)
	if(!iscarbon(quirk_holder))
		return FALSE

	var/mob/living/carbon/carbon_holder = quirk_holder
	var/obj/item/organ/cyberimp/brain/psionic_limiter/limiter = new()
	limiter.potential_points = potential_points
	limiter.limited_rank = PSIONIC_ROUNDSTART_LIMIT_RANK
	limiter.potential_rank = psionic_rank
	limiter.potential_max_strain = potential_max_strain
	if(!limiter.Insert(carbon_holder, movement_flags = DELETE_IF_REPLACED))
		qdel(limiter)
		return FALSE

	limiter_ref = WEAKREF(limiter)
	to_chat(quirk_holder, span_warning("A psionic limiter implant hums beneath your skin, holding your excess potential in check."))
	return TRUE

/datum/quirk/psionic_gift/remove()
	if(!isliving(quirk_holder))
		return

	var/obj/item/organ/cyberimp/brain/psionic_limiter/limiter = limiter_ref?.resolve()
	if(limiter?.owner == quirk_holder)
		qdel(limiter)
	limiter_ref = null

	var/datum/component/psionic_profile/profile = quirk_holder.get_psionic_profile()
	var/mutation_rank = quirk_holder.mind?.psionic_mutation_rank
	if(profile?.has_source(PSIONIC_SOURCE_MUTATION) && !isnull(GLOB.psionic_rank_points[mutation_rank]))
		profile.set_rank(
			rank = mutation_rank,
			latent_rank = mutation_rank,
			limited = FALSE,
			new_max_strain = GLOB.psionic_rank_max_strain[mutation_rank],
			new_strain_decay = GLOB.psionic_rank_strain_decay[mutation_rank],
		)
	else if(profile && !isnull(original_max_strain))
		profile.max_strain = original_max_strain
		profile.strain = min(profile.strain, profile.max_strain)
		profile.strain_decay = PSIONIC_DEFAULT_STRAIN_DECAY

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
	if(!..(preferences))
		return FALSE

	return /datum/quirk/psionic_gift::name in preferences.all_quirks

/datum/preference/choiced/psionic_rank/compile_constant_data()
	var/list/data = ..()

	var/list/rank_data = list()
	for(var/rank in GLOB.psionic_rank_points)
		rank_data[rank] = list(
			"points" = GLOB.psionic_rank_points[rank],
			"max_strain" = GLOB.psionic_rank_max_strain[rank],
			"strain_decay" = GLOB.psionic_rank_strain_decay[rank],
			"blurb" = GLOB.psionic_rank_descriptions[rank],
		)

	data["extra_quirk_data"] = rank_data
	return data

/datum/preference/choiced/psionic_rank/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/color/psionic_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "psionic_color"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/color/psionic_color/create_default_value()
	return PSIONIC_DEFAULT_COLOR

/datum/preference/color/psionic_color/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE

	return /datum/quirk/psionic_gift::name in preferences.all_quirks

/datum/preference/color/psionic_color/apply_to_human(mob/living/carbon/human/target, value)
	return
