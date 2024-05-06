/// When a mob is constricted, its pixel_x will be modified by this. Reverted on unconstriction. Modified by sprite scaling.
#define CONSTRICT_BASE_PIXEL_SHIFT 12
/// The base chance a mob has to escape from a constriction.	
#define CONSTRICT_ESCAPE_CHANCE 25

/datum/action/innate/constrict
	name = "Constrict"
	desc = "<b>Left click</b> to coil/uncoil your powerful tail around something, <b>right click</b> to begin crushing."
	check_flags = AB_CHECK_LYING|AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED|AB_CHECK_PHASED

	button_icon = 'modular_nova/modules/taur_rework/sprites/ability.dmi'
	button_icon_state = "constrict" 

	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_pickturf.dmi'

	click_action = TRUE

	/// The tail we use to constrict mobs with. Nullable, if inactive.
	var/obj/structure/serpentine_tail/tail
	/// The base time it takes for us to constrict a mob.
	var/base_coil_delay = 4 SECONDS

/datum/action/innate/constrict/Destroy()
	. = ..()

	QDEL_NULL(tail)

/datum/action/innate/constrict/Trigger(trigger_flags)	
	if(!..())
		return FALSE

	if (trigger_flags & TRIGGER_SECONDARY_ACTION)
		unset_ranged_ability(owner)
		if (isnull(tail))
			owner.balloon_alert(owner, "coil tail first!")
			return FALSE
		tail.toggle_crushing()
		return FALSE
	return TRUE

/datum/action/innate/constrict/do_ability(mob/living/caller, atom/clicked_on)
	if (!isliving(clicked_on))
		if (tail)
			QDEL_NULL(tail)
			return TRUE

		tail = new /obj/structure/serpentine_tail(owner.loc, caller, src)
		return TRUE

	var/mob/living/living_target = clicked_on

	if (living_target == caller)
		return TRUE

	if (!can_coil_target(living_target))
		return TRUE

	caller.balloon_alert_to_viewers("starts coiling tail")
	caller.visible_message(span_warning("[caller] starts coiling their tail around [living_target]..."), span_notice("You start coiling your tail around [living_target]..."), ignored_mobs = list(living_target))
	to_chat(living_target, span_userdanger("[caller] starts coiling their tail around you!"))

	owner.changeNext_move(10 MINUTES) // prevent interaction during this
	unset_ranged_ability(owner) // because we sleep
	var/result = do_after(caller, base_coil_delay, living_target, IGNORE_HELD_ITEM, extra_checks = CALLBACK(src, PROC_REF(can_coil_target), living_target))
	owner.changeNext_move(-10 MINUTES)
	if (!result)
		return TRUE

	do_constriction(living_target)
	return TRUE

/// Actually constricts the mob, by setting constricted to this mob and spawning a tail if needed.
/datum/action/innate/constrict/proc/do_constriction(mob/living/living_target)
	owner.visible_message(span_boldwarning("[owner] coils [owner.p_their()] tail around [living_target]!"), span_notice("You coil your tail around [living_target]!"), ignored_mobs = list(living_target))
	to_chat(living_target, span_userdanger("[owner] coils [owner.p_their()] tail around you!"))
	
	if (!tail)
		tail = new /obj/structure/serpentine_tail(owner.loc, owner, src)
	tail.set_constricted(living_target)
	return TRUE

/// Returns TRUE if the target can be constricted, FALSE otherwise. If silent is TRUE, sends no feedback messages.
/datum/action/innate/constrict/proc/can_coil_target(mob/living/target, silent = FALSE)
	if (!owner.Adjacent(target))
		if (!silent)
			owner.balloon_alert(owner, "too far!")
		return FALSE

	if (target.buckled)
		if (!silent)
			owner.balloon_alert(owner, "unbuckle [target.p_them()] first!")
		return FALSE

	if (owner.buckled)
		if (!silent)
			owner.balloon_alert(owner, "unbuckle yourself first!")
		return FALSE

	return TRUE

/obj/structure/serpentine_tail
	name = "serpentine tail"
	desc = "A scaley tail, currently coiled."

	icon = 'modular_nova/modules/taur_rework/sprites/tail.dmi'
	icon_state = "naga"
	pixel_x = -16

	can_buckle = TRUE
	buckle_lying = FALSE
	layer = ABOVE_OBJ_LAYER
	anchored = TRUE
	density = FALSE
	max_integrity = 60

	/// The mob we are originating from.
	var/mob/living/carbon/human/owner
	/// The action that made us. Nullable.
	var/datum/action/innate/constrict/creating_action
	
	/// The mob we are currently constricting, usually coincides with what we have buckled to us. Nullable.
	var/mob/living/constricted

	/// If we're currently allowing constricted to be grabbed. Only briefly true, during set_constricted.
	var/allowing_grab_on_constricted = FALSE

	/// Are we currently crushing constricted?
	var/currently_crushing = FALSE
	/// The amount of brute damage we will do per second to constricted if we are crushing.
	var/brute_per_second = 2
	/// How likely are we, per second, to cause a blunt wound on constricted if we are crushing?
	var/chance_to_cause_wound = 5

	/// If we try to do crush damage and total below 5 (the minimum wounding amount), we store it here for next time.
	var/stored_damage = 0

	/// Used for escaping the tail, separate from grab cooldowns.
	COOLDOWN_DECLARE(escape_cooldown)

