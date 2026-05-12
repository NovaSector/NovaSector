#define TRAIT_SWEEP_ATTACKING "sweep_attacking"

/**
 * Melee Sweep Component
 *
 * When attached to a melee weapon, causes attacks to hit all mobs
 * in a 3-tile arc centered on the direction from the attacker to the click target.
 * Only activates when the user is in combat mode and the weapon has force.
 *
 * Hooks into COMSIG_MOB_CLICKON so that clicking anywhere on the screen
 * (not just adjacent tiles) triggers the sweep in the correct direction.
 */
/datum/component/melee_sweep
	/// Damage multiplier applied to targets not in the center tile of the arc
	var/side_damage_mult = 0.7
	/// Ref to the mob currently wielding this weapon
	var/mob/living/wielder

/datum/component/melee_sweep/Initialize(side_damage_mult = 0.7)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	src.side_damage_mult = side_damage_mult

/datum/component/melee_sweep/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))

/datum/component/melee_sweep/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	unset_wielder()

/datum/component/melee_sweep/proc/on_equipped(obj/item/source, mob/living/user, slot)
	SIGNAL_HANDLER
	if(slot & ITEM_SLOT_HANDS)
		set_wielder(user)
	else
		unset_wielder()

/datum/component/melee_sweep/proc/on_dropped(obj/item/source, mob/living/user)
	SIGNAL_HANDLER
	unset_wielder()

/datum/component/melee_sweep/proc/set_wielder(mob/living/new_wielder)
	if(wielder == new_wielder)
		return
	unset_wielder()
	wielder = new_wielder
	RegisterSignal(wielder, COMSIG_MOB_CLICKON, PROC_REF(on_click))

/datum/component/melee_sweep/proc/unset_wielder()
	if(!wielder)
		return
	UnregisterSignal(wielder, COMSIG_MOB_CLICKON)
	wielder = null

/datum/component/melee_sweep/proc/on_click(mob/living/user, atom/target, list/modifiers)
	SIGNAL_HANDLER

	var/obj/item/weapon = parent

	// Only sweep when this weapon is in the active hand
	if(user.get_active_held_item() != weapon)
		return NONE

	// Don't intercept modified clicks (shift-click examine, ctrl-click, alt-click, etc)
	if(LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK) || LAZYACCESS(modifiers, ALT_CLICK))
		return NONE
	if(LAZYACCESS(modifiers, MIDDLE_CLICK) || LAZYACCESS(modifiers, RIGHT_CLICK))
		return NONE

	// Only sweep in combat mode
	if(!user.combat_mode)
		return NONE

	// Standard click checks
	if(INCAPACITATED_IGNORING(user, INCAPABLE_RESTRAINTS|INCAPABLE_STASIS))
		return NONE
	if(user.next_move > world.time)
		return NONE
	if(HAS_TRAIT(user, TRAIT_HANDS_BLOCKED))
		return NONE
	if(user.throw_mode)
		return NONE

	// Need force to sweep
	if(!weapon.force)
		return NONE

	// Only sweep at melee range (reach 1)
	if(weapon.reach > 1)
		return NONE

	// Don't sweep if clicking on ourselves or the weapon itself
	if(target == user || target == weapon)
		return NONE

	// If clicking on something adjacent, let normal attack handling take over
	if(user.Adjacent(target))
		return NONE

	var/turf/user_turf = get_turf(user)
	var/turf/target_turf = get_turf(target)
	if(!user_turf || !target_turf)
		return NONE

	var/attack_dir = get_dir(user_turf, target_turf)
	if(!attack_dir)
		return NONE

	// Face the attack direction
	user.face_atom(target)

	// Calculate the 3 arc turfs: center + two flanks
	var/turf/center_turf = get_step(user_turf, attack_dir)
	var/turf/left_turf = get_step(user_turf, turn(attack_dir, 45))
	var/turf/right_turf = get_step(user_turf, turn(attack_dir, -45))

	// Collect all living mobs in the arc
	var/list/victims = list()
	for(var/turf/arc_turf in list(center_turf, left_turf, right_turf))
		if(!arc_turf)
			continue
		for(var/mob/living/victim in arc_turf)
			if(victim == user)
				continue
			if(victim.stat == DEAD)
				continue
			victims += victim

	// Set the attack cooldown once for the whole sweep
	user.changeNext_move(weapon.attack_speed)

	// Play the sweep animation
	INVOKE_ASYNC(src, PROC_REF(do_sweep_animation), user, weapon, attack_dir)

	if(!length(victims))
		return COMSIG_MOB_CANCEL_CLICKON

	// Attack each victim (with default hit animations suppressed)
	INVOKE_ASYNC(src, PROC_REF(do_sweep_attacks), weapon, user, victims, center_turf)

	return COMSIG_MOB_CANCEL_CLICKON

