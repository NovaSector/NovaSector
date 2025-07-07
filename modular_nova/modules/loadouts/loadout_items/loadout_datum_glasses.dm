// LOADOUT ITEM DATUMS FOR THE EYES SLOT

/datum/loadout_item/glasses/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.glasses))
		.. ()
		return TRUE

/datum/loadout_item/glasses/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.glasses)
			LAZYADD(outfit.backpack_contents, outfit.glasses)
		outfit.glasses = item_path
	else
		outfit.glasses = item_path

/datum/loadout_item/glasses/post_equip_item(datum/preferences/preference_source, mob/living/carbon/human/equipper)
	var/obj/item/clothing/glasses/equipped_glasses = locate(item_path) in equipper.get_equipped_items()
	if (!equipped_glasses)
		return
	if(equipped_glasses.tint)
		equipper.update_tint()
	if(equipped_glasses.vision_flags \
		|| equipped_glasses.invis_override \
		|| equipped_glasses.invis_view \
		|| !isnull(equipped_glasses.color_cutoffs))
		equipper.update_sight()

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/glasses/biker
	name = "Biker Goggles"
	item_path = /obj/item/clothing/glasses/biker

/datum/loadout_item/glasses/retinal_projector
	name = "Civilian Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector

/datum/loadout_item/glasses/aviator_fake
	name = "Fake Aviators"
	item_path = /obj/item/clothing/glasses/fake_sunglasses/aviator

/datum/loadout_item/glasses/geist_glasses
	name = "Geist Gazers"
	item_path = /obj/item/clothing/glasses/geist_gazers

/datum/loadout_item/glasses/osi
	name = "OSI Glasses"
	item_path = /obj/item/clothing/glasses/osi

/datum/loadout_item/glasses/phantom
	name = "Phantom Glasses"
	item_path = /obj/item/clothing/glasses/phantom

/datum/loadout_item/glasses/psych_glasses
	name = "Psych Glasses"
	item_path = /obj/item/clothing/glasses/psych

/*
 *	PRESCRIPTION GLASSES
 */

/datum/loadout_item/glasses/regular
	//"Glasses"
	group = "Prescription"

/datum/loadout_item/glasses/kim
	name = "Binoclard Glasses"
	group = "Prescription"

/datum/loadout_item/glasses/circle_glasses
	//"Circle Glasses"
	group = "Prescription"

/datum/loadout_item/glasses/hipster_glasses
	//"Hipster Glasses"
	group = "Prescription"

/datum/loadout_item/glasses/jamjar_glasses
	//"Jamjar Glasses"
	group = "Prescription"

/datum/loadout_item/glasses/better
	name = "Modern Glasses"
	item_path = /obj/item/clothing/glasses/regular/modern
	can_be_reskinned = TRUE
	group = "Prescription"

/datum/loadout_item/glasses/thin
	name = "Thin-Framed Glasses"
	item_path = /obj/item/clothing/glasses/regular/thin
	group = "Prescription"

/*
*	Eyepatches/Blindfolds
*/

/datum/loadout_item/glasses/white_eyepatch
	name = "Eyepatch (White)"
	item_path = /obj/item/clothing/glasses/eyepatch/white

/datum/loadout_item/glasses/medical_eyepatch
	name = "Eyepatch - Medical"
	item_path = /obj/item/clothing/glasses/eyepatch/medical

/datum/loadout_item/glasses/eyewrap
	name = "Eyepatch - Wrap"
	item_path = /obj/item/clothing/glasses/eyepatch/wrap

/datum/loadout_item/glasses/blindfold
	name = "Blindfold"
	item_path = /obj/item/clothing/glasses/blindfold

/datum/loadout_item/glasses/blindfold/color
	name = "Blindfold - Blind Personnel"
	item_path = /obj/item/clothing/glasses/blindfold/color

/datum/loadout_item/glasses/fakeblindfold
	name = "Blindfold - Fake"
	item_path = /obj/item/clothing/glasses/trickblindfold

