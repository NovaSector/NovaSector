/datum/artifact_effect/machinery_mess
	log_name = "H1DDen c0Mp0NeNT$ 0veRRiDE"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/machinery_mess/New()
	..()
	release_method = ARTIFACT_EFFECT_PULSE

/datum/artifact_effect/machinery_mess/DoEffectPulse()
	. = ..()
	if(!.)
		return
	try_animate()
	try_hack_borg()

/datum/artifact_effect/machinery_mess/DoEffectDestroy()
	try_animate()
	try_hack_borg()

/datum/artifact_effect/machinery_mess/proc/try_animate()
	var/turf/curr_turf = get_turf(holder)
	for(var/obj/machinery/chosen_machine in range(range, curr_turf))
		if(prob(10) && !istype(chosen_machine, /obj/machinery/artifact))
			if(istype(chosen_machine, /obj/machinery/porta_turret_cover))
				var/obj/machinery/porta_turret_cover/chosen_turret = chosen_machine
				chosen_machine = chosen_turret.parent_turret

			if((chosen_machine.resistance_flags & INDESTRUCTIBLE) || is_type_in_typecache(chosen_machine, GLOB.blacklisted_malf_machines))
				return FALSE

			playsound(holder, 'sound/misc/interference.ogg', 50, ignore_walls = TRUE)
			chosen_machine.audible_message(span_userdanger("You hear a loud electrical buzzing sound coming from [chosen_machine]!"))
			if(QDELETED(chosen_machine))
				return

			new /mob/living/simple_animal/hostile/mimic/copy/machine(get_turf(chosen_machine), chosen_machine, holder, TRUE)

/datum/artifact_effect/machinery_mess/proc/try_hack_borg()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/M in range(range, curr_turf))
		if(prob(25))
			M.laws_sanity_check()
			if(M.stat != DEAD && !M.incapacitated())
				if(prob(15))
					var/datum/ai_laws/ion_lawset = pick_weighted_lawset()
					ion_lawset = new()
					M.laws.inherent = ion_lawset.inherent.Copy()
					qdel(ion_lawset)

				if(prob(20))
					M.remove_law(rand(1, M.laws.get_law_amount(list(LAW_INHERENT, LAW_SUPPLIED))))

				var/message = generate_ion_law()
				if(prob(30))
					M.replace_random_law(message, list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION), LAW_ION)
				else
					M.add_ion_law(message)

				if(prob(40))
					M.shuffle_laws(list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION))

				log_silicon("Artifact changed laws of [key_name(M)] to [english_list(M.laws.get_law_list(TRUE, TRUE))]")
				M.post_lawchange()

	for(var/mob/living/simple_animal/bot/bot in GLOB.alive_mob_list)
		if(prob(25))
			bot.emag_act()


