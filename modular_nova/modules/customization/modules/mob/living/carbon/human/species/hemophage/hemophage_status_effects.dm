/// How much brute damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_BRUTE_AMOUNT 2
/// How much burn damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_BURN_AMOUNT 2
/// How much toxin damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_TOXIN_AMOUNT 1.5
/// How much cellular damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_CELLULAR_AMOUNT 1.50
/// How much blood to regen while master of the house is active - net positive of 0.02
#define BLOOD_REGEN_MASTER_OF_THE_HOUSE 0.02

/datum/status_effect/blood_thirst_satiated
	id = "blood_thirst_satiated"
	duration = 30 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/blood_thirst_satiated
	/// What will the bloodloss_speed_multiplier of the Hemophage be changed by upon receiving this status effect?
	var/bloodloss_speed_multiplier = 0.5


/datum/status_effect/blood_thirst_satiated/on_apply()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return FALSE

	var/obj/item/organ/heart/hemophage/tumor_heart = owner.get_organ_by_type(/obj/item/organ/heart/hemophage)

	if(!tumor_heart)
		return FALSE

	tumor_heart.bloodloss_rate *= bloodloss_speed_multiplier

	return TRUE


/datum/status_effect/blood_thirst_satiated/on_remove()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return

	var/obj/item/organ/heart/hemophage/tumor_heart = owner.get_organ_by_type(/obj/item/organ/heart/hemophage)

	if(!tumor_heart)
		return

	tumor_heart.bloodloss_rate /= bloodloss_speed_multiplier


/datum/status_effect/blood_regen_active
	id = "blood_regen_active"
	status_type = STATUS_EFFECT_UNIQUE
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	alert_type = /atom/movable/screen/alert/status_effect/blood_regen_active
	/// Current multiplier for how much blood they spend healing themselves for every point of damage healed.
	var/blood_to_health_multiplier = 0.25


/datum/status_effect/blood_regen_active/on_apply()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return FALSE

	to_chat(owner, span_notice("You feel the tumor inside you pulse faster as the absence of light eases its work, allowing it to knit your flesh and reconstruct your body."))

	return TRUE


// This code also had to be copied over from /datum/action/item_action to ensure that we could display the heart in the alert.
/datum/status_effect/blood_regen_active/on_creation(mob/living/new_owner, ...)
	. = ..()
	if(!.)
		return

	if(!linked_alert)
		return

	var/obj/item/organ/heart/hemophage/tumor_heart = owner.get_organ_by_type(/obj/item/organ/heart/hemophage)
	if(tumor_heart)
		var/old_layer = tumor_heart.layer
		var/old_plane = tumor_heart.plane
		// reset the x & y offset so that item is aligned center
		tumor_heart.pixel_x = 0
		tumor_heart.pixel_y = 0
		tumor_heart.layer = FLOAT_LAYER // They need to be displayed on the proper layer and plane to show up on the button. We elevate them temporarily just to steal their appearance, and then revert it.
		tumor_heart.plane = FLOAT_PLANE
		linked_alert.cut_overlays()
		linked_alert.add_overlay(tumor_heart)
		tumor_heart.layer = old_layer
		tumor_heart.plane = old_plane

	return .


/datum/status_effect/blood_regen_active/on_remove()
	// This status effect should not exist on its own.
	if(!owner)
		return

	to_chat(owner, span_notice("You feel the pulse of the tumor in your chest returning back to normal."))