/obj/structure/serpentine_tail/New(loc, mob/living/carbon/human/new_owner, datum/action/innate/constrict/action)
	if (isnull(new_owner))
		qdel(src) // requires an owner, not stack tracing because it fails tests
		return FALSE

	set_owner(new_owner)
	set_action(action)	

	return ..()

/obj/structure/serpentine_tail/Initialize(mapload)
	. = ..()
	
	sync_sprite()

	var/mutable_appearance/overlay = mutable_appearance('modular_nova/modules/taur_rework/sprites/tail.dmi', "naga_top", ABOVE_MOB_LAYER + 0.01, src)
	overlay.appearance_flags = TILE_BOUND|PIXEL_SCALE|KEEP_TOGETHER
	add_overlay(overlay)

/obj/structure/serpentine_tail/Destroy()
	. = ..()
	
	INVOKE_ASYNC(src, PROC_REF(set_constricted), null)
	var/mob/living/carbon/human/old_owner = owner
	set_owner(null)
	set_action(null)
	creating_action?.tail = null
	old_owner?.update_mutant_bodyparts()

/// Syncs our colors, size, sprite, etc. with owner.
/obj/structure/serpentine_tail/proc/sync_sprite()
	//coloring
	var/list/finished_list = list()
	var/list/color_list = owner.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_COLOR_LIST] //identify color
	var/datum/sprite_accessory/sprite_type = GLOB.sprite_accessories["taur"][owner.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]] //identify type

	switch(sprite_type.color_src)
		if(USE_MATRIXED_COLORS)
			finished_list += rgb2num("[color_list[1]]00")
			finished_list += rgb2num("[color_list[2]]00")
			finished_list += rgb2num("[color_list[3]]00")
		if(USE_ONE_COLOR)
			var/padded_string = "[color_list[1]]00"
			finished_list += rgb2num(padded_string)
			finished_list += rgb2num(padded_string)
			finished_list += rgb2num(padded_string)

	finished_list += list(0, 0, 0, 255)
	for(var/index in 1 to finished_list.len)
		finished_list[index] /= 255

	color = finished_list
	if(isroundstartslime(owner) || isslimeperson(owner) || isjellyperson(owner))
		alpha = 130

	var/change_multiplier = get_scale_change_mult()
	var/translate = ((change_multiplier-1) * 32)/2
	transform = transform.Scale(change_multiplier)
	transform = transform.Translate(0, translate)
	appearance_flags = PIXEL_SCALE

/// Returns the scale, compared to default, our owner has.
/obj/structure/serpentine_tail/proc/get_scale_change_mult()
	return owner.dna.features["body_size"] / BODY_SIZE_NORMAL

/obj/structure/serpentine_tail/process(seconds_per_tick)
	stored_damage += (brute_per_second * seconds_per_tick)
	if (stored_damage < WOUND_MINIMUM_DAMAGE)
		return
	var/armor = constricted.run_armor_check(attack_flag = MELEE)
	var/wound_bonus = 0
	if (SPT_PROB(chance_to_cause_wound, seconds_per_tick))
		wound_bonus = rand(40, 70)
	var/def_zone = null
	if (iscarbon(constricted))
		var/mob/living/carbon/carbon_target = constricted
		def_zone = pick(carbon_target.bodyparts)
	constricted.apply_damage(stored_damage, BRUTE, def_zone = def_zone, blocked = armor, wound_bonus = wound_bonus)
	stored_damage = 0
	owner.visible_message(span_warning("[owner] squeezes [constricted] with [owner.p_their()] tail!"), span_danger("You squeeze [constricted] with your tail!"), ignored_mobs = list(constricted))
	to_chat(constricted, span_warning("[owner] squeezes you with [owner.p_their()] tail!"))

