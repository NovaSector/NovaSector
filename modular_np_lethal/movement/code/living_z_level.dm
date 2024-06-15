// Living entities with this component don't blindly move into z-level changes (most of the time) with some special behaviors.

GLOBAL_LIST_INIT(drugs_that_cause_zfalls, list(
	/datum/reagent/drug/demoneye,
	/datum/reagent/drug/bath_salts,
	/datum/reagent/drug/blastoff,
	/datum/reagent/drug/happiness,
	/datum/reagent/drug/mushroomhallucinogen,
	/datum/reagent/drug/space_drugs,
))

/datum/component/cautious_z_movement
	var/shoved = FALSE
	var/thrown = FALSE
	var/attempt_ledge = FALSE

/datum/component/cautious_z_movement/Initialize(...)
	. = ..()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_LIVING_DISARM_PRESHOVE, PROC_REF(got_shoved))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_IMPACT, PROC_REF(got_thrown))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(openspace_movement))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(handle_ledge))

/datum/component/cautious_z_movement/proc/got_shoved()
	SIGNAL_HANDLER
	shoved = TRUE

/datum/component/cautious_z_movement/proc/got_thrown()
	SIGNAL_HANDLER
	thrown = TRUE

/datum/component/cautious_z_movement/proc/reset_forced_movement_vars()
	thrown = FALSE
	shoved = FALSE

/datum/component/cautious_z_movement/proc/allow_movement()
	reset_forced_movement_vars()
	return NONE

/datum/component/cautious_z_movement/proc/disallow_movement()
	reset_forced_movement_vars()
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/component/cautious_z_movement/proc/handle_ledge()
	SIGNAL_HANDLER

	if (attempt_ledge)
		var/mob/living/alive_thing = parent
		INVOKE_ASYNC(src, PROC_REF(try_ledge), alive_thing)

/datum/component/cautious_z_movement/proc/ledge_callback()
	return (attempt_ledge == TRUE)

/datum/component/cautious_z_movement/proc/try_ledge(mob/living/us)
	// fire off a ledge sequence - hang in there, buddy!
	if (attempt_ledge)
		us.recover_from_ledge(channel = 10 SECONDS, channel_cancel = 2 SECONDS, checks = CALLBACK(src, PROC_REF(ledge_callback)))
		attempt_ledge = FALSE

/datum/component/cautious_z_movement/proc/drugged_up(mob/living/us)
	// BY THE NINES, I'M TWEAKING!!!
	var/list/juice = list()

	for (var/datum/reagent/substance as anything in us.reagents.reagent_list)
		if (locate(substance) in GLOB.drugs_that_cause_zfalls)
			return TRUE
		if (istype(substance, /datum/reagent/drug))
			juice += substance

	if (LAZYLEN(juice) >= 2) // if we have 2 concurrent drug reagents, we're drugged up
		return TRUE

	if (LAZYLEN(us.reagents.reagent_list) >= 5) // we have a LOT going on internally right now and that's gotta be fucking us up
		return TRUE

	return FALSE

