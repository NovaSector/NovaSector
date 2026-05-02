/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

/mob/living/carbon/human/species/synth/chest_only

/mob/living/carbon/human/species/synth/chest_only/Initialize(mapload)
	. = ..()

	death(TRUE) //it died to give us more content

	underwear = "Nude"
	bra = "Nude"
	undershirt = "Nude"
	socks = "Nude"

	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(!istype(bodypart, /obj/item/bodypart/chest))
			bodypart.drop_limb(special = TRUE, move_to_floor = FALSE)
			continue

	for(var/obj/item/organ/organ as anything in get_organs_for_zone(BODY_ZONE_CHEST))
		qdel(organ)

/datum/design/synth_diy
	name = "Android Frame"
	desc = "An empty android frame. Compatible with compact positronic brains."
	id = "synth_diy"
	build_type = MECHFAB
	construction_time = 30 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /mob/living/carbon/human/species/synth/chest_only
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	research_icon = 'icons/mob/silicon/robots.dmi'
	research_icon_state = "robot_old"