/datum/status_effect/blood_regen_active/tick(seconds_between_ticks)
	var/mob/living/carbon/human/regenerator = owner

	var/max_blood_for_regen = regenerator.blood_volume - MINIMUM_VOLUME_FOR_REGEN
	var/blood_used = NONE

	var/brutes_to_heal = NONE
	var/brute_damage = regenerator.getBruteLoss()

	// We have to check for the damaged bodyparts like this as well, to account for robotic bodyparts, as we don't want to heal those. Stupid, I know, but that's the best proc we got to check that currently.
	if(brute_damage && length(regenerator.get_damaged_bodyparts(brute = TRUE, burn = FALSE, required_bodytype = BODYTYPE_ORGANIC)))
		brutes_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_BRUTE_AMOUNT, brute_damage) * seconds_between_ticks)
		blood_used += brutes_to_heal * blood_to_health_multiplier
		max_blood_for_regen -= brutes_to_heal * blood_to_health_multiplier

	var/burns_to_heal = NONE
	var/burn_damage = regenerator.getFireLoss()

	if(burn_damage && max_blood_for_regen > NONE && length(regenerator.get_damaged_bodyparts(brute = FALSE, burn = TRUE, required_bodytype = BODYTYPE_ORGANIC)))
		burns_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_BURN_AMOUNT, burn_damage) * seconds_between_ticks)
		blood_used += burns_to_heal * blood_to_health_multiplier
		max_blood_for_regen -= burns_to_heal * blood_to_health_multiplier

	if(brutes_to_heal || burns_to_heal)
		regenerator.heal_overall_damage(brutes_to_heal, burns_to_heal, NONE, BODYTYPE_ORGANIC)

	var/toxin_damage = regenerator.getToxLoss()

	if(toxin_damage && max_blood_for_regen > NONE)
		var/toxins_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_TOXIN_AMOUNT, toxin_damage) * seconds_between_ticks)
		blood_used += toxins_to_heal * blood_to_health_multiplier
		max_blood_for_regen -= toxins_to_heal * blood_to_health_multiplier
		regenerator.adjustToxLoss(-toxins_to_heal)

	if(!blood_used)
		regenerator.remove_status_effect(/datum/status_effect/blood_regen_active)
		return

	regenerator.blood_volume = max(regenerator.blood_volume - blood_used, MINIMUM_VOLUME_FOR_REGEN)
	new /obj/effect/temp_visual/heal(get_turf(regenerator), COLOR_EFFECT_HEAL_RED)


/datum/movespeed_modifier/hemophage_dormant_state
	id = "hemophage_dormant_state"
	multiplicative_slowdown = 2 // Yeah, they'll be quite significantly slower when in their dormant state.
	blacklisted_movetypes = FLOATING|FLYING


/atom/movable/screen/alert/status_effect/blood_thirst_satiated
	name = "Thirst Satiated"
	desc = "Substitutes and taste-thin imitations keep your pale body standing, but nothing abates eternal thirst and slakes the infection quite like the real thing: Hot blood from a real sentient being."
	icon = 'icons/effects/bleed.dmi'
	icon_state = "bleed10"


/atom/movable/screen/alert/status_effect/blood_regen_active
	name = "Enhanced Regeneration"
	desc = "Being in a sufficiently dark location allows your tumor to allocate more energy to enhancing your body's natural regeneration, at the cost of blood volume proportional to the damage healed."
	icon = 'icons/hud/screen_alert.dmi'
	icon_state = "template"


/// Heals 1.8 brute + burn per second as long as damage value is 50 or below, consuming 0.2 units of blood per point of damage healed.
/datum/status_effect/hemokinetic_regen
	id = "hemokinetic_regen"
	alert_type = /atom/movable/screen/alert/status_effect/hemokinetic_regen
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS

/datum/status_effect/hemokinetic_regen/on_apply()

	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return
	if(!istype(carbon_owner))
		return
	if(((owner.getBruteLoss() + carbon_owner.getFireLoss()) >= 50))
		to_chat(carbon_owner, span_warning("Your body is too damaged to be healed with hemokinesis!"))
		return

	carbon_owner.balloon_alert(carbon_owner, "hemokinetic regen activated!")
	return ..()


/datum/status_effect/hemokinetic_regen/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	if((carbon_owner.getBruteLoss() + carbon_owner.getFireLoss()) >= 50)
		to_chat(carbon_owner, span_warning("Your body is too damaged to be healed with hemokinesis!"))
		qdel(src)

	var/amount_healed = 0
	amount_healed += carbon_owner.adjustBruteLoss(-1.8 * seconds_between_ticks, updating_health = FALSE)
	amount_healed += carbon_owner.adjustFireLoss(-1.8 * seconds_between_ticks, updating_health = FALSE)
	if(amount_healed)
		carbon_owner.blood_volume -= (0.2 * amount_healed)
		carbon_owner.updatehealth()

