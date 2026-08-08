/obj/effect/wind/shipbreaking_collector
	name = "salvage inlet collector field"
	desc = "Creates an artificial pull in the direction it moves, typically towards a nearby salvage collector inlet."
	icon = 'modular_nova/modules/shipbreaking/icons/inlet.dmi'
	icon_state = "inlet"
	invisibility = 0
	color = "#4699a6"
	light_range = 1
	light_power = 2
	light_on = TRUE

/obj/effect/wind/shipbreaking_collector/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)
	light_color = color

/obj/effect/wind/shipbreaking_collector/update_overlays()
	. = ..()
	. += emissive_appearance(icon, icon_state, src)

/obj/effect/wind/shipbreaking_collector/scrap
	color = "#d99f3a"
