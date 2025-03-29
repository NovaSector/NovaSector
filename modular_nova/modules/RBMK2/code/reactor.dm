/obj/machinery/power/rbmk2
	name = "\improper RB-MK2 reactor"
	desc = "Radioscopical Bluespace Mark 2 reactor, or RB MK2 for short, is a new state-of-the-art power generation technology that uses bluespace magic \
	to directly convert tritium particles into energy with minimal heat generation."
	icon = 'modular_nova/modules/RBMK2/icons/reactor_stuff.dmi'
	icon_state = "platform"
	base_icon_state = "platform"
	density = FALSE
	anchored = TRUE
	use_power = NO_POWER_USE

	max_integrity = 300

	uses_integrity = TRUE

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_REQUIRES_ANCHORED | INTERACT_ATOM_UI_INTERACT

	resistance_flags = FIRE_PROOF

	circuit = /obj/item/circuitboard/machine/rbmk2

	armor_type = /datum/armor/rbmk2

	/// Is this machine active?
	var/active = FALSE
	/// Is this machine giving power?
	var/power = TRUE
	/// Is this machine overclocked, consuming more tritium?
	var/overclocked = FALSE
	/// Is this machine venting the gases?
	var/venting = TRUE
	/// Is this machine venting in the reverse direction (sucking)?
	var/vent_reverse_direction = FALSE
	/// Is the safety active?
	var/safety = TRUE
	/// Current cooling limiter amount.
	var/cooling_limiter = 50
	/// Maximum possible cooling limiter amount.
	var/cooling_limiter_max = 90
	/// Is the reactor ejection system jammed?
	var/jammed = FALSE
	/// Was the anti-tamper light activated?
	var/tampered = FALSE
	/// Is the reactor currently suffering from a meltdown?
	var/meltdown = FALSE
	/// Once this reaches 100, you're going to see some serious shit.
	var/criticality = 0
	/// Currently stored rbmk2 rod.
	var/obj/item/tank/rbmk2_rod/stored_rod
	/// Gas that has yet to be leaked out due to not venting fast enough.
	var/datum/gas_mixture/buffer_gases
	/// Display purposes. Do not edit.
	var/last_power_generation = 0
	/// Display purposes. Do not edit.
	var/last_tritium_consumption = 0
	/// Display purposes. Do not edit.
	var/last_radiation_pulse = 0
	/// How much gas gets consumed, in moles, per cycle.
	var/gas_consumption_base = 0.000005
	/// How much gas gets consumed, in moles, per cycle, per 1000 kelvin.
	var/gas_consumption_heat = 0.0018
	/// How many joules of power to add per mole of tritium processed.
	var/base_power_generation = 7800000
	/// How many mols of goblin gas produced per mol of tritium. Increases with matter bins.
	var/goblin_multiplier = 8
	/// Max power generation possible with safeties on. Stock parts effect this value.
	var/safeties_max_power_generation = 230000
	/// A multiplier of base_power_generation. Also has an effect on heat generation. Improved via capacitors.
	var/power_efficiency = 1
	/// Pressure, in kPa, that the buffer releases the gas to. Improved via servos.
	var/vent_pressure = 200
	/// Maximum allowed power generation (joules) per cycle before the rods go apeshit. Improved via matter bins. The absolute max is 20 times this.
	var/max_power_generation = 350000
	/// All the sniffers linked to the reactor. They basically act as the radio for it.
	var/list/obj/machinery/rbmk2_sniffer/linked_sniffers = list()

/datum/armor/rbmk2
	melee = 50
	bullet = 20
	laser = 10
	energy = 100
	bomb = 30
	fire = 90
	acid = 50

/obj/machinery/power/rbmk2/Initialize(mapload)
	. = ..()

	set_wires(new /datum/wires/rbmk2(src))
	buffer_gases = new(100)

	connect_to_network()

	if(ispath(stored_rod))
		stored_rod = new stored_rod(src)
		START_PROCESSING(SSmachines, src)
		update_appearance(UPDATE_ICON)

	SSair.start_processing_machine(src)

/obj/machinery/power/rbmk2/update_icon_state()
	if(stored_rod)
		if(active)
			if(jammed)
				icon_state = "[base_icon_state]_jammed"
			else if(meltdown)
				var/meltdown_icon_number = 1 + (x + y*2) % 5
				icon_state = "[base_icon_state]_meltdown_loop[meltdown_icon_number]"
			else
				icon_state = "[base_icon_state]_closed"
		else
			icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state

	return ..()

