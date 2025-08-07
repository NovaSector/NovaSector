/datum/dynamic_ruleset/midround/from_ghosts/marauder
	name = "Ghost Roll Traitor"
	antag_datum = /datum/antagonist/traitor/marauder
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_flag = ROLE_MARAUDER
//	pref_flag = ROLE_MARAUDER
	signup_item_path = /obj/item/clothing/mask/gas/syndicate
	required_candidates = 1
	weight = 4 //Slightly less common than normal midround traitors.
	cost = 4 //But also slightly more costly.
	minimum_players = 10
	///Amount of times we've occured in the round
	var/marauder_no = 1

/datum/dynamic_ruleset/midround/from_ghosts/marauder/generate_ruleset_body(mob/player)
	var/mob/living/carbon/human/new_character = make_body(player)
	new_character.Sleeping(7 SECONDS)

	message_admins("[ADMIN_LOOKUPFLW(new_character)] has been made into a traitor by midround ruleset.")
	log_game("[key_name(new_character)] was spawned as a traitor by midround ruleset.")
	return new_character

/datum/dynamic_ruleset/midround/from_ghosts/marauder/finish_setup(mob/new_character, index)
	for(var/datum/dynamic_ruleset/midround/from_ghosts/marauder/ruleset in SSdynamic.executed_rules)
		marauder_no++
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/marauder/setup_role(datum/antagonist/traitor/marauder/role)
	role.marauder_no = marauder_no
