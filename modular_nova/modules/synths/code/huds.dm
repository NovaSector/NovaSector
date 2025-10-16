// Medical HUD override - exclude synthetics from medical HUD
/datum/atom_hud/data/human/medical/advanced/add_atom_to_single_mob_hud(mob/requesting_mob, atom/hud_atom)
	// Don't show synthetics on medical HUD - they should be on diagnostic HUD instead
	if(ishuman(hud_atom))
		var/mob/living/carbon/human/human_atom = hud_atom
		if(issynthetic(human_atom))
			return
	return ..()

// Diagnostic HUD support for synthetics
/mob/living/carbon/human/proc/diag_hud_set_health()
	if(!issynthetic(src))
		return
	if(stat == DEAD)
		set_hud_image_state(DIAG_HUD, "huddiagdead")
	else
		set_hud_image_state(DIAG_HUD, "huddiag[RoundDiagBar(health/maxHealth)]")

/mob/living/carbon/human/proc/diag_hud_set_status()
	if(!issynthetic(src))
		return
	switch(stat)
		if(CONSCIOUS)
			set_hud_image_state(DIAG_STAT_HUD, "hudstat")
		if(UNCONSCIOUS, HARD_CRIT)
			set_hud_image_state(DIAG_STAT_HUD, "hudoffline")
		else
			set_hud_image_state(DIAG_STAT_HUD, "huddead2")

/mob/living/carbon/human/proc/diag_hud_set_synthcell()
	if(!issynthetic(src))
		return
	// Use nutrition as the "charge" level for synthetics
	// NUTRITION_LEVEL_FAT (600) is max, NUTRITION_LEVEL_STARVING (150) is low
	var/chargelvl = clamp(nutrition / NUTRITION_LEVEL_FAT, 0, 1)
	set_hud_image_state(DIAG_BATT_HUD, "hudbatt[RoundDiagBar(chargelvl)]")

// Override updatehealth to call diagnostic HUD updates for synthetics
/mob/living/carbon/human/updatehealth()
	. = ..()
	if(issynthetic(src))
		diag_hud_set_health()
		diag_hud_set_status()

// Override prepare_data_huds to initialize diagnostic HUD for synthetics
/mob/living/carbon/human/prepare_data_huds()
	if(issynthetic(src))
		diag_hud_set_health()
		diag_hud_set_status()
		diag_hud_set_synthcell()
	else
		. = ..()

// Update synthetic "battery" display when nutrition changes
/mob/living/carbon/human/set_nutrition(new_nutrition)
	. = ..()
	if(issynthetic(src))
		diag_hud_set_synthcell()

