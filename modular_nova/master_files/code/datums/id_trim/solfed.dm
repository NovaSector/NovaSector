/datum/outfit/solfed/post_equip(mob/living/carbon/human/agent)
	agent.faction |= FACTION_SOLFED
	return ..()

/datum/id_trim/solfed/espatier/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/solfed
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "SolFed"
	trim_state = "trim_solfed"
	department_color = COLOR_SOLFED_GOLD
	subdepartment_color = COLOR_SOLFED_GOLD
	sechud_icon_state = SECHUD_SOLFED
	threat_modifier = -5 // Solfed Count as a police force
	big_pointer = TRUE
	pointer_color = COLOR_SOLFED_GOLD

/// Lets be real if the ERT variant of these guys are coming, ya'll are cooked
/datum/id_trim/solfed/espatier
	assignment = "SolFed Espatier"
	threat_modifier = -10 // This counts as military intervention
	trim_state = "trim_solfed_espatier"
	sechud_icon_state = SECHUD_SOLFED_ESPATIER

/datum/id_trim/solfed/espatier/engineer
	assignment = "SolFed Espatier Combat Engineer"
	trim_state = "trim_solfed_engineer"
	sechud_icon_state = SECHUD_SOLFED_ENGINEER

/datum/id_trim/solfed/espatier/corpsman
	assignment = "SolFed Espatier Combat Medic"
	trim_state = "trim_solfed_medic"
	sechud_icon_state = SECHUD_SOLFED_MEDIC

/datum/id_trim/solfed/espatier/squadleader
	assignment = "SolFed Espatier Squad Leader"
	trim_state = "trim_solfed_espatier_gold"
	sechud_icon_state = SECHUD_SOLFED_SQUADLEADER

/datum/id_trim/solfed/espatier/smartgunner
	assignment = "SolFed Espatier Smart Gunner"
	trim_state = "trim_solfed_specialist"
	sechud_icon_state = SECHUD_SOLFED_SMARTGUNNER

/datum/id_trim/solfed/espatier/specialist
	assignment = "SolFed Espatier Combat Specialist"
	trim_state = "trim_solfed_smartgun"
	sechud_icon_state = SECHUD_SOLFED_SPECIALIST

/datum/id_trim/solfed/espatier/odst
	assignment = "SolFed Orbital Drop Trooper"
	trim_state = "trim_solfed_odst"
	sechud_icon_state = SECHUD_SOLFED_ODST

/datum/id_trim/solfed/espatier/commando
	assignment = "SolFed Commando"
	trim_state = "trim_solfed_commandos"
	sechud_icon_state = SECHUD_SOLFED_COMMANDO

/// This is the Soft ERT variant of the solfed Officials
/datum/id_trim/solfed/official
	assignment = "SolFed Official"
	sechud_icon_state = SECHUD_SOLFED_LIASON

/datum/id_trim/solfed/official/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/solfed/official/gold
	trim_state = "trim_solfed_gold"

/datum/id_trim/solfed/official/ensign
	assignment = "SolFed Ensign"
	trim_state = "trim_solfed_official_ensign"
	honorifics = list("Ensign")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/official/lieutenant
	assignment = "SolFed Lieutenant"
	trim_state = "trim_solfed_official_lieutenant"
	honorifics = list("Lieutenant")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/official/commander
	assignment = "SolFed Commander"
	trim_state = "trim_solfed_official_commander"
	honorifics = list("Commander")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/official/captain
	assignment = "SolFed Captain"
	trim_state = "trim_solfed_official_captain"
	honorifics = list("Captain")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/official/admiral
	assignment = "SolFed Admiral"
	trim_state = "trim_solfed_official_admiral"
	honorifics = list("Admiral")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/police
	assignment = "SolFed Police"
	trim_state = "trim_solfed_police"
	sechud_icon_state = SECHUD_SOLFED_MARSHALS
	honorifics = list("Officer")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/police/New()
	. = ..()
	access = list(
		ACCESS_BRIG,
		ACCESS_SECURITY,
		ACCESS_SERVICE,
		ACCESS_RESEARCH,
		ACCESS_MEDICAL,
		ACCESS_COMMAND,
		ACCESS_SCIENCE,
		ACCESS_ENGINEERING,
		ACCESS_CARGO,
		ACCESS_EVA,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINISAT,
		ACCESS_TECH_STORAGE,
		ACCESS_TELEPORTER,
		)

/datum/id_trim/solfed/med
	assignment = "SolFed Paramedic"
	trim_state = "trim_solfed_medic"
	sechud_icon_state = SECHUD_SOLFED_MEDIC
	honorifics = list("Dr.","Nurse")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/med/New()
	. = ..()
	access = list(
		ACCESS_BIT_DEN,
		ACCESS_CARGO,
		ACCESS_CONSTRUCTION,
		ACCESS_HYDROPONICS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_PHARMACY,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_MORGUE,
		ACCESS_SCIENCE,
		ACCESS_SERVICE,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_PLUMBING,
		ACCESS_COMMAND,
		ACCESS_EVA,
	)

/datum/id_trim/solfed/atmos
	assignment = "SolFed Emergency Atmospherics Technician"
	trim_state = "trim_solfed_engineer"
	sechud_icon_state = SECHUD_SOLFED_ENGINEER
	honorifics = list("Technician","Engineer")
	honorific_positions = HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_NONE

/datum/id_trim/solfed/atmos/New()
	. = ..()
	access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_COMMAND,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EVA,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_ENGINE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINISAT,
		ACCESS_RC_ANNOUNCE,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_TELEPORTER,
		)

/datum/id_trim/solgov/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/solfed/liasion
	assignment = "SolFed Liasion"
	sechud_icon_state = SECHUD_SOLFED_LIASON

/datum/id_trim/space_police // Overrides the normal /tg/ ERTSEC Icon, these guys aren't NT!
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_spacepolice"
	department_color = COLOR_CENTCOM_BLUE // why did these guys get this but the other modular id trims didn't. what
	subdepartment_color = COLOR_SECURITY_RED
	sechud_icon_state = SECHUD_SPACE_POLICE
