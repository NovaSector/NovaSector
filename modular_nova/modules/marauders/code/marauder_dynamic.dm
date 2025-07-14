/datum/dynamic_ruleset/midround/from_ghosts/marauder
	name = "Ghost Roll Traitor"
	antag_datum = /datum/antagonist/traitor/marauder
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_flag = ROLE_MARAUDER
	signup_item_path = /obj/item/clothing/mask/gas/syndicate
	required_candidates = 1
	weight = 4 //Slightly less common than normal midround traitors.
	cost = 4 //But also slightly more costly.
	minimum_players = 10
	///Amount of times we've occured in the round
	var/marauder_no = 1

/datum/dynamic_ruleset/midround/from_ghosts/marauder/generate_ruleset_body(mob/applicant)
	//generate body
	var/mob/living/carbon/human/new_character = make_body(applicant)
	new_character.Sleeping(7 SECONDS)
	//mind
	var/datum/mind/player_mind = new /datum/mind(applicant.key)
	player_mind.set_assigned_role(SSjob.get_job_type(/datum/job/marauder))
	player_mind.active = TRUE
	//outfit
	new_character.dna.species.pre_equip_species_outfit(player_mind.assigned_role, new_character)
	var/datum/outfit/pyjamas = new /datum/outfit
	var/coinflip = rand(0,1)
	pyjamas.uniform = coinflip ? /obj/item/clothing/under/misc/pj/red : /obj/item/clothing/under/misc/pj/blue
	pyjamas.head = coinflip ? /obj/item/clothing/head/costume/nightcap/red : /obj/item/clothing/head/costume/nightcap/blue
	new_character.equipOutfit(pyjamas)
	var/obj/item/clothing/under/uniform = new_character.w_uniform
	uniform.has_sensor = NO_SENSORS
	//quirks
	var/client/player_client = new_character.client
	if(player_client)
		SSquirks.AssignQuirks(new_character, new_character.client)
	//logging
	message_admins("[ADMIN_LOOKUPFLW(new_character)] has been made into a traitor by midround ruleset.")
	log_game("[key_name(new_character)] was spawned as a traitor by midround ruleset.")
	return new_character

/datum/dynamic_ruleset/midround/from_ghosts/marauder/finish_setup(mob/new_character, index)
	for(var/datum/dynamic_ruleset/midround/from_ghosts/marauder/ruleset in SSdynamic.executed_rules)
		marauder_no++
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/marauder/setup_role(datum/antagonist/traitor/marauder/role)
	role.marauder_no = marauder_no
