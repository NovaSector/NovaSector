/datum/artifact_effect/machinery_mess
	log_name = "H1DDen c0Mp0NeNT$ 0veRRiDE"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/machinery_mess/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE

/datum/artifact_effect/machinery_mess/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	try_animate(seconds_per_tick)
	try_hack_borg(seconds_per_tick)

/datum/artifact_effect/machinery_mess/do_effect_destroy()
	try_animate(2)
	try_hack_borg(2)

/**
 * Tries to animate nearby machinery into angry mobs.
 * Similar to Malf ability
 */
/datum/artifact_effect/machinery_mess/proc/try_animate(seconds_per_tick)
	var/turf/curr_turf = get_turf(holder)
	for(var/obj/machinery/chosen_machine in range(range, curr_turf))
		if(SPT_PROB(5, seconds_per_tick) && !istype(chosen_machine, /obj/machinery/artifact))
			if(istype(chosen_machine, /obj/machinery/porta_turret_cover))
				var/obj/machinery/porta_turret_cover/chosen_turret = chosen_machine
				chosen_machine = chosen_turret.parent_turret

			if((chosen_machine.resistance_flags & INDESTRUCTIBLE) || is_type_in_typecache(chosen_machine, GLOB.blacklisted_malf_machines))
				return FALSE

			playsound(holder, 'sound/misc/interference.ogg', 50, ignore_walls = TRUE)
			chosen_machine.audible_message(span_userdanger("You hear a loud electrical buzzing sound coming from [chosen_machine]!"))
			if(QDELETED(chosen_machine))
				return

			new /mob/living/basic/mimic/copy/machine(get_turf(chosen_machine), chosen_machine, holder, TRUE)

/**
 * Tries to mess with silicon's laws OR emag simple bots
 */
/datum/artifact_effect/machinery_mess/proc/try_hack_borg(seconds_per_tick)
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/silicon_mob in range(range, curr_turf))
		if(SPT_PROB(12.5, seconds_per_tick))
			silicon_mob.laws_sanity_check()
			if(silicon_mob.stat != DEAD && !silicon_mob.incapacitated)
				if(SPT_PROB(7.5, seconds_per_tick))
					var/datum/ai_laws/ion_lawset = pick_weighted_lawset()
					ion_lawset = new()
					silicon_mob.laws.inherent = ion_lawset.inherent.Copy()
					qdel(ion_lawset)

				if(SPT_PROB(10, seconds_per_tick))
					silicon_mob.remove_law(rand(1, silicon_mob.laws.get_law_amount(list(LAW_INHERENT, LAW_SUPPLIED))))

				var/message = generate_ion_law()
				if(SPT_PROB(15, seconds_per_tick))
					silicon_mob.replace_random_law(message, list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION), LAW_ION)
				else
					silicon_mob.add_ion_law(message)

				if(SPT_PROB(20, seconds_per_tick))
					silicon_mob.shuffle_laws(list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION))

				log_silicon("Artifact changed laws of [key_name(silicon_mob)] to [english_list(silicon_mob.laws.get_law_list(TRUE, TRUE))]")
				silicon_mob.post_lawchange()

	for(var/mob/living/simple_animal/bot/bot in GLOB.alive_mob_list)
		if(SPT_PROB(12.5, seconds_per_tick))
			bot.emag_act()

