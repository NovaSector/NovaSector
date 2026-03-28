// NOVA MODULE IC-SPAWNING https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
//Bluespace Tech bits
/obj/item/card/id/advanced/debug/bst
	name = "\improper Bluespace ID"
	desc = "A Bluespace ID card. Has ALL the all access, you really shouldn't have this."
	icon_state = "card_platinum"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/admin/bst
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/datum/id_trim/admin/bst
	assignment = "Bluespace Technician"
	trim_state = "trim_stationengineer"
	department_color = COLOR_CENTCOM_BLUE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_SCRAMBLED

//Subspace Tech bits
/obj/item/card/id/advanced/debug/sst
	name = "\improper Subspace ID"
	desc = "A Subspace ID card. Has ALL the all access, you really shouldn't have this."
	icon_state = "card_carp"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/admin/sst
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/datum/id_trim/admin/sst
	assignment = "Subspace Technician"
	trim_state = "trim_ert_commander"
	department_color = COLOR_CENTCOM_BLUE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_SCRAMBLED

//Additional admin ID stuff
/obj/item/card/id/advanced/debug/centcomm
	name = "\improper CentComm Master ID"
	desc = "A Master ID card from Central Command. Has ALL the all access, to a suspicious degree."
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/admin/centcomm
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/datum/id_trim/admin/centcomm
	assignment = "Central Command"
	trim_state = "trim_centcomm"
	department_color = COLOR_CENTCOM_BLUE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_SCRAMBLED
