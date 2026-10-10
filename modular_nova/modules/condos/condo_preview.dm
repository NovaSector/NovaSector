/*
 * Condo room previews for the cafe teleporter UI.
 *
 * At the start of the round we run through every interior once: load it, flatten it to a
 * clean top-down picture, cache that, then free the room. The teleporter UI just shows the
 * cached picture, so using it never loads a map.
 */

/// Longest side (px) a preview picture may have; bigger rooms get scaled down to fit the UI.
#define CONDO_PREVIEW_MAX_PX 480

/// Where rendered previews are cached between rounds. The map's hash is baked into the filename,
/// so a changed .dmm just misses the cache and re-renders.
#define CONDO_PREVIEW_CACHE_DIR "data/condo_previews/"

/// Holds the preview picture of each interior. Filled in at round start by prerender_previews().
/datum/asset/simple/condo_previews

/// Asset name for an interior from its map path (".../alleyway.dmm" -> "condo_alleyway.png").
/proc/condo_preview_asset_name(mappath)
	if(!mappath)
		return null
	var/list/path_parts = splittext("[mappath]", "/")
	return "condo_[replacetext(path_parts[length(path_parts)], ".dmm", "")].png"

/// TRUE for turfs we don't want in the picture: the empty space around the room and the
/// yellow cordon tiles the maps use as a boundary.
/proc/condo_skip_turf(turf/check)
	return isspaceturf(check) || isopenspaceturf(check) || istype(check, /turf/cordon)

/// Flattens a loaded room to a clean top-down icon: floors then objects, no lighting or
/// parallax planes (those are what turn the picture into garbage).
/proc/condo_flat_render(datum/turf_reservation/condo/room)
	var/turf/bottom_left = room.bottom_left_turfs[1]
	if(!bottom_left)
		return null
	var/min_x = bottom_left.x
	var/min_y = bottom_left.y
	var/icon/result = icon('icons/blanks/96x96.dmi', "nothing")
	result.Scale(room.width * ICON_SIZE_X, room.height * ICON_SIZE_Y)
	var/list/movables = list()
	for(var/turf/room_turf as anything in room.reserved_turfs)
		if(condo_skip_turf(room_turf))
			continue
		var/icon/floor_icon = getFlatIcon(room_turf, no_anim = TRUE)
		if(floor_icon)
			result.Blend(floor_icon, ICON_OVERLAY, (room_turf.x - min_x) * ICON_SIZE_X, (room_turf.y - min_y) * ICON_SIZE_Y)
		for(var/atom/movable/thing in room_turf)
			if(thing.invisibility)
				continue
			movables += thing
		CHECK_TICK
	// objects on top, in layer order
	sortTim(movables, GLOBAL_PROC_REF(cmp_atom_layer_asc))
	for(var/atom/movable/thing as anything in movables)
		var/icon/thing_icon = getFlatIcon(thing, no_anim = TRUE)
		if(thing_icon)
			result.Blend(thing_icon, ICON_OVERLAY, (thing.x - min_x) * ICON_SIZE_X + thing.pixel_x + thing.step_x, (thing.y - min_y) * ICON_SIZE_Y + thing.pixel_y + thing.step_y)
		CHECK_TICK
	result.Blend("#000", ICON_UNDERLAY) // black behind everything instead of see-through
	// keep big rooms from blowing up the UI: cap the longest side, scale the rest down to match
	var/longest = max(result.Width(), result.Height())
	if(longest > CONDO_PREVIEW_MAX_PX)
		var/scale = CONDO_PREVIEW_MAX_PX / longest
		result.Scale(round(result.Width() * scale), round(result.Height() * scale))
	return result

/// Photographs every interior once and caches the pictures as assets. Runs in the background
/// at round start so it never blocks anything.
/datum/controller/subsystem/condos/proc/prerender_previews()
	var/datum/asset/simple/condo_previews/preview_assets = get_asset_datum(/datum/asset/simple/condo_previews)
	for(var/interior_name in condo_templates)
		var/datum/map_template/condo/chosen = condo_templates[interior_name]
		var/icon/photo = load_or_render_preview(chosen)
		if(photo)
			// register the picture right away and keep its asset handle, so the list never
			// holds a raw icon - that's what the UI sends and resolves by name
			var/asset_name = condo_preview_asset_name(chosen.mappath)
			preview_assets.assets[asset_name] = SSassets.transport.register_asset(asset_name, fcopy_rsc(photo))
		CHECK_TICK
	// previews render async at round start; if a client opened the teleporter mid-render its cached
	// url mappings are stale, so drop the cache to force a rebuild on the next open
	preview_assets.cached_serialized_url_mappings = null

/// Returns an interior's preview icon: from the on-disk cache if the .dmm is unchanged (no map
/// loading at all), otherwise renders it fresh and caches it. The map hash in the filename is
/// the cache key, so editing a map automatically invalidates its cached picture.
/datum/controller/subsystem/condos/proc/load_or_render_preview(datum/map_template/condo/chosen)
	var/hash = rustg_hash_file(RUSTG_HASH_MD5, chosen.mappath)
	if(!hash) // couldn't hash the map file - just render it, don't cache
		return photograph_interior(chosen)
	var/list/path_parts = splittext("[chosen.mappath]", "/")
	var/base = replacetext(path_parts[length(path_parts)], ".dmm", "")
	var/cache_path = "[CONDO_PREVIEW_CACHE_DIR][base]-[hash].dmi"
	if(fexists(cache_path))
		return icon(cache_path)
	var/icon/photo = photograph_interior(chosen)
	if(photo)
		fcopy(photo, cache_path) // save for next round; old-hash files for this map just go stale
	return photo

/// Loads one interior into a temp reservation, flattens it to an icon, frees the room.
/datum/controller/subsystem/condos/proc/photograph_interior(datum/map_template/condo/chosen)
	var/datum/turf_reservation/condo/room = SSmapping.request_turf_block_reservation(chosen.width, chosen.height, 1, reservation_type = /datum/turf_reservation/condo)
	if(!room)
		return null
	var/turf/bottom_left = room.bottom_left_turfs[1]
	if(!bottom_left)
		qdel(room)
		return null
	chosen.load(bottom_left)
	if(chosen.force_condo_area)
		condo_force_areas(room)
	var/icon/photo = condo_flat_render(room)
	qdel(room)
	return photo

#undef CONDO_PREVIEW_MAX_PX
#undef CONDO_PREVIEW_CACHE_DIR
