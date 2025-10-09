#define TRACKED_TIME "tracked_time"
#define TRACKED_VICTIM "tracked_victim"



/datum/component/antag_metric_tracker
	var/list/owner_antag_datums = list()
	var/mob/living/tracked_mob
	var/list/tracked_victims = list()
	var/list/objectives = list()
	var/is_antagonist = TRUE
	var/kills = 0
	var/damage_dealt = 0
	var/activity_time = 0
	var/objectives_completed = 0
	var/disruption_score = 0
	var/influence_score = 0
	var/is_dead = FALSE
	var/last_update = 0
	var/victim_track_time = 30 SECONDS

	COOLDOWN_DECLARE(update_objectives_cooldown)


/datum/component/antag_metric_tracker/Initialize(mob/living/tracked_mob)
	if(!tracked_mob)
		return COMPONENT_INCOMPATIBLE

	if(tracked_mob.mind?.antag_datums?.len == 0)
		is_antagonist = FALSE

	parent = tracked_mob
	last_update = world.time
	RegisterWithParent()
	START_PROCESSING(SSdcs, src)

/datum/component/antag_metric_tracker/RegisterWithParent()
	if(!tracked_mob)
		Destroy()

	RegisterSignal(tracked_mob, COMSIG_LIVING_ATTACK_ATOM, PROC_REF(on_damage_dealt), TRUE)
	RegisterSignal(tracked_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(tracked_mob, COMSIG_QDELETING, PROC_REF(on_qdel))


/datum/component/antag_metric_tracker/UnregisterFromParent()
	if(tracked_mob)
		UnregisterSignal(tracked_mob, list(COMSIG_MOB_APPLY_DAMAGE, COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_mob = null



/datum/component/antag_metric_tracker/proc/register_victim(mob/living/victim)
	if(victim == tracked_mob)
		return
	if(!victim || !isliving(victim) || !victim.client)
		return
	if(tracked_victims[victim.client])
		var/list/entry = tracked_victims[victim.client]
		entry[TRACKED_TIME] = victim_track_time // refresh timer
		return
	RegisterSignals(victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_victim_lost))
	tracked_victims[victim.client] = list(list(
		TRACKED_VICTIM = victim,
		TRACKED_TIME = 30 SECONDS
	))

/datum/component/antag_metric_tracker/proc/unregister_victim(mob/living/victim)
	if(victim == tracked_mob)
		return
	if(!victim || !isliving(victim) || QDELETED(victim) || !victim.client)
		return
	UnregisterSignal(victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	var/list/entry = tracked_victims[victim.client]
	if(!entry)
		return
	var/mob/living/entry_victim = entry[TRACKED_VICTIM]
	if(entry_victim != victim)
		return
	tracked_victims -= victim.client

/datum/component/antag_metric_tracker/proc/on_victim_lost(mob/living/victim, gibbed)
	SIGNAL_HANDLER

	if(QDELETED(victim) || !victim || !isliving(victim) || victim == tracked_mob)
		unregister_victim(victim)
		return
	unregister_victim(victim)
	kills++


/datum/component/antag_metric_tracker/process(delta_time)
	activity_time += delta_time
	if(world.time - last_update > 100)
		last_update = world.time

	// Checking objectives once per minute should be often enough.
	if(COOLDOWN_FINISHED(src, update_objectives_cooldown) && is_antagonist && tracked_mob?.mind && tracked_mob.mind?.antag_datums?.len)
		COOLDOWN_START(src, update_objectives_cooldown, 1 MINUTES)
		for(var/datum/antagonist/antag in tracked_mob.mind.antag_datums)
			if(!antag)
				continue
			if(!length(antag.objectives))
				continue
			check_objectives(antag)

		objectives_completed = 0
		for(var/datum/objective/objective in objectives)
			if(!istype(objective) || QDELETED(objective))
				objectives -= objective
			if(objective.completed)
				objectives_completed++

	if(!length(tracked_victims))
		return
	for(var/client/client in tracked_victims)
		var/list/entry = tracked_victims[client]
		var/mob/living/victim = entry[TRACKED_VICTIM]
		entry[TRACKED_TIME] -= 1 SECONDS * delta_time
		if(!victim || !isliving(victim) || QDELETED(victim) || !victim.mind)
			unregister_victim(victim)
		else if(entry[TRACKED_TIME] <= 0)
			unregister_victim(victim)



/datum/component/antag_metric_tracker/proc/on_damage_dealt(mob/living/attacker, atom/attacked, list/modifiers)
	SIGNAL_HANDLER

	if(!attacked || !isatom(attacked) || !tracked_mob)
		return
	if(attacked == tracked_mob)
		return
	if(!isliving(attacked))
		return
	var/mob/living/victim = attacked
	if(!victim.mind || victim.stat == DEAD)
		return
	register_victim(victim)



/datum/component/antag_metric_tracker/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER
	is_dead = TRUE



/datum/component/antag_metric_tracker/proc/check_objectives(datum/antagonist/antag)
	if(!antag)
		return
	if(!length(antag.objectives))
		return
	var/list/to_check = antag.objectives.Copy()
	for(var/datum/objective/objective in to_check)
		if(!objective.check_completion())
			continue
		objectives += objective


/datum/component/antag_metric_tracker/proc/on_qdel(datum/source)
	SIGNAL_HANDLER
	tracked_mob = null
	Destroy()

/datum/component/antag_metric_tracker/proc/add_disruption(points)
	disruption_score += points

/datum/component/antag_metric_tracker/proc/add_influence(points)
	influence_score += points

/datum/component/antag_metric_tracker/Destroy(force, silent)
	STOP_PROCESSING(SSdcs, src)
	UnregisterFromParent()
	return ..()


#undef TRACKED_TIME
#undef TRACKED_VICTIM
