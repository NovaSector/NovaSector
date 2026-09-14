/*
 * Admin (R_ADMIN) custom condo maps.
 *
 * An admin uploads a .dmm (max 40x40 tiles) and picks:
 *   - Private: load it once and step in. Not added to the picker list.
 *   - Public:  render its preview, then add it to the condo picker for the rest of the round
 *              so anyone can create/enter it. It is NOT listed until the preview rendered.
 *
 * The map must use /area/misc/condo (and a hoteldoor) like the built-in condos, otherwise the
 * room won't link up properly (we bail gracefully instead of runtiming - see link_condo_turfs).
 * Custom maps live only for the current round.
 */

/// Bumped per upload so each custom map gets a unique preview asset name.
GLOBAL_VAR_INIT(condo_custom_map_counter, 0)

/// Set on admin-uploaded templates so every load forces its tiles into /area/misc/condo (admins
/// don't have to set the area themselves).
/datum/map_template/condo/var/force_condo_area = FALSE

/// Moves every reserved tile into a fresh /area/misc/condo so the room links up correctly.
/proc/condo_force_areas(datum/turf_reservation/condo/reservation)
	if(!reservation)
		return
	var/area/misc/condo/new_area = new
	for(var/turf/room_turf as anything in reservation.reserved_turfs)
		room_turf.change_area(get_area(room_turf), new_area)

ADMIN_VERB(condo_upload_map, R_ADMIN, "Condo - Upload Custom Map", "Upload a custom condo map (max 40x40), public or private.", ADMIN_CATEGORY_FUN)
	var/map_file = input(user.mob, "Upload a condo .dmm (max 40x40 tiles)", "Upload Condo Map") as null|file
	if(!map_file)
		return
	if(copytext("[map_file]", -4) != ".dmm")
		to_chat(user, span_warning("File must be a .dmm."), confidential = TRUE)
		return
	var/map_name = tgui_input_text(user.mob, "Name this condo:", "Condo Name", "Custom Condo", max_length = 42)
	if(!map_name)
		return

	// parse + measure the map (cache = TRUE keeps the parsed map so we can load it from memory)
	var/datum/map_template/condo/custom = new(map_file, map_name, TRUE)
	if(!custom.cached_map)
		to_chat(user, span_warning("That map failed to parse."), confidential = TRUE)
		qdel(custom)
		return
	if(custom.width > 40 || custom.height > 40)
		to_chat(user, span_warning("Map too big: [custom.width]x[custom.height] (max is 40x40)."), confidential = TRUE)
		qdel(custom)
		return

	custom.keep_cached_map = TRUE // the uploaded file won't stick around, so load from memory
	// let the admin choose where players land (1 = bottom-left corner); default to the map center
	var/land_x = tgui_input_number(user.mob, "Landing column (1 = left edge ... [custom.width] = right edge)", "Condo Landing Spot", clamp(round(custom.width / 2), 1, custom.width), custom.width, 1)
	var/land_y = tgui_input_number(user.mob, "Landing row (1 = bottom edge ... [custom.height] = top edge)", "Condo Landing Spot", clamp(round(custom.height / 2), 1, custom.height), custom.height, 1)
	custom.landing_zone_x_offset = (isnull(land_x) ? round(custom.width / 2) : land_x - 1)
	custom.landing_zone_y_offset = (isnull(land_y) ? round(custom.height / 2) : land_y - 1)
	GLOB.condo_custom_map_counter++
	custom.mappath = "custom_condo_[GLOB.condo_custom_map_counter].dmm" // fake path, only names the preview asset
	custom.force_condo_area = TRUE // we'll set the areas to condo on load, the admin doesn't have to

	// load it once to confirm it has a condo door + that it loads, fixing its areas in the process
	if(!condo_validate_custom_map(custom, user))
		qdel(custom)
		return

	switch(tgui_alert(user.mob, "Make it public (anyone can use it this round) or private (just load it for you now)?", "[map_name] - [custom.width]x[custom.height]", list("Public", "Private", "Cancel")))
		if("Public")
			// render the preview FIRST - only add it to the picker once that worked
			var/icon/photo = SScondos.photograph_interior(custom)
			if(!photo)
				to_chat(user, span_warning("Failed to render a preview - not publishing."), confidential = TRUE)
				qdel(custom)
				return
			var/asset_name = condo_preview_asset_name(custom.mappath)
			var/datum/asset/simple/condo_previews/preview_assets = get_asset_datum(/datum/asset/simple/condo_previews)
			preview_assets.assets[asset_name] = SSassets.transport.register_asset(asset_name, fcopy_rsc(photo))
			// url mappings are cached on first use (with round-start previews); drop the cache so the
			// next teleporter open rebuilds it and clients can resolve this new preview
			preview_assets.cached_serialized_url_mappings = null
			// a map with the same name replaces the previous upload (override)
			var/overwrote = !isnull(SScondos.condo_templates[custom.name])
			SScondos.condo_templates[custom.name] = custom
			log_admin("[key_name(user)] [overwrote ? "overwrote" : "published"] a PUBLIC custom condo map '[custom.name]' ([custom.width]x[custom.height]).")
			message_admins("[key_name_admin(user)] [overwrote ? "overwrote" : "published"] a PUBLIC custom condo map '[custom.name]' ([custom.width]x[custom.height]).")
			to_chat(user, span_notice("[overwrote ? "Overwrote" : "Published"] '[custom.name]' - players can pick it from the teleporter this round."), confidential = TRUE)
		if("Private")
			var/datum/condo_room/room = SScondos.create_room(custom, user.mob, null, custom.name, TRUE, null)
			if(!room)
				to_chat(user, span_warning("Failed to create the room."), confidential = TRUE)
				qdel(custom)
				return
			log_admin("[key_name(user)] loaded a PRIVATE custom condo map '[custom.name]' ([custom.width]x[custom.height]).")
			message_admins("[key_name_admin(user)] loaded a PRIVATE custom condo map '[custom.name]' ([custom.width]x[custom.height]).")
		else
			qdel(custom)

/// Loads the template once into a temp reservation to confirm it loads + has a condo door, fixes
/// its areas in the process, then frees it. Returns TRUE if it's usable.
/proc/condo_validate_custom_map(datum/map_template/condo/template, user)
	var/datum/turf_reservation/condo/check = SSmapping.request_turf_block_reservation(template.width, template.height, 1, reservation_type = /datum/turf_reservation/condo)
	if(!check)
		return FALSE
	var/turf/bottom_left = check.bottom_left_turfs[1]
	if(!bottom_left)
		qdel(check)
		return FALSE
	template.load(bottom_left)
	if(template.force_condo_area)
		condo_force_areas(check)
	var/turf/landing = locate(bottom_left.x + template.landing_zone_x_offset, bottom_left.y + template.landing_zone_y_offset, bottom_left.z)
	var/landing_blocked = (!landing || landing.density)
	var/has_door = FALSE
	for(var/turf/closed/indestructible/hoteldoor/door in check.reserved_turfs)
		has_door = TRUE
		break
	qdel(check)
	if(!has_door)
		to_chat(user, span_warning("That map has no condo door (/turf/closed/indestructible/hoteldoor) - add one and re-upload."), confidential = TRUE)
		return FALSE
	if(landing_blocked)
		to_chat(user, span_warning("Heads up: the chosen landing tile is blocked (a wall or dense) - players may spawn stuck. Re-upload to pick another spot."), confidential = TRUE)
	return TRUE
