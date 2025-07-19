/datum/bounty/item/ds2_engie/emitter
	name = "Emitter"
	description = "Cybersun wants an emitter so they can make an anti-ship gun out of it. They swear it'll be cooler than it sounds."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/emitter = TRUE)

/datum/bounty/item/ds2_engie/hydro_tray
	name = "Hydroponics Tray"
	description = "DS-11 had an incident with a hydroponics tray. Mind sending a new one?"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/machinery/hydroponics/constructable = TRUE)

/datum/bounty/item/ds2_engie/cyborg_charger
	name = "Recharging Station"
	description = "Staging Area 9 had an incident with one of the recharging stations, and they need a new one sent."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/recharge_station = TRUE)

/datum/bounty/item/ds2_engie/smes_unit
	name = "Power Storage Unit"
	description = "We need to store more power. Get us a SMES unit."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/machinery/power/smes = TRUE)

/datum/bounty/item/ds2_engie/pacman
	name = "P.A.C.M.A.N. Generator"
	description = "Our backup generator blew a fuse, we need a new P.A.C.M.A.N. ASAP."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/port_gen/pacman = TRUE)

/datum/bounty/item/ds2_engie/field_gen
	name = "Field Generator"
	description = "One of our protective field generator's warranties has expired, we need a new one to replace it."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/machinery/field/generator = TRUE)

/datum/bounty/item/ds2_engie/tesla_coil
	name = "Tesla Coil"
	description = "Our electricity bill is too high, get us a tesla coil to offset this."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/energy_accumulator/tesla_coil = TRUE)

/datum/bounty/item/ds2_engie/reflector
	name = "Reflector"
	description = "We want to make our emitters take a longer route, get us a reflector to make this happen."
	reward = CARGO_CRATE_VALUE * 7
	wanted_types = list(/obj/structure/reflector = TRUE)

/datum/bounty/item/ds2_engie/communications
	name = "Communication Console"
	description = "We lost our communications array here, send us a new pre-constructed communications console."
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(/obj/machinery/computer/communications = TRUE)

