/obj/item/card/id/advanced/centcom/ert/nri
	name = "\improper HC ID"
	desc = "An ID straight from the HC."
	icon_state = "card_black"
	assigned_icon_state = "assigned_centcom"

/datum/id_trim/nri
	assignment = "HC Soldier"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri"
	threat_modifier = 2 // Matching the nri_police threat modifier

/datum/id_trim/nri/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))


/datum/id_trim/nri/commander
	assignment = "HC Platoon Commander"
	trim_state = "trim_nri_commander"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri_commander"

/datum/id_trim/nri/heavy
	assignment = "HC Heavy Soldier"

/datum/id_trim/nri/medic
	assignment = "HC Corpsman"

/datum/id_trim/nri/engineer
	assignment = "HC Combat Engineer"

/datum/id_trim/nri/diplomat
	assignment = "HC Diplomat"
	trim_state = "trim_nri_commander"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri_commander"

/datum/id_trim/nri/diplomat/major
	assignment = "HC Major"

/datum/id_trim/nri/diplomat/scientist
	assignment = "HC Research Inspector"

/datum/id_trim/nri/diplomat/doctor
	assignment = "HC Medical Inspector"
