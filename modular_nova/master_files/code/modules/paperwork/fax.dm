// Overrides Fax special networks to be relevant to each team
/obj/machinery/fax/Initialize(mapload)
	special_networks["syndicate"]["fax_name"] = "Syndicate Sectorial Command"
	special_networks += list(
		tarkon = list(fax_name = "Tarkon Industries Corporate Command", fax_id = "tarkon", color = "brown", emag_needed = TRUE),
		interdyne = list(fax_name = "Interdyne Legal Department", fax_id = "interdyne", color = "green", emag_needed = TRUE),
	)
	return ..()

/obj/machinery/fax/interdyne
	fax_name = "Interdyne Pharmaceuticals";
	name = "Interdyne Fax Machine";
	req_access = list("syndicate");
	syndicate_network = 1

/obj/machinery/fax/interdyne/Initialize(mapload)
	. = ..()
	special_networks -= list("tarkon", "syndicate")

/obj/machinery/fax/tarkon
	fax_name = "Tarkon Industries";
	name = "Tarkon Fax Machine";
	req_access = list("syndicate");
	syndicate_network = 1

/obj/machinery/fax/tarkon/Initialize(mapload)
	. = ..()
	special_networks -= list("interdyne", "syndicate")
