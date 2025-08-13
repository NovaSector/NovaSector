/datum/random_ship_event/john_starsector
	name = "John Starsector Ship"

	ship_template_id = "default"
	ship_name_pool = "john_starsector_names"

	message_title = "Starship Approach"
	message_content = "Greetings, this is Captain John Starsector of the %SHIPNAME. We're on a peaceful exploration mission and would like to request permission to dock at your station."
	arrival_announcement = "Thank you for the warm welcome. We're preparing to dock now."
	possible_answers = list("Permission granted, you may dock.", "Permission denied, stay away.")

	response_accepted = "Much appreciated! We're eager to share our discoveries with you."
	response_rejected = "Understood. We'll continue our journey elsewhere. Safe travels to you."

	announcement_color = "cyan"
