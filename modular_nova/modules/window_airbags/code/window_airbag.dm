#define DISARM_TIME (1 SECONDS)
#define TRAIT_AIRBAGGED "airbagged"

/obj/structure/window/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!. || !HAS_TRAIT(src, TRAIT_AIRBAGGED))
		return
	REMOVE_TRAIT(src, TRAIT_AIRBAGGED, TRAIT_GENERIC)
	var/obj/item/airbag = new /obj/item/airbag(user.loc)
	if(!QDELETED(airbag))
		airbag.add_fingerprint(user)

/obj/structure/window/reinforced/fulltile/Initialize(mapload)
	. = ..()
	if(mapload)
		AddElement(/datum/element/airbag)

/obj/structure/window/reinforced/plasma/fulltile/Initialize(mapload)
	. = ..()
	if(mapload)
		AddElement(/datum/element/airbag)

/**
 * Airbag Element
 *
 * Basically a fancy create on destroy.
 */
/datum/element/airbag
	/// The type we spawn when our parent is destroyed
	var/airbag_type = /obj/item/airbag/immediate_arm
	/// The type we spawn when we are disarmed.
	var/disarmed_type = /obj/item/airbag

/datum/element/airbag/Attach(datum/target)
	. = ..()
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_DESTRUCTION, PROC_REF(deploy_airbag))
	RegisterSignal(target, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(on_interact))
	RegisterSignal(target, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM, PROC_REF(on_requesting_context_from_item))
	ADD_TRAIT(target, TRAIT_AIRBAGGED, TRAIT_GENERIC)

/datum/element/airbag/Detach(datum/target)
	. = ..()

	UnregisterSignal(target, list(COMSIG_ATOM_DESTRUCTION, COMSIG_CLICK_CTRL_SHIFT, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM))
	REMOVE_TRAIT(target, TRAIT_AIRBAGGED, TRAIT_GENERIC)

/datum/element/airbag/proc/deploy_airbag(atom/movable/destroying_atom, damage_flag)
	SIGNAL_HANDLER
	new airbag_type(get_turf(destroying_atom))

/datum/element/airbag/proc/on_interact(atom/movable/clicked_atom, mob/living/clicker)
	SIGNAL_HANDLER
	if(!clicker.can_interact_with(clicked_atom) || !clicker.can_perform_action(clicked_atom, ALLOW_RESTING))
		return
	INVOKE_ASYNC(src, PROC_REF(disarm_airbag), clicked_atom, clicker)

/datum/element/airbag/proc/disarm_airbag(atom/movable/clicked_atom, mob/living/clicker)
	var/empty_hand = LAZYACCESS(clicker.get_empty_held_indexes(), 1)
	if(!empty_hand)
		clicked_atom.balloon_alert(clicker, "no empty hand!")
		return
	clicked_atom.balloon_alert_to_viewers("disarming airbag...")
	if(do_after(clicker, DISARM_TIME, clicked_atom))
		playsound(clicked_atom, 'sound/machines/click.ogg', 75, TRUE, -3)
		clicker.put_in_hands(new disarmed_type(clicker))
		Detach(clicked_atom)

/datum/element/airbag/proc/on_requesting_context_from_item(atom/source, list/context, obj/item/held_item, mob/user)
	SIGNAL_HANDLER
	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Disarm airbag"
	return CONTEXTUAL_SCREENTIP_SET

// A fun little gadget!
/obj/item/airbag
	name = "airbag"
	desc = "A small package with an explosive attached. Stand clear! \n\
		Can be attached to any window."
	icon = 'modular_nova/modules/inflatables/icons/inflatable.dmi'
	icon_state = "airbag_safe"
	base_icon_state = "airbag"
	max_integrity = 10
	/// The time in which we deploy
	var/detonate_time = 2 SECONDS
	/// The item we drop on detonation
	var/drop_type = /obj/structure/inflatable/window_airbag
	/// Are we immediately armed?
	var/immediate_arm = FALSE
	/// Are we currently armed?
	var/armed = FALSE
	/// The sound we play when armed
	var/armed_sound = 'modular_nova/modules/window_airbags/sound/airbag_arm.ogg'
	/// The sound we play when we go bang
	var/bang_sound = 'modular_nova/modules/window_airbags/sound/airbag_bang.ogg'

