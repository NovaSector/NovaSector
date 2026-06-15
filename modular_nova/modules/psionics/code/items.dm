/obj/item/psionic_resonator
	name = "psionic resonator"
	desc = "A diagnostic resonance device tuned to provoke latent psionic expression."
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "t-ray0"
	inhand_icon_state = "electronic"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/psionic_resonator/attack_self(mob/user)
	if(!isliving(user))
		return

	var/mob/living/living_user = user
	living_user.awaken_psionics(PSIONIC_DEFAULT_POINTS, source = PSIONIC_SOURCE_RESONATOR)
	to_chat(living_user, span_purple("[src] hums once, perfectly in tune with your thoughts."))

/obj/item/implant/psionic_limiter
	name = "psionic limiter implant"
	desc = "A subdermal regulator that suppresses dangerous psionic potential until removed."
	actions_types = null
	implant_color = "r"
	implant_info = "Automatically suppresses psionic output to a calibrated safe rank while preserving latent potential."
	implant_lore = "Psionic limiter implants are tuned against a subject's anomalous neural resonance. They do not remove psionic potential; they keep it folded down until the implant is removed."

	/// Imprint points held back by this limiter.
	var/stored_points = 0
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
		<b>Held Potential:</b> [stored_points] imprint point[stored_points == 1 ? "" : "s"]<BR>
	"}

/obj/item/implant/psionic_limiter/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE

	var/datum/component/psionic_profile/profile = target.get_psionic_profile()
	if(profile)
		profile.set_rank(limited_rank, potential_rank, TRUE, PSIONIC_DEFAULT_MAX_STRAIN)
	if(!silent)
		to_chat(target, span_warning("A cold pressure folds your psionic potential down to [limited_rank]."))
	return TRUE

/obj/item/implant/psionic_limiter/removed(mob/living/source, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(source))
		return FALSE
	if(special)
		return TRUE

	var/datum/component/psionic_profile/profile = source.get_psionic_profile()
	if(profile)
		profile.set_rank(potential_rank, potential_rank, FALSE, potential_max_strain)
		if(stored_points > 0)
			profile.add_points(stored_points)
	if(!silent)
		to_chat(source, span_purple("Your psionic limiter comes free, and the pressure behind it unfolds."))
	return TRUE

/obj/item/clothing/head/psionic_dampener
	name = "psionic dampener"
	desc = "A close-worn lattice that scatters psionic phenomena before they can resolve."
	icon_state = "foilhat"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/head/psionic_dampener/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_psionic, PSIONIC_ALL, 6, ITEM_SLOT_HEAD, null, null, null, TRUE)
