/datum/antagonist/bitrunning_reinforcement
	name = "Subcontracted Assisting Bitrunner"
	antagpanel_category = ANTAG_GROUP_GLITCH
	pref_flag = ROLE_GLITCH
	preview_outfit = /datum/outfit/job/bitrunner
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	suicide_cry = "ALT F4!"

/datum/antagonist/bitrunning_reinforcement/on_gain()
	. = ..()
	forge_objectives()
	owner.announce_objectives()

/datum/antagonist/bitrunning_reinforcement/forge_objectives()
	var/datum/objective/bitrunning_reinforcement_fluff/objective = new()
	objective.owner = owner
	objectives += objective

/datum/objective/bitrunning_reinforcement_fluff
	explanation_text = "Assist Nanotrasen-aligned bitrunners with completion of domains. Goof off."

/datum/objective/bitrunning_reinforcement_fluff/check_completion()
	return TRUE
