/obj/item/summon_beacon/scrap_beacon
	name = "scrap beacon beacon"
	desc = "Delivers a trash beacon directly to your location. Look up!"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "icra_delivery"

	selectable_atoms = list(
		/obj/structure/scrap_beacon,
	)

/obj/structure/shell_scrap_beacon
	name = "scrap beacon shell"
	desc = "A hollow frame for a scrap beacon. It needs an anomaly core, some wrenching, and welding to be completed."
	icon = 'modular_regzt/icons/obj/structures/scrap/scrap_beacon.dmi'
	icon_state = "beacon_shell"
	anchored = TRUE
	max_integrity = 500
	density = TRUE
	layer = MOB_LAYER + 1

	var/obj/item/core = null
	var/screwed = FALSE

/obj/structure/shell_scrap_beacon/attackby(obj/item/I, mob/user, params)
	//weld
	if(I.tool_behaviour == TOOL_WELDER)
		if(!core)
			if(!I.tool_start_check(user, amount=1))
				return
			to_chat(user, span_notice("You begin deconstructing the empty shell..."))
			if(I.use_tool(src, user, 40, volume=50))
				to_chat(user, span_notice("You cut the shell into scrap metal."))
				new /obj/item/stack/sheet/plasteel(get_turf(src), 10)
				qdel(src)
			return

		//assembl
		if(screwed)
			if(!I.tool_start_check(user, amount=1))
				return
			user.visible_message(span_notice("[user] begins welding the shell shut."), \
								span_notice("You start welding the beacon's casing."))
			if(I.use_tool(src, user, 50, volume=50))
				to_chat(user, span_nicegreen("You weld the casing shut. The scrap beacon hums to life!"))
				var/obj/structure/scrap_beacon/B = new(get_turf(src))
				if(core)
					core.forceMove(B)
					B.core = core
				qdel(src)
			return
		else
			to_chat(user, span_warning("You need to secure the core with a wrench before welding!"))
			return

	//WRENCH
	if(I.tool_behaviour == TOOL_WRENCH)
		if(!core)
			to_chat(user, span_warning("There is nothing to screw in the shell."))
			return

		if(!screwed) // ЗАКРУЧИВАЕМ
			user.visible_message(span_notice("[user] begins securing the core."), \
								span_notice("You start tightening the core's bolts."))
			if(I.use_tool(src, user, 30, volume=50))
				screwed = TRUE
				to_chat(user, span_notice("You secure the core to the frame."))
				icon_state = "beacon_core"
		else // ОТКРУЧИВАЕМ ОБРАТНО
			user.visible_message(span_notice("[user] begins loosening the core's bolts."), \
								span_notice("You start unscrewing the core."))
			if(I.use_tool(src, user, 30, volume=50))
				screwed = FALSE
				to_chat(user, span_notice("You unscrew the core. It is now loose."))
				icon_state = "beacon_core"
		return

	// --- ЛОМ (CROWBAR) ---
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(!core)
			to_chat(user, span_warning("There is nothing to pry out of the shell."))
			return
		if(screwed)
			to_chat(user, span_warning("The core is bolted down! Unscrew it first."))
			return

		// ВЫТААСКИВАЕМ ЯДРО
		user.visible_message(span_notice("[user] begins prying the core out of the shell."), \
							span_notice("You start prying the core out."))
		if(I.use_tool(src, user, 30, volume=50))
			to_chat(user, span_notice("You pry the core out of the frame."))
			core.forceMove(get_turf(src)) // Выкидываем на пол
			core = null
			icon_state = "beacon_shell"
		return

	// --- ВСТАВКА ЯДРА ---
	if(istype(I, /obj/item/assembly/signaler/anomaly/grav))
		if(core)
			to_chat(user, span_warning("There is already a core inside!"))
			return
		if(user.transferItemToLoc(I, src))
			core = I
			to_chat(user, span_notice("You carefully insert [I] into the shell."))
			icon_state = "beacon_core"
		return

	return ..()

/obj/structure/scrap_beacon
	name = "Scrap Beacon"
	desc = "This machine generates directional gravity rays which catch trash orbiting around."
	icon = 'modular_regzt/icons/obj/structures/scrap/scrap_beacon.dmi'
	icon_state = "beacon0"
	max_integrity = INFINITY
	anchored = TRUE
	density = TRUE
	layer = MOB_LAYER + 1
	var/summon_cooldown = 90 SECONDS //120 таукеки
	var/impact_speed = 3
	var/impact_prob = 100
	var/impact_range = 1
	var/last_summon = -3000
	var/active = FALSE
	var/emagged = FALSE
	var/obj/item/core = null
	var/screwed = TRUE

/obj/structure/scrap_beacon/attackby(obj/item/I, mob/user, params)
	// РАЗБОРКА: Шаг 1 — Сварка (Вскрытие корпуса)
	if(I.tool_behaviour == TOOL_WELDER)
		if(!I.tool_start_check(user, amount=1))
			return

		user.visible_message(span_notice("[user] starts cutting open [src]'s outer casing."), \
							span_notice("You begin cutting through the outer casing."))

		if(I.use_tool(src, user, 50, volume=50))
			to_chat(user, span_notice("You cut the casing open. The beacon powers down."))

			// Возвращаем состояние оболочки
			var/obj/structure/shell_scrap_beacon/S = new(get_turf(src))
			if(core)
				core.forceMove(S)
				S.core = core
			S.screwed = TRUE
			S.icon_state = "beacon_core"
			qdel(src)
		return

	return ..()

/obj/structure/scrap_beacon/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if((last_summon + summon_cooldown) >= world.time)
		to_chat(user, span_notice("[src.name] is not charged yet."))
		return
	last_summon = world.time
	if(!active)
		start_scrap_summon()

/obj/structure/scrap_beacon/update_icon_state()
	icon_state = "beacon[active ? 1 : 0]"
	return ..()

/obj/structure/scrap_beacon/emag_act(mob/user)
	if(emagged)
		return FALSE
	to_chat(user, span_warning("You are overloading a dangerous range protocols."))
	emagged = TRUE
	impact_range = 3
	impact_speed = 1
	return TRUE

/obj/structure/scrap_beacon/proc/start_scrap_summon()
	active = TRUE
	//playsound(src, 'sound/machines/scrap_beacon_start.ogg', 50, FALSE)
	update_appearance()

	sleep(30)
	var/list/flooring_near_beacon = list()
	for(var/turf/T in range(impact_range, src))
		if(!isfloorturf(T))
			continue
		if(locate(/obj/structure/scrap_pile) in T)
			continue
		if(!prob(impact_prob))
			continue
		flooring_near_beacon += T

	flooring_near_beacon -= src.loc
	while(flooring_near_beacon.len > 0)
		sleep(impact_speed)
		var/turf/newloc = pick(flooring_near_beacon)
		flooring_near_beacon -= newloc
		var/scrap_type = pick(
			1; /obj/structure/scrap_pile/material,
			3; /obj/structure/scrap_pile/maintenance,
			4; /obj/structure/scrap_pile/trash,
			2; /obj/structure/scrap_pile/food,
			2; /obj/structure/scrap_pile/cloth,
			2; /obj/structure/scrap_pile/poor,
			2; /obj/structure/scrap_pile/medical,
			2; /obj/structure/scrap_pile/industrial,
			1; /obj/structure/scrap_pile/science,
		)

		new scrap_type(newloc)

	active = FALSE
	update_appearance()
