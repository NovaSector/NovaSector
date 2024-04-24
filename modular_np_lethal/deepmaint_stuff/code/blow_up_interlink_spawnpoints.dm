GLOBAL_VAR_INIT(load_the_interlink, TRUE)

/obj/effect/landmark/blow_up_interlink_latejoin_markers
	name = "Explode All Interlink Latejoin Markers"

/obj/effect/landmark/blow_up_interlink_latejoin_markers/Initialize(mapload)
	..()
	GLOB.load_the_interlink = FALSE
	return INITIALIZE_HINT_QDEL