/datum/loadout_item/glasses/obsoleteblindfold
	name = "Blindfold - Obselete HUD"
	item_path = /obj/item/clothing/glasses/trickblindfold/obsolete

/*
 *	JOB-LOCKED
*/

//Diagnostic
/datum/loadout_item/glasses/robopatch
	name = "Diagnostic HUD - Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/diagnostic
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENCE_GUARD)
	group = "Job-Locked"

/datum/loadout_item/glasses/diaghud_glasses
	name = "Diagnostic HUD - Prescription"
	item_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR,JOB_SCIENTIST, JOB_ROBOTICIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/prescription_aviator_diagnostic
	name = "Diagnostic HUD - Prescription Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/aviator_diagnostic
	name = "Diagnostic HUD - Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/retinal_projector_diagnostic
	name = "Diagnostic HUD - Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)
	group = "Job-Locked"

//Medical
/datum/loadout_item/glasses/medicpatch
	name = "Medical HUD - Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/med
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)
	group = "Job-Locked"

/datum/loadout_item/glasses/medhud_glasses
	name = "Medical HUD - Prescription"
	item_path = /obj/item/clothing/glasses/hud/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)
	group = "Job-Locked"

/datum/loadout_item/glasses/prescription_aviator_health
	name = "Medical HUD - Prescription Sunglassess"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)
	group = "Job-Locked"

/datum/loadout_item/glasses/aviator_health
	name = "Medical HUD - Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)
	group = "Job-Locked"

/datum/loadout_item/glasses/retinal_projector_health
	name = "Medical HUD - Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)
	group = "Job-Locked"

//Meson
/datum/loadout_item/glasses/mesonpatch
	name = "Meson HUD - Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)
	group = "Job-Locked"

/datum/loadout_item/glasses/meson_prescription
	name = "Meson HUD - Prescription"
	item_path = /obj/item/clothing/glasses/meson/prescription
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)
	group = "Job-Locked"

/datum/loadout_item/glasses/prescription_aviator_meson
	name = "Meson HUD - Prescription Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)
	group = "Job-Locked"

/datum/loadout_item/glasses/aviator_meson
	name = "Meson HUD - Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)
	group = "Job-Locked"

/datum/loadout_item/glasses/retinal_projector_meson
	name = "Meson HUD - Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)
	group = "Job-Locked"

//Science
/datum/loadout_item/glasses/scipatch
	name = "Science HUD - Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sci
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD, JOB_VIROLOGIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/science_glasses
	name = "Science HUD - Prescription"
	item_path = /obj/item/clothing/glasses/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD, JOB_VIROLOGIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/prescription_aviator_science
	name = "Science HUD - Prescription Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD, JOB_VIROLOGIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/aviator_science
	name = "Science HUD - Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD, JOB_VIROLOGIST)
	group = "Job-Locked"

/datum/loadout_item/glasses/retinal_projector_science
	name = "Science HUD - Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD, JOB_VIROLOGIST)
	group = "Job-Locked"

//Security
/datum/loadout_item/glasses/sechud
	name = "Security HUD"
	item_path = /obj/item/clothing/glasses/hud/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/glasses/secpatch
	name = "Security HUD - Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/glasses/sechud_glasses
	name = "Security HUD - Prescription"
	item_path = /obj/item/clothing/glasses/hud/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/glasses/prescription_aviator_security
	name = "Security HUD - Prescription Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/glasses/aviator_security
	name = "Security HUD - Sunglasses"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/glasses/sechud_sunglasses_blue
	name = "Security HUD - Sunglasses (Blue)"
	item_path = /obj/item/clothing/glasses/hud/security/sunglasses/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/glasses/retinal_projector_security
	name = "Security HUD - Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD, JOB_DETECTIVE)
	group = "Job-Locked"

/*
 *	DONATOR
 */

/datum/loadout_item/glasses/donator
	abstract_type = /datum/loadout_item/glasses/donator
	donator_only = TRUE

/datum/loadout_item/glasses/donator/fake_sunglasses
	name = "Fake Sunglasses"
	item_path = /obj/item/clothing/glasses/fake_sunglasses
