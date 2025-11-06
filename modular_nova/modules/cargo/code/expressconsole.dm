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
	cargo_account = ACCOUNT_CIV /// Change this later to somethin else, as this is meant to prevent runtiming
	contraband = TRUE

	/// Do not touch this unless a new company is added to the imports list.
	var/static/list/allowed_categories = list(
		NAKAMURA_ENGINEERING_MODSUITS_NAME,
		BLACKSTEEL_FOUNDATION_NAME,
		NRI_SURPLUS_COMPANY_NAME,
		DEFOREST_MEDICAL_NAME,
		DONK_CO_NAME,
		KAHRAMAN_INDUSTRIES_NAME,
		FRONTIER_EQUIPMENT_NAME,
		SOL_DEFENSE_DEFENSE_NAME,
		MICROSTAR_ENERGY_NAME,
		VITEZSTVI_AMMO_NAME,
	)

	pod_type = /obj/structure/closet/supplypod/bluespacepod

/obj/machinery/computer/cargo/express/ghost/Initialize(mapload)
	. = ..()
	if(type == abstract_type) // These are not meant to be spawned
		return INITIALIZE_HINT_QDEL

/obj/machinery/computer/cargo/express/ghost/on_construction(mob/user)
	. = ..()
	/// Should report the player that built the console to the admins, in case anything fucky happens.
	message_admins("[ADMIN_LOOKUPFLW(usr)] Has built a ghost role imports console ([src.name]) at [AREACOORD(src)].")

/obj/machinery/computer/cargo/express/ghost/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("You try to change the routing protocols, but the [src.name] displays a runtime error and reboots!"))
	return FALSE //never let this console be emagged

/obj/machinery/computer/cargo/express/ghost/packin_up(forced = FALSE) //we're the ghost role, add the company imports stuff to our express console
	. = ..()

	if(meme_pack_data["Company Imports"])
		return

	meme_pack_data["Company Imports"] = list(
		"name" = "Company Imports",
		"packs" = list()
	)

	for(var/armament_category in SSarmaments.entries)//babe! it's 4pm, time for the company importing logic
		for(var/subcategory in SSarmaments.entries[armament_category][CATEGORY_ENTRY])
			if(armament_category in allowed_categories)
				for(var/datum/armament_entry/armament_entry as anything in SSarmaments.entries[armament_category][CATEGORY_ENTRY][subcategory])
					meme_pack_data["Company Imports"]["packs"] += list(list(
						"name" = "[armament_category]: [armament_entry.name]",
						"first_item_icon" = armament_entry?.item_type.icon,
						"first_item_icon_state" = armament_entry?.item_type.icon_state,
						"cost" = armament_entry.cost,
						"id" = REF(armament_entry),
						"description" = armament_entry.description,
						"desc" = armament_entry.description,
					))

/obj/machinery/computer/cargo/express/ghost/ui_act(action, params, datum/tgui/ui)
	if(action == "add") // if we're generating a supply order
		if (!beacon || !using_beacon ) // checks if using a beacon or not.
			say("Error! Destination is not whitelisted, aborting.")
			return
		var/id = params["id"]
		id = text2path(id) || id
		var/datum/supply_pack/is_supply_pack = SSshuttle.supply_packs[id]
		if(!is_supply_pack || !istype(is_supply_pack)) //if we're ordering a company import pack, add a temp pack to the global supply packs list, and remove it
			var/datum/armament_entry/armament_order = locate(id)
			params["id"] = length(SSshuttle.supply_packs) + 1
			var/datum/supply_pack/armament/temp_pack = new
			temp_pack.name = initial(armament_order.item_type.name)
			temp_pack.cost = armament_order.cost
			temp_pack.contains = list(armament_order.item_type)
			SSshuttle.supply_packs += temp_pack
			. = ..()
			SSshuttle.supply_packs -= temp_pack
			return
	return ..()

//Interdyne Pharmaceuticals Console's console
/obj/item/circuitboard/computer/cargo/express/ghost/interdyne
	name = "Interdyne Express Supply Console"
	greyscale_colors = COLOR_PRIDE_GREEN
	build_path = /obj/machinery/computer/cargo/express/ghost/interdyne
	contraband = TRUE

/obj/machinery/computer/cargo/express/ghost/interdyne
	name = "\improper Interdyne Express Supply Console"
	desc = "A specialized Interdyne Pharmaceuticals console, allowing for deepspace communication with a specialized drop pod railgun for precise and accurate \
		deliveries, no matter how remote they are located"
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost/interdyne
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_INT
	contraband = TRUE

//Deep Space 2's console
/obj/item/circuitboard/computer/cargo/express/ghost/syndicate
	name = "Syndicate Express Supply Console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/cargo/express/ghost/syndicate
	contraband = TRUE

/obj/machinery/computer/cargo/express/ghost/syndicate
	name = "\improper Syndicate Express Supply Console"
	desc = "A specialized Syndicate Express Supply Console, synced with a deepspace syndicate storage satellite, armed with a drop pod railgun for precise and accurate \
		deliveries over long distances, no matter how remote they are located."
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost/syndicate
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_DS2

// Tarkon Industries console
/obj/item/circuitboard/computer/cargo/express/ghost/tarkon
	name = "Tarkon Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express/ghost/tarkon
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	contraband = TRUE

/obj/machinery/computer/cargo/express/ghost/tarkon
	name = "\improper Tarkon Express Supply Console"
	desc = "A specialized Tarkon Industries Express Supply Console, synced a deepspace storage satellite, armed with a drop pod railgun for precise and accurate \
		deliveries over long distances, no matter how remote they are located."
	circuit = /obj/item/circuitboard/computer/cargo/express/ghost/tarkon
	req_access = list(ACCESS_TARKON)
	cargo_account = ACCOUNT_TI
