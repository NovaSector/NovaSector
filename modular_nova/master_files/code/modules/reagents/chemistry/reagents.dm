/datum/reagent
	/// Modular version of `chemical_flags`, so we don't have to worry about
	/// it causing conflicts in the future.
	var/chemical_flags_nova = NONE

/datum/reagent/drug/nicotine
	addiction_types = list(/datum/addiction/nicotine = 4) // 1.6 per 2 seconds

/datum/reagent/toxin/pestkiller/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	if(istype(exposed_obj, /obj/structure/spider))
		var/obj/structure/spider/webs_or_something = exposed_obj
		webs_or_something.take_damage(rand(15, 35), BURN, 0) // melts spider stuff pretty fast. pest control, y'know?
