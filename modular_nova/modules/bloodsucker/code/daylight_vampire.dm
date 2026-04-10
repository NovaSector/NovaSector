/**
 * Gives the Vampire the gohome power, called 1.5 minutes before Sol starts
**/
/datum/antagonist/vampire/proc/sol_near_start(atom/source)
	SIGNAL_HANDLER
	if(vampire_haven_area && !(locate(/datum/action/cooldown/vampire/gohome) in powers))
		grant_power(new /datum/action/cooldown/vampire/gohome)

/**
 * Removes the gohome power, called at the end of Sol
**/
/datum/antagonist/vampire/proc/on_sol_end(atom/source)
	SIGNAL_HANDLER
	for(var/datum/action/cooldown/vampire/gohome/power in powers)
		remove_power(power)

/**
 * Called near the end of Sol. Give our vampire a level to spend.
**/
/datum/antagonist/vampire/proc/sol_near_end(atom/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(rank_up), 1)

/**
 * Handles the Sol status effect, called while Sol is risen
**/
/datum/antagonist/vampire/proc/handle_sol()
	SIGNAL_HANDLER
	var/mob/living/current = owner.current
	if(QDELETED(current))
		return

	// Give Sol debuff if not in a coffin
	if(!istype(current.loc, /obj/structure/closet/crate/coffin))
		current.apply_status_effect(/datum/status_effect/vampire_sol)
	else
		// Try to remove Sol debuff
		current.remove_status_effect(/datum/status_effect/vampire_sol)

		// Try to enter torpor if we're not in a frenzy or staked
		if(current.has_status_effect(/datum/status_effect/frenzy))
			if(COOLDOWN_FINISHED(src, vampire_spam_sol_burn))
				to_chat(current, span_userdanger("You are in a frenzy! You cannot enter Torpor until you have enough blood."))
				COOLDOWN_START(src, vampire_spam_sol_burn, VAMPIRE_SPAM_SOL)
			return
		if(check_if_staked())
			if(COOLDOWN_FINISHED(src, vampire_spam_sol_burn))
				to_chat(current, span_userdanger("You are staked! Remove the offending weapon from your heart before sleeping."))
				COOLDOWN_START(src, vampire_spam_sol_burn, VAMPIRE_SPAM_SOL)
			return
		if(!current.has_status_effect(/datum/status_effect/vampire_torpor))
			current.apply_status_effect(/datum/status_effect/vampire_torpor)
			current.add_mood_event("vampsleep", /datum/mood_event/coffinsleep)
			return

	var/shielded = FALSE

	if(istype(current.loc, /obj/structure/closet) || istype(current.loc, /obj/machinery))
		shielded = TRUE

	if(HAS_TRAIT(current, TRAIT_STASIS) || HAS_TRAIT(current, TRAIT_NO_TRANSFORM))
		shielded = TRUE

	if(is_type_in_list(get_area(current) in VAMPIRE_SOL_SHIELDED))
		shielded = TRUE

	var/datum/weather/ash_storm/ash_storm = SSweather.get_weather_by_type(/datum/weather/ash_storm)
	if(ash_storm?.stage == MAIN_STAGE)
		var/area/our_area = get_area(current)
		if(our_area && (our_area in ash_storm.impacted_areas))
			shielded = TRUE

	var/sol_burn_calculated = VAMPIRE_SOL_BURN / (min(2, 1 + (humanity / 10)))

	if(shielded)
		if(current_vitae >= VAMPIRE_SOL_SHIELD_THRESHOLD)
			adjust_blood_volume(-sol_burn_calculated / 2)
		if(shielded != were_shielded)
			to_chat(current, span_cult_bold("This area's shielding affords acceptable safety. <b>Don't worry, blood won't drain below [VAMPIRE_SOL_SHIELD_THRESHOLD].</b>"), type = MESSAGE_TYPE_WARNING)
	else if(!current.has_status_effect(/datum/status_effect/vampire_torpor))
		playsound(owner.current, SFX_SIZZLE, 10, vary = TRUE)
		adjust_blood_volume(-sol_burn_calculated)
		if(shielded != were_shielded)
			to_chat(current, span_narsiesmall("IT BURNS!"), type = MESSAGE_TYPE_WARNING)
		burn_and_kill()

	were_shielded = shielded

