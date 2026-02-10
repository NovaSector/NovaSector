/// SYNDICATE ID TRIMS
/datum/id_trim/syndicom/nova

// Note: These two are only left here because of the old Cybersun code.
/datum/id_trim/syndicom/nova/crew
	assignment = "Syndicate Operative"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/datum/id_trim/syndicom/nova/captain
	assignment = "Syndicate Ship Captain"
	trim_state = "trim_captain"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/// DS-2

/datum/id_trim/syndicom/nova/ds2
	assignment = "DS-2 Operative"
	trim_state = "trim_unknown"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_SYNDIE_RED
	threat_modifier = 5 // Matching the syndicate threat level since DS2 is a syndicate station.

/datum/id_trim/syndicom/nova/ds2/prisoner
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi' // I can't put this on the basetype AAAAAA
	assignment = "DS-2 Hostage"
	trim_state = "trim_ds2prisoner"
	subdepartment_color = COLOR_MAROON
	sechud_icon_state = SECHUD_DS2_PRISONER

/datum/id_trim/syndicom/nova/ds2/miner
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Mining Officer"
	trim_state = "trim_ds2miningofficer"
	sechud_icon_state = SECHUD_DS2_MININGOFFICER
	honorifics = list("Lieutenant", "Mining Officer")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/syndicatestaff
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 General Staff"
	trim_state = "trim_ds2generalstaff"
	sechud_icon_state = SECHUD_DS2_GENSTAFF
	honorifics = list("Cook", "Janitor", "Private", "Assistant", "Chef")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/researcher
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Researcher"
	trim_state = "trim_ds2researcher"
	sechud_icon_state = SECHUD_DS2_RESEARCHER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)
	honorifics = list("Researcher", "Doctor")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/enginetechnician
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Engine Technician"
	trim_state = "trim_ds2enginetech"
	sechud_icon_state = SECHUD_DS2_ENGINETECH
	honorifics = list("Engineer", "Technician")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/medicalofficer
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Medical Officer"
	trim_state = "trim_ds2medicalofficer"
	sechud_icon_state = SECHUD_DS2_DOCTOR
	honorifics = list("MD.","Dr.","Nurse")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/masteratarms
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Master At Arms"
	trim_state = "trim_ds2masteratarms"
	sechud_icon_state = SECHUD_DS2_MASTERATARMS
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)
	honorifics = list("M.A.A","Lieutenant","Senior Officer")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/brigofficer
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Brig Officer"
	trim_state = "trim_ds2brigofficer"
	sechud_icon_state = SECHUD_DS2_BRIGOFFICER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)
	honorifics = list("Officer","Corporal","Peacekeeper")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/corporateliasion // DS2 HoP
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Corporate Liaison"
	trim_state = "trim_ds2corporateliaison"
	sechud_icon_state = SECHUD_DS2_CORPLIAISON
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)
	honorifics = list("Liason","Representative","Administrator")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/id_trim/syndicom/nova/ds2/stationadmiral
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Admiral"
	trim_state = "trim_ds2admiral"
	sechud_icon_state = SECHUD_DS2_ADMIRAL
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)
	honorifics = list("Admiral","Captain","Director")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/// Interdyne

/datum/id_trim/syndicom/nova/interdyne
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "Interdyne Scientist"
	trim_state = "trim_interdyne"
	sechud_icon_state = SECHUD_INTERDYNE_CREW
	department_color = COLOR_LIME
	subdepartment_color = COLOR_VERY_DARK_LIME_GREEN
	threat_modifier = 2 // Interdyne is allowed on station, so this'll get beepskys off them.

/datum/id_trim/syndicom/nova/interdyne/shaftminer
	assignment = "Interdyne Shaft Miner"
	sechud_icon_state = SECHUD_INTERDYNE_SHAFTMINER
	department_color = COLOR_CARGO_BROWN

/datum/id_trim/syndicom/nova/interdyne/deckofficer
	assignment = "Deck Officer"
	trim_state = "trim_deckofficer"
	sechud_icon_state = SECHUD_INTERDYNE_DECKOFFICER
	department_color = COLOR_VERY_DARK_LIME_GREEN
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)
