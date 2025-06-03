// Overrides Fax special networks to be relevant to each team
/obj/machinery/fax/Initialize(mapload)
	special_networks = list(
		nanotrasen = list(fax_name = "NT HR Department", fax_id = "central_command", color = "teal", emag_needed = FALSE),
		tarkon = list(fax_name = "Syndicate Sectorial Command", fax_id = "tarkon", color = "red", emag_needed = TRUE),
		interdyne = list(fax_name = "Interdyne Legal Department", fax_id = "interdyne", color = "green", emag_needed = TRUE),
	)
	return ..()
