// PIXEL TILT - Character rotation keybind for RP

// Component
/datum/component/pixel_tilt
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/tilt_angle = 0
	var/maximum_tilt = 45
	var/tilt_increment = 5
	var/matrix/original_transform

/datum/component/pixel_tilt/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/owner = parent
	original_transform = matrix(owner.transform)
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

/datum/component/pixel_tilt/proc/reset_tilt_and_remove()
	SIGNAL_HANDLER
	var/mob/living/owner = parent
	tilt_angle = 0
	animate(owner, transform = original_transform, time = 0.2 SECONDS)
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

/datum/component/pixel_tilt/proc/reset_tilt()
	SIGNAL_HANDLER
	reset_tilt_and_remove()

/datum/component/pixel_tilt/proc/apply_tilt(mob/source, direct)
	var/mob/living/owner = parent
	switch(direct)
		if(EAST)
			tilt_angle = clamp(tilt_angle + tilt_increment, -maximum_tilt, maximum_tilt)
		if(WEST)
			tilt_angle = clamp(tilt_angle - tilt_increment, -maximum_tilt, maximum_tilt)

	var/matrix/tilt_matrix = matrix(original_transform)
	tilt_matrix.Turn(tilt_angle)
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

