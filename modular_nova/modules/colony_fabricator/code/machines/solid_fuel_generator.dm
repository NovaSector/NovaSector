/obj/machinery/power/port_gen/pacman/solid_fuel
	name = "\improper A.W-type portable generator"
	desc = "The second most common generator design in the galaxy, second only to the P.A.C.M.A.N. \
		The A.W(Atomic Whisper) is similar to other generators in it's use \
		but instead of burning fuel, it uses uranium for small scale reactions. \
		Unlike other generators however, this one isn't as portable, or as safe to operate, \
		but at least it makes a hell of a lot more power. Must be <b>bolted to the ground</b> \
		and <b>attached to a wire</b> before use. A massive warning label wants you to know that this generator \
		is not only radioactive, but also<b>outputs heated steam from it's water recycler into the atmosphere.</b>."
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "fuel_generator_0"
	base_icon_state = "fuel_generator"
	circuit = null
	anchored = TRUE
	max_sheets = 25
	time_per_sheet = parent_type::time_per_sheet * (2) //100% better
	power_gen = parent_type::power_gen * 3.2
	drag_slowdown = 1.5
	sheet_path = /obj/item/stack/sheet/mineral/uranium
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/fuel_generator

/obj/machinery/power/port_gen/pacman/solid_fuel/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	if(!mapload)
		flick("fuel_generator_deploy", src)

// formerly NO_DECONSTRUCTION
/obj/machinery/power/port_gen/pacman/solid_fuel/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/port_gen/pacman/solid_fuel/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/port_gen/pacman/solid_fuel/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// We don't need to worry about the board, this machine doesn't have one!
/obj/machinery/power/port_gen/pacman/solid_fuel/on_construction(mob/user)
	return

/obj/machinery/power/port_gen/pacman/solid_fuel/proc/emit_radiation()
		radiation_pulse(
		src,
		max_range = 2,
	)

/obj/machinery/power/port_gen/pacman/solid_fuel/process()
	. = ..()
	if(active)
		emit_radiation()
		var/turf/where_we_spawn_air = get_turf(src)
		where_we_spawn_air.atmos_spawn_air("water_vapor=10;TEMP=840") // Mid-range steam output temp for nuclear reactors is around 520C or 840K.

// Item for creating the generator or carrying it around

/obj/item/flatpacked_machine/fuel_generator
	name = "flat-packed A.W-type portable generator"
	desc = /obj/machinery/power/port_gen/pacman/solid_fuel::desc
	icon_state = "fuel_generator_packed"
	type_to_deploy = /obj/machinery/power/port_gen/pacman/solid_fuel
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