/atom/movable/screen/alert/status_effect/hemokinetic_regen
	name = "Hemokinetic Regen"
	desc = "Our wounds are healing at the expense of blood."
	icon_state = "fleshmend"


/// Stamina is reduced to 50% and movespeed gains heavy slowdown, but you will regen blood at 0.02u per second. Temporarily re-enables having to breathe.
/datum/status_effect/master_of_the_house
	id = "master_of_the_house"
	alert_type = /atom/movable/screen/alert/status_effect/master_of_the_house
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS


/datum/status_effect/master_of_the_house/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		carbon_owner.max_stamina *= 0.5
		REMOVE_TRAIT(carbon_owner, TRAIT_NOBREATH, SPECIES_TRAIT)
		REMOVE_TRAIT(carbon_owner, TRAIT_OXYIMMUNE, SPECIES_TRAIT)
		carbon_owner.add_movespeed_modifier(/datum/movespeed_modifier/master_of_the_house)


/datum/status_effect/master_of_the_house/on_remove()
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return
	carbon_owner.max_stamina /= 0.5 // stamina is halved while this is active.
	carbon_owner.remove_movespeed_modifier(/datum/movespeed_modifier/master_of_the_house)
	if(carbon_owner.oxyloss) // if they have oxyloss, don't just heal it instantly
		carbon_owner.apply_status_effect(/datum/status_effect/slave_to_the_tumor)
	else
		ADD_TRAIT(carbon_owner, TRAIT_NOBREATH, SPECIES_TRAIT)
		ADD_TRAIT(carbon_owner, TRAIT_OXYIMMUNE, SPECIES_TRAIT)


/datum/status_effect/master_of_the_house/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	carbon_owner.blood_volume += BLOOD_REGEN_MASTER_OF_THE_HOUSE


/datum/movespeed_modifier/master_of_the_house
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = 0.25

/atom/movable/screen/alert/status_effect/master_of_the_house
	name = "Master of the House"
	desc = "You are taking back control of your lungs. Breathing once more requires air, but your enriched blood soothes and satiates the hunger within. \
		You are more sluggish than usual as you maintain this state."
	icon_state = "regenerative_core"


/datum/status_effect/slave_to_the_tumor
	id = "slave_to_the_tumor"
	alert_type = /atom/movable/screen/alert/status_effect/slave_to_the_tumor
	duration = 8 SECONDS
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	/// Snapshot of the mob's oxyloss at the time of getting the status, so we know how much to heal
	var/oxyloss_to_heal


/datum/status_effect/slave_to_the_tumor/on_apply()
	. = ..()
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/carbon_owner = owner
	oxyloss_to_heal = carbon_owner.oxyloss
	to_chat(carbon_owner, "You feel a sense of relief as you embrace the tumor once more...")


/datum/status_effect/slave_to_the_tumor/on_remove()
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/carbon_owner = owner
	ADD_TRAIT(carbon_owner, TRAIT_NOBREATH, SPECIES_TRAIT)
	ADD_TRAIT(carbon_owner, TRAIT_OXYIMMUNE, SPECIES_TRAIT)


// With the tumor back in control, any accrued oxyloss is healed over the course of this status
/datum/status_effect/slave_to_the_tumor/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	carbon_owner.adjustOxyLoss(oxyloss_to_heal/duration, forced = TRUE)


/atom/movable/screen/alert/status_effect/slave_to_the_tumor
	name = "Slave to the Tumor"
	desc = "You've given control of your lungs back to the tumor..."
	icon_state = "regenerative_core"


#undef BLOOD_REGEN_BRUTE_AMOUNT
#undef BLOOD_REGEN_BURN_AMOUNT
#undef BLOOD_REGEN_TOXIN_AMOUNT
#undef BLOOD_REGEN_CELLULAR_AMOUNT
