/datum/artifact_effect/powernet
	log_name = "Powernet"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/powernet/New()
	. = ..()
	trigger = TRIGGER_TOUCH
	release_method = ARTIFACT_EFFECT_AURA

/datum/artifact_effect/powernet/do_effect_aura()
	. = ..()
	if(!.)
		return
	if(istype(holder, /obj/machinery/power))
		var/obj/machinery/power/P = holder
		P.add_avail(250000)
