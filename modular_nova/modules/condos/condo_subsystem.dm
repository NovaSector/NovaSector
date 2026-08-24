SUBSYSTEM_DEF(condos)
	name = "Condos"
	ss_flags = SS_NO_FIRE
	init_stage = INITSTAGE_LAST
	/// All possible condo templates.
	var/list/condo_templates = list()
	/// Active rooms: hidden id (string) -> /datum/condo_room.
	var/list/active_condos = list()
	/// Counter for handing out hidden room ids.
	var/next_condo_id = 0
	/// Items we delibrately prevent being deleted. Malleable. Try to keep this to only items that cannot be re-obtained without admin interference; with some exceptions.
	var/list/item_blacklist = list(
		/obj/item/blackbox, \
		/obj/item/gun/energy/laser/captain, \
		/obj/item/gun/energy/e_gun/hos, \
		/obj/item/hand_tele, \
		/obj/item/tank/jetpack/captain, \
		/obj/item/clothing/shoes/magboots/advance, \
		/obj/item/blueprints, \
		/obj/item/clothing/accessory/medal/gold/captain, \
		/obj/item/hypospray/mkii/deluxe/cmo, \
		/obj/item/fireaxe, \
		/obj/item/crowbar/mechremoval, \
		/obj/item/storage/belt/utility/chief, \
		/obj/item/mod/control/pre_equipped/magnate, \
		/obj/item/gun/ballistic/shotgun/automatic/combat/compact, \
		/obj/item/clothing/suit/hooded/ablative, \
		/obj/item/nuke_core, \
		/obj/item/nuke_core_container, \
		/obj/item/disk/computer/hdd_theft, \
		/obj/item/nuke_core_container/supermatter, \
		/obj/item/aicard, \
		/obj/item/gun/energy/temperature/security, \
		/obj/item/mod/control/pre_equipped/advanced, \
		/obj/item/mod/control/pre_equipped/research, \
		/obj/item/mod/control/pre_equipped/rescue, \
		/obj/item/mod/control/pre_equipped/safeguard, \
		/obj/item/storage/belt/sheath/sabre, \
		/obj/item/card, \
		/obj/item/modular_computer, \
		/obj/item/nullrod, \
		/obj/item/stamp/head, \
	)

/datum/controller/subsystem/condos/Initialize()
	preload_condo_templates()
	// render the preview photos in the background so it doesn't hold up init
	INVOKE_ASYNC(src, PROC_REF(prerender_previews))
	return SS_INIT_SUCCESS

/// Registers every /datum/map_template/condo subtype as a pickable interior.
/datum/controller/subsystem/condos/proc/preload_condo_templates()
	for(var/item in subtypesof(/datum/map_template/condo))
		var/datum/map_template/condo/condo_type = item
		if(!(initial(condo_type.mappath)))
			continue
		var/datum/map_template/condo/condo_template = new condo_type()

		condo_templates[condo_template.name] = condo_template
		SSmapping.map_templates[condo_template.name] = condo_template

/// Builds a brand new room from a template: reserves space, loads it, registers a /datum/condo_room
/// and warps the owner in. Returns the room (or null on failure).
/datum/controller/subsystem/condos/proc/create_room(datum/map_template/condo/template, mob/owner, parent_object, display_name, private, password)
	var/datum/turf_reservation/condo/reservation = SSmapping.request_turf_block_reservation(template.width, template.height, 1, reservation_type = /datum/turf_reservation/condo)
	var/turf/bottom_left = reservation?.bottom_left_turfs[1]
	if(!bottom_left)
		to_chat(owner, span_warning("Failed to reserve a room for you! Contact the technical concierge."))
		if(reservation)
			qdel(reservation)
		return null
	template.load(bottom_left)
	if(template.force_condo_area)
		condo_force_areas(reservation)
	reservation.condo_template = template

	var/datum/condo_room/room = new
	next_condo_id += 1
	room.id = "[next_condo_id]"
	room.template = template
	room.reservation = reservation
	room.owner_ckey = owner?.ckey
	room.owner_name = owner?.real_name || owner?.name
	room.display_name = display_name || "[room.owner_name]'s room"
	room.private = private
	room.password = password
	active_condos[room.id] = room

	link_condo_turfs(room, parent_object)
	warp_into_room(room, owner)
	return room

/// Drops a mob at a room's landing spot.
/datum/controller/subsystem/condos/proc/warp_into_room(datum/condo_room/room, mob/user)
	var/turf/bottom_left = room?.reservation?.bottom_left_turfs[1]
	if(!bottom_left || !user)
		return FALSE
	do_sparks(3, FALSE, get_turf(user))
	return user.forceMove(locate(
		bottom_left.x + room.template.landing_zone_x_offset,
		bottom_left.y + room.template.landing_zone_y_offset,
		bottom_left.z,
	))

/// Points the room's /area/ and door at the room datum.
/datum/controller/subsystem/condos/proc/link_condo_turfs(datum/condo_room/room, parent_object)
	var/turf/condo_bottom_left = room.reservation.bottom_left_turfs[1]
	var/area/misc/condo/current_area = get_area(condo_bottom_left)
	if(!istype(current_area)) // a custom/admin map that forgot to use /area/misc/condo - bail instead of runtiming
		return
	current_area.name = room.display_name
	current_area.parent_object = parent_object
	current_area.condo_room = room
	current_area.reservation = room.reservation

	for(var/turf/closed/indestructible/hoteldoor/door in room.reservation.reserved_turfs)
		door.parentSphere = parent_object
		door.condo_room = room
		door.desc = "The door to [room.display_name]. \
			Strangely, this door doesn't even seem openable. \
			The doorknob, however, seems to buzz with unusual energy...<br/>\
			[span_info("Alt-Click to look through the peephole.")] \
			[span_info("The owner can Ctrl-Click to manage the room.")]"
	for(var/turf/open/space/bluespace/bluespace_turf in room.reservation.reserved_turfs)
		bluespace_turf.parentSphere = parent_object
