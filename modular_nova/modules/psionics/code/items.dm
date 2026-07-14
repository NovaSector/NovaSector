/obj/item/organ/cyberimp/brain/psionic_limiter
	name = "psionic limiter implant"
	desc = "A subdermal regulator that suppresses dangerous psionic potential until removed."
	icon = 'modular_nova/modules/psionics/icons/implants.dmi'
	icon_state = "psionic_limiter"
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
	AddComponent(/datum/component/psionic_protection, charges = 6, inventory_flags = ITEM_SLOT_HEAD)
