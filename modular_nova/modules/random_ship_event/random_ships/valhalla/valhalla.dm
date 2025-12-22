/datum/random_ship_event/valhalla
	name = "Pleasurecraft Valhalla"
	auto_accept = FALSE

	message_title = "Phantom Ship Detected Nearby"
	message_content = "A derelict vessel has been caught on short-range telemetrics. \n\
		Its designation is `%SHIPNAME`, its classification is pleasurecraft. \n\
		Immediate scanning prompts no lifeforms, minor energy presence in cockpit. \n\
		Connect with shuttle computer for remote navigating, or request artillery aid? \n\
		%STATION will not be charged for leased use of nearby NT sanctioned B.S.A."

	response_accepted = "Connecting to derelict vessel... confirmed. \n\
		Beginning engine spooling... confirmed. \n\
		Shuttle is in transit towards the station."
	response_rejected = "Please wait while a NT intern forwards the request."
	possible_answers = list("Connect to nav. computer and direct to near-station space.", "Request destruction of vessel.")
	arrival_announcement = "%SHIPNAME has been remotely navigated to near-station space. \n\
		NT requests documenting a formal investigation to be issued to SolFed criminal investigation."
	hailer = "Nanotrasen Communication Channel"

/datum/random_ship_event/valhalla/New()
	. = ..()
	ship_name = ("Valhalla" + "\Roman[rand(1,5)]")

/datum/random_ship_event/valhalla/generate_message()
	var/built_message_content = replacetext(message_content, "%SHIPNAME", ship_name)
	built_message_content = replacetext(built_message_content, "%STATION", station_name())
	arrival_announcement = replacetext(arrival_announcement, "%SHIPNAME", ship_name)
	var/datum/comm_message/message = new /datum/comm_message(message_title, built_message_content, possible_answers)
	message.answer_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(random_ship_event_answered), message, src)
	return message

/datum/random_ship_event/valhalla/spawn_ship()
	var/list/possible_spawns = list()
	for(var/obj/docking_port/stationary/port as anything in SSshuttle.stationary_docking_ports)
		if(istype(port, /obj/docking_port/stationary/syndicate))
			possible_spawns += get_turf(port)
	if(!length(possible_spawns))
		log_admin("Error spawning Random Ship Event. Couldn't find any valid docks.")
		return

	var/datum/map_template/shuttle/random_ship/valhalla = SSmapping.shuttle_templates["random_ship_valhalla"]
	valhalla.load(pick(possible_spawns))
	on_ship_spawn()
	priority_announce(arrival_announcement, title = faction, sender_override = hailer, color_override = announcement_color)

/datum/random_ship_event/valhalla/on_ship_spawn()
	for(var/obj/machinery/light/light as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		if(is_station_level(light.z))
			light.flicker(rand(1, 3))
		CHECK_TICK

/datum/random_ship_event/valhalla/on_accept()
	. = ..()
	spawn_ship()

/datum/random_ship_event/valhalla/on_refuse()
	. = ..()
	spawn_meteors(
		number = rand(5, 10),
		meteor_types = GLOB.meteors_dust,
		direction = pick(GLOB.cardinals),
	)
