//For ruin-specific machines --- limitied/unique functions, or functions mimicked from normal machines.
//Think along the lines of a console with lore or a fuse box that needs x fuses to activate --- or, just a retextured GPS Computer, like the first item

/* ----------------- Computers ----------------- */
/obj/item/gps/computer/space //Subtype that runs pod computer code, with a texture to blend better with normal walls
	icon = 'modular_nova/modules/mapping/icons/machinery/gps_computer.dmi'	//needs its own file for pixel size ;-;
	name = "gps computer"
	icon_state = "pod_computer"
	anchored = TRUE
	density = TRUE
	pixel_y = -5    //I dunno why this sprite lines up differently, but this is a better value to line this one up in a way that looks built into a wall
	gpstag = SPACE_SIGNAL_GPSTAG	//really the only non-aesthetic change, gives the space ruin GPS signal

/obj/item/gps/computer/space/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(I.use_tool(src, user, 20, volume=50))
		user.visible_message(span_warning("[user] disassembles [src]."),
			span_notice("You start to disassemble [src]..."), span_hear("You hear clanking and banging noises."))
		deconstruct(TRUE)
	return TRUE

/obj/item/gps/computer/space/atom_deconstruct(disassembled)
	. = ..()
	new /obj/item/gps/spaceruin(loc)	//really the only non-aesthetic change, gives the space ruin GPS signal

/obj/item/gps/computer/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	attack_self(user)

/**
 * Power related machines
 */

/// Primarily a replacement for Bluespace SMES/RTG spam into be something more realistic
/obj/machinery/power/micro_reactor
	icon = 'modular_nova/modules/mapping/icons/machinery/reactor.dmi'
	name = "micro reactor"
	desc = "Designed as a self-containing powersource for long-haul vessels, the stamp of SOAR Industries \
		on the top. A steady output once active with plenty of safety features to ensure a meltdown is not possible, \
		having one installed means a steady clean powersource for between 75-125 years."
	icon_state = "reactor0_0"
	base_icon_state = "reactor0"
	density = TRUE
	anchored = TRUE

	var/power_gen = 200 KILO WATTS
	var/active = FALSE
	var/power_output = 1

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

	light_color = LIGHT_COLOR_ELECTRIC_CYAN
	light_on = FALSE

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
