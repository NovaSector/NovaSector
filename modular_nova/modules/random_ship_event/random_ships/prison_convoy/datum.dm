/datum/random_ship_event/prison_convoy
	name = "SolFed Prison Convoy"

	ship_template_id = "prison_ship"
	ship_name_pool = "solfed_names"

	message_title = "SolFed Correctional Transport"
	message_content = "Attention station personnel. This is the %SHIPNAME, SolFed Correctional Transport. We are transporting high-risk prisoners and require an emergency docking bay for prisoner transfer and maintenance."
	arrival_announcement = "Docking sequence initiated. All personnel are advised to clear the docking area."
	possible_answers = list("Permission granted, you may dock.", "Permission denied, we cannot accommodate a prison convoy.")

	response_accepted = "Acknowledged. Prepare for prisoner transfer protocols. Station security is requested to meet us at the docking bay."
	response_rejected = "Negative. This is a SolFed priority transport. We are invoking emergency protocol Alpha-7 and docking anyway. Stand by."

	announcement_color = "red"