/datum/component/cautious_z_movement/proc/openspace_movement(mob/living/alive_thing, atom/new_location)
	SIGNAL_HANDLER

	if (attempt_ledge && alive_thing.do_afters["ledge_recover"] && !shoved && !thrown) // we're currently trying to mantle a ledge. movement should basically always fail, but the act should also cancel our ledging do_after
		attempt_ledge = FALSE // this should cause ledge_callback to end the do_after and make us plummet to the ground in the tile we're in, hopefully
		return disallow_movement()

	var/turf/new_loc_turf = get_turf(new_location)
	if (isopenspaceturf(new_loc_turf)) // we're about to lemming off a fucking cliff.
		if (HAS_TRAIT_NOT_FROM(alive_thing, TRAIT_MOVE_FLYING, "ledge trait") || HAS_TRAIT(alive_thing, TRAIT_NEGATES_GRAVITY)) //don't need to worry about any of this if we're flying or anti-grav enabled
			return allow_movement()

		if (alive_thing.combat_mode) // if you're combat-mode enabled, you'll always move into open space. no ledge grab chances for you either
			return allow_movement()

		if (shoved || thrown) // we got force-moved, so always allow it
			return allow_movement()

		var/turf/is_it_stairs = GET_TURF_BELOW(new_loc_turf)
		if (is_it_stairs && locate(/obj/structure/stairs) in is_it_stairs) //hey but first does it have stairs? because stairs are good, we like stairs
			return allow_movement()

		if (istype(new_loc_turf, /turf/open/floor/catwalk_floor)) //catwalks are okay
			return allow_movement()

		if (locate(/obj/structure/lattice) in new_loc_turf) //lattices are also okay
			return allow_movement()

		if (alive_thing.stat != CONSCIOUS || alive_thing.IsUnconscious() || alive_thing.IsParalyzed() || alive_thing.IsImmobilized() || alive_thing.IsStun() || alive_thing.IsKnockdown() || alive_thing.IsFrozen() || alive_thing.IsSleeping()) // you can't do shit, so you're going off the edge
			return allow_movement()

		if (ishuman(alive_thing))
			var/mob/living/carbon/human/human_thing = alive_thing
			var/human_dizziness = human_thing.get_timed_status_effect_duration(/datum/status_effect/dizziness)
			var/human_confusion = human_thing.get_timed_status_effect_duration(/datum/status_effect/confusion)
			var/human_drowsiness = human_thing.get_timed_status_effect_duration(/datum/status_effect/drowsiness)
			var/human_drugginess = human_thing.get_timed_status_effect_duration(/datum/status_effect/drugginess)
			var/human_jitteriness = human_thing.get_timed_status_effect_duration(/datum/status_effect/jitter)

			// TODO: captagon really needs to like, always trigger this. check for total reagents being digested?

			if (human_dizziness >= 6 SECONDS)
				human_thing.visible_message(span_warning("Struggling to stay upright, [human_thing] stumbles and tips right over into [new_loc_turf]!"), span_userdanger("The world just won't stop spinning, and it all suddenly gets worse as you topple into [new_loc_turf]!"))
				if (prob(5))
					attempt_ledge = TRUE // dizziness is the worst state to be in when you're like this
				return allow_movement()

			// Collectively, how rattled is our shit right now?
			var/debilitation = human_confusion + human_drugginess
			if (debilitation >= 12 SECONDS || drugged_up(human_thing)) // if you're rattled, you go down the fucking hole
				human_thing.visible_message(span_warning("Tweaking out of [human_thing.p_their()] mind, [human_thing] steps right off into [new_loc_turf]!"), span_userdanger("Tweaking out of your mind, you step into [new_loc_turf] with reckless abandon!"))
				if (prob(33))
					attempt_ledge = TRUE // sometimes carol lets you hold on for another day
				return allow_movement()

			// Are we really drowsy?
			if (human_drowsiness >= 30 SECONDS)
				human_thing.visible_message(span_warning("Too drowsy to spot the danger, [human_thing] walks straight off into [new_loc_turf]!"), span_userdanger("Thoughts of the sleep you so desperately need cloud your mind, causing you to walk straight off into [new_loc_turf]!"))
				if (prob(50))
					attempt_ledge = TRUE // 50% of the time, you get a chance to recover.
				return allow_movement()

			// Are we tweaking off stimulants to a really noticable degree?
			if (human_jitteriness >= 3 MINUTES)
				human_thing.visible_message(span_warning("Unable to contain [human_thing.p_their()] convulsions, [human_thing] totters right off into [new_loc_turf]!"), span_userdanger("Unable to control your jittery convulsions, you totter right off into [new_loc_turf]!"))
				attempt_ledge = TRUE // you always get a shot, jitteriness is not that bad
				return allow_movement()

		// 1% of the time, we'll fumble and move instead, but we'll always get a chance to recover, at least.
		if (prob(1))
			attempt_ledge = TRUE
			return allow_movement()
		else
			to_chat(alive_thing, span_notice("You keep a safe distance from [new_loc_turf]."))
			return disallow_movement()

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cautious_z_movement)

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cautious_z_movement)