/obj/structure/serpentine_tail/atom_destruction(damage_flag)
	/// Assoc list of [damage_flag -> damage_type], e.g. ACID = BURN.
	var/static/list/damage_flags_to_types = list(
		ACID = BURN,
		LASER = BURN,
		ENERGY = BURN,
		BIO = BURN,
		FIRE = BURN,
		CONSUME = BRUTE,
		MELEE = BRUTE,
		BULLET = BRUTE,
		BOMB = BRUTE
	)

	var/damage_type = damage_flags_to_types[damage_flag]
	if (!damage_type)
		damage_type = BRUTE

	var/obj/item/bodypart/def_zone = owner.get_bodypart(BODY_ZONE_L_LEG)
	if (!def_zone || rand(50))
		def_zone = owner.get_bodypart(BODY_ZONE_R_LEG)
	if (!def_zone)
		def_zone = owner.get_bodypart(BODY_ZONE_CHEST)

	to_chat(owner, span_userdanger("You recall your tail as a sharp pain shoots through it!"))
	owner.apply_damage(30, damage_type, def_zone)

	return ..()

/// Setter proc for constricted. Handles signals, pixel shifting, status effects, etc.
/obj/structure/serpentine_tail/proc/set_constricted(mob/living/target)
	if (constricted == target)
		return

	if (currently_crushing && !target)
		stop_crushing()

	if (constricted)		
		UnregisterSignal(constricted, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_EXAMINE, COMSIG_LIVING_TRY_PULL))
		constricted.pixel_x -= CONSTRICT_BASE_PIXEL_SHIFT * get_scale_change_mult()
		constricted.remove_status_effect(/datum/status_effect/constricted)

	constricted = target

	if (!constricted)
		return

	RegisterSignal(constricted, COMSIG_MOVABLE_MOVED, PROC_REF(constricted_moved))
	RegisterSignal(constricted, COMSIG_ATOM_EXAMINE, PROC_REF(constricted_examined))
	RegisterSignal(constricted, COMSIG_LIVING_TRY_PULL, PROC_REF(constricted_tried_pull))
	var/old_grab_state = owner.grab_state // intentionally placed before the signals so we can allow the grab to carry over
	constricted.forceMove(get_turf(src))
	buckle_mob(constricted)
	constricted.pixel_x += CONSTRICT_BASE_PIXEL_SHIFT * get_scale_change_mult()
	constricted.apply_status_effect(/datum/status_effect/constricted)

	if (old_grab_state < GRAB_AGGRESSIVE)
		return

	allowing_grab_on_constricted = TRUE
	owner.grab(constricted)
	owner.setGrabState(old_grab_state)
	allowing_grab_on_constricted = FALSE

/// Toggle proc for crushing. See stop_crushing and start_crushing.
/obj/structure/serpentine_tail/proc/toggle_crushing()
	if (!constricted)
		owner.balloon_alert(owner, "not constricted anything!")
		return FALSE

	if (currently_crushing)
		stop_crushing()
	else
		start_crushing()

	return TRUE

/// Setter proc for currently_crushing that handles processing and warnings.
/obj/structure/serpentine_tail/proc/start_crushing()
	if (currently_crushing)
		return FALSE

	currently_crushing = TRUE
	START_PROCESSING(SSobj, src)

	owner.balloon_alert_to_viewers("starts crushing")
	owner.visible_message(span_boldwarning("[owner] starts crushing [constricted] with [owner.p_their()] tail!"), span_warning("You start crushing [constricted] with your tail!"), ignored_mobs = list(constricted))
	to_chat(constricted, span_userdanger("[owner] starts crushing you with [owner.p_their()] tail!"))
	return TRUE

/// Setter proc for currently_crushing that handles processing and warnings.
/obj/structure/serpentine_tail/proc/stop_crushing()
	if (!currently_crushing)
		return FALSE

	owner.balloon_alert_to_viewers("stops crushing")
	owner.visible_message(span_warning("[owner] stops crushing [constricted] with [owner.p_their()] tail."), span_notice("You stop crushing [constricted] with your tail."), ignored_mobs = list(constricted))
	to_chat(constricted, span_boldwarning("[owner] stops crushing you with [owner.p_their()] tail."))

	currently_crushing = FALSE
	STOP_PROCESSING(SSobj, src)
	stored_damage = 0
	return TRUE

/// Setter proc for owner that handles signals, bodyparts, etc.
/obj/structure/serpentine_tail/proc/set_owner(mob/living/carbon/human/new_owner)
	if (owner)
		UnregisterSignal(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_GRAB, COMSIG_LIVING_TRY_PULL, COMSIG_LIVING_SET_BODY_POSITION))

	owner?.hide_taur_body = FALSE
	owner = new_owner
	owner?.hide_taur_body = TRUE

	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(owner_moved))
	RegisterSignal(owner, COMSIG_LIVING_GRAB, PROC_REF(owner_tried_grab))
	RegisterSignal(owner, COMSIG_LIVING_TRY_PULL, PROC_REF(owner_tried_pull))
	RegisterSignal(owner, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(owner_body_position_changed))
	owner?.update_mutant_bodyparts()

