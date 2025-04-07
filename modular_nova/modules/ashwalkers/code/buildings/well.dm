/obj/structure/water_source/fuel_well
	name = "fuel well"
	desc = "A bubbling pool of fuel. This would probably be valuable, had bluespace technology not destroyed the need for fossil fuels 200 years ago."
	icon_state = "puddle-oil"
	dispensedreagent = /datum/reagent/fuel
	color = "#742912"	//Gives it a weldingfuel hue

//attack hand is for cleaning stuff on the parent obj, and I don't want you cleaning stuff with welding fuel!
/obj/structure/water_source/fuel_well/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	flick("puddle-oil-splash", src)
	reagents.expose(user, TOUCH, 20) //Covers target in 20u of fuel.
	to_chat(user, span_warning("You touch the pool of fuel, only to get fuel all over yourself! It would be wise to wash this off with water."))

/obj/structure/water_source/fuel_well/attackby(obj/item/attacking_item, mob/living/user, params)
	flick("puddle-oil-splash", src)
	return ..()

/obj/structure/water_source/fuel_well/shovel_act(mob/living/user, obj/item/tool)
	to_chat(user, "You fill in [src] with soil.")
	tool.play_tool_sound(src)
	deconstruct()

/obj/structure/water_source/fuel_well/welder_act(mob/living/user, obj/item/tool)
	var/obj/item/weldingtool/attacking_welder = tool
	if(istype(attacking_welder) && !attacking_welder.welding)
		if(attacking_welder.reagents.has_reagent(/datum/reagent/fuel, attacking_welder.max_fuel))
			to_chat(user, span_warning("Your [attacking_welder.name] is already full!"))
			return

		reagents.trans_to(attacking_welder, attacking_welder.max_fuel, transferred_by = user)
		user.visible_message(span_notice("[user] refills [user.p_their()] [attacking_welder.name]."), span_notice("You refill [attacking_welder]."))
		playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
		attacking_welder.update_appearance()
		return

/obj/structure/water_source/brick_well
	name = "brick well"
	desc = "Brick by brick, a well has been built to access great water reserves that lay untapped underneath."
	icon = 'modular_nova/modules/ashwalkers/icons/structures.dmi'
	icon_state = "brick_well"
	density = TRUE

	///determines whether it is covered, and whether it needs to have the ground below it dug out
	var/well_covered = FALSE

/**
 * To check if the well is on the correct turf type-- must be a diggable turf (asteroid) or else returns false
 */
/obj/structure/water_source/brick_well/proc/correct_turf()
	var/turf/src_turf = get_turf(src)
	if(istype(src_turf, /turf/open/misc/asteroid))
		return src_turf

	return FALSE

/**
 * If well_covered is true, then itll always work (on the right turf!); otherwise, check the below turf to see if it is dug
 */
/obj/structure/water_source/brick_well/proc/cover_work()
	if(!correct_turf())
		return FALSE

	if(well_covered)
		return TRUE

	var/turf/open/misc/asteroid/asteroid_turf = correct_turf()
	if(!asteroid_turf.dug)
		return FALSE

	return TRUE

//attack hand is for cleaning stuff, but if the well isn't working, then we can't wash!
/obj/structure/water_source/brick_well/attack_hand(mob/living/user, list/modifiers)
	if(!cover_work())
		to_chat(user, span_warning("[src] needs to have [get_turf(src)] dug out to work!"))
		return

	return ..()

/obj/structure/water_source/brick_well/shovel_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("You begin to deconstruct [src]."))
	tool.play_tool_sound(src)
	if(!do_after(user, 5 SECONDS, target = src))
		return

	to_chat(user, span_notice("You deconstruct [src]."))
	tool.play_tool_sound(src)
	deconstruct()

//I don't enjoy the fact it is an attackby, but the parent obj uses this proc, so I'm putting the cover check here as well
/obj/structure/water_source/brick_well/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/wood))
		if(well_covered)
			to_chat(user, span_notice("[src] is already covered..."))
			return

		if(!attacking_item.use(3))
			to_chat(user, span_warning("[src] requires three pieces of wood to construct a cover!"))
			return

		to_chat(user, span_notice("You begin to build a cover."))
		if(!do_after(user, 5 SECONDS, target = src))
			return

		to_chat(user, span_notice("You built a cover."))
		well_covered = TRUE
		add_overlay("well_cover")
		return

	if(!cover_work())
		to_chat(user, span_warning("[src] needs to have [get_turf(src)] dug out to work!"))
		return

	return ..()
