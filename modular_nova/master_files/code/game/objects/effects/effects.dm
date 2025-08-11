#define MAX_FAKE_STEAM_STAGES 5
#define STAGE_DOWN_TIME (10 SECONDS)
#define FAKE_STEAM_TARGET_ALPHA 204

/// Fake steam effect
/obj/effect/abstract/fake_steam
	layer = FLY_LAYER
	icon = 'icons/effects/atmospherics.dmi'
	icon_state = "water_vapor"
	blocks_emissive = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/next_stage_down = 0
	var/current_stage = 0

/obj/effect/abstract/fake_steam/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/abstract/fake_steam/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/abstract/fake_steam/process()
	if(next_stage_down > world.time)
		return
	stage_down()

/obj/effect/abstract/fake_steam/proc/update_alpha()
	alpha = FAKE_STEAM_TARGET_ALPHA * (current_stage / MAX_FAKE_STEAM_STAGES)

/obj/effect/abstract/fake_steam/proc/stage_down()
	if(!current_stage)
		qdel(src)
		return
	current_stage--
	next_stage_down = world.time + STAGE_DOWN_TIME
	update_alpha()

/obj/effect/abstract/fake_steam/proc/stage_up(max_stage = MAX_FAKE_STEAM_STAGES)
	var/target_max_stage = min(MAX_FAKE_STEAM_STAGES, max_stage)
	current_stage = min(current_stage + 1, target_max_stage)
	next_stage_down = world.time + STAGE_DOWN_TIME
	update_alpha()

#define SAUNA_WET_STACKS 1

/obj/effect/abstract/fake_steam/sauna

/obj/effect/abstract/fake_steam/sauna/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/abstract/fake_steam/sauna/proc/on_entered(datum/source, atom/movable/entered)
	SIGNAL_HANDLER
	if(!iscarbon(entered))
		return
	var/mob/living/carbon/carbon_mob = entered
	if(!carbon_mob.has_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna))
		carbon_mob.apply_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna)

/obj/effect/abstract/fake_steam/sauna/proc/on_exited(datum/source, atom/movable/exited)
	SIGNAL_HANDLER
	if(locate(/obj/effect/abstract/fake_steam/sauna) in get_turf(exited))
		return
	if(!iscarbon(exited))
		return
	var/mob/living/carbon/carbon_mob = exited
	if(carbon_mob.has_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna))
		carbon_mob.remove_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna)

/obj/effect/abstract/fake_steam/sauna/stage_up()
	. = ..()
	for(var/mob/living/carbon/carbon_mob as anything in get_turf(src))
		if(!iscarbon(carbon_mob))
			continue
		if(!carbon_mob.has_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna))
			carbon_mob.apply_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna)

/obj/effect/abstract/fake_steam/sauna/stage_down()
	if(!current_stage)
		for(var/mob/living/carbon/carbon_mob as anything in get_turf(src))
			if(!iscarbon(carbon_mob))
				continue
			if(carbon_mob.has_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna))
				carbon_mob.remove_status_effect(/datum/status_effect/washing_regen/hot_spring/sauna)
	return ..()

/datum/status_effect/washing_regen/hot_spring/sauna

/datum/status_effect/washing_regen/hot_spring/sauna/on_apply()
	. = ..()
	alert_type = /atom/movable/screen/alert/status_effect/washing_regen/hotspring/sauna

/atom/movable/screen/alert/status_effect/washing_regen/hotspring/sauna
	name = "Sauna"
	desc = "A steaming hot sauna is so relaxing..."

#undef MAX_FAKE_STEAM_STAGES
#undef STAGE_DOWN_TIME
#undef FAKE_STEAM_TARGET_ALPHA
#undef SAUNA_WET_STACKS
