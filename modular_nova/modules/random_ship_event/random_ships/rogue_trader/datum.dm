/datum/random_ship_event/rogue_ship
	name = "Rogue Trader Ship"

	ship_template_id = "default"
	ship_name_pool = "rogue_trader_names"

	message_title = "Trade Request"
	message_content = "Hey, this is the %SHIPNAME. We're a group of independent traders looking to do business with your station. May we approach and dock?"
	arrival_announcement = "Thank you for your hospitality. We're preparing to dock now."
	possible_answers = list("Permission granted, you may dock.", "Permission denied, stay away.")

	response_accepted = "Thank you for your cooperation. We look forward to profitable trade."
	response_rejected = "Understood. We'll take our business elsewhere."

	announcement_color = "green"
