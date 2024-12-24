/obj/machinery/nova/fan //Due to constrains, atmos effects arent stopped on depower, so only the self powered version is player buildable.
	name = "tiny fan"
	desc = "A tiny fan, releasing a thin gust of air."
	layer = HIGH_PIPE_LAYER
	power_channel = AREA_USAGE_ENVIRON
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION
	use_power = IDLE_POWER_USE
	max_integrity = 150
	density = FALSE
	icon = 'icons/obj/mining_zones/survival_pod.dmi'
	icon_state = "fan_tiny"
	can_atmos_pass = ATMOS_PASS_NO
	rad_insulation = RAD_LIGHT_INSULATION
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

/obj/machinery/nova/fan/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, TRUE)
	var/static/list/turf_traits = list(TRAIT_FIREDOOR_STOP)
	AddElement(/datum/element/give_turf_traits, turf_traits)

/obj/machinery/nova/fan/Destroy()
	air_update_turf(TRUE, FALSE)
	. = ..()

/obj/machinery/nova/fan/block_superconductivity() //Needed to avoid some heat issues. If you allow to use the powered version, figure a way to turn this off when its depowered.
	return TRUE

/obj/machinery/nova/fan/wrench_act(mob/living/user, obj/item/tool)
	balloon_alert_to_viewers("deconstructing...")
	if(!do_after(user, 2 SECONDS, src))
		balloon_alert_to_viewers("stopped deconstructing")
		return TRUE

	tool.play_tool_sound(src)
	deconstruct(TRUE)
	// Machinery is not friendly with dissasembly and getting items back.
	var/turf/location = get_turf(user)
	new /obj/item/stack/sheet/iron/five(location)
	new /obj/item/stack/cable_coil/five(location)
	return TRUE

/obj/machinery/nova/fan/self_powered
	name = "self powered tiny fan"
	desc = parent_type::desc + " This one seems to have a heated plasma shard that propels the blades!"
	use_power = NO_POWER_USE

/datum/crafting_recipe/nova/fan/self
	name = "Self Powered Tiny Fan"
	tool_behaviors = list(TOOL_WRENCH, TOOL_WELDER)
	result = /obj/machinery/nova/fan
	reqs = list(
		/obj/item/pipe = 1,
		/obj/item/stack/sheet/iron = 4,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/mineral/plasma=1,
	)
	time = 2 SECONDS
	category = CAT_ATMOSPHERIC
