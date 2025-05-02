/datum/antagonist/bitrunning_reinforcement
	name = "Subcontracted Assisting Bitrunner"
	antagpanel_category = ANTAG_GROUP_GLITCH
	job_rank = ROLE_GLITCH
	preview_outfit = /datum/outfit/job/bitrunner
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = FALSE
	show_to_ghosts = FALSE
	suicide_cry = "ALT F4!"

/datum/antagonist/bitrunning_reinforcement/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/bitrunning_reinforcement/on_gain()
	. = ..()

	forge_objectives()

	if(iscarbon(owner.current))
		var/mob/living/carbon/carbon_mob = owner.current
		carbon_mob.make_virtual_mob()

/datum/antagonist/bitrunning_reinforcement/forge_objectives()
	var/datum/objective/bitrunning_reinforcement_fluff/objective = new()
	objective.owner = owner
	objectives += objective

/datum/objective/bitrunning_reinforcement_fluff

/datum/objective/bitrunning_reinforcement_fluff/New()
	explanation_text = "Assist Nanotrasen-aligned bitrunners with completion of domains. Goof off."
	return ..()

/datum/objective/bitrunning_reinforcement_fluff/check_completion()
	if(locate(/mob/living/carbon) in (GLOB.alive_player_list - owner.current))
		return FALSE

	return TRUE
