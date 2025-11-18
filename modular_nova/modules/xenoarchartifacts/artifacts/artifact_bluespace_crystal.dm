/obj/machinery/artifact/bluespace_crystal
	name = "bluespace crystal"
	desc = "A strange blue crystal."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi'
	icon_state = "artifact_13"
	artifact_type_id = ARTIFACT_CRYSTAL_BLUE
	density = TRUE
	being_used = 0
	need_init = FALSE
	anchored = FALSE
	light_color = "#24c1ff"
	max_integrity = 200
	/// Spawned anomaly type
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
		/obj/effect/anomaly/bluespace = 6,
	))
	max_integrity = rand(150, 300)
	new /datum/proximity_monitor(src, 3)
	first_effect = new /datum/artifact_effect/tesla(src)
	first_effect.trigger = TRIGGER_PROXY
	set_light(4)

/obj/machinery/artifact/bluespace_crystal/Destroy()
	var/turf/mainloc = get_turf(src)
	var/count_crystal = rand(1,50)
	for(var/i in 1 to count_crystal)
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

/**
 * Teleports people in range of 7 tiles randomly
 */
/obj/machinery/artifact/bluespace_crystal/proc/teleport()
	for (var/mob/living/living_mob in range(7, get_turf(src)))
		var/weakness = get_anomaly_protection(living_mob)
		if(!weakness)
			continue

		living_mob.visible_message(
			span_warning("[living_mob] is displaced by a strange force!"),
			span_warning("You are displaced by a strange force!"),
			blind_message = span_hear("You hear zap nearby."),
		)
		if(living_mob.buckled)
			living_mob.buckled.unbuckle_mob()

		var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread()
		sparks.set_up(3, 0, get_turf(living_mob))
		sparks.start()

		var/turf/target_turf = pick(orange(get_turf(living_mob), 20 * weakness))
		do_teleport(living_mob, target_turf, 4)
		sparks = new /datum/effect_system/spark_spread()
		sparks.set_up(3, 0, get_turf(living_mob))
		sparks.start()

/obj/machinery/artifact/bluespace_crystal/ex_act(severity)
	take_damage(50*severity, BURN, ENERGY, FALSE)
