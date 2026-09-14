/// Essentially a rewritten version of Hilbert's Hotel that supports multiple map templates; and a reference to GMTower's beautiful condo system. You should play it's successor... :3
/obj/machinery/cafe_condo_teleporter
	name = "Matrixed Teleportation Unit"
	desc = "A sub-divided; stable teleportation system with a unseen central processing hub."
	icon = /obj/machinery/teleport/hub::icon
	icon_state = /obj/machinery/teleport/hub::icon_state
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Custom lamp color a viewer picked via the color picker while creating (ckey -> hex).
	var/list/picked_colors = list()

/// Pets a player can spawn into their room: display name -> mob type. Acts as the allowlist.
GLOBAL_LIST_INIT(condo_pets, list(
	"Corgi" = /mob/living/basic/pet/dog/corgi,
	"Pug" = /mob/living/basic/pet/dog/pug,
	"Cat" = /mob/living/basic/pet/cat,
	"Kitten" = /mob/living/basic/pet/cat/kitten,
	"Fox" = /mob/living/basic/pet/fox,
	"Gondola" = /mob/living/basic/pet/gondola,
))

/// Ambient sound presets a player can set for their room: display name -> AMBIENCE_* key.
GLOBAL_LIST_INIT(condo_ambiences, list(
	"Generic" = AMBIENCE_GENERIC,
	"Creepy" = AMBIENCE_CREEPY,
	"Spooky" = AMBIENCE_SPOOKY,
	"Medical" = AMBIENCE_MEDICAL,
	"Engineering" = AMBIENCE_ENGI,
	"Mining" = AMBIENCE_MINING,
	"Holy" = AMBIENCE_HOLY,
	"Space" = AMBIENCE_SPACE,
	"Forest" = AMBIENCE_FOREST,
	"Mushroom" = AMBIENCE_MUSHROOM,
	"Maintenance" = AMBIENCE_MAINT,
	"Danger" = AMBIENCE_DANGER,
))

/obj/machinery/cafe_condo_teleporter/examine(mob/user)
	. = ..()
	. += span_notice("You can use this to retire to a private room.")
	. += span_warning("Beware: once all occupants exit a room; it resets.")

/obj/machinery/cafe_condo_teleporter/attack_robot(mob/user)
	if(user.Adjacent(src))
		ui_interact(user)
	return TRUE

/obj/machinery/cafe_condo_teleporter/attack_hand(mob/living/user, list/modifiers)
	ui_interact(user)
	return TRUE

/obj/machinery/cafe_condo_teleporter/attack_tk(mob/user)
	to_chat(user, span_notice("\The [src] actively rejects your mind as the bluespace energies surrounding it disrupt your telekinesis."))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/cafe_condo_teleporter/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/cafe_condo_teleporter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CondoSelect", name)
		ui.open()

/// the preview pictures for the interior list
/obj/machinery/cafe_condo_teleporter/ui_assets(mob/user)
	return list(get_asset_datum(/datum/asset/simple/condo_previews))

/// the interiors + customization options to choose from when creating a room
/obj/machinery/cafe_condo_teleporter/ui_static_data(mob/user)
	var/list/data = list()
	var/list/archetypes = list()
	for(var/template_name in sort_list(SScondos.condo_templates))
		var/datum/map_template/condo/condo_template = SScondos.condo_templates[template_name]
		archetypes += list(list(
			"key" = template_name,
			"name" = condo_template.name,
			"image" = condo_preview_asset_name(condo_template.mappath),
		))
	data["archetypes"] = archetypes
	var/list/pet_names = list()
	for(var/pet_name in GLOB.condo_pets)
		pet_names += pet_name
	data["pets"] = pet_names
	var/list/ambience_names = list()
	for(var/ambience_name in GLOB.condo_ambiences)
		ambience_names += ambience_name
	data["ambiences"] = ambience_names
	return data

