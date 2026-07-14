/obj/structure/shuttle_decoration/rcs
	name = "reaction control thruster"
	desc = "A small cold gas thruster used to orient the ship in place while in space."
	icon_state = "rcs"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/rcs, 5)

/obj/structure/shuttle_decoration/ladder
	name = "\improper EVA ladder"
	desc = "An exterior ladder for use on EVA."
	icon_state = "ladder_silver"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/ladder, 5)

/obj/structure/shuttle_decoration/ladder_black
	name = "\improper EVA ladder"
	desc = "An exterior ladder for use on EVA."
	icon_state = "ladder_black"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/ladder_black, 5)

/obj/structure/shuttle_decoration/eva_catwalks
	name = "\improper EVA catwalk"
	desc = "A narrow catwalk for use on EVA."
	icon_state = "catwalk"
	layer = CATWALK_LAYER
	plane = FLOOR_PLANE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/eva_catwalks, 16)

/obj/structure/shuttle_decoration/radiator
	name = "shuttle radiator"
	desc = "A modular heat radiator for use on ships, uses a few valuable heat conductive metals in the fins."
	icon_state = "radiator"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/radiator, 4)

/obj/structure/shuttle_decoration/extinguisher
	name = "exterior extinguisher rack"
	desc = "A pair of extinguisher canisters with an activation switch, will flood the space on the other side of its \
		mounting wall with extinguisher foam when triggered."
	icon_state = "extinguisher"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	integrity_failure = 0.6
	/// How long does it take to pull the switch?
	var/switch_time = 2 SECONDS
	/// Has the extinguisher been used up?
	var/used_up = FALSE

/obj/structure/shuttle_decoration/extinguisher/examine(mob/user)
	. = ..()
	if(used_up)
		. += span_notice("The gauge on the control panel shows the tanks are empty, it must be used up.")

/obj/structure/shuttle_decoration/extinguisher/interact(mob/user)
	if(!anchored)
		return
	if(used_up)
		return
	if(!do_after(user, switch_time, src))
		return
	playsound(src, 'sound/effects/bamf.ogg', 75, TRUE)
	var/turf/foam_turf = get_step(src, REVERSE_DIR(dir))
	make_the_foam(foam_turf)

/obj/structure/shuttle_decoration/extinguisher/atom_break(damage_flag)
	. = ..()
	var/turf/foam_turf = get_step(src, dir)
	make_the_foam(foam_turf)

/// Makes a cloud of extinguisher foam at the tile given
/obj/structure/shuttle_decoration/extinguisher/proc/make_the_foam(turf/target_turf)
	var/datum/reagents/foam_reagents = new /datum/reagents/(60)
	foam_reagents.add_reagent(/datum/reagent/firefighting_foam, 60)
	var/datum/effect_system/fluid_spread/foam/foam = new(loc, 4, holder = src, location = target_turf, carry = foam_reagents)
	foam.start()

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/extinguisher, 4)

/obj/structure/shuttle_decoration/bullbar
	name = "crash bar"
	desc = "A strong grid of bars connected to ships to protect the hull during collisions. \
		Commonly referred to as a \"Carp Catcher\"."
	icon_state = "bullbar"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/bullbar, 4)

/obj/structure/shuttle_decoration/headlight
	name = "shuttle headlights"
	desc = "An array of high-power lights for visibility around shuttles."
	icon_state = "headlight"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	light_on = TRUE
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_color = LIGHT_COLOR_CYAN
	light_range = 5
	light_power = 2

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/headlight, 0)

/obj/structure/shuttle_decoration/landing_engine
	name = "landing engine"
	desc = "A gimballed engine for planetgoing shuttles that need to land any direction other than vertical."
	icon_state = "lander"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/landing_engine, 15)

/obj/structure/shuttle_decoration/aux_engine
	name = "auxiliary engine"
	desc = "A smaller engine used for extra power or extra agility on ships."
	icon_state = "aux_booster"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/aux_engine, 10)

/obj/structure/shuttle_decoration/junction_box
	name = "junction box"
	desc = "A power junction box for routing high voltage power through a ship's systems."
	icon_state = "junction"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/junction_box, 4)

/obj/structure/shuttle_decoration/console
	name = "computer console"
	desc = "Controls for the ship, monitoring for the reactor, or even just a screen for watching \"Extremely Large Baseball\" on."
	icon_state = "console"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/shuttle_decoration/console, 10)