/// Performs the actual attacks on all victims in the sweep arc
/datum/component/melee_sweep/proc/do_sweep_attacks(obj/item/weapon, mob/living/user, list/victims, turf/center_turf)
	// Suppress the default per-target attack animations during sweep
	ADD_TRAIT(user, TRAIT_SWEEP_ATTACKING, src)

	for(var/mob/living/victim as anything in victims)
		if(QDELETED(victim) || QDELETED(user) || QDELETED(weapon))
			break
		if(!user.Adjacent(victim))
			continue

		var/list/attack_modifiers = list()

		// Side targets take reduced damage
		var/turf/victim_turf = get_turf(victim)
		if(victim_turf != center_turf)
			MODIFY_ATTACK_FORCE_MULTIPLIER(attack_modifiers, side_damage_mult)

		// Call attack() directly - this handles damage, signals, logging, etc.
		weapon.attack(victim, user, list(), attack_modifiers)

	REMOVE_TRAIT(user, TRAIT_SWEEP_ATTACKING, src)

/// Animates the weapon sprite sweeping across the 3-tile arc
/datum/component/melee_sweep/proc/do_sweep_animation(mob/living/user, obj/item/weapon, attack_dir)
	var/turf/user_turf = get_turf(user)
	if(!user_turf)
		return
	new /obj/effect/temp_visual/melee_sweep_arc(user_turf, weapon, attack_dir)

// ---- Suppress default attack animations during sweep ----

/atom/movable/do_attack_animation(atom/attacked_atom, visual_effect_icon, obj/item/used_item, no_effect, fov_effect = TRUE, item_animation_override = null)
	if(HAS_TRAIT(src, TRAIT_SWEEP_ATTACKING))
		return
	return ..()

// ---- Sweep arc visual effect ----

/obj/effect/temp_visual/melee_sweep_arc
	duration = 30
	randomdir = FALSE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 200

/obj/effect/temp_visual/melee_sweep_arc/Initialize(mapload, obj/item/weapon, attack_dir)
	. = ..()
	if(!weapon || !attack_dir)
		return INITIALIZE_HINT_QDEL

	// Copy weapon appearance
	icon = weapon.icon
	icon_state = weapon.icon_state
	color = weapon.color

	// dir2angle returns clockwise degrees from north (NORTH=0, EAST=90, etc)
	var/base_angle = dir2angle(attack_dir)

	// Counteract the weapon sprite's built-in icon_angle so the handle
	// always faces inward (toward the user) during the sweep.
	var/angle_correction = -90 - weapon.icon_angle

	// Start transform: correct sprite orientation, move one tile out, then orbit to left flank
	var/matrix/start_transform = new
	start_transform.Turn(angle_correction)
	start_transform.Translate(0, 32)
	start_transform.Turn(base_angle - 45)
	transform = start_transform

	// Animate sweep: orbit from left flank to right flank (90 degree arc)
	var/matrix/end_transform = new
	end_transform.Turn(angle_correction)
	end_transform.Translate(0, 32)
	end_transform.Turn(base_angle + 45)
	animate(src, transform = end_transform, time = 21, easing = LINEAR_EASING)
	// Hold at the end, then snap fade
	animate(src, time = 6)
	animate(src, alpha = 0, time = 3)

#undef TRAIT_SWEEP_ATTACKING
