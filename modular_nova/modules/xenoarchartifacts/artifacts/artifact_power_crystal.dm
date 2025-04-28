// This is the power crystal, that basically generates lots of power when it is:
// 1) Wrenched down to the floor turf where the cable ends
// 2) Has wired = 1 (click on it with the cable to enable and with cutters to disable)

/obj/machinery/power/crystal
	name = "large crystal"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi'
	icon_state = "artifact_11"
	density = TRUE
	anchored = FALSE
	var/datum/artifact_effect/first_effect
	var/wired = FALSE
	var/icon_custom_crystal = null

/obj/machinery/power/crystal/Initialize(mapload)
	. = ..()
	first_effect = new /datum/artifact_effect/powernet(src)
	if(anchored)
		connect_to_network()
	icon_custom_crystal = pick("artifact_11", "artifact_12", "artifact_13")
	icon_state = icon_custom_crystal
	desc = pick("It shines faintly as it catches the light.", "It appears to have a faint inner glow.",
                "It seems to draw you inward as you look it at.", "Something twinkles faintly as you look at it.",
                "It's mesmerizing to behold.")

/obj/machinery/power/crystal/attackby(obj/item/attack_item, mob/user)
	if(default_unfasten_wrench(user, attack_item))
		anchored ? connect_to_network() : disconnect_from_network()
		update_crystal()
		return

	if(attack_item.tool_behaviour == TOOL_WIRECUTTER) // If we want to remove the wiring
		if(wired)
			user.visible_message(
				span_notice("[user] starts cutting off the wiring of the [src]."),
				span_notice("You start cutting off the wiring of the [src]."),
				blind_message = span_hear("You hear cutting nearby."),
			)
			if(attack_item.use_tool(src, user, 20, volume = 50))
				user.visible_message(
					span_notice("[user] cuts off the wiring of the [src]."),
					span_notice("You cut off the wiring of the [src]."),
					blind_message = span_notice("Cutting sound stops."),
				)
				wired = FALSE
				update_crystal()
				return
		else
			to_chat(user, span_red("There is currently no wiring on the [src]."))
			return

	if(istype(attack_item, /obj/item/stack/cable_coil)) // If we want to put the wiring
		if(!wired)
			var/obj/item/stack/cable_coil/our_cable_coil = attack_item
			if(!our_cable_coil.use(2))
				to_chat(user, span_red("There's not enough wire to finish the task."))
				return
			user.visible_message(
				span_notice("[user] starts putting the wiring all over the [src]."),
				span_notice("You start putting the wiring all over the [src]."),
			)
			if(attack_item.use_tool(src, user, 20, volume = 50))
				user.visible_message(
					span_notice("[user] puts the wiring all over the [src]."),
					span_notice("You put the wiring all over the [src]."),
				)
				wired = TRUE
				update_crystal()
			return
		else
			balloon_alert(user, "already wired!")
			return
	return ..()

/obj/machinery/power/crystal/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))
		to_chat(user, span_warning("You can't reach [src] from here."))
		return TRUE
	if(wired && anchored)
		first_effect.ToggleActivate()
		update_crystal()
	to_chat(user, span_bold("You touch [src]."))

/obj/machinery/power/crystal/Destroy()
	if(first_effect)
		QDEL_NULL(first_effect)
	visible_message(
		span_warning("[src] shatters!"),
		blind_message = span_hear("You hear glass breaking nearby."),
	)
	var/turf/mainloc = get_turf(src)
	var/count_crystal_bs = rand(1,3)
	for(var/i = 0 to count_crystal_bs - 1)
		new /obj/item/stack/sheet/bluespace_crystal(mainloc)
	var/count_shard = rand(1,10)
	for(var/i = 0 to count_shard - 1)
		new /obj/item/shard(mainloc)
	return ..()

/**
 * Updates the icon, according to the activation/wired status
 */
/obj/machinery/power/crystal/proc/update_crystal()
	if(wired && anchored && first_effect.activated)
		icon_state = "[icon_custom_crystal]_active"
	else
		icon_state = icon_custom_crystal
	if(wired)
		add_overlay(image('modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi', "crystal_overlay"))
	else
		cut_overlays()

// laser_act
/obj/machinery/power/crystal/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	if(istype(hitting_projectile, /obj/projectile/energy) || istype(hitting_projectile, /obj/projectile/beam))
		visible_message(
			span_danger("The [hitting_projectile] gets reflected by [src]!")
		)
		// Find a turf near or on the original location to bounce to
		if(hitting_projectile.starting)
			hitting_projectile.reflect(src)
		return
	return ..()