/// Setter proc for action.
/obj/structure/serpentine_tail/proc/set_action(datum/action/innate/constrict/action)
	creating_action = action

/obj/structure/serpentine_tail/user_unbuckle_mob(mob/living/buckled_mob, mob/user)	
	if (!constricted || (user != constricted)) // anyone can easily free them except themselves
		return ..()

	if (!COOLDOWN_FINISHED(src, escape_cooldown))
		to_chat(user, span_warning("You're still recovering from your last escape attempt!")) // prevent escape spam
		return FALSE

	var/escape_chance = CONSTRICT_ESCAPE_CHANCE
	if (HAS_TRAIT(user, TRAIT_SLIPPERY))
		escape_chance += 10 // akula

	if (!prob(escape_chance))
		user.visible_message(span_warning("[user] squirms as they fail to escape from [owner]'s tail!"), span_warning("You squirm as you fail to escape from [owner]'s tail!"), ignored_mobs = owner)
		to_chat(owner, span_warning("[user] squirms as they fail to escape from the grip of your tail!"))
		COOLDOWN_START(src, escape_cooldown, 0.5 SECONDS) // arbitrary
		return FALSE

	user.visible_message(span_warning("[user] breaks free from [owner]'s tail!"), span_warning("You break free from [owner]'s tail!"), ignored_mobs = owner)
	to_chat(owner, span_boldwarning("[user] breaks free from the grip of your tail!"))
	return ..()

/obj/structure/serpentine_tail/post_unbuckle_mob(mob/living/unbuckled_mob)
	. = ..()
	
	if (unbuckled_mob == constricted)
		set_constricted(null)

/obj/structure/serpentine_tail/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/weapons/bladeslice.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(!damage_amount)
				return

			playsound(loc, 'sound/items/welder.ogg', 100, TRUE)


/// Signal proc for when owner moves. Qdels src.
/obj/structure/serpentine_tail/proc/owner_moved(datum/signal_source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	qdel(src)

/// Signal proc for if our owner changes body positions. Qdels src if they lie down.
/obj/structure/serpentine_tail/proc/owner_body_position_changed(datum/signal_source, old_position, new_position)
	SIGNAL_HANDLER
	
	if (new_position == LYING_DOWN)
		qdel(src)

/// Signal proc for if constricted moves. If the new loc isnt our loc, we stop constricting them. Used for teleportation escapes.
/obj/structure/serpentine_tail/proc/constricted_moved(datum/signal_source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	if (constricted.loc != loc)
		INVOKE_ASYNC(src, PROC_REF(set_constricted), null)

/// Signal proc for constricted being examined. Appends a string warning the viewer of them being crushed.
/obj/structure/serpentine_tail/proc/constricted_examined(datum/signal_source, mob/user, list/examine_text)
	SIGNAL_HANDLER

	if (currently_crushing)
		examine_text += span_boldwarning("[owner] is crushing [constricted.p_them()] with [owner.p_their()] tail!")

/// Signal proc for owner pulling someone. Forbids them from pulling constricted.
/obj/structure/serpentine_tail/proc/owner_tried_pull(datum/signal_source, atom/movable/thing, force)
	SIGNAL_HANDLER

	if (!allowing_grab_on_constricted && thing == constricted)
		owner.balloon_alert(owner, "can't grab constricted!")
		return COMPONENT_CANCEL_ATTACK_CHAIN

/// Signal proc for owner grabbing someone, separate from pulling. Forbids them from upgrading grabs on constricted.
/obj/structure/serpentine_tail/proc/owner_tried_grab(datum/signal_source, mob/living/grabbing)
	SIGNAL_HANDLER

	if (!allowing_grab_on_constricted && grabbing == constricted)
		owner.balloon_alert(owner, "can't grab constricted!")
		return COMPONENT_CANCEL_ATTACK_CHAIN

/// Signal proc that prevents constricted from grabbing owner.
/obj/structure/serpentine_tail/proc/constricted_tried_pull(datum/signal_source, atom/movable/thing, force)
	SIGNAL_HANDLER

	if (thing == owner)
		constricted.balloon_alert(constricted, "can't grab constricter!")
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/status_effect/constricted
	id = "constricted_tail"

	alert_type = /atom/movable/screen/alert/status_effect/constricted

/atom/movable/screen/alert/status_effect/constricted
	name = "Constricted"
	desc = "You're being constricted by a giant tail! You can resist, attack the tail, or attack the constricter to escape!"

	icon = 'modular_nova/modules/taur_rework/sprites/ability.dmi'
	icon_state = "constrict" 

#undef CONSTRICT_BASE_PIXEL_SHIFT
#undef CONSTRICT_ESCAPE_CHANCE
