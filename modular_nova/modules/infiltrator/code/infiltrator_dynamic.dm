/datum/dynamic_ruleset/midround/from_ghosts/infiltrator
	name = "Midround Operative"
	antag_datum = /datum/antagonist/traitor/infiltrator
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_flag = ROLE_INFILTRATOR
	signup_item_path = /obj/item/clothing/mask/gas/syndicate
	required_candidates = 1
	weight = 4 //Slightly less common than normal midround traitors.
	cost = 4 //But also slightly more costly.
	minimum_players = 10
	///Amount of infiltrators spawned in the round
	var/infil_number = 1

/datum/dynamic_ruleset/midround/from_ghosts/infiltrator/generate_ruleset_body(mob/applicant)
	//generate body
	var/mob/living/carbon/human/new_character = make_body(applicant)
	new_character.Sleeping(7 SECONDS)
	//outfit
	new_character.dna.species.pre_equip_species_outfit(null, new_character)
	var/datum/outfit/pyjamas = new /datum/outfit
	var/coinflip = rand(0,1)
	pyjamas.uniform = coinflip ? /obj/item/clothing/under/misc/pj/red : /obj/item/clothing/under/misc/pj/blue
	pyjamas.head = coinflip ? /obj/item/clothing/head/costume/nightcap/red : /obj/item/clothing/head/costume/nightcap/blue
	new_character.equipOutfit(pyjamas)
	//client
	var/client/player_client = new_character.client
	if(player_client)
		SSquirks.AssignQuirks(new_character, new_character.client)
	//mind
	var/datum/mind/player_mind = new /datum/mind(applicant.key)
	player_mind.set_assigned_role(SSjob.get_job_type(/datum/job/infiltrator))
	player_mind.active = TRUE
	//logging
	message_admins("[ADMIN_LOOKUPFLW(new_character)] has been made into an infiltrator by midround ruleset.")
	log_game("[key_name(new_character)] was spawned as an infiltrator by midround ruleset.")
	return new_character

/datum/dynamic_ruleset/midround/from_ghosts/infiltrator/finish_setup(mob/new_character, index)
	for(var/datum/dynamic_ruleset/midround/from_ghosts/infiltrator/ruleset in SSdynamic.executed_rules)
		infil_number++
	new_character.faction |= ROLE_SYNDICATE
	new_character.faction &= FACTION_NEUTRAL
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/infiltrator/setup_role(datum/antagonist/traitor/infiltrator/role)
	role.infil_number = infil_number
