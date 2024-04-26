/obj/machinery/computer/order_console/gakster
	name = "Grey Market Access Point"
	desc = "An interface for accessing the galactic market of less-than-legal retailers spread across the system."
	flags_1 = NO_DEBRIS_AFTER_DECONSTRUCTION
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	order_categories = list(
		"Peacekeeper",
		"Rayisa",
		"Operator",
		"Safariman",
		"Dealer",
	)
	blackbox_key = null
	express_cost_multiplier = 1
	cooldown_time = 5 SECONDS
	forced_express = TRUE
	/// List of items that this console buys and for how much
	var/list/stuff_we_buy = list(
		/obj/item/epic_loot/grenade_fuze = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/nail_box = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/cold_weld = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/signal_amp = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/fuel_conditioner = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/aramid = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/cordura = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/ripstop = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/water_filter = PAYCHECK_COMMAND,
		/obj/item/epic_loot/thermometer = PAYCHECK_COMMAND,
		/obj/item/epic_loot/current_converter = PAYCHECK_COMMAND,
		/obj/item/epic_loot/electric_motor = PAYCHECK_COMMAND,
		/obj/item/epic_loot/thermal_camera = PAYCHECK_COMMAND,
		/obj/item/epic_loot/shuttle_gyro = PAYCHECK_COMMAND,
		/obj/item/epic_loot/phased_array = PAYCHECK_COMMAND,
		/obj/item/epic_loot/shuttle_battery = PAYCHECK_COMMAND,
		/obj/item/epic_loot/device_fan = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/display_broken = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/civilian_circuit = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/processor = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/disk_drive = PAYCHECK_COMMAND / 2,
		/obj/item/epic_loot/display = PAYCHECK_COMMAND,
		/obj/item/epic_loot/graphics = PAYCHECK_COMMAND,
		/obj/item/epic_loot/military_circuit = PAYCHECK_COMMAND,
		/obj/item/epic_loot/power_supply = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/green = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/teal = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/blue = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/ourple = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/red = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/orange = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/yellow = PAYCHECK_COMMAND,
		/obj/item/keycard/epic_loot/black = PAYCHECK_COMMAND * 20,
		/obj/item/epic_loot/vein_finder = PAYCHECK_COMMAND * 5,
		/obj/item/epic_loot/eye_scope = PAYCHECK_COMMAND * 5,
		/obj/item/epic_loot/press_pass = PAYCHECK_COMMAND * 1.5,
		/obj/item/epic_loot/hdd = PAYCHECK_COMMAND * 1.5,
		/obj/item/epic_loot/slim_diary = PAYCHECK_COMMAND * 1.5,
		/obj/item/epic_loot/plasma_explosive = PAYCHECK_COMMAND * 1.5,
		/obj/item/epic_loot/silver_chainlet = PAYCHECK_COMMAND * 1.5,
		/obj/item/epic_loot/ssd = PAYCHECK_COMMAND * 2,
		/obj/item/epic_loot/military_flash = PAYCHECK_COMMAND * 2,
		/obj/item/epic_loot/diary = PAYCHECK_COMMAND * 2,
		/obj/item/epic_loot/corpo_folder = PAYCHECK_COMMAND * 2,
		/obj/item/epic_loot/intel_folder = PAYCHECK_COMMAND * 2,
		/obj/item/epic_loot/gold_chainlet = PAYCHECK_COMMAND * 2,
	)

/obj/machinery/computer/order_console/gakster/examine(mob/user)
	. = ..()
	. += span_engradio("<b>Components</b> and <b>keycards</b> can be exchanged for <b>cash</b> here.")
	. += span_engradio("<b>Attack</b> the console with the items you wish to <b>sell</b>.")

/obj/machinery/computer/order_console/gakster/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(!(weapon.type in stuff_we_buy))
		return
	var/tha_money = stuff_we_buy[weapon.type]
	new /obj/item/stack/spacecash/c1(drop_location(), tha_money)
	playsound(src, 'sound/effects/cashregister.ogg', 50, TRUE)
	qdel(weapon)

/obj/machinery/computer/order_console/gakster/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/computer/order_console/gakster/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/computer/order_console/gakster/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE
