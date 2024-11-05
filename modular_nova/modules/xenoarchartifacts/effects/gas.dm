/datum/artifact_effect/gas
	log_name = "Gas"
	type_name = ARTIFACT_EFFECT_PARTICLE
	/// If turf pressure is above max_pressure we do not spawn gas
	var/max_pressure
	/// Target gas percentage in turf air
	var/target_percentage
	var/list/gas_types = list(
		/datum/gas/carbon_dioxide,
		/datum/gas/nitrogen,
		/datum/gas/oxygen,
		/datum/gas/plasma,
		/datum/gas/nitrous_oxide,
		/datum/gas/hydrogen,
		/datum/gas/miasma,
	)
	var/list/rare_gas_types = list(
		/datum/gas/bz,
		/datum/gas/halon,
		/datum/gas/pluoxium,
	)
	// Go ahead with your gambling addiction. It is ( 5% that is is rolled + X% that gas effect rolls ) * 0% xenoarcheologists exist
	var/list/legendary_gas_types = list(
		/datum/gas/tritium,
		/datum/gas/zauker,
		/datum/gas/helium,
	)
	/// Spawned gas type
	var/current_gas_type
	/// We also spawn new gas with randomized temperature
	var/spawn_temp

/datum/artifact_effect/gas/New()
	. = ..()
	if (prob(5))
		current_gas_type = pick(legendary_gas_types)
	else if (prob(15))
		current_gas_type = pick(rare_gas_types)
	else
		current_gas_type = pick(gas_types)
	release_method = pick(ARTIFACT_EFFECT_TOUCH, ARTIFACT_EFFECT_AURA)
	max_pressure = rand(115, 1000)
	spawn_temp = rand(1,1000)

/datum/artifact_effect/gas/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	var/turf/holder_loc = get_turf(holder)
	if(holder_loc)
		assume_gas(current_gas_type, rand(2, 25))

/datum/artifact_effect/gas/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/holder_loc = get_turf(holder)
	if(holder_loc)
		assume_gas(current_gas_type, pick(0, rand(0,50)))

/datum/artifact_effect/gas/do_effect_destroy(seconds_per_tick)
	. = ..()
	var/turf/holder_loc = get_turf(holder)
	if(holder_loc)
		assume_gas(current_gas_type, 75 * seconds_per_tick)

/**
 * Spawns gas on the same turf as the artifact
 *
 * Arguments:
 * * spawn_id - gas type
 * * spawn_mol - how much mol of the gas
 */
/datum/artifact_effect/gas/proc/assume_gas(spawn_id, spawn_mol)
	var/turf/open/our_open_turf = get_turf(holder)
	if(!istype(our_open_turf))
		return FALSE
	var/datum/gas_mixture/env = our_open_turf.return_air()
	if (env.return_pressure() >= max_pressure)
		return FALSE
	var/datum/gas_mixture/merger = new
	merger.assert_gas(spawn_id)
	merger.gases[spawn_id][MOLES] = spawn_mol
	merger.temperature = spawn_temp
	our_open_turf.assume_air(merger)
