/obj/machinery/power/rtg/portable
	name = "High-Temperature Self-Contained Reaction Generator"
	desc = "The ultimate in 'middle of nowhere' power generation. Unlike standard RTGs, this particular \
		design of generator uses a volatile compound reacting with unstable elements to create a constant trickle of power \
		There's a label on the side reminding operators that the contents are under heavy pressure, and that impacts should be avoided at all costs. \
		It has a yellow radioactive warning, minor radiation posibility. Do not store tomatos nearby."
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	circuit = null
	power_gen = 15 KILO WATTS // 50% more than a t4 solar or winded turbine.
	max_integrity = 40
	/// What we turn into when we are repacked
	var/repacked_type = /obj/item/flatpacked_machine/rtg

/obj/machinery/power/rtg/portable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/radioactive, 1, RAD_LIGHT_INSULATION, URANIUM_IRRADIATION_CHANCE * 0.5, URANIUM_RADIATION_MINIMUM_EXPOSURE_TIME * 7)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	if(!mapload)
		flick("rtg_deploy", src)

// Item for creating the arc furnace or carrying it around

// formerly NO_DECONSTRUCTION
/obj/machinery/power/rtg/portable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/rtg/portable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/rtg/portable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/power/rtg/portable/atom_destruction(damage_flag)
	if (damage_flag)
		var/turf/this_turf = get_turf(src)
		explosion(src, devastation_range = 0, heavy_impact_range = 2, light_impact_range = 4, flash_range = 5, adminlog = TRUE)
		var/datum/effect_system/explosion/explosiooon
		explosiooon = new /datum/effect_system/explosion/smoke
		explosiooon.set_up(this_turf)
		playsound(this_turf, 'sound/effects/chemistry/shockwave_explosion.ogg', 80, TRUE)
		explosiooon.start()
	return ..()

/obj/item/flatpacked_machine/rtg
	name = "flat-packed radioisotope thermoelectric generator"
	desc = "A deployable radioisotope generator capable of producing a practically free trickle of power. \
		It's improved radiation shielding and stabilizing agents left it inert, if volatile."
	icon_state = "rtg_packed"
	type_to_deploy = /obj/machinery/power/rtg/portable
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
