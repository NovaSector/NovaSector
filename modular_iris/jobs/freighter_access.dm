#define ACCESS_FREIGHTER_GENERAL "freighter_general"
#define ACCESS_FREIGHTER_COMMAND "freighter_command"

/datum/id_trim/away/freighter
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	access = list(ACCESS_FREIGHTER_GENERAL, ACCESS_MINERAL_STOREROOM, ACCESS_MECH_SCIENCE)

/datum/id_trim/away/freighter/cargo
	assignment = "Johnson & Co Deckhand"
	trim_state = "trim_cargotechnician"
	sechud_icon_state = SECHUD_FREIGHTER_CARGO

/datum/outfit/freighter_crew
	id_trim = /datum/id_trim/away/freighter/cargo

/datum/id_trim/away/freighter/miner
	assignment = "Johnson & Co Excavator"
	trim_state = "trim_shaftminer"
	sechud_icon_state = SECHUD_FREIGHTER_MINER

/datum/outfit/freighter_excavator
	id_trim = /datum/id_trim/away/freighter/miner

/datum/id_trim/away/freighter/foreman
	assignment = "Johnson & Co Foreman"
	trim_state = "trim_captain"
	sechud_icon_state = SECHUD_FREIGHTER_FOREMAN
	access = list(ACCESS_FREIGHTER_GENERAL, ACCESS_MINERAL_STOREROOM, ACCESS_MECH_SCIENCE, ACCESS_FREIGHTER_COMMAND)
	big_pointer = TRUE

/datum/outfit/freighter_boss
	id_trim = /datum/id_trim/away/freighter/foreman



/obj/effect/mapping_helpers/airlock/access/all/freighter/general/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_FREIGHTER_GENERAL
	return access_list

/obj/effect/mapping_helpers/airlock/access/all/freighter/command/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_FREIGHTER_COMMAND
	return access_list
