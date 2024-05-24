// MODULAR ID TRIM ACCESS OVERRIDES GO HERE!!

//(Most) of Security has inverted IDs, with custom blue-on-black icons. This is to distinguish them from their head, who has a white-on-blue icon
/datum/id_trim/job/head_of_security
	subdepartment_color = COLOR_ASSEMBLY_BLACK

/datum/id_trim/job/warden
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_ASSEMBLY_BLACK

/datum/id_trim/job/security_officer
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_ASSEMBLY_BLACK

/datum/id_trim/job/detective
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_ASSEMBLY_BLACK


/datum/id_trim/job/chief_engineer/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS

/datum/id_trim/job/atmospheric_technician/New()
	. = ..()

	minimal_access |= ACCESS_ENGINE_EQUIP

/datum/id_trim/job/chief_medical_officer/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS

/datum/id_trim/job/research_director/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS


/datum/id_trim/job/head_of_personnel/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS

/datum/id_trim/fakecentcom
    access = list(ACCESS_CENT_GENERAL)
    assignment = JOB_CENTCOM
    trim_state = "trim_centcom"
    sechud_icon_state = SECHUD_CENTCOM
    department_color = COLOR_CENTCOM_BLUE
    subdepartment_color = COLOR_CENTCOM_BLUE

/datum/id_trim/job/blueshield
	assignment = "Blueshield"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CENTCOM_BLUE // Not the other way around. I think.
	sechud_icon_state = SECHUD_BLUESHIELD
	extra_access = list(ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_GATEWAY, ACCESS_VAULT)
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_CAPTAIN, ACCESS_CARGO, ACCESS_COMMAND, ACCESS_CONSTRUCTION,
		ACCESS_MAINT_TUNNELS, ACCESS_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_TELEPORTER, ACCESS_RC_ANNOUNCE, ACCESS_RESEARCH,
		ACCESS_SCIENCE, ACCESS_WEAPONS
	)
	minimal_wildcard_access = list(ACCESS_CENT_GENERAL, ACCESS_COMMAND)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS)

/datum/id_trim/job/nanotrasen_consultant
	assignment = "Nanotrasen Consultant"
	trim_state = "trim_centcom"
	department_color = COLOR_GREEN
	subdepartment_color = COLOR_GREEN
	sechud_icon_state = SECHUD_NT_CONSULTANT
	extra_access = list(ACCESS_AI_UPLOAD, ACCESS_VAULT)
	minimal_access = list(
				ACCESS_BRIG_ENTRANCE, ACCESS_CAPTAIN, ACCESS_CENT_GENERAL, ACCESS_COMMAND, ACCESS_COURT,
				ACCESS_CONSTRUCTION, ACCESS_EVA, ACCESS_GATEWAY, ACCESS_KEYCARD_AUTH, ACCESS_LAWYER, ACCESS_MAINT_TUNNELS,
				ACCESS_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_RC_ANNOUNCE, ACCESS_SERVICE, ACCESS_SCIENCE, ACCESS_RESEARCH,
				ACCESS_TELEPORTER, ACCESS_WEAPONS
				)
	minimal_wildcard_access = list(ACCESS_CENT_GENERAL, ACCESS_COMMAND)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS)

/datum/id_trim/job/corrections_officer
	assignment = "Corrections Officer"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_corrections_officer"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_ASSEMBLY_BLACK
	sechud_icon_state = SECHUD_CORRECTIONS_OFFICER
	extra_access = list()
	minimal_access = list(
				ACCESS_BRIG, ACCESS_BRIG_ENTRANCE, ACCESS_COURT,
				ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_WEAPONS
				)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS, ACCESS_HOS)
	job = /datum/job/corrections_officer

/datum/id_trim/job/barber
	assignment = "Barber"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_barber"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME
	sechud_icon_state = SECHUD_BARBER
	extra_access = list()
	minimal_access = list(ACCESS_BARBER, ACCESS_MAINT_TUNNELS, ACCESS_SERVICE, ACCESS_THEATRE)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS, ACCESS_HOP)
	job = /datum/job/barber

/datum/id_trim/job/virologist
	assignment = "Virologist"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_virologist"
	department_color = COLOR_MEDICAL_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_VIROLOGIST
	minimal_access = list(
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_VIROLOGY,
		ACCESS_PHARMACY,
		)
	extra_access = list(
		ACCESS_PLUMBING,
		ACCESS_MORGUE,
		ACCESS_SURGERY,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_CMO,
		)
	job = /datum/job/virologist
