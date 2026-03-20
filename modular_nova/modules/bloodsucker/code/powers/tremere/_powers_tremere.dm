/**
 *	# Hemokinetic Powers
 *
 *	This file is for Hemokinetic power procs and Bloodsucker procs that deal exclusively with the Hemokinetic clade.
 *	Hemokinetic has quite a bit of unique things to it, so its own subtype is warranted.
 */

/datum/action/cooldown/bloodsucker/targeted/tremere
	name = "Hemokinetic Adaptation"
	desc = ""
	power_explanation = ""
	active_background_icon_state = "tremere_power_on"
	base_background_icon_state = "tremere_power_off"
	button_icon = 'modular_nova/modules/bloodsucker/icons/tremere_bloodsucker.dmi'
	background_icon = 'modular_nova/modules/bloodsucker/icons/tremere_bloodsucker.dmi'

	level_current = 0
	// Re-defining these as we want total control over them
	power_flags = BP_AM_STATIC_COOLDOWN
	// Targeted stuff
	unset_after_click = FALSE
