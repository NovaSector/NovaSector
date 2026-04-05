//Borer egg station trait
/datum/station_trait/borereggs
	name = "Cortical borer specimens"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 4
	show_in_report = TRUE
	report_message = "We've given you a few Cortical Borer eggs to study and take care of."

/datum/station_trait/borereggs/New()
	..()
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_pregame))

/datum/station_trait/borereggs/proc/on_pregame(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(borerblast))

/datum/station_trait/borereggs/proc/borerblast()

    for(var/i in 1 to 3)
        spawn_borer_egg()

/datum/station_trait/borereggs/proc/spawn_borer_egg()
    for(var/area/station/science/explab/borers in (GLOB.areas))
        var/list/turfs = get_area_turfs(borers)
        for(var/i in 1 to round(length(turfs) * 0.5))
            CHECK_TICK
            var/turf/open/chosen = pick_n_take(turfs)
            if(!istype(chosen))
                continue
            var/skip_this = FALSE
            for(var/atom/movable/mov as anything in chosen) //stop borer eggs from spawning on windows
                if(mov.density && !(mov.pass_flags_self & LETPASSTHROW))
                    skip_this = TRUE
                    break
            if(skip_this)
                continue
            if(prob(25)) ///Chance at a better borer
                new /obj/effect/mob_spawn/ghost_role/borer_egg/empowered(chosen)
            else
                new /obj/effect/mob_spawn/ghost_role/borer_egg(chosen)
            return
