/turf/closed/mineral/strange_rock/Initialize(mapload)
	. = ..()
	if (prob(50))
		mineral_type = /obj/structure/boulder
		GLOB.artifact_turfs.Add(src)
