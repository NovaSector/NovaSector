/obj/structure/antfarm
	name = "ant farm"
	desc = "Though it may look natural, this was not made by ants."
	icon = 'modular_nova/modules/ashwalkers/icons/structures.dmi'
	icon_state = "anthill"
	density = TRUE
	anchored = TRUE

	/// If the farm is occupied by ants
	var/has_ants = FALSE

	/// the chance for the farm to get ants
	var/ant_chance = 0

	/// the list of ore-y stuff that ants can drag up from deep within their nest
	var/list/ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/glass/basalt = 20,
		/obj/item/stack/ore/plasma = 14,
		/obj/item/stack/ore/silver = 8,
		/obj/item/xenoarch/strange_rock = 8,
		/obj/item/stack/stone = 8,
		/obj/item/stack/sheet/mineral/coal = 8,
		/obj/item/stack/ore/titanium = 8,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/gold = 3,
	)

	// The cooldown between each worm "breeding"
	COOLDOWN_DECLARE(ant_timer)

/obj/structure/antfarm/Initialize(mapload)
	. = ..()
	var/turf/src_turf = get_turf(src)
	if(!src_turf.GetComponent(/datum/component/simple_farm))
		src_turf.balloon_alert_to_viewers("must be on farmable surface")
		return INITIALIZE_HINT_QDEL

	for(var/obj/structure/antfarm/found_farm in range(2, get_turf(src)))
		if(found_farm == src)
			continue

		src_turf.balloon_alert_to_viewers("too close to another farm")
		return INITIALIZE_HINT_QDEL

	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, ant_timer, 30 SECONDS)

/obj/structure/antfarm/Destroy()
	STOP_PROCESSING(SSobj, src)
	new /obj/item/stack/ore/glass(get_turf(src), 20)
	return ..()

/obj/structure/antfarm/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, ant_timer))
		return

	COOLDOWN_START(src, ant_timer, 30 SECONDS)

	if(!has_ants)
		if(prob(ant_chance))
			balloon_alert_to_viewers("ants have appeared!")
			has_ants = TRUE

		return

	var/spawned_ore = pick_weight(ore_list)
	new spawned_ore(get_turf(src))

/obj/structure/antfarm/examine(mob/user)
	. = ..()
	. += span_notice("<br>There are currently [has_ants ? "" : "no "]ants in the farm.")
	if(!has_ants)
		. += span_notice("To add ants, feed the farm some <b>food</b>.")

/obj/structure/antfarm/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/food))
		if(has_ants)
			balloon_alert(user, "ants block the way!")
			return ITEM_INTERACT_BLOCKING

		qdel(tool)
		balloon_alert(user, "food has been placed")
		user.mind?.adjust_experience(/datum/skill/primitive, 2)
		ant_chance++
		if(prob(user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
			ant_chance++
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/storage/bag/plants))
		if(has_ants)
			balloon_alert(user, "ants block the way!")
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "feeding the ants")
		for(var/obj/item/food/selected_food in tool.contents)
			var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
			if(has_ants || !do_after(user, 1 SECONDS * skill_modifier, src))
				return ITEM_INTERACT_BLOCKING

			user.mind?.adjust_experience(/datum/skill/primitive, 2)
			qdel(selected_food)
			ant_chance++
			if(prob(user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
				ant_chance++

		return ITEM_INTERACT_BLOCKING

	return ITEM_INTERACT_SUCCESS
