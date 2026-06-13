// Overrides Fax special networks to be relevant to each team
/obj/machinery/fax/Initialize(mapload)
	special_networks["syndicate"]["fax_name"] = "Syndicate Sectorial Command"
	special_networks += list(
		tarkon = list(fax_name = "Tarkon Industries Corporate Command", fax_id = "tarkon", color = "brown", emag_needed = TRUE),
		interdyne = list(fax_name = "Interdyne Legal Department", fax_id = "interdyne", color = "green", emag_needed = TRUE),
		sol_fed = list(fax_name = "Sol Federation Local Command Team", fax_id = "sol_fed", color = "blue", emag_needed = FALSE),
		clowns = list(fax_name = "Clown Planet", fax_id = "clowns", color = "pink", emag_needed = FALSE),
		mimes = list(fax_name = "La Pantomime Troupe", fax_id = "mimes", color = "white", emag_needed = FALSE),
		trade_union = list(fax_name = "Free Trade Union Local Office", fax_id = "trade_union", color = "brown", emag_needed = FALSE),
		void = list(fax_name = "Void Imperium", fax_id = "void", color = "purple", emag_needed = FALSE),
		helio = list(fax_name = "Heliostatic Coalition", fax_id = "helio", color = "red", emag_needed = FALSE),
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
	syndicate_network = 0

/obj/machinery/fax/tarkon/Initialize(mapload)
	. = ..()
	special_networks -= list("interdyne", "syndicate")
