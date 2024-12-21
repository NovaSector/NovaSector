#define INTERDICTION_LENS_RANGE 4
#define POWER_PER_PERSON 5

/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens
	name = "interdiction lens"
	desc = "A mesmerizing light that flashes to a rhythm that you just can't stop tapping to."
	clockwork_desc = "A small device which will slow down nearby attackers and projectiles at a large power cost, both active and passive."
	icon_state = "interdiction_lens"
	base_icon_state = "interdiction_lens"
	anchored = TRUE
	break_message = span_warning("The interdiction lens breaks into multiple fragments, which gently float to the ground.")
	max_integrity = 150
	minimum_power = POWER_PER_PERSON
	passive_consumption = 25
	var/datum/proximity_monitor/advanced/dampening_field


/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens/Destroy()
	if(enabled)
		STOP_PROCESSING(SSobj, src)
	QDEL_NULL(dampening_field)
	return ..()


/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens/process(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(SPT_PROB(3, seconds_per_tick))
		new /obj/effect/temp_visual/steam_release(get_turf(src))

	for(var/mob/living/living_mob in viewers(INTERDICTION_LENS_RANGE, src))
		if(!IS_CLOCK(living_mob) && use_power(POWER_PER_PERSON))
			living_mob.apply_status_effect(/datum/status_effect/interdiction)

	for(var/obj/vehicle/sealed/mecha/mech in range(INTERDICTION_LENS_RANGE, src))
		if(!use_power(POWER_PER_PERSON))
			continue

		mech.emp_act(EMP_HEAVY)
		do_sparks(mech, TRUE, mech)


/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens/repowered()
	. = ..()
	flick("interdiction_lens_recharged", src)

	if(istype(dampening_field))
		QDEL_NULL(dampening_field)

	dampening_field = new(src, INTERDICTION_LENS_RANGE, TRUE, src)


/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens/depowered()
	. = ..()
	flick("interdiction_lens_discharged", src)
	QDEL_NULL(dampening_field)


/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens/free/use_power(amount)
	return


/obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens/free/check_power(amount)
	if(!LAZYLEN(transmission_sigils))
		return FALSE
	return TRUE


//Dampening field

/datum/proximity_monitor/advanced/projectile_dampener/peaceborg/clockwork/catch_bullet_effect(obj/projectile/bullet)
	var/mob/living/shooter = bullet.firer
	if(istype(shooter) && IS_CLOCK(shooter))
		return
	. = ..()

#undef INTERDICTION_LENS_RANGE
#undef POWER_PER_PERSON
