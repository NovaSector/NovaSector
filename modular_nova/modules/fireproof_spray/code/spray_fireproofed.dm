/**
 * Component representing an atom being fireproof sprayed
 * Can only be used on clothing atoms
 */
/datum/component/spray_fireproofed
	// How much fire protection we have left before we wear off.
	var/spray_health = 1000
	/// The amount of time the item can be in fire safely. -1 makes it permanent.
	var/fire_immunity_time
	/// The time it takes for the item to 'cool off' aka be able to grant fire resistance again
	var/cooling_off_time
	/// Whether or not we are cooling down
	var/cooling_down
	/// timerid for the fire immunity
	var/fire_immunity_timer
	/// The cooldown it takes for the item to cool off once it's reached its resistance threshold
	COOLDOWN_DECLARE(cool_off_cd)

/datum/component/spray_fireproofed/Initialize(immunity_time = 60 SECONDS, cooloff_time = 5 SECONDS)
	if(!isclothing(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/clothing/clothing_parent = parent
	if(clothing_parent.resistance_flags & FIRE_PROOF)
		stack_trace("Tried to add /datum/component/spray_firepoofed to an item ([clothing_parent.type]) that was already fireproof!")
		return COMPONENT_INCOMPATIBLE

	if(immunity_time == -1) // permanent
		add_fireproofing()
		return COMPONENT_REDUNDANT

	fire_immunity_time = immunity_time
	cooling_off_time = cooloff_time

/datum/component/spray_fireproofed/Destroy(force)
	if(!QDELETED(parent))
		var/obj/item/clothing/clothing_parent = parent
		var/mob/parent_loc = clothing_parent.loc
		if(!force && istype(parent_loc))
			parent_loc.balloon_alert(parent_loc, "fireproof spray wears off of [parent]!")
	deltimer(fire_immunity_timer)
	return ..()

/datum/component/spray_fireproofed/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_PRE_FIRE_ACT, PROC_REF(on_pre_fire_act))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

	add_fireproofing()

/datum/component/spray_fireproofed/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_PRE_FIRE_ACT,
		COMSIG_ATOM_EXAMINE,
	))
	remove_fireproofing()

// Keep check if the cooling down period has stopped, so we aren't reliant on fire_act() doing that for us.
/datum/component/spray_fireproofed/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, cool_off_cd))
		return

	cooling_down = FALSE
	STOP_PROCESSING(SSburning, src)

/// Makes the item fireproof
/datum/component/spray_fireproofed/proc/add_fireproofing()
	var/obj/item/clothing/clothing_parent = parent
	clothing_parent.resistance_flags |= FIRE_PROOF
	clothing_parent.name = "fireproofed " + clothing_parent.name

/// Un-makes the item fireproof
/datum/component/spray_fireproofed/proc/remove_fireproofing()
	var/obj/item/clothing/clothing_parent = parent
	if(!QDELETED(clothing_parent))
		clothing_parent.resistance_flags &= ~FIRE_PROOF
		clothing_parent.name = replacetext(clothing_parent.name, "fireproofed ", "")

/// Alerts any examiners that the parent is fireproofed
/datum/component/spray_fireproofed/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("It is coated with fireproofing material.[spray_health <= 500 ? " It is beginning to wear off.": ""]")

/// There is a limit to how much flame protection is offered by the spray. After 60 seconds (by default), the spray begins to wear down. It will need time to cool off again before granting full immunity.
/datum/component/spray_fireproofed/proc/on_pre_fire_act(obj/source, exposed_temperature, exposed_volume)
	SIGNAL_HANDLER

	// Begin the timer for fire immunity
	if(!cooling_down && !timeleft(fire_immunity_timer))
		fire_immunity_timer = addtimer(CALLBACK(src, PROC_REF(end_fire_immunity)), fire_immunity_time, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE|TIMER_DELETE_ME)
		return

	// begin wearing down if we are still getting burned once the immunity expires and before we've cooled off
	if(cooling_down && exposed_temperature >= FIRE_MINIMUM_TEMPERATURE_TO_SPREAD)
		spray_health -= min(10, exposed_temperature/100)

	if(spray_health <= 0)
		qdel(src)
		return

	// Reset the cooling down period with each fire_act() if we're not cooled down yet.
	if(cooling_down && !COOLDOWN_FINISHED(src, cool_off_cd))
		COOLDOWN_START(src, cool_off_cd, cooling_off_time)

/// When the fire immunity reaches its limit
/datum/component/spray_fireproofed/proc/end_fire_immunity()
	COOLDOWN_START(src, cool_off_cd, cooling_off_time)
	cooling_down = TRUE
	START_PROCESSING(SSburning, src)
