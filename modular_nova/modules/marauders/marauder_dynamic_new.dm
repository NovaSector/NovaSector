/* Preparation file for the dynamic refactor
/datum/dynamic_ruleset/midround/from_ghosts/marauder
	name = "Ghost Roll Traitor"
	config_tag = "Marauders"
	preview_antag_datum = /datum/antagonist/traitor/marauder
	midround_type = LIGHT_MIDROUND
	candidate_role = "Marauder"
	pref_flag = ROLE_MARAUDER
	jobban_flag = ROLE_MARAUDER
	ruleset_flags = RULESET_INVADER
	weight = list(
		DYNAMIC_TIER_LOW = 4,
		DYNAMIC_TIER_LOWMEDIUM = 4,
		DYNAMIC_TIER_MEDIUMHIGH = 6,
		DYNAMIC_TIER_HIGH = 8,
	)
	min_pop = 20
	repeatable = TRUE
	signup_atom_appearance = /obj/item/clothing/mask/gas/syndicate
	///Amount of times we've occured in the round
	var/marauder_no = 1

/datum/dynamic_ruleset/midround/from_ghosts/marauder/create_ruleset_body()
	var/mob/living/carbon/human/new_character = make_body(player)
	new_character.Sleeping(7 SECONDS)

	message_admins("[ADMIN_LOOKUPFLW(new_character)] has been made into a traitor by midround ruleset.")
	log_game("[key_name(new_character)] was spawned as a traitor by midround ruleset.")
	return new_character

/datum/dynamic_ruleset/midround/from_ghosts/marauder/prepare_for_role(datum/mind/player_mind)
	for(var/datum/dynamic_ruleset/midround/from_ghosts/marauder/ruleset in SSdynamic.executed_rules)
		marauder_no++

/datum/dynamic_ruleset/midround/from_ghosts/marauder/assign_role(datum/mind/player_mind)
	var/datum/antagonist/traitor/marauder/antag_datum = new /datum/antagonist/traitor/marauder
	antag_datum.marauder_no = marauder_no
	player_mind.add_antag_datum(antag_datum)
*/