/datum/antagonist/vampire/proc/burn_and_kill()
	var/mob/living/current = owner.current
	if(QDELETED(current))
		return
	// We can resist it as long as we have blood.
	if(current_vitae >= 25)
		current.apply_damage(1, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
	else
		if(owner.current.stat == CONSCIOUS)
			current.apply_damage(20, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
			INVOKE_ASYNC(current, TYPE_PROC_REF(/mob, emote), "scream")
		else
			current.apply_damage(50, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))

/datum/antagonist/vampire/proc/give_warning(atom/source, danger_level, vampire_warning_message, vassal_warning_message)
	SIGNAL_HANDLER

	if(!owner?.current)
		return
	to_chat(owner, vampire_warning_message, type = MESSAGE_TYPE_WARNING)

	switch(danger_level)
		if(DANGER_LEVEL_FIRST_WARNING)
			owner.current.playsound_local(null, 'modular_nova/modules/bloodsucker/sound/griffin_3.ogg', 50, TRUE)
		if(DANGER_LEVEL_SECOND_WARNING)
			owner.current.playsound_local(null, 'modular_nova/modules/bloodsucker/sound/griffin_5.ogg', 50, TRUE)
		if(DANGER_LEVEL_THIRD_WARNING)
			owner.current.playsound_local(null, 'sound/effects/alert.ogg', 75, TRUE)
		if(DANGER_LEVEL_SOL_ROSE)
			owner.current.playsound_local(null, 'sound/ambience/misc/ambimystery.ogg', 75, TRUE)
		if(DANGER_LEVEL_SOL_ENDED)
			owner.current.playsound_local(null, 'sound/music/antag/bloodcult/ghosty_wind.ogg', 90, TRUE)

/datum/status_effect/vampire_sol
	id = "vampire_sol"
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/vampire_sol
	// var/list/datum/action/vampire/burdened_actions

/datum/status_effect/vampire_sol/on_apply()
	if(!SSsol.sunlight_active || istype(owner.loc, /obj/structure/closet/crate/coffin))
		return FALSE

	RegisterSignal(SSsol, COMSIG_SOL_END, PROC_REF(on_sol_end))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_owner_moved))
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vampire_sol)
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/vampire_sol)
	to_chat(owner, span_userdanger("Sol has risen! Your powers are suppressed, and you will not heal outside of a coffin!"), type = MESSAGE_TYPE_INFO)
	return TRUE

/datum/status_effect/vampire_sol/on_remove()
	UnregisterSignal(SSsol, COMSIG_SOL_END)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.remove_filter(id)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vampire_sol)
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/vampire_sol)

/datum/status_effect/vampire_sol/proc/on_sol_end()
	SIGNAL_HANDLER
	if(!QDELING(src))
		to_chat(owner, span_big(span_boldnotice("Sol has ended, your vampiric powers are no longer strained!")), type = MESSAGE_TYPE_INFO)
		qdel(src)

/datum/status_effect/vampire_sol/proc/on_owner_moved()
	SIGNAL_HANDLER
	if(istype(owner.loc, /obj/structure/closet/crate/coffin))
		qdel(src)

/atom/movable/screen/alert/status_effect/vampire_sol
	name = "Solar Flares"
	desc = "Solar flares bombard the station, heavily weakening your vampiric abilities and burdening your body!\nSleep in a coffin to avoid the effects of the solar flare!"
	icon = 'modular_nova/modules/bloodsucker/icons/actions_vampire.dmi'
	icon_state = "sol_alert"

/datum/actionspeed_modifier/vampire_sol
	multiplicative_slowdown = 1

/datum/movespeed_modifier/vampire_sol
	multiplicative_slowdown = 0.45
