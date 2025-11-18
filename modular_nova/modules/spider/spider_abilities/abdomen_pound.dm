/// Default additional time to spend stunned per usage of ability
#define DEFAULT_ACTIVATED_ENDLAG 3 DECISECONDS

/// Rise into the air and slam down, knocking people away. No real cooldown but has escalating endlag if used in quick succession.
/datum/action/cooldown/mob_cooldown/abdomen_pound
	name = "Abdomen Pound"
	desc = "Raise your abdomen in the air and slam it onto the ground, scattering those close to you."
	button_icon = 'icons/effects/magic.dmi'
	button_icon_state = "3"
	cooldown_time = 10 SECONDS
	melee_cooldown_time = 0
	click_to_activate = FALSE
	shared_cooldown = NONE
	/// Timer we use to track our current action
	var/active_timer
	/// How far away can we reach people?
	var/pound_distance = 3
	/// How long to animate for before we start?
	var/windup_time = 1.2 SECONDS
	/// Minimum amount of stun time following use of wing buffet
	var/minimum_endlag = 4 DECISECONDS
	/// Amount of extra time to stay stunned after the end of the ability
	var/additional_endlag = 0 DECISECONDS
	/// Amount of time to add to endlag after each successful use of the ability
	var/endlag_per_activation = DEFAULT_ACTIVATED_ENDLAG
	/// How much accumulated stun time do we subtract every second? Takes a full minute to regen off a single use :(
	var/endlag_decay_per_second = DEFAULT_ACTIVATED_ENDLAG / 60
	/// List of traits we apply while the ability is ongoing, stops us from moving around and such
	var/static/list/applied_traits = list(
		TRAIT_IMMOBILIZED,
		TRAIT_INCAPACITATED,
		TRAIT_NO_FLOATING_ANIM,
		TRAIT_ABDOMEN_POUND,
	)

/datum/action/cooldown/mob_cooldown/abdomen_pound/Grant(mob/granted_to)
	. = ..()
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(on_life))

/datum/action/cooldown/mob_cooldown/abdomen_pound/Remove(mob/removed_from)
	. = ..()
	deltimer(active_timer)
	UnregisterSignal(removed_from, COMSIG_LIVING_LIFE)
	removed_from.remove_traits(applied_traits, REF(src))

/// Decay our accumulated additional tiredness
/datum/action/cooldown/mob_cooldown/abdomen_pound/proc/on_life(mob/living/liver, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if (liver.stat == DEAD)
		return // not so life now buddy
	additional_endlag = max(0, additional_endlag - (endlag_decay_per_second * seconds_per_tick))

/datum/action/cooldown/mob_cooldown/abdomen_pound/Activate(atom/target)
	begin_sequence()
	StartCooldown()
	return TRUE

/// Rise that ass up into the air
/datum/action/cooldown/mob_cooldown/abdomen_pound/proc/begin_sequence()
	owner.add_traits(applied_traits, REF(src)) // No moving till we're done
	owner.update_appearance(UPDATE_ICON)
	owner.balloon_alert(owner, "you raise your abdomen high up into the air.")
	animate(owner, pixel_y = 10, time = windup_time)
	active_timer = addtimer(CALLBACK(src, PROC_REF(ground_pound)), windup_time, TIMER_DELETE_ME | TIMER_STOPPABLE)
	for (var/mob/living/candidate in view(pound_distance, owner))
		if(candidate == owner || candidate.faction_check_atom(owner))
			continue
		owner.balloon_alert_to_viewers("Raises their abdomen high up into the air!")

/// Slam it into the ground
/datum/action/cooldown/mob_cooldown/abdomen_pound/proc/ground_pound()
	if (QDELETED(owner))
		return
	owner.pixel_y = 0
	playsound(owner, 'sound/effects/gravhit.ogg', 100, TRUE)
	for (var/mob/living/candidate in view(pound_distance, owner))
		if(candidate == owner || candidate.faction_check_atom(owner))
			continue
		owner.visible_message(span_boldwarning("[candidate] is knocked back by the sudden slam on the tiles!"))
		to_chat(candidate, span_userdanger("You're knocked back by the spiders impact on the floor!"))
		var/dir_to_target = get_dir(get_turf(owner), get_turf(candidate))
		var/throwtarget = get_edge_target_turf(target, dir_to_target)
		candidate.safe_throw_at(throwtarget, range = 7, speed = 1, thrower = owner)
		candidate.Paralyze(5 SECONDS)

	var/stun_time = minimum_endlag + (additional_endlag )
	additional_endlag += endlag_per_activation// double dips, rough
	owner.update_appearance(UPDATE_ICON)
	active_timer = addtimer(CALLBACK(src, PROC_REF(complete_ability)), stun_time, TIMER_DELETE_ME | TIMER_STOPPABLE)

/datum/action/cooldown/mob_cooldown/abdomen_pound/proc/complete_ability()
	owner.remove_traits(applied_traits, REF(src))
	owner.update_appearance(UPDATE_ICON)

#undef DEFAULT_ACTIVATED_ENDLAG
