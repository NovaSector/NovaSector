/// pew pew
/obj/effect/ebeam/vetus/Destroy()
	for(var/mob/living/M in get_turf(src))
		M.electrocute_act(20, "the giant arc", flags = SHOCK_NOGLOVES) //fuck your gloves.
	return ..()
