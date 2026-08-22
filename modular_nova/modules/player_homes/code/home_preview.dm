/*
 * Home previews for the cafe terminal.
 *
 * A home's picture is rendered at save time, while the rooms are already loaded and we are already
 * paying for a full write_map() pass, then cached next to the save as a .png. That ordering is not
 * an optimisation - it is the only workable one. The terminal shows a player their home *before*
 * they step into it, so the rooms are not loaded and there is nothing to photograph on demand.
 *
 * MERGE NOTE - NovaSector/NovaSector#7784
 * That PR adds condo_flat_render(), which is flat_render_reservation() below with a
 * /datum/turf_reservation/condo in its signature and a round-start prerender in front of it. When
 * 7784 lands, delete condo_flat_render() and point condo_preview.dm at this one - the renderer is
 * not condo-specific and there is no reason to carry two of it.
 */

/// Longest side, in pixels, a preview may have. Bigger rooms get scaled down to fit the UI.
#define HOME_PREVIEW_MAX_PX 480

/// Turfs that should not appear in a picture: the empty space around a room, and the cordon tiles
/// the reservation system fences it in with.
/proc/skip_turf_in_render(turf/check)
	return isspaceturf(check) || isopenspaceturf(check) || istype(check, /turf/cordon)

/**
 * Flattens a loaded reservation into a clean top-down picture: floors first, then movables in layer
 * order. Lighting and parallax planes are excluded by going through getFlatIcon() per atom rather
 * than screen-grabbing - those planes are exactly what turns a picture like this into garbage.
 *
 * Mobs are skipped. The render happens while the owner is standing at their own console, and a
 * photograph of yourself looking at yourself is not what anybody wants on the terminal.
 */
/proc/flat_render_reservation(datum/turf_reservation/reservation)
	var/turf/bottom_left = reservation?.bottom_left_turfs[1]
	if(isnull(bottom_left))
		return null
	var/min_x = bottom_left.x
	var/min_y = bottom_left.y

	var/icon/result = icon('icons/blanks/96x96.dmi', "nothing")
	result.Scale(reservation.width * ICON_SIZE_X, reservation.height * ICON_SIZE_Y)

	var/list/movables = list()
	for(var/turf/room_turf as anything in reservation.reserved_turfs)
		if(skip_turf_in_render(room_turf))
			continue
		var/icon/floor_icon = getFlatIcon(room_turf, no_anim = TRUE)
		if(floor_icon)
			result.Blend(floor_icon, ICON_OVERLAY, (room_turf.x - min_x) * ICON_SIZE_X, (room_turf.y - min_y) * ICON_SIZE_Y)
		for(var/atom/movable/thing in room_turf)
			if(thing.invisibility || ismob(thing))
				continue
			movables += thing
		CHECK_TICK

	sortTim(movables, GLOBAL_PROC_REF(cmp_atom_layer_asc))
	for(var/atom/movable/thing as anything in movables)
		var/icon/thing_icon = getFlatIcon(thing, no_anim = TRUE)
		if(thing_icon)
			result.Blend(thing_icon, ICON_OVERLAY, (thing.x - min_x) * ICON_SIZE_X + thing.pixel_x + thing.step_x, (thing.y - min_y) * ICON_SIZE_Y + thing.pixel_y + thing.step_y)
		CHECK_TICK

	result.Blend("#000", ICON_UNDERLAY) // black behind everything, rather than see-through

	var/longest = max(result.Width(), result.Height())
	if(longest > HOME_PREVIEW_MAX_PX)
		var/scale = HOME_PREVIEW_MAX_PX / longest
		result.Scale(round(result.Width() * scale), round(result.Height() * scale))
	return result

/// Photographs a loaded home and caches the picture beside its save. Returns TRUE if one was made.
/datum/controller/subsystem/homes/proc/render_preview(datum/home_instance/home)
	var/icon/photo = flat_render_reservation(home.reservation)
	if(isnull(photo))
		return FALSE
	var/path = home_file(home.owner_ckey, "home_preview.png")
	fdel(path)
	fcopy(photo, path)
	// The old asset was registered under the old picture's hash, so nothing will ask for it again.
	preview_assets -= home.owner_ckey
	return fexists(path)

/// The asset datum for one player's preview, built on demand and remembered on the subsystem.
/// Returns null if they have no picture yet - a home saved before previews existed, for instance.
/datum/controller/subsystem/homes/proc/get_preview_asset(ckey)
	var/path = home_file(ckey, "home_preview.png")
	if(!path || !fexists(path))
		return null
	var/datum/asset/home_preview/cached = preview_assets[ckey]
	if(!isnull(cached))
		return cached
	// The picture's own hash goes in the asset name. A player who re-saves gets a new name, so a
	// client can never be served the cached picture of a home they have since rearranged.
	var/hash = rustg_hash_file(RUSTG_HASH_MD5, path)
	if(!hash)
		return null
	cached = new /datum/asset/home_preview("home_preview_[ckey]_[hash].png", path)
	preview_assets[ckey] = cached
	return cached

/// Throws away a player's cached picture and the asset built from it. Called whenever their home
/// stops existing, so the terminal never shows a preview of something that has been demolished.
/datum/controller/subsystem/homes/proc/forget_preview(ckey)
	var/datum/asset/home_preview/stale = preview_assets[ckey]
	if(!isnull(stale))
		stale.unregister()
		preview_assets -= ckey
	fdel(home_file(ckey, "home_preview.png"))

/// One player's home preview. Instanced per ckey rather than fetched with get_asset_datum(), since
/// the picture differs for every player and there is no singleton to be had. abstract_type keeps
/// SSassets from trying to instantiate it as a normal round-start asset.
/datum/asset/home_preview
	abstract_type = /datum/asset/home_preview
	var/asset_name

/datum/asset/home_preview/New(name, path)
	// Deliberately not calling parent: /datum/asset/New() claims GLOB.asset_datums[type], which is
	// a singleton registry that a per-player asset has no business writing itself into.
	if(!name || !path)
		return
	asset_name = name
	SSassets.transport.register_asset(asset_name, fcopy_rsc(file(path)))

/datum/asset/home_preview/send(client)
	if(!asset_name)
		return
	return SSassets.transport.send_assets(client, asset_name)

/datum/asset/home_preview/get_url_mappings()
	if(!asset_name)
		return list()
	return list("[asset_name]" = SSassets.transport.get_asset_url(asset_name))

/datum/asset/home_preview/unregister()
	if(!asset_name)
		return
	SSassets.transport.unregister_asset(asset_name)

#undef HOME_PREVIEW_MAX_PX
