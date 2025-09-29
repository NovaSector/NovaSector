SUBSYSTEM_DEF(storytellers)
	name = "Storytellers"
	runlevels = RUNLEVEL_GAME
	wait = 1 MINUTES
	priority = FIRE_PRIORITY_LOW

	/// active storyteller instance
	var/datum/storyteller/active

/datum/controller/subsystem/storytellers/Initialize()
	. = ..()
	// Create default storyteller; later can be selected via config/admin
	active = new /datum/storyteller
	active.initialize_round()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/storytellers/fire(resumed)
	if(active)
		active.think()
