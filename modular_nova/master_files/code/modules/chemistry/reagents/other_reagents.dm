/datum/reagent/space_cleaner/sterilizine/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	// sterilize miasma into oxygen in sufficient concentrations
	if(reac_volume < 1)
		return
	if(istype(exposed_turf, /turf/open))
		var/turf/open/open_exposed_turf = exposed_turf
		var/datum/gas_mixture/turf/air = open_exposed_turf.air
		var/list/moles = air.moles
		var/miasma_moles = moles[/datum/gas/miasma]

		//Replace miasma with oxygen
		var/cleaned_air = miasma_moles
		moles[/datum/gas/miasma] -= cleaned_air
		moles[/datum/gas/oxygen] += cleaned_air
		air.garbage_collect()
