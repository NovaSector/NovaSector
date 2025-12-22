#define SHADOW_CURE_LIMB_PROB 20
#define SHADOW_CURE_WOUND_PROB 33

// no basic alert - only nightmares get their more important alert about bullet dodge. this removes redundant / info bombardment
/datum/status_effect/shadow
	alert_type = NONE

// shadows can now lose limbs and take wounds - because of this, we'll need them to regenerate those
/datum/status_effect/shadow/regeneration/heal_owner()
	. = ..()
	if (!iscarbon(owner))
		return
	var/mob/living/carbon/carbon_owner = owner
	if (prob(SHADOW_CURE_LIMB_PROB))
		if (length(carbon_owner.get_missing_limbs()))
			carbon_owner.regenerate_limb(pick(carbon_owner.get_missing_limbs()), dismembered_by_copy = carbon_owner.body_zone_dismembered_by?.Copy())
			to_chat(carbon_owner, span_nicegreen("You regenerate one of your missing limbs."))
			playsound(carbon_owner, 'sound/effects/wounds/pierce1.ogg', 80, TRUE)
	if (prob(SHADOW_CURE_WOUND_PROB))
		if (length(carbon_owner.all_wounds))
			var/datum/wound/wound = pick(carbon_owner.all_wounds)
			wound.remove_wound()
			to_chat(carbon_owner, span_nicegreen("You cure one of your wounds."))
			playsound(carbon_owner, 'sound//effects/wounds/splatter.ogg', 80, TRUE)

#undef SHADOW_CURE_LIMB_PROB
#undef SHADOW_CURE_WOUND_PROB
