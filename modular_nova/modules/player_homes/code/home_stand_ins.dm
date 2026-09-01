/*
 * Workarounds for various home-building elements that the standard map save can't handle.
 */

/*
 * TURF DECALS
 * A decal is not an object. It's an element. We need to write these elements
 * back to the dmm as objects so they can reapply themselves on load.
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

/// Every /datum/element/decal currently attached to this turf.
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

/// Renders this turf's decals as object entries.
/turf/proc/get_decal_save_entries()
	var/list/entries = list()
	for(var/datum/element/decal/saved as anything in get_turf_decals())
		if(!isnull(saved.smoothing))
			continue
		var/mutable_appearance/pic = saved.pic
		if(isnull(pic) || isnull(pic.icon) || isnull(saved.base_icon_state))
			continue

		// A home always sits at plane offset 0, but write_map defaults to save_flag = ALL, so this
		// could matter for exporting multi-z some day.
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

/*
 * STANDING WATER
 */

/// Depths a marker can be set to, low to deep. Keys are what the tool shows, values are liquid height.
GLOBAL_LIST_INIT(home_water_depths, list(
	"Puddle" = ONE_LIQUIDS_HEIGHT,
	"Ankle-deep" = ONE_LIQUIDS_HEIGHT * LIQUID_ANKLES_LEVEL_HEIGHT,
	"Waist-deep" = ONE_LIQUIDS_HEIGHT * LIQUID_WAIST_LEVEL_HEIGHT,
	"Shoulder-deep" = ONE_LIQUIDS_HEIGHT * LIQUID_SHOULDERS_LEVEL_HEIGHT,
	"Over your head" = ONE_LIQUIDS_HEIGHT * LIQUID_FULLTILE_LEVEL_HEIGHT,
))

/// How long a marker stays lit up after the tool pings it.
#define HOME_WATER_REVEAL_TIME (10 SECONDS)

/obj/effect/home_water_source
	name = "hydrostatic marker"
	desc = "A surveyor's mark. The registry reads these off the floor plan and pours the water back \
		every time the residence is unfolded."
	icon = 'modular_nova/modules/liquids/icons/obj/effects/liquid.dmi'
	icon_state = "spawner"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER // over the pool it made, on the rare occasion it is drawn at all
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	/// How deep this tile refills, in liquid height units. One of GLOB.home_water_depths' values.
	var/water_height = ONE_LIQUIDS_HEIGHT * LIQUID_WAIST_LEVEL_HEIGHT
	/// Running reveal, so a second ping extends it rather than being cut short by the first's timer.
	var/reveal_timer

/obj/effect/home_water_source/Initialize(mapload, height)
	. = ..()
	if(isnum(height))
		water_height = height
	if(mapload)
		return INITIALIZE_HINT_LATELOAD
	fill_turf()

/obj/effect/home_water_source/LateInitialize()
	fill_turf()

/obj/effect/home_water_source/Destroy(force)
	if(reveal_timer)
		deltimer(reveal_timer)
		reveal_timer = null
	return ..()

/// The depth this marker is set to.
/obj/effect/home_water_source/proc/depth_label()
	for(var/label in GLOB.home_water_depths)
		if(GLOB.home_water_depths[label] == water_height)
			return LOWER_TEXT(label)
	return "[water_height] units deep"

/// Pours this marker's water onto the tile it sits on.
/obj/effect/home_water_source/proc/fill_turf()
	var/turf/standing = loc
	if(!isturf(standing))
		stack_trace("A hydrostatic marker initialized outside a turf ([standing || "nullspace"]).")
		return FALSE
	standing.add_liquid(/datum/reagent/water, water_height, FALSE, T20C)
	return TRUE

/// Lights the markers up for a moment.
/obj/effect/home_water_source/proc/reveal(duration = HOME_WATER_REVEAL_TIME)
	if(reveal_timer)
		deltimer(reveal_timer)
	animate(src, alpha = 180, time = 0.2 SECONDS)
	reveal_timer = addtimer(CALLBACK(src, PROC_REF(conceal)), duration, TIMER_STOPPABLE)

/obj/effect/home_water_source/proc/conceal()
	reveal_timer = null
	animate(src, alpha = 0, time = 0.5 SECONDS)

/obj/effect/home_water_source/examine(mob/user)
	. = ..()
	. += span_notice("It is set to fill this tile [depth_label()] on every load.")

/obj/effect/home_water_source/get_save_vars()
	. = ..()
	. += NAMEOF(src, water_height)
	return .

/obj/item/home_water_marker
	name = "hydrostatic marker tool"
	desc = "Pools made easy. Click a tile to mark it as needing water."
	desc_controls = "Use in hand to set the depth, right-click in hand to light up nearby marks. \
		Right-click a marked floor to lift its mark."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/selected_depth = "Waist-deep"
	/// How far a ping reaches when the tool is used outside a home.
	var/ping_range = 7

/obj/item/home_water_marker/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return
	var/picked = tgui_input_list(user, "How deep should the water be?", "Marker Depth", GLOB.home_water_depths, selected_depth)
	if(isnull(picked) || !user.can_perform_action(src))
		return
	selected_depth = picked
	balloon_alert(user, "set to [LOWER_TEXT(picked)]")

/obj/item/home_water_marker/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(.)
		return
	ping(user)

/// Reveals every mark in the home, or nearby if the tool is being used outside one.
/obj/item/home_water_marker/proc/ping(mob/user)
	var/datum/home_instance/home = get_home_of(user)
	var/list/turfs = isnull(home?.reservation) ? RANGE_TURFS(ping_range, user) : home.reservation.reserved_turfs

	var/found = 0
	for(var/turf/searched as anything in turfs)
		for(var/obj/effect/home_water_source/mark in searched)
			mark.reveal()
			found++
	balloon_alert(user, found ? "[found] mark\s lit" : "no marks found")

/obj/item/home_water_marker/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/target = interacting_with
	if(isspaceturf(target))
		balloon_alert(user, "nothing to hold it!")
		return ITEM_INTERACT_BLOCKING

	var/depth = GLOB.home_water_depths[selected_depth]
	var/obj/effect/home_water_source/existing = locate() in target
	if(!isnull(existing))
		existing.reveal()
		if(existing.water_height == depth)
			balloon_alert(user, "already marked")
			return ITEM_INTERACT_BLOCKING
		existing.water_height = depth
		balloon_alert(user, "reset to [LOWER_TEXT(selected_depth)]")
		to_chat(user, span_notice("You reset the mark to [existing.depth_label()]."))
		return ITEM_INTERACT_SUCCESS

	// Add water as it's placed.
	var/obj/effect/home_water_source/placed = new(target, depth)
	placed.reveal()
	balloon_alert(user, "marked [LOWER_TEXT(selected_depth)]")
	return ITEM_INTERACT_SUCCESS

/obj/item/home_water_marker/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/target = interacting_with
	var/obj/effect/home_water_source/existing = locate() in target
	if(isnull(existing))
		balloon_alert(user, "no mark here")
		return ITEM_INTERACT_BLOCKING

	qdel(existing)
	// Remove the water if we remove the mark, for accidents.
	if(target.liquids)
		qdel(target.liquids, TRUE)
	balloon_alert(user, "mark lifted")
	return ITEM_INTERACT_SUCCESS

#undef HOME_WATER_REVEAL_TIME
