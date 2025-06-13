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
	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_INFIL_MEMORY)
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
	//load the map, if its the first time running don't force
	if(infil_number == 1)
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_INFIL_MEMORY)
	else
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_INFIL_MEMORY, TRUE)
	//set our spawnpoint
	role.set_spawnpoint(infil_number)
