/turf/closed/mineral/strange_rock/Initialize(mapload)
	. = ..()
	mineralType = /obj/structure/boulder
	GLOB.artifact_turfs.Add(src)
