/datum/reagent/space_cleaner/sterilizine/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	// sterilize miasma into oxygen in sufficient concentrations
	if(reac_volume < 1)
		return

	if(!istype(exposed_turf, /turf/open))
		return

	var/turf/open/open_exposed_turf = exposed_turf
	var/datum/gas_mixture/turf/air = open_exposed_turf.air
	air.assert_gases(/datum/gas/miasma, /datum/gas/oxygen)
	var/list/moles = air.moles
	var/miasma_moles = moles[/datum/gas/miasma]

	if(!miasma_moles)
		return

	moles[/datum/gas/miasma] -= miasma_moles
	moles[/datum/gas/oxygen] += miasma_moles
	air.garbage_collect()
	exposed_turf.air_update_turf(FALSE, FALSE)