/obj/machinery/power/rbmk2/update_overlays()
	. = ..()
	if(panel_open)
		. += "platform_panel"

	if(stored_rod)

		var/datum/gas_mixture/rod_mix = stored_rod.air_contents

		if(venting)
			var/mutable_appearance/heat_overlay = mutable_appearance(icon, "platform_heat")
			heat_overlay.appearance_flags |= RESET_COLOR
			if(vent_reverse_direction)
				heat_overlay.color = heat2colour(buffer_gases.temperature)
				heat_overlay.alpha = min( (rod_mix.temperature - T0C) * (1/500) * 255, 255)
			else
				heat_overlay.color = heat2colour(rod_mix.temperature)
				heat_overlay.alpha = min( (rod_mix.temperature - T0C) * (1/500) * 255, 255)
			. += heat_overlay

		if(!active && !jammed && rod_mix.gases[/datum/gas/tritium])
			var/meter_icon_num = CEILING( min(rod_mix.gases[/datum/gas/tritium][MOLES] / 10, 1) * 5, 1)
			if(meter_icon_num > 0)
				var/rod_mix_pressure = rod_mix.return_pressure()
				var/mutable_appearance/meter_overlay = mutable_appearance(icon, "platform_rod_glow_[meter_icon_num]")
				meter_overlay.appearance_flags |= RESET_COLOR
				var/return_pressure_mod = clamp( (rod_mix_pressure - stored_rod.pressure_limit*0.5) / stored_rod.pressure_limit*0.5, 0, 1)
				meter_overlay.color = rgb(return_pressure_mod*255, 255 - return_pressure_mod*255, 0)
				. += meter_overlay

/obj/machinery/power/rbmk2/return_analyzable_air()
	. = list()
	if(stored_rod)
		. += stored_rod.air_contents
	. += buffer_gases

