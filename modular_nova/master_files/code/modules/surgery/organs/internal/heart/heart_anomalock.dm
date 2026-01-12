/obj/item/organ/heart/cybernetic/anomalock
	/// Do we confer EMP interception/immunity?
	var/gives_emp_immunity = TRUE
	/// What type of voltaic overdrive do we confer in crit?
	var/datum/status_effect/voltaic_overdrive/overdrive_type = /datum/status_effect/voltaic_overdrive

/obj/item/organ/heart/cybernetic/anomalock/weak
	name = "scavenged voltaic combat cyberheart"
	desc = "A cutting-edge cyberheart, pulled from an abandoned corporate scientist's corpse. \
		Voltaic technology allows the heart to keep the body upright in dire circumstances, \
		alongside redirecting anomalous flux energy to fully shield the user from shocks. \
		Requires a refined flux core as a power source. Due to battle damage, does not provide immunity from EMPs and \
		has a shortened overdrive time."

	gives_emp_immunity = FALSE
	survival_cooldown_time = 10 MINUTES
	overdrive_type = /datum/status_effect/voltaic_overdrive/short

/datum/status_effect/voltaic_overdrive/short
	duration = 10 SECONDS
