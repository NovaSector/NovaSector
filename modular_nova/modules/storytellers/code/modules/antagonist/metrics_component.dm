/datum/component/antag_metric_tracker
	var/datum/antagonist/owner_antag
	var/mob/living/tracked_mob
	var/kills = 0
	var/damage_dealt = 0
	var/activity_time = 0
	var/objectives_completed = 0
	var/disruption_score = 0
	var/influence_score = 0
	var/is_dead = FALSE
	var/last_update = 0

/datum/component/antag_metric_tracker/Initialize()
	if(!istype(parent, /datum/antagonist))
		return COMPONENT_INCOMPATIBLE

	owner_antag = parent
	tracked_mob = owner_antag.owner?.current
	if(tracked_mob)
		RegisterSignal(tracked_mob, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_damage_dealt))
		RegisterSignal(tracked_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	last_update = world.time
	START_PROCESSING(SSdcs, src)


/datum/component/antag_metric_tracker/process(delta_time)
	activity_time += delta_time
	if(world.time - last_update > 100)
		last_update = world.time


/datum/component/antag_metric_tracker/proc/on_damage_dealt(datum/source, damage, damagetype, def_zone, hit_zone)
	SIGNAL_HANDLER
	var/mob/living/victim = source
	if(ishuman(victim) && !victim.mind?.antag_datums?.len)
		damage_dealt += damage
		if(victim.stat == DEAD)
			kills++


/datum/component/antag_metric_tracker/proc/on_death(datum/source, gibbed)
	SIGNAL_HANDLER
	is_dead = TRUE



/datum/component/antag_metric_tracker/proc/on_objective_completed(datum/source, datum/objective/obj)
	SIGNAL_HANDLER
	objectives_completed++



/datum/component/antag_metric_tracker/proc/add_disruption(points)
	disruption_score += points

/datum/component/antag_metric_tracker/proc/add_influence(points)
	influence_score += points

/datum/component/antag_metric_tracker/Destroy(force, silent)
	STOP_PROCESSING(SSdcs, src)
	if(tracked_mob)
		UnregisterSignal(tracked_mob, list(COMSIG_MOB_APPLY_DAMAGE, COMSIG_LIVING_DEATH))
	return ..()
