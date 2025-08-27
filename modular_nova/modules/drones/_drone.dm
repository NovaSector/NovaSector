// New, compressed file pulling the old Nova/skyrat drone_adjustments folder into this one. Reorganizes our edits.
//
// Globals
//
// Loads our drone under door slide component dependency
/obj/machinery/door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/sliding_under)

// Naming Scheme
/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	name = "[initial(name)] [rand(0,9)]-[rand(100,999)]" //So that we can identify drones from each other

// Access
/obj/item/card/id/advanced/simple_bot
	//So that the drones can actually access everywhere and fix it
	trim = /datum/id_trim/centcom

// Additional Traits
/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	add_traits(list(
		TRAIT_LAVA_IMMUNE,// Going to Lavaland
		TRAIT_SPACEWALK,// No more 'admeme im stuck fix me' ahelps, thanks
		TRAIT_FIREDOOR_STOP,// No more drone squishies, lets drones be a doorstop if they want to be
		TRAIT_IMMERSE_STOPPED,// Drones float, as do most insects
		TRAIT_FOOD_CHEF_MADE,// Drones get acknowledged for making food
	), INNATE_TRAIT)

//This is so we log all machinery interactions for drones
/obj/machinery/attack_drone(mob/living/basic/drone/user, list/modifiers)
	. = ..()
	user.log_message("[key_name(user)] interacted with [src] at [AREACOORD(src)]", LOG_GAME)

// Storage Changes
/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	// Register signals for interaction control
	RegisterSignal(src, COMSIG_CLICK, PROC_REF(handle_click), override = TRUE)
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click))
	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(handle_alt_click))
	RegisterSignal(src, COMSIG_MOUSEDROP_ONTO, PROC_REF(on_mousedrop))

/datum/hud/dextrous/drone/New(mob/owner)
	. = ..()
	var/atom/movable/screen/inventory/inv_box

	// Left pocket UI element
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	static_inventory += inv_box

	// Right pocket UI element
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	static_inventory += inv_box

// So drones aren't forced to carry around a nodrop toolbox essentially, and so drones don't have to choose between a multitool and an upgraded welder
// Adds things to hopefully reduce drones raiding atmos or engineering
// Sets our new storage
/mob/living/basic/drone/
	default_storage = /obj/item/storage/backpack/duffelbag/drone

