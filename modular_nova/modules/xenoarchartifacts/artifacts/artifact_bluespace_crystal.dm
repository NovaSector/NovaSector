/obj/machinery/artifact/bluespace_crystal
	name = "bluespace crystal"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi'
	icon_state = "artifact_13"
	icon_num = 0
	density = TRUE
	being_used = 0
	need_init = FALSE
	anchored = FALSE
	light_color = "#24c1ff"
	max_integrity = 200
	var/anomaly


/obj/machinery/artifact/bluespace_crystal/Initialize(mapload)
	. = ..()
	anomaly = pick_weight(list(
	/obj/effect/anomaly/flux = 1,
	/obj/effect/anomaly/grav/high = 1,
	/obj/effect/anomaly/ectoplasm = 1,
	/obj/effect/anomaly/bioscrambler = 1,
	/obj/effect/anomaly/pyro = 1,
	/obj/effect/anomaly/bhole = 1,
	/obj/effect/anomaly/bluespace = 6
	))
	max_integrity = rand(150, 300)
	new /datum/proximity_monitor(src, 3)
	first_effect = new /datum/artifact_effect/tesla(src)
	first_effect.trigger = TRIGGER_PROXY
	desc = "A blue strange crystal"
	icon_num = ARTIFACT_CRYSTAL_BLUE
	set_light(4)

/obj/machinery/artifact/bluespace_crystal/Destroy()
	var/turf/mainloc = get_turf(src)
	var/count_crystal = rand(1,50)
	for(var/i = 0 to count_crystal - 1)
		new /obj/item/stack/sheet/bluespace_crystal(mainloc)
	var/obj/effect/anomaly/anomaly_spawned = new anomaly(get_turf(src))
	anomaly_spawned.lifespan = 1800
	teleport()
	return ..()

/obj/machinery/artifact/bluespace_crystal/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir)
	. = ..()
	if(.)
		var/power = round(. / 10)
		tesla_zap(src, power, 50000 * power)
		empulse(src, power, 2 * power)

/obj/machinery/artifact/bluespace_crystal/proc/teleport()
	for (var/mob/living/Mob in range(7, get_turf(src)))

		var/weakness = get_anomaly_protection(Mob)
		if(!weakness)
			continue

		to_chat(Mob, "<span class='red'>You are displaced by a strange force!</span>")
		if(Mob.buckled)
			Mob.buckled.unbuckle_mob()


		var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread()
		sparks.set_up(3, 0, get_turf(Mob))
		sparks.start()

		var/turf/target_turf = pick(orange(get_turf(Mob), 20 * weakness))
		do_teleport(Mob, target_turf, 4)
		sparks = new /datum/effect_system/spark_spread()
		sparks.set_up(3, 0, get_turf(Mob))
		sparks.start()

/obj/machinery/artifact/bluespace_crystal/ex_act(severity)
	take_damage(50*severity, BURN, ENERGY, FALSE)
