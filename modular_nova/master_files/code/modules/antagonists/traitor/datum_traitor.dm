/datum/antagonist/traitor/roundend_report()
	var/list/result = list()

	var/traitor_won = TRUE

	result += printplayer(owner)

	var/used_telecrystals = 0
	var/uplink_owned = FALSE
	var/purchases = ""

	LAZYINITLIST(GLOB.uplink_purchase_logs_by_key)
	// Uplinks add an entry to uplink_purchase_logs_by_key on init.
	var/datum/uplink_purchase_log/purchase_log = GLOB.uplink_purchase_logs_by_key[owner.key]
	if(purchase_log)
		used_telecrystals = purchase_log.total_spent
		uplink_owned = TRUE
		purchases += purchase_log.generate_render(FALSE)

	var/objectives_text = ""
	if(objectives.len) //If the traitor had no objectives, don't need to process this.
		var/count = 1
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				traitor_won = FALSE
			objectives_text += "<br><B>Objective #[count]</B>: [objective.explanation_text] [objective.get_roundend_success_suffix()]"
			count++

	result += "<br>[owner.name] <B>[traitor_flavor["roundend_report"]]</B>"

	if(uplink_owned)
		var/uplink_text = "(used [used_telecrystals] TC) [purchases]"
		if((used_telecrystals == 0) && traitor_won)
			var/static/icon/badass = icon('icons/ui/antags/badass.dmi', "badass")
			uplink_text += "<BIG>[icon2html(badass, world)]</BIG>"
		result += uplink_text

	result += objectives_text

	if(uplink_handler && uplink_handler.contractor_hub)
		result += contractor_round_end()

	return result.Join("<br>")
