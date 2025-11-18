// Only used in power crystal artifact. Can't be randomly generated in machine artifact
/datum/artifact_effect/powernet
	log_name = "Powernet"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/powernet/New()
	. = ..()
	trigger = TRIGGER_TOUCH
	release_method = ARTIFACT_EFFECT_AURA

/datum/artifact_effect/powernet/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	if(istype(holder, /obj/machinery/power))
		var/obj/machinery/power/power_holder = holder
		power_holder.add_avail(125000 * seconds_per_tick)
