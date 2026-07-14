/obj/machinery/power/micro_reactor
	name = "shuttle core"
	desc = "A large container attached to the bottom of smaller ships, using the same \
		crystal heart technology as MOD cores and ethereals do. Acts not as a generator, but \
		rather a battery with a lifespan anywhere between \"generational\" and a year or two, \
		depending on how much energy the ship will use."
	icon = 'modular_nova/modules/ships_r_us/icons/reactor.dmi'
	icon_state = "reactor0_0"
	base_icon_state = "reactor0"
	density = FALSE
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND
	light_color = LIGHT_COLOR_COPPER_OXIDE
	light_on = FALSE
	var/power_gen = 50 KILO WATTS
	var/active = FALSE
	var/power_output = 1
	var/datum/looping_sound/generator/soundloop

/obj/machinery/power/micro_reactor/Initialize(mapload)
	. = ..()
	soundloop = new(src, active)
	connect_to_network()

/obj/machinery/power/micro_reactor/Destroy()
	QDEL_NULL(soundloop)
	return ..()

// formerly NO_DECONSTRUCTION
/obj/machinery/power/micro_reactor/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/micro_reactor/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/micro_reactor/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/power/micro_reactor/update_icon_state()
	icon_state = "[base_icon_state]_[active]"
	return ..()

/obj/machinery/power/micro_reactor/attack_hand(mob/user, list/modifiers)
	. = ..()
	TogglePower()

/obj/machinery/power/micro_reactor/attack_robot(mob/user)
	. = ..()
	TogglePower()

/obj/machinery/power/micro_reactor/proc/handleInactive()
	return

/obj/machinery/power/micro_reactor/update_appearance(updates)
    . = ..()
    if(!active)
        set_light(0)
        return
    set_light(2, 3)

/obj/machinery/power/micro_reactor/proc/TogglePower()
	if(active)
		active = FALSE
		set_light_power(0)
		set_light_on(0)
		update_appearance()
		soundloop.stop()
	else
		active = TRUE
		START_PROCESSING(SSmachines, src)
		set_light_power(3)
		set_light_range(2)
		set_light_on(TRUE)
		update_appearance()
		soundloop.start()

/obj/machinery/power/micro_reactor/process()
	if(active)
		if(!anchored)
			TogglePower()
			return
		if(powernet)
			add_avail(power_to_energy(power_gen * power_output))
	else
		handleInactive()

/obj/machinery/power/micro_reactor/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += "It is[!active?"n't":""] running."
