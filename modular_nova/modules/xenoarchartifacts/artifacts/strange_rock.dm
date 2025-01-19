/turf/closed/mineral/strange_rock/Initialize()
	. = ..()
	if (prob(3))
		mineralType = /obj/structure/boulder
		GLOB.artifact_turfs.Add(src)
