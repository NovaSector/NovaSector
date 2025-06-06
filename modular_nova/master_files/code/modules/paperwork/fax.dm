// Overrides Fax special networks to be relevant to each team
/obj/machinery/fax/Initialize(mapload)
	special_networks["syndicate"]["fax_name"] = "Syndicate Sectorial Command"
	special_networks += list(
		tarkon = list(fax_name = "Syndicate Sectorial Command", fax_id = "tarkon", color = "red", emag_needed = TRUE),
		interdyne = list(fax_name = "Interdyne Legal Department", fax_id = "interdyne", color = "green", emag_needed = TRUE),
	)
	return ..()