/// the live list of rooms you can see/enter
/obj/machinery/cafe_condo_teleporter/ui_data(mob/user)
	var/list/data = list()
	var/list/rooms = list()
	for(var/room_id in SScondos.active_condos)
		var/datum/condo_room/room = SScondos.active_condos[room_id]
		rooms += list(list(
			"id" = room.id,
			"name" = room.display_name,
			"owner" = room.owner_name,
			"map" = room.template?.name,
			"private" = room.private,
			"mine" = (room.owner_ckey && room.owner_ckey == user.ckey),
		))
	data["rooms"] = rooms
	data["picked_color"] = picked_colors[user.ckey]
	return data

/obj/machinery/cafe_condo_teleporter/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	switch(action)
		if("pick_color")
			var/picked = input(user, "Pick a lamp color", "Lamp Color", picked_colors[user.ckey] || "#ffffff") as color|null
			if(picked)
				picked_colors[user.ckey] = picked
			return TRUE
		if("create")
			if(!check_target_eligibility(user))
				return TRUE
			var/datum/map_template/condo/chosen_condo = SScondos.condo_templates[params["key"]]
			if(!chosen_condo)
				to_chat(user, span_warning("Pick an interior first."))
				return TRUE
			var/private = params["private"]
			var/room_name = sanitize(params["name"])
			var/datum/condo_room/room = SScondos.create_room(chosen_condo, user, src, room_name, private, private ? params["password"] : null)
			if(!room)
				return TRUE
			room.brightness = clamp(round(text2num(params["brightness"])), 0, 3)
			room.lamp_color = condo_sanitize_lamp_color(params["lamp_color"])
			room.ambience = params["ambience"]
			room.apply_lights()
			room.apply_ambience()
			setup_room_extras(room, params["pet"], params["pet_name"], params["zero_grav"], user)
			// the APC powers the room a beat after it loads and resets the bulbs, so re-apply lights
			addtimer(CALLBACK(room, TYPE_PROC_REF(/datum/condo_room, apply_lights)), 2 SECONDS)
			ui.close()
			return TRUE

		if("enter")
			if(!check_target_eligibility(user))
				return TRUE
			var/datum/condo_room/room = SScondos.active_condos[params["id"]]
			if(!room)
				return TRUE
			if(room.try_enter(user))
				ui.close()
			return TRUE

/// One-time room extras at creation: a pet (named + bonded to the owner) and/or zero gravity.
/// (Lighting + ambience live on the room datum so the door panel can change them too.)
/obj/machinery/cafe_condo_teleporter/proc/setup_room_extras(datum/condo_room/room, pet_choice, pet_label, zero_grav, mob/owner)
	if(!room?.reservation)
		return
	var/turf/anchor = room.reservation.bottom_left_turfs[1]
	if(!anchor)
		return
	if(pet_choice && GLOB.condo_pets[pet_choice])
		var/turf/landing = locate(
			anchor.x + room.template.landing_zone_x_offset,
			anchor.y + room.template.landing_zone_y_offset,
			anchor.z,
		) || anchor
		var/pet_type = GLOB.condo_pets[pet_choice]
		var/mob/living/basic/pet/new_pet = new pet_type(landing)
		var/clean_name = pet_label ? reject_bad_name(pet_label) : null
		if(clean_name)
			new_pet.name = clean_name
			new_pet.real_name = clean_name
		// befriend adds the owner to the pet's friends list, so command-capable pets (dogs) will
		// obey the owner's follow/stay orders, and the rest treat them as their person
		if(owner)
			new_pet.befriend(owner)
	if(zero_grav)
		for(var/turf/room_turf as anything in room.reservation.reserved_turfs)
			room_turf.AddElement(/datum/element/forced_gravity, 0)

/// Sanitycheck to prevent exploitation
/obj/machinery/cafe_condo_teleporter/proc/check_target_eligibility(mob/to_be_checked)
	if(!src.Adjacent(to_be_checked))
		to_chat(to_be_checked, span_warning("You too far away from \the [src] to enter it!"))
		return FALSE
	if(to_be_checked.incapacitated)
		to_chat(to_be_checked, span_warning("You aren't able to activate \the [src] anymore!"))
		return FALSE
	return TRUE
