/datum/artifact_effect/tesla
	log_name = "Tesla"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/tesla/New(atom/location)
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE
	current_charge = 0
	maximum_charges = 30
	activation_pulse_cost = maximum_charges
	artifact_id = "tesla"

/datum/artifact_effect/tesla/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/radius = rand(0,4)
	radius = radius + 2
	tesla_zap(source = holder, zap_range = radius, power = radius * 15000, cutoff = 10000, zap_flags = ZAP_OBJ_DAMAGE | ZAP_MOB_DAMAGE | ZAP_MOB_STUN | ZAP_GENERATES_POWER)
	// Yep, it can be used to generate power via tesla coils.

/datum/artifact_effect/tesla/do_effect_destroy()
	tesla_zap(source = holder, zap_range = 7, power = 2500000, cutoff = 10000, zap_flags = ZAP_OBJ_DAMAGE | ZAP_MOB_DAMAGE | ZAP_MOB_STUN | ZAP_GENERATES_POWER)
