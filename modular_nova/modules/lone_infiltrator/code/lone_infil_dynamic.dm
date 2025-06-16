/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator
	name = "Lone Infiltrator"
	antag_datum = /datum/antagonist/traitor/lone_infiltrator
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_flag = ROLE_LONE_INFILTRATOR
	restricted_roles = list(JOB_CYBORG,
							JOB_AI,
							JOB_SECURITY_OFFICER,
							JOB_WARDEN,
							JOB_DETECTIVE,
							JOB_HEAD_OF_SECURITY,
							JOB_CAPTAIN,
							JOB_CORRECTIONS_OFFICER,
							JOB_NT_REP,
							JOB_BLUESHIELD,
							JOB_ORDERLY,
							JOB_BOUNCER,
							JOB_CUSTOMS_AGENT,
							JOB_ENGINEERING_GUARD,
							JOB_SCIENCE_GUARD,
							)
	required_candidates = 1
	weight = 4 //Slightly less common than normal midround traitors.
	cost = 4 //But also slightly more costly.
	minimum_players = 10
	///Amount of infiltrators spawned in the round
	var/infil_number = 1

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/generate_ruleset_body(mob/applicant)
	var/mob/living/carbon/human/new_character = make_body(applicant)
	new_character.client.prefs.safe_transfer_prefs_to(new_character)
	new_character.dna.update_dna_identity()
	new_character.regenerate_icons()
	new_character.dna.species.pre_equip_species_outfit(null, new_character)
	var/datum/mind/player_mind = new /datum/mind(applicant.key)
	player_mind.active = TRUE

	message_admins("[ADMIN_LOOKUPFLW(new_character)] has been made into lone infiltrator by midround ruleset.")
	log_game("[key_name(new_character)] was spawned as a lone infiltrator by midround ruleset.")
	return new_character

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/finish_setup(mob/new_character, index)
	. = ..()
	new_character.mind.special_role = ROLE_SYNDICATE
	new_character.mind.set_assigned_role(SSjob.get_job_type(/datum/job/lone_infiltrator))

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/setup_role(datum/antagonist/traitor/lone_infiltrator/role)
	//get our number
	for(var/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/ruleset as anything in SSdynamic.executed_rules)
		infil_number++
	//load the shuttle, we don't trust lazy_load with this
	load_shuttle(infil_number)
	//load the map, if its the first time running don't force
	if(infil_number == 1)
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_INFIL_MEMORY)
	else
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_INFIL_MEMORY, TRUE)
	//set our spawnpoint
	role.set_spawnpoint(infil_number)

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/proc/load_shuttle(infil_number)
	var/is_first = FALSE
	if(infil_number == 1)
		is_first = TRUE
	var/datum/map_template/shuttle/lone_infil/infil_shuttle = SSmapping.shuttle_templates["lone_infil_default"]
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - infil_shuttle.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - infil_shuttle.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/turf = locate(x,y,z)
	if(!turf)
		CRASH("[src] found no turf to load in")
	if(!infil_shuttle.load(turf))
		CRASH("Loading [infil_shuttle] failed!")
	var/obj/docking_port/mobile/mobile_port = is_first ? SSshuttle.getShuttle("lone_infil") : SSshuttle.getShuttle("lone_infil_[infil_number]")
	mobile_port.destination = is_first ? SSshuttle.getDock("lone_infil") : SSshuttle.getDock("lone_infil_[infil_number]")
	mobile_port.mode = SHUTTLE_IGNITING
	mobile_port.setTimer(mobile_port.ignitionTime)
