/datum/pirate_gang/tiders
	name = "Tidy Tiders"

	ship_template_id = "tiders"
	ship_name_pool = "rogue_names"

	threat_title = "Sector protection offer"
	threat_content = "Hey, everyone. We REALLY need %PAYOFF credits wired in order to maintain \
		our quality of life here aboard the %SHIPNAME.  \
		It'd be REALLY awesome if you handed over said funds. We wouldn't want to get off \
		on the wrong foot, would we?"
	arrival_announcement = "Too late now. We're coming over, whether you like it or not."
	possible_answers = list("Sure, we'll help.","Go beg somewhere else.")

	response_received = "This will do well. Thank you!"
	response_rejected = "Eh, wait, you don't want to pay us? That's ok, we're coming over then."
	response_too_late = "Shouldn't have ignored us. You'll be seeing us soon."
	response_not_enough = "Hey.. This isn't enough! That's okay though, we'll be coming over to settle this soon."
