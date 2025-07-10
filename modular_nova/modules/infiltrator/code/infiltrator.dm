//antag
/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	roundend_category = "Infiltrators"
	preview_outfit = /datum/outfit/infiltrator_preview
	give_uplink = FALSE
	/// Identifying number of the traitor
	var/infil_number
	/// The turf inside the lazy_template marked as this antag's spawn
	var/turf/spawnpoint

/datum/outfit/infiltrator_preview
	name = "Infiltrator (Preview only)"

/datum/antagonist/traitor/infiltrator/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)
	owner_mob.faction |= ROLE_SYNDICATE
	owner_mob.faction &= FACTION_NEUTRAL

/datum/antagonist/traitor/infiltrator/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	if(owner_mob)
		owner_mob.remove_language(/datum/language/codespeak, source = LANGUAGE_MIND)
		owner_mob.faction &= ROLE_SYNDICATE
		owner_mob.faction |= FACTION_NEUTRAL

/datum/antagonist/traitor/infiltrator/on_gain()
	. = ..()
	//load the map, if its the first time running don't force
	if(infil_number == 1)
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_MIDROUND_TRAITOR)
	else
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_MIDROUND_TRAITOR, TRUE)
	//load the shuttle, we don't trust lazy_load with this
	load_shuttle(infil_number)
	//move our guy
	set_spawnpoint(infil_number)
	move_to_spawnpoint()

/datum/antagonist/traitor/infiltrator/proc/load_shuttle(infil_number)
	var/is_first = FALSE
	if(infil_number == 1)
		is_first = TRUE
	var/datum/map_template/shuttle/infiltrator/infil_shuttle = SSmapping.shuttle_templates["traitor_default"]
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - infil_shuttle.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - infil_shuttle.height)
	var/z
	if(SSmapping.empty_space)
		z = SSmapping.empty_space.z_value
	else
	//no space level, lets go for the safest next option
		z = 1
	var/turf/turf = locate(x,y,z)
	if(!turf)
		CRASH("[src] found no turf to load its shuttle in")
	if(!infil_shuttle.load(turf))
		CRASH("Loading [infil_shuttle] failed!")
	//dock at our port
	var/obj/docking_port/mobile/mobile_port = is_first ? SSshuttle.getShuttle("traitor") : SSshuttle.getShuttle("traitor_[infil_number]")
	mobile_port.destination = is_first ? SSshuttle.getDock("traitor") : SSshuttle.getDock("traitor_[infil_number]")
	mobile_port.mode = SHUTTLE_IGNITING
	mobile_port.setTimer(mobile_port.ignitionTime)

/datum/antagonist/traitor/infiltrator/proc/set_spawnpoint(infil_number)
	spawnpoint = GLOB.traitor_start[infil_number]

/datum/antagonist/traitor/infiltrator/proc/move_to_spawnpoint()
	owner.current.forceMove(spawnpoint)
	var/obj/structure/bed/bed = locate(/obj/structure/bed) in spawnpoint.contents
	var/obj/item/bedsheet/bedsheet = locate(/obj/item/bedsheet) in spawnpoint.contents
	if(!bed || !bedsheet)
		return
	//put them in bed
	owner.current.setDir(SOUTH)
	bed.buckle_mob(owner.current)
	bedsheet.coverup(owner.current)

//antag job
/datum/job/infiltrator
	title = ROLE_INFILTRATOR
	plasmaman_outfit = /datum/outfit/infiltrator_plasmaman

/datum/outfit/infiltrator_plasmaman
	name = "Infiltrator (Plasmaman)"
	head = /obj/item/clothing/head/helmet/space/plasmaman/syndie
	uniform = /obj/item/clothing/under/plasmaman/syndicate
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
	belt = /obj/item/tank/internals/plasmaman/belt/full
	internals_slot = ITEM_SLOT_BELT
