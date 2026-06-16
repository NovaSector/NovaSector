/obj/item/assembly/signaler/anomaly/attack_self(mob/user, modifiers)
	if(!isliving(user))
		return

	var/mob/living/living_user = user
	var/datum/component/psionic_profile/profile = living_user.get_psionic_profile()
	if(!profile)
		return

	var/datum/psionic_school/school = get_psionic_school_for_anomaly_core(type)
	if(!school)
		to_chat(living_user, span_notice("[src] hums against your thoughts, but its resonance does not match an imprinted branch."))
		return TRUE

	if(profile.attune_school(school.type))
		qdel(src)
	return TRUE

/obj/item/implant/psionic_limiter
	name = "psionic limiter implant"
	desc = "A subdermal regulator that suppresses dangerous psionic potential until removed."
	actions_types = null
	implant_color = "r"
	implant_info = "Automatically suppresses psionic output to a calibrated safe rank while preserving latent potential."
	implant_lore = "Psionic limiter implants are tuned against a subject's anomalous neural resonance. They do not remove psionic potential; they keep it folded down until the implant is removed."

	/// Total imprint point pool restored when this limiter is removed.
	var/potential_points = PSIONIC_DEFAULT_POINTS
	/// Rank enforced while the limiter is installed.
	var/limited_rank = PSIONIC_ROUNDSTART_LIMIT_RANK
	/// Rank restored when the limiter is removed.
	var/potential_rank = PSIONIC_DEFAULT_RANK
	/// Max strain restored when the limiter is removed.
	var/potential_max_strain = PSIONIC_DEFAULT_MAX_STRAIN

/obj/item/implant/psionic_limiter/get_data()
	return {"
		<b>Implant Specifications:</b><BR>
		<b>Name:</b> Psionic Limiter Implant<BR>
		<b>Suppression:</b> [limited_rank]<BR>
		<b>Latent Rating:</b> [potential_rank]<BR>
		<b>Latent Potential:</b> [potential_points] imprint point[potential_points == 1 ? "" : "s"]<BR>
	"}

/obj/item/implant/psionic_limiter/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE

	var/datum/component/psionic_profile/profile = target.get_psionic_profile()
	var/limiter_active = profile && is_psionic_rank_above(potential_rank, limited_rank)
	if(limiter_active)
		apply_limit(profile)
	if(!silent && limiter_active)
		to_chat(target, span_warning("A cold pressure folds your psionic potential down to [limited_rank]."))
	return TRUE

/obj/item/implant/psionic_limiter/removed(mob/living/source, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(source))
		return FALSE

	var/datum/component/psionic_profile/profile = source.get_psionic_profile()
	var/limiter_active = profile && is_psionic_rank_above(potential_rank, limited_rank)
	if(limiter_active)
		remove_limit(profile)
	if(!silent && limiter_active)
		to_chat(source, span_purple("Your psionic limiter comes free, and the pressure behind it unfolds."))
	return TRUE

/obj/item/implant/psionic_limiter/proc/apply_limit(datum/component/psionic_profile/profile)
	profile.set_rank(
		rank = limited_rank,
		latent_rank = potential_rank,
		limited = TRUE,
		new_max_strain = PSIONIC_DEFAULT_MAX_STRAIN,
	)
	set_profile_points(profile, get_psionic_rank_points(limited_rank))

/obj/item/implant/psionic_limiter/proc/remove_limit(datum/component/psionic_profile/profile)
	profile.set_rank(
		rank = potential_rank,
		latent_rank = potential_rank,
		limited = FALSE,
		new_max_strain = potential_max_strain,
	)
	set_profile_points(profile, potential_points)

/obj/item/implant/psionic_limiter/proc/set_profile_points(datum/component/psionic_profile/profile, points)
	if(profile.has_source(PSIONIC_SOURCE_QUIRK))
		profile.set_source_points(PSIONIC_SOURCE_QUIRK, points, silent = TRUE)
		profile.reset_imprints(profile.get_total_source_points(), silent = TRUE)
		return

	profile.reset_imprints(points, silent = TRUE)

/obj/item/clothing/head/psionic_dampener
	name = "psionic dampener"
	desc = "A close-worn lattice that scatters psionic phenomena before they can resolve."
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "foilhat"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/head/psionic_dampener/Initialize(mapload)
	. = ..()
	AddComponent(
		/datum/component/anti_psionic,
		psionic_flags = PSIONIC_ALL,
		charges = 6,
		inventory_flags = ITEM_SLOT_HEAD,
		restrict_user = TRUE,
	)
