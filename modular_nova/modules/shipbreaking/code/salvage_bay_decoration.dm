GLOBAL_LIST_EMPTY(shipbreaking_anchors)

/turf/open/floor/engine/anchor_jack
	name = "anchor jack"
	desc = "An extraordinarily dense piece of material made to act as a 'space anchor' to arrest \
		movement of vessels. You don't think it would be a good idea to try and take this apart."
	icon = 'modular_nova/modules/shipbreaking/icons/salvage_bay.dmi'
	icon_state = "anchor_jack"
	initial_gas_mix = AIRLESS_ATMOS
	temperature = TCMB

/turf/open/floor/engine/anchor_jack/wrench_act(mob/living/user, obj/item/tool)
	user.balloon_alert(user, "can't reach bolts!")
	return

/obj/effect/mapping_helpers/salvage_anchor
	name = "salvage anchor tether start"
	icon = 'modular_nova/modules/shipbreaking/icons/salvage_bay.dmi'
	icon_state = "tether_start"
	id_tag = "anchor_test"
	late = TRUE
	invisibility = INVISIBILITY_ABSTRACT
	var/starting_anchor = TRUE

/obj/effect/mapping_helpers/salvage_anchor/Initialize(mapload)
	. = ..()
	if(starting_anchor)
		GLOB.shipbreaking_anchors += src

// Mapping helpers need to be set to late init or theyw ill delete themselves, which we don't want to happen here
// Because lateShuttleMove handles everything we need to do
/obj/effect/mapping_helpers/salvage_anchor/LateInitialize()
	return

/obj/effect/mapping_helpers/salvage_anchor/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	if(id_tag)
		id_tag = "[port.shuttle_id]_[id_tag]"

/obj/effect/mapping_helpers/salvage_anchor/Destroy(force)
	if(starting_anchor)
		GLOB.shipbreaking_anchors -= src
	return ..()

/obj/effect/mapping_helpers/salvage_anchor/end
	name = "salvage anchor tether end"
	icon_state = "tether_end"
	starting_anchor = FALSE
	/// The anchor beam we keep
	var/datum/beam/anchor_cable

/obj/effect/mapping_helpers/salvage_anchor/end/lateShuttleMove(turf/oldT, list/movement_force, move_dir)
	. = ..()
	if(anchor_cable)
		anchor_cable.Destroy()
	for(var/obj/effect/mapping_helpers/salvage_anchor/anchor in GLOB.shipbreaking_anchors)
		if(anchor.id_tag != id_tag)
			continue
		var/atom/start_anchor = get_turf(anchor)
		var/atom/end_anchor = get_turf(src)
		anchor_cable = start_anchor.Beam(end_anchor, "anchor_cable", 'modular_nova/modules/shipbreaking/icons/salvage_bay.dmi', emissive = FALSE, layer = BELOW_CATWALK_LAYER)

// Map default numbered ones

/obj/effect/mapping_helpers/salvage_anchor/one
	id_tag = "anchor_one"

/obj/effect/mapping_helpers/salvage_anchor/end/one
	id_tag = "anchor_one"

/obj/effect/mapping_helpers/salvage_anchor/two
	id_tag = "anchor_two"

/obj/effect/mapping_helpers/salvage_anchor/end/two
	id_tag = "anchor_two"

/obj/effect/mapping_helpers/salvage_anchor/three
	id_tag = "anchor_three"

/obj/effect/mapping_helpers/salvage_anchor/end/three
	id_tag = "anchor_three"

/obj/effect/mapping_helpers/salvage_anchor/four
	id_tag = "anchor_four"

/obj/effect/mapping_helpers/salvage_anchor/end/four
	id_tag = "anchor_four"

/obj/effect/mapping_helpers/salvage_anchor/five
	id_tag = "anchor_five"

/obj/effect/mapping_helpers/salvage_anchor/end/five
	id_tag = "anchor_five"

/obj/effect/mapping_helpers/salvage_anchor/six
	id_tag = "anchor_six"

/obj/effect/mapping_helpers/salvage_anchor/end/six
	id_tag = "anchor_six"

/obj/effect/mapping_helpers/salvage_anchor/seven
	id_tag = "anchor_seven"

/obj/effect/mapping_helpers/salvage_anchor/end/seven
	id_tag = "anchor_seven"

/obj/effect/mapping_helpers/salvage_anchor/eight
	id_tag = "anchor_eight"

/obj/effect/mapping_helpers/salvage_anchor/end/eight
	id_tag = "anchor_eight"
