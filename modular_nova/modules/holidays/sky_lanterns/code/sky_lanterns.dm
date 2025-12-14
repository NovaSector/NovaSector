/obj/item/flashlight/sky_lantern
	name = "sky lantern"
	desc = "A delicate paper lantern designed to float and glow. Often released during festivals or rituals."
	icon = 'modular_nova/modules/holidays/sky_lanterns/icons/sky_lanterns.dmi'
	icon_state = "sky_lantern" //Sprites by diltyrr on Nova's discord.
	light_range = 4
	light_power = 1.2
	light_color = "#ffd966"
	light_system = OVERLAY_LIGHT
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.1)
	///check if we're floating to prevent redundant add/remove
	var/is_floating = FALSE

/// Centralized state controller (immediate)
/obj/item/flashlight/sky_lantern/proc/update_floating_state_immediate()
	if(light_on && isturf(loc))
		start_floating(src)
	else
		stop_floating(src)

/// Deferred state controller (to wait after other animations play)
/obj/item/flashlight/sky_lantern/proc/update_floating_state_deferred(delay = 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(update_floating_state_immediate)), delay, TIMER_STOPPABLE | TIMER_DELETE_ME)

/// Apply flying trait if not already applied
/obj/item/flashlight/sky_lantern/proc/start_floating()
	if(is_floating)
		return
	is_floating = TRUE
	// Avoid duplicate element/trait application
	if(!HAS_TRAIT(src, TRAIT_MOVE_FLYING))
		AddElement(/datum/element/movetype_handler)
		ADD_TRAIT(src, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))

/// Remove flying trait if present
/obj/item/flashlight/sky_lantern/proc/stop_floating()
	if(!is_floating)
		return
	is_floating = FALSE
	if(HAS_TRAIT(src, TRAIT_MOVE_FLYING))
		REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))
		RemoveElement(/datum/element/movetype_handler)

/obj/item/flashlight/sky_lantern/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/item/flashlight/sky_lantern/LateInitialize()
	update_floating_state_immediate()

/obj/item/flashlight/sky_lantern/toggle_light(mob/user)
	. = ..()
	update_floating_state_immediate()

/obj/item/flashlight/sky_lantern/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	update_floating_state_deferred(1 SECONDS)

/obj/item/flashlight/sky_lantern/dropped(mob/user, silent)
	. = ..()
	update_floating_state_deferred(1 SECONDS)

/obj/item/flashlight/sky_lantern/equipped(mob/user, slot)
	. = ..()
	update_floating_state_immediate()

/datum/crafting_recipe/sky_lantern
	name = "sky lantern"
	result = /obj/item/flashlight/sky_lantern
	reqs = list(/obj/item/paper = 2, /obj/item/flashlight/flare/candle = 1, /obj/item/stack/cable_coil = 1)
	time = 5 SECONDS
	category = CAT_MISC
