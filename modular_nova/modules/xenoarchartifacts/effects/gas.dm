/datum/artifact_effect/gas
	log_name = "Gas"
	type_name = ARTIFACT_EFFECT_PARTICLE
	var/max_pressure
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
	var/current_gas_type
	var/spawn_temp

/datum/artifact_effect/gas/New()
	..()
	if (prob(5))
		current_gas_type = pick(legendary_gas_types)
	else if (prob(15))
		current_gas_type = pick(rare_gas_types)
	else
		current_gas_type = pick(gas_types)
	release_method = pick(ARTIFACT_EFFECT_TOUCH, ARTIFACT_EFFECT_AURA)
	max_pressure = rand(115, 1000)
	spawn_temp = rand(1,1000)

/datum/artifact_effect/gas/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	var/turf/holder_loc = holder.loc
	if(isturf(holder_loc))
		assume_gas(current_gas_type, rand(2, 15))

/datum/artifact_effect/gas/DoEffectAura()
	. = ..()
	if(!.)
		return
	var/turf/holder_loc = holder.loc
	if(isturf(holder_loc))
		assume_gas(current_gas_type, pick(0, rand(0,5)))

/datum/artifact_effect/gas/DoEffectDestroy()
	. = ..()
	var/turf/holder_loc = holder.loc
	if(isturf(holder_loc))
		assume_gas(current_gas_type, 150)

/datum/artifact_effect/gas/proc/assume_gas(spawn_id, spawn_mol)
	var/turf/open/O = get_turf(holder)
	if(!isopenturf(O))
		return FALSE
	var/datum/gas_mixture/env = O.return_air()
	if (env.return_pressure() >= max_pressure)
		return FALSE
	var/datum/gas_mixture/merger = new
	merger.assert_gas(spawn_id)
	merger.gases[spawn_id][MOLES] = spawn_mol
	merger.temperature = spawn_temp
	O.assume_air(merger)
