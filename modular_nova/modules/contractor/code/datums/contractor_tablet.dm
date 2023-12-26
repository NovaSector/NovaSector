/datum/computer_file/program/contract_uplink
	downloader_category = PROGRAM_CATEGORY_EQUIPMENT
	tgui_id = "SyndContractor"
	/// If the contract uplink's been assigned to a person yet
	var/assigned = FALSE

/datum/computer_file/program/contract_uplink/on_start(mob/living/user)
	. = ..(user)
