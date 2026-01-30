// PIXEL TILT - Character rotation keybind for RP
// Component
/datum/component/pixel_tilt
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Current tilt angle being requested by the player (in degrees). This represents desired rotation, not necessarily what is currently applied.
	var/tilt_angle = 0
	/// The last tilt angle that was actually applied to the mob's transform. Used so we can undo only our own rotation before applying a new one, without capturing or overwriting other transform changes (such as scaling)
	var/last_applied_tilt_angle = 0
	/// Maximum allowed tilt angle in either direction. Prevents excessive rotation and visual distortion.
	var/maximum_tilt = 45
	/// Amount of tilt (in degrees) added or removed per key press. Controls how quickly the character rotates while tilting.
	var/tilt_increment = 5

/datum/component/pixel_tilt/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/owner = parent
	owner.balloon_alert(owner, "started tilting!")

/datum/component/pixel_tilt/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(pre_move_check))
	// Anti-abuse: Reset tilt on ANY of these events
	RegisterSignals(parent, list(
		COMSIG_LIVING_RESET_PULL_OFFSETS, // Being pulled
		COMSIG_MOVABLE_MOVED, // Moving tiles
		COMSIG_LIVING_SET_BODY_POSITION, // Laying down/standing up/sitting
	), PROC_REF(reset_tilt_and_remove))

/datum/component/pixel_tilt/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_MOB_CLIENT_PRE_LIVING_MOVE,
		COMSIG_LIVING_RESET_PULL_OFFSETS,
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_SET_BODY_POSITION,
	))

/**
 * Removes the currently applied tilt rotation from the mob's transform,
 * then cleans up and deletes the component.
 *
 * This ensures no residual rotation remains when tilt ends.
 */
/datum/component/pixel_tilt/proc/reset_tilt_and_remove()
	SIGNAL_HANDLER
	var/mob/living/owner = parent

	var/matrix/transform_to_reset = matrix(owner.transform)
	snap_tilt_angle()
	transform_to_reset.Turn(-last_applied_tilt_angle)

	animate(owner, transform = transform_to_reset, time = 0.2 SECONDS)

	if(!QDELETED(owner))
		owner.balloon_alert(owner, "stopped tilting!")

	qdel(src)

/datum/component/pixel_tilt/proc/pre_move_check(mob/source, new_loc, direct)
	SIGNAL_HANDLER

	switch(direct)
		if(EAST, WEST)
			apply_tilt(source, direct)
			return COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE
		if(NORTH, SOUTH)
			reset_tilt_and_remove()
			return
	return COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE

/**
 * Snaps internal tilt angle values to a fixed precision.
 *
 * Tilt angles are discrete by design, so this prevents floating-point
 * drift from accumulating and ensures inverse rotation operations remain
 * reliable when rebuilding transforms. Rounds by a factor of 0.01 by default.
 */
/datum/component/pixel_tilt/proc/snap_tilt_angle(rounding_factor = 0.01)
	tilt_angle = round(tilt_angle, rounding_factor)
	last_applied_tilt_angle = round(last_applied_tilt_angle, rounding_factor)

/**
 * Applies or updates the visual tilt rotation based on player input.
 *
 * The transform is rebuilt by first undoing the previously applied tilt
 * before applying the new desired angle. This allows tilt to coexist
 * safely with other transform effects such as scaling without capturing
 * or overwriting external state.
 */
/datum/component/pixel_tilt/proc/apply_tilt(mob/source, direct)
	var/mob/living/owner = parent
	switch(direct)
		if(EAST)
			tilt_angle = clamp(tilt_angle + tilt_increment, -maximum_tilt, maximum_tilt)
		if(WEST)
			tilt_angle = clamp(tilt_angle - tilt_increment, -maximum_tilt, maximum_tilt)

	// rebuild from current transform
	var/matrix/tilt_matrix = matrix(owner.transform)

	// remove previous rotation
	snap_tilt_angle()
	tilt_matrix.Turn(-last_applied_tilt_angle)

	// apply tilt
	tilt_matrix.Turn(tilt_angle)
	last_applied_tilt_angle = tilt_angle
	animate(owner, transform = tilt_matrix, time = 0.1 SECONDS, flags = ANIMATION_PARALLEL)

// Keybind
/datum/keybinding/mob/pixel_tilt
	hotkey_keys = list("N")
	name = "pixel_tilt"
	full_name = "Pixel Tilt"
	description = "Rotate your character's sprite. Hold and use arrow keys."
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXEL_TILT_DOWN

/datum/keybinding/mob/pixel_tilt/down(client/user)
	. = ..()
	if(.)
		return

	var/datum/component/pixel_tilt/tilt_component = user.mob.GetComponent(/datum/component/pixel_tilt)
	if(tilt_component)
		tilt_component.reset_tilt_and_remove()
	else
		user.mob.add_pixel_tilt_component()

/// Mob integration
/mob/proc/add_pixel_tilt_component()
	return

/mob/living/add_pixel_tilt_component()
	AddComponent(/datum/component/pixel_tilt)
