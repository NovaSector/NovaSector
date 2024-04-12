#define CONSTRICT_BASE_PIXEL_SHIFT 12

/datum/action/innate/constrict
	name = "Constrict"
	desc = "Left click to coil/uncoil your powerful tail around something, right click to begin crushing."

	button_icon = 'modular_nova/modules/taur_rework/sprites/ability.dmi'
	button_icon_state = "constrict" 

	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_pickturf.dmi'

	click_action = TRUE

	var/obj/structure/serpentine_tail/tail
	var/coil_delay = 4 SECONDS

/datum/action/innate/constrict/Destroy()
	. = ..()

	QDEL_NULL(tail)

/datum/action/innate/constrict/IsAvailable(feedback)
	. = ..()
	
	if (!.)
		return FALSE

	if (owner.incapacitated())
		if (feedback)
			owner.balloon_alert(owner, "incapacitated!")
		return FALSE

/datum/action/innate/constrict/Trigger(trigger_flags)	
	if(!..())
		return FALSE

	if (trigger_flags & TRIGGER_SECONDARY_ACTION)
		unset_ranged_ability(owner)
		if (isnull(tail))
			owner.balloon_alert(owner, "coil tail first!")
			return FALSE
		tail.toggle_crushing()
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
		return FALSE
	if (!owner.Adjacent(living_target))
		owner.balloon_alert(owner, "too far!")
		return FALSE
	if (living_target.buckled)
		owner.balloon_alert(owner, "unbuckle [owner.p_them()] first!")
		return FALSE
	if (owner.buckled)
		owner.balloon_alert(owner, "unbuckle yourself first!")
		return FALSE
	
	caller.balloon_alert_to_viewers("starts coiling tail")
	caller.visible_message(span_warning("[caller] starts coiling their tail around [living_target]..."), span_notice("You start coiling your tail around [living_target]."), ignored_mobs = list(living_target))
	to_chat(living_target, span_userdanger("[caller] starts coiling their tail around you!"))

	ADD_TRAIT(owner, TRAIT_HANDS_BLOCKED, ACTION_TRAIT)
	unset_ranged_ability(owner) // because we sleep
	var/result = do_after(caller, coil_delay, living_target, IGNORE_HELD_ITEM, extra_checks = CALLBACK(src, PROC_REF(coil_checks), living_target))
	REMOVE_TRAIT(owner, TRAIT_HANDS_BLOCKED, ACTION_TRAIT)
	if (!result)
		return FALSE
	
	caller.visible_message(span_boldwarning("[caller] coils their tail around [living_target]"), span_notice("You coil your tail around [living_target]!"), ignored_mobs = list(living_target))
	to_chat(living_target, span_userdanger("[caller] coils their tail around you!"))
	playsound(get_turf(owner), 'modular_nova/modules/emotes/sound/emotes/hiss.ogg', 25, TRUE)
	
	tail = new /obj/structure/serpentine_tail(owner.loc, caller, src)
	tail.set_constricted(living_target)
	return TRUE
	
/datum/action/innate/constrict/proc/coil_checks(mob/living/target)
	if (target.buckled)
		owner.balloon_alert(owner, "unbuckle [owner.p_them()] first!")
		return FALSE
	if (owner.buckled)
		owner.balloon_alert(owner, "unbuckle yourself first!")
		return FALSE

	return TRUE

/obj/structure/serpentine_tail
	name = "serpentine tail"
	desc = "A scaley tail, currently coiled."

	icon = 'modular_nova/master_files/icons/effects/turf_effects_64.dmi' // TODO: MOVE TO THIS MODULE
	icon_state = "naga"
	pixel_x = -16

	can_buckle = TRUE
	buckle_lying = FALSE
	layer = ABOVE_OBJ_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 60
	sound

	/// The mob we are originating from. Used for redirecting damage.
	var/mob/living/carbon/human/owner
	/// The action that made us. Nullable.
	var/datum/action/innate/constrict/creating_action
	
	var/mob/living/constricted

	var/currently_crushing = FALSE

	var/brute_per_second = 2
	/// Per second.
	var/chance_to_cause_wound = 10

	/// If we try to do crush damage and total below 5 (the minimum wounding amount), we store it here for next time.
	var/stored_damage = 0

/obj/structure/serpentine_tail/New(loc, mob/living/carbon/human/new_owner, datum/action/innate/constrict/action)
	if (isnull(new_owner))
		stack_trace("/obj/structure/serpentine_tail requires a owner to be set")
		qdel(src)
		return FALSE

	set_owner(new_owner)
	set_action(action)	

	return ..()

/obj/structure/serpentine_tail/Initialize(mapload)
	. = ..()
	
	sync_sprite()

	// TODO: MOVE ICON STATES TO THIS MODULE
	var/mutable_appearance/overlay = mutable_appearance('modular_nova/master_files/icons/effects/turf_effects_64.dmi', "naga_top", ABOVE_MOB_LAYER + 0.01, src)
	overlay.appearance_flags = TILE_BOUND|PIXEL_SCALE|KEEP_TOGETHER
	src.add_overlay(overlay)

