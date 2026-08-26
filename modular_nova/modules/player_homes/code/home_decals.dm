/*
 * A decal is not an object. It's an element. We need to write these elements
 * back to the dmm as objects so they can reapply themselves on load.
 *
 * /obj/effect/turf_decal on its own is not enough, this carries every arg
 * the element was attached with, so it reloads exactly what was painted
 */
/obj/effect/turf_decal/persisted
	var/decal_dir
	var/decal_plane = FLOAT_PLANE
	var/decal_cleanable = FALSE
	var/decal_description

/obj/effect/turf_decal/persisted/Initialize(mapload)
	SHOULD_CALL_PARENT(FALSE)
	if(flags_1 & INITIALIZED_1)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	flags_1 |= INITIALIZED_1

	var/turf/target = loc
	if(!isturf(target))
		stack_trace("A persisted decal initialized outside a turf ([target || "nullspace"]).")
		return INITIALIZE_HINT_QDEL

	target.AddElement( \
		/datum/element/decal, \
		icon, \
		icon_state, \
		decal_dir, \
		decal_plane, \
		layer, \
		alpha, \
		color, \
		null, \
		decal_cleanable, \
		decal_description, \
	)
	return INITIALIZE_HINT_QDEL

/*
 * Every /datum/element/decal currently attached to this turf.
 */
/turf/proc/get_turf_decals()
	var/list/decals = list()
	var/listening = _listen_lookup?[COMSIG_ATOM_UPDATE_OVERLAYS]
	if(isnull(listening))
		return decals
	if(!islist(listening))
		if(istype(listening, /datum/element/decal))
			decals += listening
		return decals
	for(var/datum/element/decal/found in listening)
		decals += found
	return decals

/*
 * Renders this turf's decals as object entries
 */
/turf/proc/get_decal_save_entries()
	var/list/entries = list()
	for(var/datum/element/decal/saved as anything in get_turf_decals())
		if(!isnull(saved.smoothing))
			continue
		var/mutable_appearance/pic = saved.pic
		if(isnull(pic) || isnull(pic.icon) || isnull(saved.base_icon_state))
			continue

		// A home always sits at plane offset 0, so this doesn't do anything for us here,
		// but the write_map defaults to save_flag = ALL so this technically could be useful
		// for exporting multi-z in the future?
		var/saved_plane = PLANE_TO_TRUE(pic.plane)
		if(isnull(saved_plane))
			saved_plane = pic.plane

		var/list/edits = list(
			"icon = [tgm_encode(pic.icon)]",
			"icon_state = [tgm_encode(saved.base_icon_state)]",
			"layer = [pic.layer]",
			"alpha = [pic.alpha]",
			"decal_plane = [saved_plane]",
		)
		if(saved.directional)
			edits += "decal_dir = [saved.directional]"
		if(!isnull(pic.color))
			edits += "color = [tgm_encode(pic.color)]"
		if(saved.cleanable)
			edits += "decal_cleanable = [saved.cleanable]"
		if(saved.description)
			edits += "decal_description = [tgm_encode(saved.description)]"

		entries += "/obj/effect/turf_decal/persisted{\n\t[edits.Join(";\n\t")]\n\t}"
	return entries
