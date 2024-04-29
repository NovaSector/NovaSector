/datum/round_event_control/sappers
	name = "Space Sappers"
	typepath = /datum/round_event/sappers
	weight = 10
	earliest_start = 60 MINUTES //Gives the station time to work on their powernet
	max_occurrences = 1
	min_players = 20
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_INVASION
	description = "A gang of outlaws are sapping the powernet with their credit miners."
	map_flags = EVENT_SPACE_ONLY

/datum/round_event_control/sappers/preRunEvent()
	if (SSmapping.is_planetary())
		return EVENT_CANT_RUN
	return ..()

/datum/round_event/sappers
	fakeable = FALSE

/datum/round_event/sappers/start()
	spawn_sapper_gang()

/proc/spawn_sapper_gang()
	var/list/candidates = SSpolling.poll_ghost_candidates("Do you wish to be considered to join the [span_notice("Space Sappers?")]", check_jobban = ROLE_TRAITOR, alert_pic = /obj/item/wrench/bolter, role_name_text = "sapper gang")
	shuffle_inplace(candidates)

	var/datum/map_template/shuttle/pirate/sapper/ship = SSmapping.shuttle_templates["pirate_sapper"]
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - ship.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - ship.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/turf = locate(x,y,z)
	if(!turf)
		CRASH("Sapper event found no turf to load in")

	if(!ship.load(turf))
		CRASH("Loading sapper ship failed!")

	for(var/turf/area_turf as anything in ship.get_affected_turfs(turf))
		for(var/obj/effect/mob_spawn/ghost_role/human/sapper/spawner in area_turf)
			if(candidates.len > 0)
				var/mob/our_candidate = candidates[1]
				var/mob/spawned_mob = spawner.create_from_ghost(our_candidate)
				candidates -= our_candidate
				notify_ghosts(
					"The sapper ship has an object of interest: [spawned_mob]!",
					source = spawned_mob,
					header = "Sappers!",
				)
			else
				notify_ghosts(
					"The sapper ship has an object of interest: [spawner]!",
					source = spawner,
					header = "Sappers Spawn Here!",
				)
