/datum/design/jawsoflife/science
	name = "Hybrid cutters"
	desc = "An off-shoot of the jaws of life that lacks the door-opening power"
	build_path = /obj/item/crowbar/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/screwdriver/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science/New()
	name = ("Science " + name)
	desc += " with a science paintjob"

	return ..()
