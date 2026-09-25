/obj/structure/sink/cycler
	name = "water cycler"
	desc = "A machine that connects with many different waste systems to recycle as much water as possible from what would otherwise be thrown overboard. \
		Works as both a source of water and a sink for washing with."
	icon = 'modular_nova/modules/shipbreaking/icons/watercloset.dmi'
	icon_state = "sink"
	buildstacktype = /obj/item/stack/sheet/aluminum
	buildstackamount = 2
	has_water_reclaimer = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink/cycler, 20)
