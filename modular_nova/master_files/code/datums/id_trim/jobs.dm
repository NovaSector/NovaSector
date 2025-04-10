// MODULAR ID TRIM ACCESS OVERRIDES GO HERE!!

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

/datum/id_trim/job/blueshield
	assignment = "Blueshield"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CENTCOM_BLUE // Not the other way around. I think.
	sechud_icon_state = SECHUD_BLUESHIELD
	extra_access = list(
		ACCESS_BRIG,
		ACCESS_CARGO,
		ACCESS_COURT,
		ACCESS_GATEWAY,
		ACCESS_SECURITY,
	)
	minimal_access = list(
		ACCESS_ALL_PERSONAL_LOCKERS,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CENT_GENERAL,
		ACCESS_COMMAND,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_EVA,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SCIENCE,
		ACCESS_TELEPORTER,
		ACCESS_WEAPONS,
		ACCESS_CAPTAIN,
	)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
	)
	job = /datum/job/blueshield

/datum/id_trim/job/nanotrasen_consultant
	assignment = "Nanotrasen Consultant"
	trim_state = "trim_centcom"
	department_color = COLOR_GREEN
	subdepartment_color = COLOR_GREEN
	sechud_icon_state = SECHUD_NT_CONSULTANT
	extra_access = list()
	minimal_access = list(
		ACCESS_AI_UPLOAD,
		ACCESS_ALL_PERSONAL_LOCKERS,
		ACCESS_AUX_BASE,
		ACCESS_BAR,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CENT_GENERAL,
		ACCESS_CHAPEL_OFFICE,
		ACCESS_COMMAND,
		ACCESS_CONSTRUCTION,
		ACCESS_CREMATORIUM,
		ACCESS_COURT,
		ACCESS_ENGINEERING,
		ACCESS_EVA,
		ACCESS_GATEWAY,
		ACCESS_HOP,
		ACCESS_HYDROPONICS,
		ACCESS_JANITOR,
		ACCESS_KEYCARD_AUTH,
		ACCESS_KITCHEN,
		ACCESS_LAWYER,
		ACCESS_LIBRARY,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MEDICAL,
		ACCESS_MECH_ENGINE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MECH_SCIENCE,
		ACCESS_MECH_SECURITY,
		ACCESS_MINING_STATION,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PSYCHOLOGY,
		ACCESS_RC_ANNOUNCE,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TELEPORTER,
		ACCESS_THEATRE,
		ACCESS_VAULT,
		ACCESS_WEAPONS,
		ACCESS_CAPTAIN,
	)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
	)
	job = /datum/job/nanotrasen_consultant

/datum/id_trim/job/corrections_officer
	assignment = "Corrections Officer"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_corrections_officer"
	department_color = COLOR_SECURITY_RED
	subdepartment_color = COLOR_SECURITY_RED
	sechud_icon_state = SECHUD_CORRECTIONS_OFFICER
	extra_access = list()
	minimal_access = list(
		ACCESS_BRIG,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_COURT,
		ACCESS_MAINT_TUNNELS,
		ACCESS_SECURITY,
		ACCESS_WEAPONS,
	)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_HOS,
	)
	job = /datum/job/corrections_officer

/datum/id_trim/job/barber
	assignment = "Barber"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_barber"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME
	sechud_icon_state = SECHUD_BARBER
	extra_access = list()
	minimal_access = list(
		ACCESS_BARBER,
		ACCESS_MAINT_TUNNELS,
		ACCESS_SERVICE,
		ACCESS_THEATRE,
	)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_HOP,
	)
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
