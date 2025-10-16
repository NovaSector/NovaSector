// Medical HUD override - exclude synthetics from medical HUD
/datum/atom_hud/data/human/medical/advanced/add_atom_to_single_mob_hud(mob/requesting_mob, atom/hud_atom)
	// Don't show synthetics on medical HUD - they should be on diagnostic HUD instead
	if(ishuman(hud_atom))
		var/mob/living/carbon/human/human_atom = hud_atom
		if(issynthetic(human_atom))
			return
	return ..()

// Add HEALTH_HUD and STATUS_HUD to diagnostic HUD for synths
/datum/atom_hud/data/diagnostic
	hud_icons = list(DIAG_HUD, DIAG_STAT_HUD, DIAG_BATT_HUD, DIAG_MECH_HUD, DIAG_BOT_HUD, DIAG_TRACK_HUD, DIAG_CAMERA_HUD, DIAG_AIRLOCK_HUD, DIAG_LAUNCHPAD_HUD, HEALTH_HUD, STATUS_HUD, DNR_HUD)

// Synth health display - use HEALTH_HUD bar like medical HUD does
/mob/living/carbon/human/proc/diag_hud_set_health()
	if(!issynthetic(src))
		return
	// Use medical HUD style health bar
	set_hud_image_state(HEALTH_HUD, "hud[RoundHealth(src)]")

// Synth status display - use STATUS_HUD with disease detection like medical HUD
/mob/living/carbon/human/proc/diag_hud_set_status()
	if(!issynthetic(src))
		return

	// Use same logic as medical HUD for carbons
	if(HAS_TRAIT(src, TRAIT_XENO_HOST) || HAS_TRAIT(src, TRAIT_SPIDER_HOST))
		set_hud_image_state(STATUS_HUD, "hudxeno")
		return

	if(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
		if(HAS_TRAIT(src, TRAIT_MIND_TEMPORARILY_GONE) || can_defib_client())
			set_hud_image_state(STATUS_HUD, "huddefib")
		else if(HAS_TRAIT(src, TRAIT_GHOSTROLE_ON_REVIVE))
			set_hud_image_state(STATUS_HUD, "hudghost")
		else
			set_hud_image_state(STATUS_HUD, "huddead")
		return

	var/virus_threat = check_virus()
	if (!virus_threat)
		set_hud_image_state(STATUS_HUD, "hudhealthy")
		return

	switch(virus_threat)
		if(DISEASE_SEVERITY_UNCURABLE)
			set_hud_image_state(STATUS_HUD, "hudill6")
		if(DISEASE_SEVERITY_BIOHAZARD)
			set_hud_image_state(STATUS_HUD, "hudill5")
		if(DISEASE_SEVERITY_DANGEROUS)
			set_hud_image_state(STATUS_HUD, "hudill4")
		if(DISEASE_SEVERITY_HARMFUL)
			set_hud_image_state(STATUS_HUD, "hudill3")
		if(DISEASE_SEVERITY_MEDIUM)
			set_hud_image_state(STATUS_HUD, "hudill2")
		if(DISEASE_SEVERITY_MINOR)
			set_hud_image_state(STATUS_HUD, "hudill1")
		if(DISEASE_SEVERITY_NONTHREAT)
			set_hud_image_state(STATUS_HUD, "hudill0")
		if(DISEASE_SEVERITY_POSITIVE)
			set_hud_image_state(STATUS_HUD, "hudbuff")

// DNR HUD support for synthetics
/mob/living/carbon/human/proc/diag_hud_set_dnr()
	if(!issynthetic(src))
		return
	set_hud_image_state(DNR_HUD, "hud_dnr")
	if(HAS_TRAIT(src, TRAIT_DNR))
		set_hud_image_active(DNR_HUD)
	else
		set_hud_image_inactive(DNR_HUD)

// Custom energy bar for synths (horizontal at bottom)
/mob/living/carbon/human/proc/diag_hud_set_synthcell()
	if(!issynthetic(src))
		return
	// Use nutrition as the "charge" level for synthetics
	// NUTRITION_LEVEL_FAT (600) is max, NUTRITION_LEVEL_STARVING (150) is low
	var/chargelvl = clamp(nutrition / NUTRITION_LEVEL_FAT, 0, 1)
	set_hud_image_state(DIAG_BATT_HUD, "hudbatt[RoundDiagBar(chargelvl)]")

	// Position energy bar at bottom
	if(!hud_list)
		return
	var/image/holder = hud_list[DIAG_BATT_HUD]
	if(!holder)
		return
	holder.pixel_w = -(get_cached_width() - world.icon_size) / 2
	holder.pixel_z = (get_cached_height() - world.icon_size) - 16

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
		diag_hud_set_dnr()
	else
		. = ..()

// Update synthetic "battery" display when nutrition changes
/mob/living/carbon/human/set_nutrition(new_nutrition)
	. = ..()
	if(issynthetic(src))
		diag_hud_set_synthcell()

// Override med_hud_set_status to call diagnostic HUD for synths
/mob/living/carbon/human/med_hud_set_status()
	// For synths, use diagnostic HUD instead of medical HUD
	if(issynthetic(src))
		diag_hud_set_status()
		return
	return ..()

// Override update_dnr_hud for synths
/mob/living/carbon/human/update_dnr_hud()
	if(issynthetic(src))
		diag_hud_set_dnr()
		return
	return ..()
