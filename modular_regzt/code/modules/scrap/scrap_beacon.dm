/obj/structure/scrap_beacon
    name = "Scrap Beacon"
    desc = "This machine generates directional gravity rays which catch trash orbiting around."
    icon = 'modular_regzt/icons/obj/structures/scrap/scrap_beacon.dmi'
    icon_state = "beacon0"
    anchored = TRUE
    density = TRUE
    layer = MOB_LAYER + 1
    var/summon_cooldown = 120 SECONDS
    var/impact_speed = 3
    var/impact_prob = 100
    var/impact_range = 1
    var/last_summon = -3000
    var/active = FALSE
    var/emagged = FALSE

/obj/structure/scrap_beacon/attack_hand(mob/user)
    . = ..()
    if(.)
        return
    if((last_summon + summon_cooldown) >= world.time)
        to_chat(user, span_notice("[src.name] is not charged yet."))
        return
    last_summon = world.time
    if(!active)
        start_scrap_summon()

/obj/structure/scrap_beacon/update_icon_state()
    icon_state = "beacon[active ? 1 : 0]"
    return ..()

/obj/structure/scrap_beacon/emag_act(mob/user)
    if(emagged)
        return FALSE
    to_chat(user, span_warning("You are overloading a dangerous range protocols."))
    emagged = TRUE
    impact_range = 3
    impact_speed = 1
    return TRUE

/obj/structure/scrap_beacon/proc/start_scrap_summon()
    active = TRUE
    //playsound(src, 'sound/machines/scrap_beacon_start.ogg', 50, FALSE)
    update_appearance()

    sleep(30)
    var/list/flooring_near_beacon = list()
    for(var/turf/T in range(impact_range, src))
        if(!isfloorturf(T))
            continue
        if(locate(/obj/structure/scrap) in T)
            continue
        if(!prob(impact_prob))
            continue
        flooring_near_beacon += T

    flooring_near_beacon -= src.loc
    while(flooring_near_beacon.len > 0)
        sleep(impact_speed)
        var/turf/newloc = pick(flooring_near_beacon)
        flooring_near_beacon -= newloc
        var/scrap_type = pick(
            1; /obj/structure/scrap/material,
            3; /obj/structure/scrap/maintenance,
            4; /obj/structure/scrap/trash,
			2; /obj/structure/scrap/food,
			2; /obj/structure/scrap/cloth,
			2; /obj/structure/scrap/poor,
			2; /obj/structure/scrap/medical,
			2; /obj/structure/scrap/industrial,
			1; /obj/structure/scrap/science,
        )

        new scrap_type(newloc)

    active = FALSE
    update_appearance()
