#define GOHOME_START 0
#define GOHOME_FLICKER_ONE 2
#define GOHOME_FLICKER_TWO 4
#define GOHOME_TELEPORT 6

/**
 * Given to Bloodsuckers near Sol if they have a den claimed.
 * Teleports them to their den after a delay.
 * Makes them drop everything if someone witnesses the act.
 */
/datum/action/cooldown/bloodsucker/gohome
	name = "Homing Instinct"
	desc = "The symbiont's biological compass guides you back to your nest. Disperse into vapor and return to your claimed den.<br><b>WARNING:</b> You will drop <b>ALL</b> of your possessions if observed."
	button_icon_state = "power_gohome"
	active_background_icon_state = "vamp_power_off_oneshot"
	base_background_icon_state = "vamp_power_off_oneshot"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_SINGLEUSE|BP_AM_STATIC_COOLDOWN
	bloodsucker_check_flags = BP_CANT_USE_IN_FERAL
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 100
	cooldown_time = 10 SECONDS
	power_activates_immediately = FALSE
	level_current = -1

	///What stage of the teleportation are we in
	var/teleporting_stage = GOHOME_START
	///The types of mobs that will drop post-teleportation.
	var/static/list/spawning_mobs = list(
		/mob/living/basic/mouse = 3,
		/mob/living/basic/bat = 1,
	)

/datum/action/cooldown/bloodsucker/gohome/get_power_explanation_extended()
	. = list()
	. += "Homing Instinct will, after a short delay, transport you to your claimed den."
	. += "You will drop all belongings if seen by an observer."
	. += "The adaptation will cancel if the claimed den is destroyed."
	. += "Immediately after activating, lights around you will begin to flicker."
	. += "Once you arrive at your den, a rat or bat will appear where you vanished."

/datum/action/cooldown/bloodsucker/gohome/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	/// Have No Haven (NOTE: You only got this power if you had a haven, so this means it's destroyed)
	if(!istype(bloodsuckerdatum_power) || !bloodsuckerdatum_power.claimed_den)
		owner.balloon_alert(owner, "den was destroyed!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/gohome/ActivatePower(atom/target)
	owner.balloon_alert(owner, "preparing to teleport...")
	return TRUE

/datum/action/cooldown/bloodsucker/gohome/DeactivatePower(deactivate_flags)
	if(active && teleporting_stage != GOHOME_TELEPORT)
		owner.balloon_alert(owner, "teleportation cancelled.")
		teleporting_stage = GOHOME_START
		return . = ..(DEACTIVATE_POWER_DO_NOT_REMOVE)
	. = ..()

/datum/action/cooldown/bloodsucker/gohome/process(seconds_per_tick)
	. = ..()
	if(!.)
		return FALSE

	switch(teleporting_stage)
		if(GOHOME_START)
			INVOKE_ASYNC(src, PROC_REF(flicker_lights), 3, 20)
		if(GOHOME_FLICKER_ONE)
			INVOKE_ASYNC(src, PROC_REF(flicker_lights), 4, 40)
		if(GOHOME_FLICKER_TWO)
			INVOKE_ASYNC(src, PROC_REF(flicker_lights), 4, 60)
		if(GOHOME_TELEPORT)
			INVOKE_ASYNC(src, PROC_REF(teleport_to_den), owner)
	teleporting_stage++

/datum/action/cooldown/bloodsucker/gohome/ContinueActive(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isturf(owner.loc))
		return FALSE
	if(!bloodsuckerdatum_power.claimed_den)
		user.balloon_alert(user, "den destroyed!")
		to_chat(owner, span_warning("Your den has been destroyed! You no longer have a destination."))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/gohome/proc/flicker_lights(flicker_range, beat_volume)
	for(var/obj/machinery/light/nearby_lights in view(flicker_range, get_turf(owner)))
		nearby_lights.flicker(5)
	playsound(get_turf(owner), 'sound/effects/singlebeat.ogg', beat_volume, 1)

/datum/action/cooldown/bloodsucker/gohome/proc/teleport_to_den(mob/living/carbon/user)
	var/drop_item = FALSE
	var/turf/current_turf = get_turf(user)
	// If we aren't in the dark, anyone watching us will cause us to drop out stuff
	if(current_turf && current_turf.lighting_object && current_turf.get_lumcount() >= 0.2)
		for(var/mob/living/watchers in viewers(world.view, get_turf(user)) - user)
			if(QDELETED(watchers.client) || watchers.stat != CONSCIOUS)
				continue
			if(issilicon(watchers))
				continue
			if(watchers.is_blind())
				continue
			if(!IS_BLOODSUCKER(watchers) && !IS_THRALL(watchers))
				drop_item = TRUE
				break
	// Drop all necessary items (handcuffs, legcuffs, items if seen)
	user.uncuff()
	if(drop_item)
		for(var/obj/item/literally_everything in owner)
			owner.dropItemToGround(literally_everything)

	playsound(current_turf, 'sound/effects/magic/summon_karp.ogg', 60, 1)

	var/datum/effect_system/basic/steam_spread/puff = new(current_turf, 3, FALSE)
	puff.start()

	/// STEP FIVE: Create animal at prev location
	var/mob/living/simple_animal/new_mob = pick_weight(spawning_mobs)
	new new_mob(current_turf)
	/// TELEPORT: Move to den & close it!
	user.set_resting(TRUE, TRUE, FALSE)
	do_teleport(user, bloodsuckerdatum_power.claimed_den, no_effects = TRUE, forced = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
	bloodsuckerdatum_power.claimed_den.force_enter(user)

	DeactivatePower()
	pay_cost()

/// Bloodsucker steam spread that uses vampire smoke
/datum/effect_system/basic/steam_spread/bloodsucker
	effect_type = /obj/effect/particle_effect/steam

#undef GOHOME_START
#undef GOHOME_FLICKER_ONE
#undef GOHOME_FLICKER_TWO
#undef GOHOME_TELEPORT
