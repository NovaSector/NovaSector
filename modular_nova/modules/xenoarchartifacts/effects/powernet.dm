/datum/artifact_effect/powernet
	log_name = "Powernet"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/powernet/New()
	..()
	trigger = TRIGGER_TOUCH
	release_method = ARTIFACT_EFFECT_PULSE
	maximum_charges = rand(5,10)
	activation_pulse_cost = maximum_charges


/datum/artifact_effect/powernet/DoEffectPulse()
	. = ..()
	if(!.)
		return
	if(istype(holder, /obj/machinery/power))
		var/obj/machinery/power/P = holder
		P.add_avail(500000)