/obj/item/airbag/Initialize(mapload)
	. = ..()
	if(immediate_arm)
		arm()
		anchored = TRUE

/obj/item/airbag/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[armed ? "armed" : "safe"]"

/obj/item/airbag/attack_self(mob/user, modifiers)
	. = ..()
	arm()

/obj/item/airbag/afterattack(atom/attacked_atom, mob/user, list/modifiers, list/attack_modifiers)
	if(attempt_attach(attacked_atom, user))
		playsound(attacked_atom, 'sound/machines/click.ogg', 75, TRUE, -3)
		attacked_atom.AddElement(/datum/element/airbag)
		qdel(src)
		return

/obj/item/airbag/proc/attempt_attach(atom/target, mob/user)
	if(!loc.Adjacent(target) || !istype(target, /obj/structure/window))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_AIRBAGGED))
		user.balloon_alert(user, "already airbagged!")
		return FALSE
	return TRUE

/// the airbag item is preparing itself, anchoring itself and then finally deploying the airbag structure
/obj/item/airbag/proc/arm()
	if(armed)
		return
	if(!anchored)
		addtimer(CALLBACK(src, PROC_REF(deploy_anchor)), 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(bang)), detonate_time)
	armed = TRUE
	playsound(src, armed_sound, 50)
	update_appearance()

/// Anchors the airbag to the ground, namely to prevent air movement.
/obj/item/airbag/proc/deploy_anchor()
	if(!isturf(loc) || anchored)
		return
	anchored = TRUE

/// Detonates the airbag, dropping the item, and harming humans who weren't cautious
/obj/item/airbag/proc/bang()
	if(ishuman(loc))
		blow_up_arm(loc)
	else if(isturf(loc))
		for(var/mob/living/mob in loc.contents)
			mob.throw_at(get_edge_target_turf(src, mob.dir), rand(7, 10), 5) // it said 'stand clear'
	var/obj/created_object = new drop_type(get_turf(src))
	playsound(src, bang_sound, 50, pressure_affected = FALSE)
	do_smoke(
		range = 1,
		amount = 1,
		holder = created_object,
		location = get_turf(created_object),
		smoke_type = /obj/effect/particle_effect/fluid/smoke/quick,
		log = FALSE
	)
	qdel(src)

/// dislocate the arm holding the item, and then fling them too. ouch!
/obj/item/airbag/proc/blow_up_arm(mob/living/carbon/human/victim)
	var/datum/wound_pregen_data/pregen_data = GLOB.all_wound_pregen_data[/datum/wound/blunt/bone/moderate]
	var/obj/item/bodypart/arm/limb = victim.get_bodypart(pick(GLOB.arm_zones))
	if(victim.held_items[LEFT_HANDS] == src)
		limb = victim.get_bodypart(BODY_ZONE_L_ARM)
	else if(victim.held_items[RIGHT_HANDS] == src)
		limb = victim.get_bodypart(BODY_ZONE_R_ARM)
	if(pregen_data.can_be_applied_to(limb, random_roll = FALSE) && (limb.biological_state & BIO_JOINTED))
		limb.force_wound_upwards(/datum/wound/blunt/bone/moderate)
	victim.apply_damage(20, BRUTE, limb.body_zone, wound_bonus = 10)
	victim.throw_at(get_edge_target_turf(src, pick(GLOB.cardinals)), rand(7, 10), 5)

/obj/item/airbag/immediate_arm
	immediate_arm = TRUE

/datum/design/airbag
	name = "Airbag"
	desc = "Keep that vacuum of space from sucking!"
	id = "airbag"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | COLONY_FABRICATOR
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/airbag
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/obj/structure/inflatable/window_airbag
	name = "window airbag"
	desc = "A quick deploying airbag that seals holes when a window is broken!"
	icon_state = "airbag_wall"
	torn_type = null // No debris left behind!
	deflated_type = /obj/item/airbag

#undef DISARM_TIME
#undef TRAIT_AIRBAGGED
