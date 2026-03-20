/datum/action/cooldown/bloodsucker/distress
	name = "Distress"
	desc = "The sub-strain triggers a pheromone distress signal, alerting your Progenitor to your location at the cost of self-harm."
	button_icon_state = "power_distress"
	power_explanation = "Distress:\n\
		Activate from anywhere. Your Progenitor Bloodsucker will instantly be alerted of your location via pheromone signal."
	power_flags = NONE
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 10
	cooldown_time = 10 SECONDS
	level_current = -1

/datum/action/cooldown/bloodsucker/distress/ActivatePower(trigger_flags)
	. = ..()
	var/turf/open/floor/target_area = get_area(owner)
	var/datum/antagonist/ghoul/ghouldatum = owner.mind.has_antag_datum(/datum/antagonist/ghoul)

	owner.balloon_alert(owner, "distress pheromone released!")
	to_chat(ghouldatum.master.owner, "<span class='userdanger'>[owner], your Thrall, is sending a distress signal from [target_area]!</span>")

	var/mob/living/user = owner
	user.adjust_brute_loss(10)
	return TRUE
