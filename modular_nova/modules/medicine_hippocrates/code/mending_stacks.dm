/*
 * MEDICINE_HIPPOCRATES - sutures and meshes
 *
 * heal_brute / heal_burn stay set so that every upstream "is there anything here worth treating?"
 * check keeps working (and so the item still reads correctly to a health analyzer or a borg). What
 * changes is that heal_carbon() hands the healing to the mending status effect instead of applying
 * it on the spot. Bleed control and burn wound treatment are untouched.
 */

/obj/item/stack/medical
	/// Brute healed per second by the mending effect. If either mending rate is set, heal_carbon() heals over time instead of instantly.
	var/mending_brute_rate = 0
	/// Burn healed per second by the mending effect.
	var/mending_burn_rate = 0
	/// How long the limb mends for, in deciseconds.
	var/mending_duration = 15 SECONDS

/obj/item/stack/medical/heal_carbon(mob/living/carbon/patient, mob/living/user, healed_zone)
	if((!mending_brute_rate && !mending_burn_rate) || !CONFIG_GET(flag/medicine_hippocrates))
		return ..()

	// Suppress the instant heal for the duration of the parent call - everything else the parent does
	// (the visible message, bleed control, burn wound treatment, post_heal_effects) still applies.
	// Nothing between here and the restore sleeps, so this can't be observed by anything else.
	var/stored_heal_brute = heal_brute
	var/stored_heal_burn = heal_burn
	heal_brute = 0
	heal_burn = 0
	. = ..()
	heal_brute = stored_heal_brute
	heal_burn = stored_heal_burn

	if(.)
		patient.start_mending(healed_zone, mending_brute_rate, mending_burn_rate, mending_duration)

/**
 * Once a limb is mending, its brute/burn damage stops coming off on contact, so the upstream checks
 * would keep seeing "still damaged" and the `repeating` loop would empty the whole stack into it.
 *
 * We turn a limb away only when the brute/burn we mend is the *only* thing left to do. If it still
 * has an open bleed or a dressable burn wound - the things the parent treats instantly - the
 * application goes through as normal, so open wounds are never refused.
 */
/obj/item/stack/medical/try_heal_checks(mob/living/patient, mob/living/user, healed_zone, silent = FALSE)
	. = ..()
	if(!. || (!mending_brute_rate && !mending_burn_rate) || !iscarbon(patient) || !CONFIG_GET(flag/medicine_hippocrates))
		return .

	var/mob/living/carbon/carbon_patient = patient
	// Mirrors the zone fallback the parent does, so we check the same limb it just approved.
	if(!(healed_zone in carbon_patient.get_all_limbs()))
		healed_zone = BODY_ZONE_CHEST

	var/datum/status_effect/mending/mending_effect = carbon_patient.has_status_effect(/datum/status_effect/mending)
	if(isnull(mending_effect) || !mending_effect.is_limb_saturated(healed_zone, mending_brute_rate, mending_burn_rate))
		return .

	// Limb's already mending at least this well. Still let the application through if there's instant
	// work only the parent can do - stopping a bleed, or dressing a burn wound.
	var/obj/item/bodypart/affecting = carbon_patient.get_bodypart(healed_zone)
	if(affecting)
		if(stop_bleeding && affecting.cached_bleed_rate > 0)
			return .
		if(flesh_regeneration || sanitization)
			var/datum/wound/burn/flesh/burn_wound = locate() in affecting.wounds
			if(burn_wound?.can_be_ointmented_or_meshed())
				return .

	if(!silent)
		carbon_patient.balloon_alert(user, "already mending!")
	return FALSE

/obj/item/stack/medical/suture
	mending_brute_rate = 0.5

/obj/item/stack/medical/suture/medicated
	mending_brute_rate = 1

/obj/item/stack/medical/mesh
	mending_burn_rate = 0.5

/obj/item/stack/medical/mesh/advanced
	mending_burn_rate = 1

/*
 * Compatibility with the suture and mesh variants other modules add.
 */

// modular_nova/modules/deforest_medical_items - pure bleed control, has no damage healing to spread out.
/obj/item/stack/medical/suture/coagulant
	mending_brute_rate = 0

// modular_nova/modules/food_replicator - these two top up oxyloss based on how much they just healed.
// post_heal_effects runs from inside our heal_carbon() while heal_brute/heal_burn are temporarily
// zeroed, so amount_healed arrives as 0; feed them the item's nominal heal value from initial() instead.
/obj/item/stack/medical/suture/bloody
	mending_brute_rate = 0.3

/obj/item/stack/medical/suture/bloody/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	if(mending_brute_rate && CONFIG_GET(flag/medicine_hippocrates))
		amount_healed = initial(heal_brute)
	return ..(amount_healed, healed_mob, user)

/obj/item/stack/medical/mesh/bloody
	mending_burn_rate = 0.3

/obj/item/stack/medical/mesh/bloody/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	if(mending_burn_rate && CONFIG_GET(flag/medicine_hippocrates))
		amount_healed = initial(heal_burn)
	return ..(amount_healed, healed_mob, user)
