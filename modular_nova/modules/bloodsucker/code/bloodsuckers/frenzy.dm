/**
 * # Feral Episode Status Effect
 *
 * This is the status effect given to Bloodsuckers during a Feral Episode.
 * The symbiont overrides motor control during starvation, forcing the host to feed.
 */

/atom/movable/screen/alert/status_effect/frenzy
	name = "Feral Episode"
	desc = "The symbiont has overridden your motor control! You are entirely feral -- find and drain blood, or you will be terminated!"
	icon = 'modular_nova/modules/bloodsucker/icons/bloodsucker_actions.dmi'
	icon_state = "power_recover"
	alerttooltipstyle = "cult"

/datum/status_effect/frenzy
	id = "Frenzy"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	///Boolean on whether they were an AdvancedToolUser, to give the trait back upon exiting.
	var/was_tooluser = FALSE
	/// The stored Bloodsucker antag datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum
	var/trait_list = list(TRAIT_MUTE, TRAIT_DEAF, TRAIT_STRONG_GRABBER)

/datum/status_effect/frenzy/get_examine_text()
	return span_notice("They seem... inhumane, and feral!")

/datum/status_effect/frenzy/on_apply()
	var/mob/living/carbon/human/user = owner
	bloodsuckerdatum = IS_BLOODSUCKER(user)

	// Disable ALL Powers and notify their entry
	bloodsuckerdatum.DisableAllPowers(forced = TRUE)
	to_chat(owner, span_userdanger("<FONT size = 3>Blood! You need Blood, now! The symbiont has seized motor control! You will DIE if you do not get BLOOD."))
	to_chat(owner, span_announce("* Bloodsucker Tip: While in a Feral Episode, you quickly accrue burn damage, instantly aggressively grab, have stun resistance, cannot speak, hear, or use any adaptations outside of Drain and Molecular Compression (if you have it)."))
	owner.balloon_alert(owner, "feral episode! Drain blood or die!")
	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_ENTERS_FERAL)

	// Give the other Feral Episode effects
	owner.add_traits(trait_list, FERAL_TRAIT)
	if(HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER))
		was_tooluser = TRUE
		REMOVE_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.add_client_colour(/datum/client_colour/manual_heart_blood, REF(src))
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if((user.handcuffed && cuffs) || (user.legcuffed && legcuffs))
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	bloodsuckerdatum.frenzied = TRUE
	return ..()

/datum/status_effect/frenzy/on_remove()
	owner.balloon_alert(owner, "you come back to your senses.")
	owner.remove_traits(trait_list, FERAL_TRAIT)
	if(was_tooluser)
		ADD_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
		was_tooluser = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.remove_client_colour(REF(src))

	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXITS_FERAL)
	bloodsuckerdatum.frenzied = FALSE
	return ..()

/datum/status_effect/frenzy/tick()
	var/mob/living/carbon/human/user = owner
	// If duration is not -1, that means we're about to lose the feral episode, give them some safe time.
	if(!bloodsuckerdatum.frenzied || duration > 0 || user.stat != CONSCIOUS)
		return
	user.adjust_fire_loss(1 + (bloodsuckerdatum.GetNeuralErosion() / 10))
