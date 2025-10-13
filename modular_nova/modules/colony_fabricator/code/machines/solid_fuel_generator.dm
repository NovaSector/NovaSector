/obj/machinery/power/port_gen/pacman/solid_fuel
	name = "\improper A.W-type portable generator"
	desc = "The second most common generator design in the galaxy, second only to the P.A.C.M.A.N. \
		This new and improved Akhter design of the A.W (Atomic Whisperer) is similar to other micro fission reactors in its use, using a hybrid temperature moderated design, \
		this design opts for spinning panels used to absorb radiation using an advanced decay process to turn the radiation into 520C helium and water. \
		This however comes at a cost of being more resource intensive to produce and must be <b>bolted to the ground<b> in order to function. \
		A massive warning label indicates to have capacitated supervision when trying to harvest and export the profitable byproduct gasses."
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "fuel_generator_0"
	base_icon_state = "fuel_generator"
	circuit = null
	anchored = TRUE
	max_sheets = 25 // 50% worse than pacman, 25% better than superpacman
	time_per_sheet = parent_type::time_per_sheet // pacman is 180, superpacman is 60, this make it thrice as efficient as the super pacman
	power_gen = parent_type::power_gen *2 // superpacman is 3, but, one sheet is consumed thrice as fast and they have a limit of 20 sheets.
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
/obj/machinery/power/port_gen/pacman/solid_fuel/on_construction(mob/user, from_flatpack)
	return

/obj/machinery/power/port_gen/pacman/solid_fuel/process()
	. = ..()
	if(active)
		var/turf/where_we_spawn_air = get_turf(src)
		where_we_spawn_air.atmos_spawn_air("water_vapor=9;TEMP=400") 
		where_we_spawn_air.atmos_spawn_air("helium=1;TEMP=400")

// Item for creating the generator or carrying it around

/obj/item/flatpacked_machine/fuel_generator
	name = "flat-packed A.W-type portable generator"
	desc = /obj/machinery/power/port_gen/pacman/solid_fuel::desc
	icon_state = "fuel_generator_packed"
	type_to_deploy = /obj/machinery/power/port_gen/pacman/solid_fuel
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
/obj/machinery/power/port_gen/pacman/solid_fuel/Initialize(mapload)
	. = ..()
	QDEL_NULL(soundloop)
	soundloop = new /datum/looping_sound/solid_fuel_generator(src, active)