/obj/machinery/power/rbmk2/Destroy()
	for(var/obj/machinery/rbmk2_sniffer/sniffer as anything in linked_sniffers)
		sniffer.unlink_reactor(desired_reactor = src)

	if(SSticker.IsRoundInProgress())
		var/turf/our_turf = get_turf(src)
		message_admins("[src] deleted at [ADMIN_VERBOSEJMP(our_turf)]")
		log_game("[src] deleted at [AREACOORD(our_turf)]")
		investigate_log("deleted at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	QDEL_NULL(stored_rod)
	SSair.stop_processing_machine(src)

	return ..()

/obj/machinery/power/rbmk2/on_deconstruction(disassembled = TRUE)
	if(!disassembled && stored_rod)
		//Uh oh.
		var/turf/our_turf = get_turf(src)
		if(criticality > 0)
			var/explosion_power = (criticality/100)*8
			message_admins("[src] exploded due to criticality at [ADMIN_VERBOSEJMP(our_turf)]")
			log_game("[src] exploded due to criticality [AREACOORD(our_turf)]")
			investigate_log("exploded due to criticality [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)
			stored_rod.take_damage(1000, armour_penetration = 100)
			if(stored_rod)
				remove_rod()
			explosion(src, devastation_range = explosion_power*0.25, heavy_impact_range = explosion_power*0.5, light_impact_range = explosion_power, flash_range = explosion_power*2, adminlog = FALSE)
			last_radiation_pulse = GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE*4 //It just keeps getting worse and worse.
			radiation_pulse(src, last_radiation_pulse, threshold = RAD_FULL_INSULATION)
		else
			message_admins("[src] exploded due to damage at [ADMIN_VERBOSEJMP(our_turf)]")
			log_game("[src] exploded due to damage [AREACOORD(our_turf)]")
			investigate_log("exploded due to damage [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)
			stored_rod.take_damage(1000, armour_penetration = 100)
			if(stored_rod) //Just in case.
				remove_rod()
	. = ..()

/obj/machinery/power/rbmk2/preloaded
	stored_rod = /obj/item/tank/rbmk2_rod/preloaded

/obj/machinery/power/rbmk2/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(active || user.combat_mode || !istype(tool, /obj/item/tank/rbmk2_rod))
		return NONE
	src.add_fingerprint(user)
	tool.add_fingerprint(user)
	add_rod(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/rbmk2/exchange_parts(mob/user, obj/item/storage/part_replacer/replacer_tool)
	if(active)
		balloon_alert(user, "turn off before upgrading!")
		return FALSE

	. = ..()

/obj/machinery/power/rbmk2/on_set_panel_open(old_value)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/machinery/power/rbmk2/proc/force_unjam(obj/item/attacking_item, mob/living/user, damage_to_deal = 50)
	if(!jammed)
		return FALSE
	if(atom_integrity <= damage_to_deal)
		balloon_alert(user, "too damaged!")
		return FALSE
	if(attacking_item.use_tool(src, user, 4 SECONDS, volume = 50) && jam(user, FALSE))
		take_damage(damage_to_deal, armour_penetration = 100)
		src.Shake(duration = 0.5 SECONDS)
		balloon_alert(user, "unjammed!")
		return TRUE
	return FALSE

//Remove the rod.
/obj/machinery/power/rbmk2/click_alt(mob/living/user)
	if(!active && stored_rod)
		src.add_fingerprint(user)
		stored_rod.add_fingerprint(user)
		if(remove_rod(user))
			balloon_alert(user, "rod removed!")
		return TRUE

/obj/machinery/power/rbmk2/proc/remove_rod(mob/living/user, do_throw = FALSE)
	if(!stored_rod)
		return FALSE
	if(active && !jammed)
		return FALSE
	var/turf/our_turf = get_turf(src)
	if(!our_turf)
		return FALSE
	if(meltdown)
		return FALSE
	if(do_throw)
		if(jammed)
			if(prob(80))
				take_damage(0.5, armour_penetration = 100, sound_effect = FALSE)
				stored_rod.take_damage(0.5, armour_penetration = 100)
				src.Shake(duration = 0.5 SECONDS)
				var/damage_sound = pick(
					'sound/effects/structure_stress/pop1.ogg',
					'sound/effects/structure_stress/pop2.ogg',
					'sound/effects/structure_stress/pop3.ogg',
				)
				playsound(src, damage_sound, 50, TRUE, extrarange = -3)
				return FALSE
			else //Yes. Spamming the eject button can unjam it.
				jam(user, FALSE) //We did it!
				toggle_active(user, FALSE) //Turning it off.
				playsound(src, 'sound/machines/shutter.ogg', 50, TRUE, extrarange = -3)
				return FALSE
		stored_rod.forceMove(our_turf)
		stored_rod.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), rand(3, 6), 5)
		playsound(src, 'sound/items/weapons/gun/general/grenade_launch.ogg', 50, TRUE, extrarange = -3)
	else
		if(jammed)
			return FALSE
		if(!user?.put_in_hands(stored_rod))
			stored_rod.forceMove(our_turf)
		playsound(src, 'sound/items/weapons/gun/shotgun/insert_shell.ogg', 50, TRUE, frequency = -1, extrarange = -3)
	stored_rod = null
	STOP_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_ICON)
	if(user)
		user.log_message("removed a rod from [src]", LOG_GAME)
		investigate_log("had a rod removed by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	return TRUE

/obj/machinery/power/rbmk2/proc/add_rod(mob/living/user, obj/item/tank/rbmk2_rod/desired_rod)
	if(stored_rod && !remove_rod(user))
		return FALSE
	if(active)
		return FALSE
	desired_rod.forceMove(src)
	stored_rod = desired_rod
	update_appearance(UPDATE_ICON)
	START_PROCESSING(SSmachines, src)
	playsound(src, 'sound/items/weapons/gun/shotgun/insert_shell.ogg', 50, TRUE, frequency = 1, extrarange = -3)
	if(user)
		user.log_message("inserted a rod into [src]", LOG_GAME)
		investigate_log("had a rod inserted by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	return TRUE


/obj/machinery/power/rbmk2/proc/jam(mob/living/user, desired_state = !jammed)
	if(jammed == desired_state)
		return

	if(!active && desired_state) //Can't jam when already open
		return

	var/turf/our_turf = get_turf(src)
	if(user)
		user.log_message("jammed [src]", LOG_GAME)
		investigate_log("jammed due to damage by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
	else
		log_game("[src] jammed due to damage at [AREACOORD(our_turf)]")
		investigate_log("jammed due to damage at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	jammed = desired_state

	playsound(src, 'sound/effects/pressureplate.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_active(mob/living/user, desired_state = !active)
	for(var/obj/machinery/power/rbmk2/reactor in get_turf(src))
		if(reactor != src)
			reactor.deconstruct(FALSE) // To prevent stacking reactors on top of each other.
			balloon_alert_to_viewers("[reactor] tears itself apart!")
			return

	if(active == desired_state)
		return

	if(!force && desired_state)
		if(!stored_rod)
			return
		if(!anchored)
			return

	if(jammed)
		return FALSE

	if(meltdown) //You thought.
		if(!jammed) //JAM IT.
			jam(user, TRUE)
		return FALSE

	active = desired_state

	if(active)
		var/turf/our_turf = get_turf(src)
		if(user)
			user.log_message("turned on [src]", LOG_GAME)
			investigate_log("was turned on by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		else
			log_game("[src] was turned on at [AREACOORD(our_turf)]")
			investigate_log("was turned on at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	update_appearance(UPDATE_ICON)

	playsound(src, 'sound/machines/eject.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/obj/machinery/power/rbmk2/proc/toggle_vents(mob/living/user, desired_state = !venting)
	if(desired_state == venting)
		return FALSE

	venting = desired_state

	if(!venting)
		var/turf/our_turf = get_turf(src)
		if(user)
			user.log_message("had vents turned off by [src]", LOG_GAME)
			investigate_log("had vents turned off by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		else
			log_game("[src] had vents turned off at [AREACOORD(our_turf)]")
			investigate_log("had vents turned off at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	update_appearance(UPDATE_ICON)

	playsound(src, 'sound/machines/creak.ogg', 50, TRUE, extrarange = -3)

	return TRUE

/// Switches vent directions. Toggling between sucking air in and pushing air out
/obj/machinery/power/rbmk2/proc/toggle_reverse_vents(mob/living/user, desired_state = !vent_reverse_direction)
	if(desired_state == vent_reverse_direction)
		return FALSE

	if(venting) //Can't change when they're already on.
		if(user)
			balloon_alert(user, "turn vents off first")
		return FALSE

	vent_reverse_direction = desired_state

	if(user)
		user.log_message("had vents set to [vent_reverse_direction ? "reverse" : "normal"] by [src]", LOG_GAME)
		investigate_log("had vents set to [vent_reverse_direction ? "reverse" : "normal"] by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
		balloon_alert(user, "vents switched to [vent_reverse_direction ? "pulling" : "pushing"]")
	else
		var/turf/our_turf = get_turf(src)
		log_game("[src] had vents set to [vent_reverse_direction ? "reverse" : "normal"] at [AREACOORD(our_turf)]")
		investigate_log("had vents set to [vent_reverse_direction ? "reverse" : "normal"] at [AREACOORD(our_turf)]", INVESTIGATE_ENGINE)

	return TRUE

/obj/machinery/power/rbmk2/RefreshParts()
	. = ..()

	//Requires x4 capacitors
	var/power_efficiency_mul = 0.5
	for(var/datum/stock_part/capacitor/new_capacitor in component_parts)
		power_efficiency_mul += (new_capacitor.tier * 0.125)
	power_efficiency = initial(power_efficiency) * power_efficiency_mul

	//Requires x2 matter bins
	var/max_power_generation_mul = 0
	goblin_multiplier = initial(goblin_multiplier)
	for(var/datum/stock_part/matter_bin/new_matter_bin in component_parts)
		max_power_generation_mul += (new_matter_bin.tier * 0.5) + max(0, new_matter_bin.tier-1)*0.1
		goblin_multiplier += (new_matter_bin.tier-1)*0.5
	max_power_generation = initial(max_power_generation) * (max_power_generation_mul**(1 + (max_power_generation_mul-1)*0.1))
	max_power_generation = FLOOR(max_power_generation, 10000)
	safeties_max_power_generation = max(initial(safeties_max_power_generation), round(max_power_generation*0.75, 125000))

	//Requires x4 servos
	var/vent_pressure_multiplier = 0
	for(var/datum/stock_part/servo/new_servo in component_parts)
		vent_pressure_multiplier += new_servo.tier * 0.25
	vent_pressure = initial(vent_pressure) * vent_pressure_multiplier

/obj/machinery/power/rbmk2/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RBMK2", name)
		ui.open()

/obj/machinery/power/rbmk2/ui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["rod"] = stored_rod
	data["last_power_output"] = display_power(last_power_generation)
	data["efficiency"] = power_efficiency*100
	data["consuming"] = last_tritium_consumption*10000
	return data

/obj/machinery/power/rbmk2/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user

	switch(action)
		if("activate")
			toggle_active(user)
			. = TRUE
		if("eject")
			remove_rod(user, do_throw = TRUE)
			. = TRUE
		if("venttoggle")
			toggle_vents(user)
			. = TRUE
		if("ventdirection")
			toggle_reverse_vents(user)
			. = TRUE
		if("safetytoggle")
			var/turf/machine_turf = get_turf(src)
			if(safety == TRUE)
				balloon_alert(user, "safety lights are off")
				safety = FALSE
				if(isliving(user))
					user.log_message("turned the safety off of [src]", LOG_GAME)
					investigate_log("had the safety turned off by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
				else
					log_game("[src] had the safety turned off at [AREACOORD(machine_turf)]")
					investigate_log("had the safety turned off at [AREACOORD(machine_turf)]", INVESTIGATE_ENGINE)
				return
			if(safety == FALSE)
				balloon_alert(user, "safety lights are on")
				safety = TRUE
				if(isliving(user))
					user.log_message("turned the safety on of [src]", LOG_GAME)
					investigate_log("had the safety turned on by [key_name(user)] at [AREACOORD(src)].", INVESTIGATE_ENGINE)
				else
					log_game("[src] had the safety turned on at [AREACOORD(machine_turf)]")
					investigate_log("had the safety turned on at [AREACOORD(src)]", INVESTIGATE_ENGINE)
				return
			. = TRUE

/obj/machinery/power/rbmk2/examine(mob/user)
	. = ..()

	. += span_notice("A digital display on the side side says <b>MAX SAFE POWER: [display_power(safeties_max_power_generation)], WARRANTY VOID IF EXCEEDED</b>.")

	. += "It is linked to [length(linked_sniffers)] sniffer(s)."

	. += "It is[!active?"n't":""] running."

	if(!power || !powernet)
		. += span_warning("It is not connected to a power cable.")

	if(!venting)
		. += span_warning("The vents are closed.")
	else if(vent_reverse_direction)
		. += "Its vents are running in reverse."
	if(!stored_rod)
		. += span_warning("It it is missing a RB-MK2 reactor rod.")
	else if(jammed)
		. += span_danger("The reactor rod is jammed! <b>Pry</b> the rod back in to unjam in!")
	else if(meltdown)
		. += span_danger("The reactor rod is leaping erractically!")
	else
		. += span_notice("There is an RB-MK2 reactor rod installed. <b>Wrench</b> it down to activate, or remove it with ALT+CLICK.")

	if(active)
		. += span_notice("It is currently consuming [last_tritium_consumption] moles of tritium per cycle, producing [display_power(last_power_generation)].")

/obj/machinery/power/rbmk2/examine_more(mob/user)
	. = ..()
	. += "It is running at <b>[power_efficiency*100]%</b> power efficiency."
	. += "It can output in environments up to <b>[vent_pressure]kPa</b>."
	. += "It can handle an estimated power load of <b>[display_power(max_power_generation)]</b> before going critical."

/obj/machinery/power/rbmk2/proc/transfer_rod_temperature(datum/gas_mixture/gas_source, allow_cooling_limiter = TRUE, multiplier = 1)
	var/datum/gas_mixture/rod_mix = stored_rod.air_contents

	var/rod_mix_heat_capacity = rod_mix.heat_capacity()
	if(rod_mix_heat_capacity <= 0)
		return FALSE

	var/gas_source_heat_capacity = gas_source.heat_capacity()
	if(gas_source_heat_capacity <= 0)
		return FALSE

	var/rod_mix_temperature = rod_mix.temperature
	var/gas_source_temperature = gas_source.temperature

	var/delta_temperature = rod_mix_temperature - gas_source_temperature
	if(delta_temperature == 0)
		return FALSE

	var/energy_transfer = delta_temperature*rod_mix_heat_capacity*gas_source_heat_capacity/(rod_mix_heat_capacity+gas_source_heat_capacity)

	var/temperature_change = (energy_transfer/rod_mix_heat_capacity)*multiplier
	if(allow_cooling_limiter && temperature_change > 0) //Cooling!
		temperature_change *= clamp(1 - cooling_limiter*0.01, 0, 1) //Clamped in case of adminbus fuckery.

	rod_mix.temperature -= temperature_change*0.85
	gas_source.temperature += temperature_change

	return TRUE

/obj/machinery/power/rbmk2/proc/shock(mob/living/victim, shock_multiplier = 1)
	if(!powernet)
		return FALSE
	if(!electrocute_mob(victim, powernet, src, shock_multiplier, TRUE))
		return FALSE
	do_sparks(5, TRUE, src)
	return TRUE