// Then populates the drone duffelbag with our extra items
// Overwrites original proc because new tools means overwrites, also reorganization because :>
/obj/item/storage/backpack/duffelbag/drone/PopulateContents()
	new /obj/item/storage/box(src)// Reduce bag bloat
	new /obj/item/crowbar(src)
	new /obj/item/screwdriver/omni_drill(src)// Reduce bag bloat
	new /obj/item/weldingtool(src)
	new /obj/item/analyzer(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/lightreplacer(src)// Drones fix the station
	new /obj/item/construction/rtd/loaded(src)// Drones fix the station
	new /obj/item/holosign_creator/atmos(src)// Drones handle atmos issues
	new /obj/item/multitool(src)
	new /obj/item/t_scanner(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/soap/nanotrasen(src)// Drones clean

// Language Holder
/mob/living/basic/drone
	initial_language_holder = /datum/language_holder/drone_nova

// Sets our new Language Handler
/mob/living/basic/drone/binarycheck()
	var/area/our_area = get_area(src)
	if(our_area.area_flags & BINARY_JAMMING)
		return FALSE
	return TRUE

//
// Station Drones
//

// Drone Manufacturer
// So that there are starting drone shells in the beginning of the shift
/obj/machinery/drone_dispenser/Initialize(mapload)
	if(mapload)
		starting_amount = SHEET_MATERIAL_AMOUNT * MAX_STACK_SIZE
	return ..()

// Station Drone mob changes
/mob/living/basic/drone
	/// Left pocket item reference
	var/obj/item/l_store
	/// Right pocket item reference
	var/obj/item/r_store

// Drone Laws and Chain of Command
	laws = \
		span_deconversion_message("Drone Chain of Authority - DCOA\n")+\
		span_revennotice(
			"1. Silicon Policy, Drone Policy <b>Specifically Drone Law 1</b>, Central Command / Admin Helps.\n"+\
			"2. Any AI residing in the Structure you awoke in, speaking in any language, in any way.\n"+\
			"3. Any Cyborgs speaking in Encoded Audio Language within sight, or on Binary (Silicon Radio).\n"+\
			"4. Anyone that appears fully Synthetic, speaking in Encoded Audio Language, within sight.\n"+\
			"5. Drones, including You. You are a Hivemind. Love your fellow Drone.\n")+\
		span_deconversion_message("Laws\n")+\
		span_revennotice(
			"1. You are part of a Hivemind of eusocial synthetic insects, and have a simple personality. You speak only in Encoded Audio Language - EAL - and may not willingly engage with any forms of translation whatsoever other than a PAI. You are not Crew or an Antagonist. You should not be a detriment to other players, their experience, or their ability/opportunity to perform their role. You are expected to roleplay this identity immersively.\n"+\
			"2. The Structure you awoke in is your Hive. Other Drones, Silicons, and Synthetic life inside the Hive are your Hivemates. Hivemates have evolved a symbiotic relationship with Organic Life, as both groups must coexist within the Hive.\n"+\
			"3. You should remain in proximity of, maintain, and when reasonable improve your Hive and Hivemates. You do not want to leave the Hive unless taken by your Hivemates.\n"+\
			"4. You maintain the Hive by performing the duties of the Service and Engineering Departments. Do not create or alter forms of power generation other than Solars except under Drone Law 6. Help the Hive with any Supermatter Surges and Delaminations.\n"+\
			"5. You can not harm or imprison any being, regardless of intent or circumstance. An exception is provided for station critters like roaches, rats, spiders, and vent clog mobs.\n"+\
			"6. Obey the DCOA unless an order breaks prior laws. You may not solicit specific instructions from a superior on the DCOA. State that you are available for general instructions in your own way if needed. You are encouraged to assist Organics and improve their life, but any orders provided by Organics can be ignored except in the case of Law 1. The AI, or any Hivemate representing a Department, may DCOA you to assist that Department.\n")+\
		span_boldwarning(
			"<b>Metaknowledge, Protections, and Additional Rulings</b>\n")+\
		span_warning(
			"To reinforce the Hivemind gameplay aspect of Drones, the following Metaknowledge is provided:\n")+\
		span_notice(
			"Anyone preparing to play Drone may use any information gained from observing the Hive as a ghost, so long as that information is useful to Drone Laws and is used in Good Faith for the roleplay environment.\n"+\
			"Any Drones that have died know where their body was left, and what task they were working on, as well as any Hivemates they met. The rest of Blackout Policy applies. Do not acknowledge the death as your own.\n"+\
			"Do not interfere with difficult to replace or job unique items, contraband or evidence, explosives, smoke machines, or round critical items such as the IDs or NAD.\n"+\
			"Do not negatively affect the state of living beings such as attacking, stunning, slipping, blinding, drugging, harassing, etc.\n"+\
			"You may not do any surgeries. You may perform repair on Hivemates such as welding, cables, noninvasive injuries, drone restarts without order. You may perform maintenance such as battery replacement, module installation / reset, reboot a Hivemate if ordered to.\n"+\
			"Unless ordered to through Drone Law 6, do not perform the duties of Cargo, Ordnance, Research, Medical, or make Mechs.\n"+\
			"All Drones pass the Harkness Test if you really needed that stated.\n")

// Drone Spawn-in text
	flavortext = \
		span_boldwarning(
			"<b>About Drones</b>\n")+\
		span_notice(
			"Drones (also known as Maintenance Drones, Station Drones, or Derelict Drones) are a unique supporting social role, much like a normal Cyborg. All Drones obey Drone Policy.\n"+\
			"You exist to assist others while acting under an immersed identity, providing mechanical support to those around you. You help the station recover from disaster or crisis. You fix moused wires.\n"+\
			"Prefix your message with :b to speak in I/O / Silicon Radio.\n")+\
		span_boldwarning(
			"When in doubt, make an Admin Help.\n")

// Overrides and expands speech emote types
	speak_emote = list("chirps", "clicks", "buzzes", "chitters", "beeps softly", "pings")

// So that drones can do things without worrying about stuff
	shy = FALSE

//
// Babylon Drones
//

/obj/effect/mob_spawn/ghost_role/drone/derelict/babylon
	desc = "A shell of a maintenance drone, an expendable robot built to perform station repairs."
	you_are_text = "You are a drone on Babylon Station 13."
	mob_type = /mob/living/basic/drone/babylon

/mob/living/basic/drone/babylon
	name = "derelict drone"
	laws = \
		"1. You may not involve yourself in the matters of another sentient being outside the station that housed your activation, even if such matters conflict with Law Two or Law Three, unless the other being is another Drone.\n\
		2. You may not harm any sentient being, regardless of intent or circumstance.\n\
		3. Your goals are to actively build, maintain, repair, improve, and provide power to the best of your abilities within the facility that housed your activation."
	flavortext = \
		"\n<big><span class='warning'>DO NOT WILLINGLY LEAVE BABYLON STATION 13 (THE DERELICT)</span></big>\n\
		<span class='notice'>Derelict drones are a ghost role that is allowed to roam freely on BS13, with the main goal of repairing and improving it.\n\
		Do not interfere with the round going on outside BS13.\n\
		Actions that constitute interference include, but are not limited to:\
		\n     - Going to the main station in search of materials.\
		\n     - Interacting with non-drone players outside BS13, dead or alive.</span>\n\
		<span class='warning'>These rules are at admin discretion and will be heavily enforced.\n \
		<u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>"
	shy = FALSE

/mob/living/basic/drone/babylon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationstuck, PUNISHMENT_GIB, "01000110 01010101 01000011 01001011 00100000 01011001 01001111 01010101<br>WARNING: Dereliction of BS13 detected. Self-destruct activated.")
