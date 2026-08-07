#define PSIONIC_NULLIFICATION_HEADBAND_CHARGES 3
#define PSIONIC_RESONANCE_SCANNER_RANGE 10
#define PSIONIC_RESONANCE_SCANNER_COOLDOWN (15 SECONDS)

/obj/item/organ/cyberimp/brain/psionic_limiter
	name = "psionic limiter implant"
	desc = "A subdermal regulator that suppresses dangerous psionic potential until removed."
	icon = 'modular_nova/modules/psionics/icons/implants.dmi'
	icon_state = "psionic_limiter"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2)
	w_class = WEIGHT_CLASS_TINY
	slot = ORGAN_SLOT_PSIONIC_IMPLANT
	aug_icon = 'modular_nova/modules/psionics/icons/implants.dmi'
	aug_overlay = "psionic_limiter_body"

	/// Total imprint point pool restored when this limiter is removed.
	var/potential_points = PSIONIC_DEFAULT_POINTS
	/// Rank enforced while the limiter is installed.
	var/limited_rank = PSIONIC_ROUNDSTART_LIMIT_RANK
	/// Rank restored when the limiter is removed.
	var/potential_rank = PSIONIC_DEFAULT_RANK
	/// Max strain restored when the limiter is removed.
	var/potential_max_strain = PSIONIC_DEFAULT_MAX_STRAIN
	/// TRUE when a source has set the potential values before this implant is inserted.
	var/preconfigured = FALSE

/obj/item/organ/cyberimp/brain/psionic_limiter/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	var/datum/component/psionic_profile/profile = organ_owner.get_psionic_profile()
	try_apply_limit(profile)
	return TRUE

/obj/item/organ/cyberimp/brain/psionic_limiter/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	var/datum/component/psionic_profile/profile = organ_owner.get_psionic_profile()
	var/limiter_active = profile && is_psionic_rank_above(potential_rank, limited_rank)
	if(limiter_active)
		remove_limit(profile)
	preconfigured = FALSE
	return TRUE

/// Records a wearer's existing psionic state when needed, then limits it to the configured rank.
/obj/item/organ/cyberimp/brain/psionic_limiter/proc/try_apply_limit(datum/component/psionic_profile/profile)
	if(!profile)
		return FALSE

	if(!preconfigured)
		potential_points = profile.get_total_source_points()
		potential_rank = profile.psionic_rank
		potential_max_strain = profile.max_strain
		preconfigured = TRUE

	if(!is_psionic_rank_above(potential_rank, limited_rank))
		return FALSE

	apply_limit(profile)
	return TRUE

/obj/item/organ/cyberimp/brain/psionic_limiter/proc/apply_limit(datum/component/psionic_profile/profile)
	profile.set_rank(
		rank = limited_rank,
		latent_rank = potential_rank,
		limited = TRUE,
		new_max_strain = GLOB.psionic_rank_max_strain[limited_rank],
		new_strain_decay = GLOB.psionic_rank_strain_decay[limited_rank],
	)
	set_profile_points(profile, get_psionic_rank_points(limited_rank))

/obj/item/organ/cyberimp/brain/psionic_limiter/proc/remove_limit(datum/component/psionic_profile/profile)
	profile.set_rank(
		rank = potential_rank,
		latent_rank = potential_rank,
		limited = FALSE,
		new_max_strain = potential_max_strain,
		new_strain_decay = GLOB.psionic_rank_strain_decay[potential_rank],
	)
	set_profile_points(profile, potential_points)

/obj/item/organ/cyberimp/brain/psionic_limiter/proc/set_profile_points(datum/component/psionic_profile/profile, points)
	if(profile.has_source(PSIONIC_SOURCE_QUIRK))
		profile.set_source_points(PSIONIC_SOURCE_QUIRK, points, silent = TRUE)
		profile.reset_imprints(profile.get_total_source_points(), silent = TRUE)
		return

	profile.reset_imprints(points, silent = TRUE)

/obj/item/restraints/handcuffs/psionic_dampener
	name = "psionic dampener cuffs"
	desc = "A pair of reinforced restraints threaded with a psionic dampening lattice. They suppress psionic projection while locked around someone's wrists."
	icon = 'modular_nova/modules/psionics/icons/dampener_cuffs.dmi'
	worn_icon = 'modular_nova/modules/psionics/icons/dampener_cuffs_belt.dmi'
	lefthand_file = 'modular_nova/modules/psionics/icons/dampener_cuffs_lefthand.dmi'
	righthand_file = 'modular_nova/modules/psionics/icons/dampener_cuffs_righthand.dmi'
	icon_state = "psionic_dampener"
	worn_icon_state = "psionic_dampener"
	inhand_icon_state = "psionic_dampener"
	handcuff_time = 5 SECONDS
	breakouttime = 2 MINUTES
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2,
	)

/obj/item/restraints/handcuffs/psionic_dampener/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/block_host_psionics, inventory_flags = ITEM_SLOT_HANDCUFFED)

/obj/item/clothing/head/psionic_nullification
	name = "psionic nullification headband"
	desc = "A slim band threaded with silvered anti-psionic lattice. Its weave unravels a little with each psionic effect it turns aside, and a spent band cannot be recharged."
	icon = 'modular_nova/modules/psionics/icons/nullification_headband.dmi'
	worn_icon = 'modular_nova/modules/psionics/icons/nullification_headband_worn.dmi'
	icon_state = "nullification_headband"
	worn_icon_state = "nullification_headband"
	supports_variations_flags = NONE
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2,
	)

/obj/item/clothing/head/psionic_nullification/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psionic_protection, charges = PSIONIC_NULLIFICATION_HEADBAND_CHARGES, inventory_flags = ITEM_SLOT_HEAD)

/obj/item/psionic_resonance_scanner
	name = "psionic resonance scanner"
	desc = "A handheld lattice detector tuned to active psionic fields. Pings for active signatures nearby and reports the bearing of the strongest return."
	icon = 'modular_nova/modules/psionics/icons/resonance_scanner.dmi'
	icon_state = "resonance_scanner"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)
	/// Recalibration cooldown between scans.
	COOLDOWN_DECLARE(scan_cooldown)

/obj/item/psionic_resonance_scanner/attack_self(mob/user, modifiers)
	if(!isliving(user))
		return
	if(!COOLDOWN_FINISHED(src, scan_cooldown))
		balloon_alert(user, "recalibrating!")
		return

	COOLDOWN_START(src, scan_cooldown, PSIONIC_RESONANCE_SCANNER_COOLDOWN)
	var/mob/living/living_user = user
	playsound(src, 'sound/machines/sonar-ping.ogg', 30, TRUE)
	var/list/resonance_targets = get_resonance_targets(living_user, PSIONIC_RESONANCE_SCANNER_RANGE)
	if(!length(resonance_targets))
		to_chat(living_user, span_notice("[src] pings once and settles: no active psionic signatures nearby."))
		return

	var/mob/living/nearest_target = get_nearest_resonance_target(living_user, resonance_targets)
	var/signature_word = length(resonance_targets) == 1 ? "signature" : "signatures"
	to_chat(living_user, span_warning("[src] chirps: [length(resonance_targets)] active psionic [signature_word] detected. The strongest return is [get_resonance_descriptor(living_user, nearest_target)]."))

#undef PSIONIC_NULLIFICATION_HEADBAND_CHARGES
#undef PSIONIC_RESONANCE_SCANNER_RANGE
#undef PSIONIC_RESONANCE_SCANNER_COOLDOWN
