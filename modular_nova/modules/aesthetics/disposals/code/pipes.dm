/datum/asset/spritesheet_batched/pipes/create_spritesheets()
	// Overwritten to have our own pipe sprites in it.
	for (var/each in list('icons/obj/pipes_n_cables/pipe_item.dmi', 'modular_nova/modules/aesthetics/disposals/icons/disposals.dmi', 'icons/obj/pipes_n_cables/transit_tube.dmi', 'icons/obj/pipes_n_cables/hydrochem/fluid_ducts.dmi'))
		insert_all_icons("", each, GLOB.alldirs)
