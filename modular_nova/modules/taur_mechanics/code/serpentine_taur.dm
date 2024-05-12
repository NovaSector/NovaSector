/obj/item/organ/external/taur_body/serpentine
	/// The constrict ability we have given our owner. Nullable, if we have no owner.
	var/datum/action/innate/constrict/constrict_ability

	/// Did our owner have their feet blocked before we ran on_mob_insert? Used for determining if we should unblock their feet slots on removal.
	var/owner_blocked_feet_before_insert

/obj/item/organ/external/taur_body/serpentine/Destroy()
	QDEL_NULL(constrict_ability) // handled in remove, but lets be safe
	return ..()

/obj/item/organ/external/taur_body/serpentine/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	constrict_ability = new /datum/action/innate/constrict(organ_owner)
	constrict_ability.Grant(organ_owner)

	owner_blocked_feet_before_insert = (organ_owner.dna.species.no_equip_flags & ITEM_SLOT_FEET)
	organ_owner.dna.species.no_equip_flags |= ITEM_SLOT_FEET
	organ_owner.dna.species.modsuit_slot_exceptions |= ITEM_SLOT_FEET

	ADD_TRAIT(organ_owner, TRAIT_LIGHT_STEP, ORGAN_TRAIT)

/obj/item/organ/external/taur_body/serpentine/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	QDEL_NULL(constrict_ability)
	if (!owner_blocked_feet_before_insert)
		organ_owner.dna.species.no_equip_flags &= ~ITEM_SLOT_FEET
	owner_blocked_feet_before_insert = FALSE
	organ_owner.dna.species.modsuit_slot_exceptions &= ~ITEM_SLOT_FEET

	REMOVE_TRAIT(organ_owner, TRAIT_LIGHT_STEP, ORGAN_TRAIT)
