SUBSYSTEM_DEF(storytellers)
	name = "Storytellers"
	runlevels = RUNLEVEL_GAME
	wait = 1 MINUTES
	priority = FIRE_PRIORITY_PING

	/// active storyteller instance
	var/datum/storyteller/active

	var/station_value = 0

/datum/controller/subsystem/storytellers/Initialize()
	. = ..()
	// Create default storyteller; later can be selected via config/admin
	active = new /datum/storyteller
	active.initialize_round()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/storytellers/fire(resumed)
	if(active)
		active.think()

/datum/controller/subsystem/storytellers/proc/register_atom_for_storyteller(atom/A)
	if(!active)
		return
	if(isnull(A) || QDELETED(A))
		return
	var/value = A.story_value()
	if(isnull(value) || value <= 0)
		return

	active.analyzer.register_atom_for_storyteller(A)
