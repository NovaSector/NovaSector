/obj/item/flashlight/sky_lantern
	name = "sky lantern"
	desc = "A delicate paper lantern designed to float and glow. Often released during festivals or rituals."
	icon = 'modular_nova/modules/holidays/sky_lanterns/icons/sky_lanterns.dmi'
	icon_state = "sky_lantern"
	light_range = 4
	light_power = 1.2
	light_color = "#ffd966"
	light_system = OVERLAY_LIGHT

/obj/item/flashlight/sky_lantern/Initialize(mapload)
	. = ..()
	if(light_on)
		start_floating()

/obj/item/flashlight/sky_lantern/toggle_light(mob/user)
	. = ..()
	if(light_on)
		start_floating()
	else
		stop_floating()

/datum/crafting_recipe/sky_lantern
	name = "sky lantern"
	result = /obj/item/flashlight/sky_lantern
	reqs = list(/obj/item/paper = 2,/obj/item/flashlight/flare/candle/ = 1, /obj/item/stack/rods = 1 )
	time = 5 SECONDS
	category = CAT_MISC

/obj/item/flashlight/sky_lantern/proc/start_floating()
	var/up_time = rand(8,12)
	var/down_time = rand(8,12)
	var/side_time = rand(15,20)

	// Vertical bob
	animate(src, pixel_z = 1, time = up_time, loop = -1, flags = ANIMATION_RELATIVE)
	animate(src, pixel_z = -1, time = down_time, flags = ANIMATION_RELATIVE)

	// Horizontal sway
	animate(src, pixel_y = 1, time = side_time, loop = -1, flags = ANIMATION_RELATIVE)
	animate(src, pixel_y = -1, time = side_time, flags = ANIMATION_RELATIVE)

	// Scale pulse (slightly smaller, then back to normal)
	animate(src, transform = matrix(0.95, 0, 0, 0.95, 0, 0), time = 10, loop = -1)
	animate(src, transform = matrix(1, 0, 0, 1, 0, 0), time = 10)


/obj/item/flashlight/sky_lantern/proc/stop_floating()
	animate(src, pixel_z = 0, pixel_y = 0, flags = ANIMATION_END_NOW)
