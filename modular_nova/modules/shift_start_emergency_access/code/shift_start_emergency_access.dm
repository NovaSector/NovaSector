/**
 * Gives departments time to fill their jobs at round start, before making them accessible.
 * Five minutes after round start, airlocks associated with unstaffed departments get emergency access and the affected departments are announced.
 * When a player spawns into a department, this system revokes emergency access from that department.
 * Command and Security are excluded. (for obvious reasons).
 */
/datum/departmental_emergency_access
	/// Flags for each department's access requirements, used to identify which airlocks belong to which departments.
	var/list/department_accesses = list(
		/datum/job_department/engineering = REGION_ACCESS_ENGINEERING,
		/datum/job_department/medical = REGION_ACCESS_MEDBAY,
		/datum/job_department/science = REGION_ACCESS_RESEARCH,
		/datum/job_department/cargo = REGION_ACCESS_SUPPLY,
		/datum/job_department/service = REGION_ACCESS_GENERAL,
	)
	/// Shared or command-related accesses are excluded so they do not misidentify a door as departmental. (We don't want to EA Head's office).
	var/list/ignored_department_accesses
	/// Airlock -> departments whose access flags appear on that airlock. A door can belong to multiple departments.
	var/list/door_departments = list()
	/// Department typepath -> airlocks associated with that department.
	var/list/department_doors = list()
	/// Department typepaths with at least one player who has spawned into a job.
	var/list/staffed_departments = list()
	/// Airlocks this system changed to emergency access; only these may be changed back by this system.
	var/list/managed_doors = list()
	/// Prevents the delayed staffing scan from running more than once.
	var/initialized = FALSE
	/// Prevents multiple job-spawn signals from scheduling duplicate round-start scans.
	var/roundstart_initialization_scheduled = FALSE

/// Which accesses should be ignored when determining which airlocks belong to which departments.
/// This prevents command and shared accesses from misidentifying a door as departmental.
/datum/departmental_emergency_access/New()
	. = ..()
	ignored_department_accesses = COMMAND_ACCESS + PRIVATE_COMMAND_ACCESS + CAPTAIN_ACCESS + list(
		ACCESS_BUDGET,
		ACCESS_MAINT_TUNNELS,
		ACCESS_EXTERNAL_AIRLOCKS,
	)

/// Registers a signal to detect when a player spawns into a job, so the system can revoke emergency access for that department.
/datum/departmental_emergency_access/proc/register_job_signal()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_spawn))

/// Records each department as staffed when a player spawns into one of its jobs.
/datum/departmental_emergency_access/proc/on_job_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER
	if(!player_client || !job)
		return

	// Mark this department as staffed if the job belongs to a department.
	for(var/department_type in department_accesses)
		var/datum/job_department/department = SSjob.get_department_type(department_type)
		if(!department || !(job.departments_bitflags & department.department_bitflags))
			continue
		staffed_departments |= department_type
		if(initialized)
			update_department_doors(department_type)

	// Schedule one scan after round-start spawning; later spawns only update their own departments.
	if(initialized || roundstart_initialization_scheduled)
		return

	roundstart_initialization_scheduled = TRUE
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(schedule_access_check)))

/// Waits five minutes from shift start before evaluating department staffing.
/datum/departmental_emergency_access/proc/schedule_access_check()
	addtimer(CALLBACK(src, PROC_REF(initialize_access)), 5 MINUTES)

/// Scans all station airlocks and enables emergency access for any unstaffed departments, then announces which departments are unstaffed.
/datum/departmental_emergency_access/proc/initialize_access()
	if(initialized)
		return
	initialized = TRUE

	// Gather all airlocks and their associated departments, ignoring command and shared accesses.
	var/list/command_accesses = COMMAND_ACCESS + PRIVATE_COMMAND_ACCESS + CAPTAIN_ACCESS
	for(var/obj/machinery/door/airlock/airlock as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock))
		if(QDELETED(airlock) || !istype(get_area(airlock), /area/station))
			continue
		// Maintenance access in req_one_access is an any-access rule, so don't open that maintenance door.
		if(ACCESS_MAINT_TUNNELS in airlock.req_one_access)
			continue

		var/list/required_accesses = list()
		if(length(airlock.req_access))
			required_accesses |= airlock.req_access
		if(length(airlock.req_one_access))
			required_accesses |= airlock.req_one_access
		// Ignore unrestricted doors and any door that grants command access.
		if(!length(required_accesses) || length(required_accesses & command_accesses))
			continue

		for(var/department_type in department_accesses)
			var/list/department_specific_accesses = department_accesses[department_type] - ignored_department_accesses
			// Match only department-specific requirements, not the shared accesses excluded above.
			if(!length(required_accesses & department_specific_accesses))
				continue

			if(!door_departments[airlock])
				door_departments[airlock] = list()
			if(!department_doors[department_type])
				department_doors[department_type] = list()
			door_departments[airlock] |= department_type
			department_doors[department_type] |= airlock

	// Gather doors and announcement names first so the announcement precedes the access change.
	var/list/doors_to_open = list()
	var/list/departments_to_announce = list()
	for(var/obj/machinery/door/airlock/airlock as anything in door_departments)
		if(QDELETED(airlock) || airlock.emergency)
			continue
		if(!has_unstaffed_department(airlock))
			continue

		doors_to_open += airlock
		for(var/department_type in door_departments[airlock])
			if(department_type in staffed_departments)
				continue
			var/datum/job_department/department = SSjob.get_department_type(department_type)
			departments_to_announce |= department.department_name

	// Give the crew notice of exactly which departments are unstaffed before enabling their airlocks.
	if(length(departments_to_announce))
		minor_announce(
			"No personnel have been assigned to the following departments: [english_list(departments_to_announce)]. Emergency access has been enabled for their department.",
			"Departmental Staffing Update:",
			sound_override = ANNOUNCER_DEPARTMENTAL,
		)

	for(var/obj/machinery/door/airlock/airlock as anything in doors_to_open)
		if(QDELETED(airlock))
			continue
		airlock.emergency = TRUE
		managed_doors[airlock] = TRUE
		airlock.update_appearance()

/// Returns TRUE if any department associated with this door is unstaffed, so it needs emergency access initially.
/datum/departmental_emergency_access/proc/has_unstaffed_department(obj/machinery/door/airlock/airlock)
	for(var/department_type in door_departments[airlock])
		if(!(department_type in staffed_departments))
			return TRUE
	return FALSE

/// Rechecks this department's doors after a spawn and revokes system-granted access for that department.
/datum/departmental_emergency_access/proc/update_department_doors(department_type)
	var/revoked_doors = 0
	for(var/obj/machinery/door/airlock/airlock as anything in department_doors[department_type])
		if(QDELETED(airlock) || !managed_doors[airlock])
			continue
		airlock.emergency = FALSE
		managed_doors -= airlock
		airlock.update_appearance()
		revoked_doors++

	if(!revoked_doors)
		return

	// Announce when assigned personnel arrive and the system revokes their department's emergency access.
	var/datum/job_department/department = SSjob.get_department_type(department_type)
	minor_announce(
		"Personnel have reported for duty for [department.department_name]. Emergency access has been revoked from [department.department_name].",
		"Departmental Staffing Update:",
		sound_override = ANNOUNCER_DEPARTMENTAL, // Use the standard departmental announcement sound.
	)

GLOBAL_DATUM_INIT(departmental_emergency_access, /datum/departmental_emergency_access, new)

/// Register after the jobs subsystem's parent initialization, when SSdcs is available.
/datum/controller/subsystem/job/Initialize()
	. = ..()
	GLOB.departmental_emergency_access.register_job_signal()