/obj/structure/serpentine_tail/Destroy()
	. = ..()
	
	INVOKE_ASYNC(src, PROC_REF(set_constricted), null)
	var/mob/living/carbon/human/old_owner = owner
	set_owner(null)
	creating_action.tail = null
	set_action(null)
	old_owner?.update_mutant_bodyparts()

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

	finished_list += list(0,0,0,255)
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

/obj/structure/serpentine_tail/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	/*if (user == constricted)
		to_chat(user, span_warning("You try to squeeze your way out of [owner]'s grasp..."))
		if (!do_after(user, 1 SECONDS, src, IGNORE_HELD_ITEM))
			return FALSE
		if (!prob(CONSTRICT_ESCAPE_CHANCE))*/

	if (!constricted)
		return ..()

	if (user != owner)
		if (user != constricted)
			user.visible_message(span_warning("[user] tries to pry [constricted] from [owner]'s grasp!"), span_danger("You try to pry [constricted] from [owner]'s grasp..."), ignored_mobs = list(owner, constricted))
			to_chat(owner, span_userdanger("[user] tries to pry [constricted] from your grasp!"))
			to_chat(constricted, span_userdanger("[user] tries to pry you from [owner]'s grasp!"))
			if (!do_after(user, 4 SECONDS, src))
				return FALSE

	return ..()

/obj/structure/serpentine_tail/proc/set_constricted(mob/living/target)
	if (constricted == target)
		return

	if (currently_crushing && !target)
		stop_crushing()

	if (constricted)
		UnregisterSignal(constricted, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_EXAMINE))
	constricted = target

	if (constricted)
		RegisterSignal(constricted, COMSIG_MOVABLE_MOVED, PROC_REF(constricted_moved))
		RegisterSignal(constricted, COMSIG_ATOM_EXAMINE, PROC_REF(constricted_examined))
		constricted.forceMove(get_turf(src))
		buckle_mob(constricted)
		owner.grab(constricted)
		if (owner.grab_state < GRAB_AGGRESSIVE)
			owner.setGrabState(GRAB_AGGRESSIVE) // even silicons get aggrograbbed
		constricted.pixel_x += CONSTRICT_BASE_PIXEL_SHIFT * get_scale_change_mult()

/obj/structure/serpentine_tail/proc/toggle_crushing()
	if (!constricted)
		owner.balloon_alert(owner, "not constricted anything!")
		return FALSE

	if (currently_crushing)
		stop_crushing()
	else
		start_crushing()
	return TRUE

/obj/structure/serpentine_tail/proc/start_crushing()
	if (currently_crushing)
		return FALSE

	currently_crushing = TRUE
	START_PROCESSING(SSobj, src)

	owner.balloon_alert_to_viewers("starts crushing")
	owner.visible_message(span_boldwarning("[owner] starts crushing [constricted] with [owner.p_their()] tail!"), span_warning("You start crushing [constricted] with your tail."), ignored_mobs = list(constricted))
	to_chat(constricted, span_userdanger("[owner] starts crushing you with [owner.p_their()] tail!"))
	return TRUE

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

/obj/structure/serpentine_tail/proc/set_owner(mob/living/carbon/human/new_owner)
	if (owner)
		UnregisterSignal(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_GRAB))

	owner?.hide_taur_body = FALSE
	owner = new_owner
	owner?.hide_taur_body = TRUE

	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(owner_moved))
	RegisterSignal(owner, COMSIG_LIVING_GRAB, PROC_REF(owner_did_grab))
	owner?.update_mutant_bodyparts()

/obj/structure/serpentine_tail/proc/set_action(datum/action/innate/constrict/action)
	src.creating_action = action

/obj/structure/serpentine_tail/post_unbuckle_mob(mob/living/unbuckled_mob)
	. = ..()
	
	if (unbuckled_mob == constricted)
		set_constricted(null)

/obj/structure/serpentine_tail/proc/owner_moved(datum/signal_source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	qdel(src)

/obj/structure/serpentine_tail/proc/constricted_moved(datum/signal_source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	if (constricted.loc != loc)
		INVOKE_ASYNC(src, PROC_REF(set_constricted), null)

/obj/structure/serpentine_tail/proc/constricted_examined(datum/signal_source, mob/user, list/examine_text)
	SIGNAL_HANDLER

	if (currently_crushing)
		examine_text += span_boldwarning("[owner] is crushing [constricted.p_them()] with [owner.p_their()] tail!")

/obj/structure/serpentine_tail/proc/owner_did_grab(datum/signal_source, mob/living/grabbing)
	SIGNAL_HANDLER

	if (grabbing != constricted)
		INVOKE_ASYNC(src, PROC_REF(set_constricted), null)
	
#undef CONSTRICT_BASE_PIXEL_SHIFT
