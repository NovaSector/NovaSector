/datum/computer_file/program/contract_uplink
	category = PROGRAM_CATEGORY_MISC
	tgui_id = "SyndContractor"
	/// If the contract uplink's been assigned to a person yet
	var/assigned = FALSE

/datum/computer_file/program/contract_uplink/on_start(mob/living/user)
	. = ..(user)
