/obj/item/organ/taur_body/serpentine
	/// The constrict ability we have given our owner. Nullable, if we have no owner.
	var/datum/action/innate/constrict/constrict_ability

/obj/item/organ/taur_body/serpentine/Destroy()
	QDEL_NULL(constrict_ability) // handled in remove, but lets be safe
	return ..()

/obj/item/organ/taur_body/serpentine/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	constrict_ability = new /datum/action/innate/constrict(organ_owner)
	constrict_ability.Grant(organ_owner)

/// Adds TRAIT_HARD_SOLES to our owner.
/obj/item/organ/taur_body/proc/add_hardened_soles(mob/living/carbon/organ_owner = owner)
	ADD_TRAIT(organ_owner, TRAIT_HARD_SOLES, ORGAN_TRAIT)

/obj/item/organ/taur_body/serpentine/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	QDEL_NULL(constrict_ability)
