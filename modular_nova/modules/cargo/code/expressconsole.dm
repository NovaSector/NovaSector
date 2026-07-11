/obj/item/circuitboard/computer/cargo/express/ghost
	name = "Soar Industries Express Delivery Console"
	build_path = /obj/machinery/computer/cargo/express/ghost
	contraband = TRUE

/obj/machinery/computer/cargo/express/ghost
	name = "\improper Soar Industries Express Delivery Console"
	desc = "A Standard express delivery console, preloaded with a specialized protocol by SOAR Industries. Allowing it to access specialized companies."
	abstract_type = /obj/machinery/computer/cargo/express/ghost
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_CIV /// Change this later to something else, as this is meant to prevent runtiming
	contraband = TRUE
	bypass_express_lock = TRUE
	console_flag = CARGO_CONSOLE_PDA

	pod_type = /obj/structure/closet/supplypod/bluespacepod

/obj/machinery/computer/cargo/express/ghost/Initialize(mapload)
	. = ..()
	if(type == abstract_type) // These are not meant to be spawned
		return INITIALIZE_HINT_QDEL

/obj/machinery/computer/cargo/express/ghost/on_construction(mob/user)
	. = ..()
	/// Should report the player that built the console to the admins, in case anything fucky happens.
	message_admins("[ADMIN_LOOKUPFLW(usr)] Has built a ghost role express console ([src.name]) at [AREACOORD(src)].")

/obj/machinery/computer/cargo/express/ghost/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("You try to change the routing protocols, but the [src.name] displays a runtime error and reboots!"))
	return FALSE //never let this console be emagged

/obj/machinery/computer/cargo/express/ghost/ui_act(action, params, datum/tgui/ui)
	if(action == "add") // if we're generating a supply order
		if (!beacon || !using_beacon ) // checks if using a beacon or not.
			say("Error! Destination is not whitelisted, aborting.")
			return
	return ..()

//Interdyne Pharmaceuticals Console's console
/obj/item/circuitboard/computer/cargo/express/ghost/interdyne
	name = "Interdyne Express Supply Console"
	greyscale_colors = COLOR_PRIDE_GREEN
	build_path = /obj/machinery/computer/cargo/express/ghost/interdyne

/obj/machinery/computer/cargo/express/ghost/interdyne
	name = "\improper Interdyne Express Supply Console"
	desc = "A specialized Interdyne Pharmaceuticals console, allowing for deepspace communication with a specialized drop pod railgun for precise and accurate \
		deliveries, no matter how remote they are located"
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost/interdyne
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_INT
	console_flag = CARGO_CONSOLE_INTERDYNE

//Deep Space 2's console
/obj/item/circuitboard/computer/cargo/express/ghost/syndicate
	name = "Syndicate Express Supply Console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/cargo/express/ghost/syndicate

/obj/machinery/computer/cargo/express/ghost/syndicate
	name = "\improper Syndicate Express Supply Console"
	desc = "A specialized Syndicate Express Supply Console, synced with a deepspace syndicate storage satellite, armed with a drop pod railgun for precise and accurate \
		deliveries over long distances, no matter how remote they are located."
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost/syndicate
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_DS2
	console_flag = CARGO_CONSOLE_DS2

// Tarkon Industries console
/obj/item/circuitboard/computer/cargo/express/ghost/tarkon
	name = "Tarkon Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express/ghost/tarkon
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING

/obj/machinery/computer/cargo/express/ghost/tarkon
	name = "\improper Tarkon Express Supply Console"
	desc = "A specialized Tarkon Industries Express Supply Console, synced a deepspace storage satellite, armed with a drop pod railgun for precise and accurate \
		deliveries over long distances, no matter how remote they are located."
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost/tarkon
	req_access = list(ACCESS_TARKON)
	cargo_account = ACCOUNT_TI
	console_flag = CARGO_CONSOLE_TARKON
