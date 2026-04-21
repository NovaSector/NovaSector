/// How far a holosynth can stray from their projector pen
#define HOLOSYNTH_RANGE 9

/obj/item/holosynth_pen
	name = "holosynth projector-magnet combo"
	desc = "A complex mechanism that both projects the form of a hologram and manipulates its aerogel canvas. \
	Miraculously, it also doubles as a pen."
	icon = 'modular_nova/modules/holosynth/icons/holosynth_pen.dmi'
	worn_icon = 'modular_nova/modules/holosynth/icons/holosynth_pen.dmi'
	icon_state = "Holopen"
	worn_icon_state = "w_holopen"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_EARS
	w_class = WEIGHT_CLASS_TINY
	/// The ink color used when writing with this pen
	var/colour = BLOOD_COLOR_HOLOGEL
	/// The font used when writing with this pen
	var/font = FOUNTAIN_PEN_FONT
	damtype = BURN
	force = 5
	/// Weakref to the Mob this pen leashes and contains
	var/datum/weakref/linked_mob_ref
	/// Weakref to the tile this pen saves to deploy the mob to and from
	var/datum/weakref/saved_loc_ref

/obj/item/holosynth_pen/Initialize(mapload, mob/living/carbon/human/linked_mob)
	. = ..()
	AddElement(/datum/element/tool_renaming)
	AddComponent(/datum/component/gps/item, "HOLOSIGNAL", state = GLOB.deep_inventory_state, overlay_state = FALSE)

	if(linked_mob)
		linked_mob_ref = WEAKREF(linked_mob)
		saved_loc_ref = WEAKREF(get_turf(linked_mob))

		create_transform_component()
		RegisterSignal(src, COMSIG_TRANSFORMING_PRE_TRANSFORM, PROC_REF(transform_check))
		RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
		RegisterSignal(linked_mob, COMSIG_LIVING_DEATH, PROC_REF(user_death))
		RegisterSignal(linked_mob, COMSIG_QDELETING, PROC_REF(user_qdeleted))

		linked_mob.AddComponent(\
			/datum/component/leash,\
			owner = src,\
			distance = HOLOSYNTH_RANGE,\
			force_teleport_out_effect = /obj/effect/temp_visual/guardian/phase/out,\
			force_teleport_in_effect = /obj/effect/temp_visual/guardian/phase,\
		)
		var/col_pref = linked_mob.client?.prefs?.read_preference(/datum/preference/color/mutant/holosynth_color)
		var/ray_color = col_pref || linked_mob.dna?.features["holo_color"] || rgb(125, 180, 225)
		AddComponent(/datum/component/holoray_trail, linked_mob, ray_color)
	else
		linked_mob_ref = null

	AddComponent(\
		/datum/component/aura_healing,\
		range = 1,\
		brute_heal = 1,\
		burn_heal = 1.5,\
		simple_heal = 1.2,\
		wound_clotting = 0.1,\
		organ_healing = list(ORGAN_SLOT_BRAIN = 1, ORGAN_SLOT_HEART = 0.5, ORGAN_SLOT_EARS = 1, ORGAN_SLOT_EYES = 1, ORGAN_SLOT_TONGUE = 1.5),\
		requires_visibility = FALSE,\
		limit_to_trait = TRAIT_HOLOSYNTH,\
		healing_color = BLOOD_COLOR_HOLOGEL,\
	)

/obj/item/holosynth_pen/proc/create_transform_component()
	AddComponent(\
		/datum/component/transforming,\
		start_transformed = FALSE,\
		force_on = 14,\
		inhand_icon_change = FALSE,\
		w_class_on = w_class,\
	)

/obj/item/holosynth_pen/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(user)
		balloon_alert(user, "clicked")
	playsound(src, 'sound/items/pen_click.ogg', 30, TRUE, -3)
	icon_state = initial(icon_state) + (active ? "_writing" : "")
	worn_icon_state = initial(worn_icon_state) + (active ? "_writing" : "")
	update_appearance(UPDATE_ICON)

	var/mob/living/carbon/human/linked_mob = linked_mob_ref?.resolve()
	var/turf/saved_loc = saved_loc_ref?.resolve()
	if(QDELETED(saved_loc))
		saved_loc_ref = null

	if(isnull(linked_mob))
		return COMPONENT_NO_DEFAULT_MESSAGE

	if(active)
		saved_loc_ref = WEAKREF(get_turf(linked_mob))
		new /obj/effect/temp_visual/guardian/phase/out(get_turf(linked_mob))
		linked_mob.unequip_everything()
		linked_mob.forceMove(src)
	else
		if(get_dist(linked_mob, src) <= HOLOSYNTH_RANGE)
			linked_mob.forceMove(saved_loc || get_turf(src))
			linked_mob.heal_and_revive()
			new /obj/effect/temp_visual/guardian/phase(get_turf(linked_mob))
		else
			balloon_alert(user, "too far!")
			saved_loc_ref = WEAKREF(get_turf(linked_mob))

	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/holosynth_pen/proc/user_death()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/linked_mob = linked_mob_ref?.resolve()
	if(QDELETED(linked_mob))
		return
	saved_loc_ref = WEAKREF(get_turf(linked_mob))
	new /obj/effect/temp_visual/guardian/phase/out(get_turf(linked_mob))
	linked_mob.unequip_everything()
	linked_mob.forceMove(src)

/// The linked mob is being deleted (cryopod, admin vv, etc.) — the pen has no reason to persist.
/obj/item/holosynth_pen/proc/user_qdeleted(mob/living/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	linked_mob_ref = null
	qdel(src)

/obj/item/holosynth_pen/Destroy()
	var/mob/living/carbon/human/linked_mob = linked_mob_ref?.resolve()

	if(linked_mob && !QDELETED(linked_mob))
		UnregisterSignal(linked_mob, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
		linked_mob.apply_status_effect(/datum/status_effect/holosynth_dissolving)
		linked_mob.visible_message(
			span_danger("[linked_mob]'s whole body begins to fade away!"),
			span_userdanger("You feel your projector being destroyed! You start to fade away!"),
		)
	return ..()

/obj/item/holosynth_pen/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return try_set_saved_loc(interacting_with, user)

/obj/item/holosynth_pen/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isturf(interacting_with))
		return NONE
	return try_set_saved_loc(interacting_with, user)

/// Validates targeting conditions and pins the pen's saved location to the target's turf.
/obj/item/holosynth_pen/proc/try_set_saved_loc(atom/target, mob/living/user)
	var/mob/living/carbon/human/linked_mob = linked_mob_ref?.resolve()
	if(isnull(linked_mob) || user == linked_mob)
		return ITEM_INTERACT_FAILURE
	if(linked_mob.loc != src)
		balloon_alert(user, "holosynth is active!")
		return ITEM_INTERACT_FAILURE
	if(target.density)
		balloon_alert(user, "solid object!")
		return ITEM_INTERACT_FAILURE
	saved_loc_ref = WEAKREF(get_turf(target))
	balloon_alert(user, "location targeted")
	playsound(src, 'sound/items/pen_click.ogg', 30, TRUE, -3)
	return ITEM_INTERACT_SUCCESS

/obj/item/holosynth_pen/examine()
	. = ..()
	var/mob/living/carbon/human/linked_mob = linked_mob_ref?.resolve()

	if(linked_mob)
		. += span_info("This one belongs to [linked_mob].")

/obj/item/holosynth_pen/get_writing_implement_details()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return list(
			interaction_mode = MODE_WRITING,
			font = font,
			color = colour,
			use_bold = FALSE,
		)
	return null

/obj/item/holosynth_pen/proc/transform_check(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/linked_mob = linked_mob_ref?.resolve()

	if(user == linked_mob)
		balloon_alert(user, "can't modify yourself!")
		return COMPONENT_BLOCK_TRANSFORM

// The death effect
/atom/movable/screen/alert/status_effect/holosynth_death_alert
	name = "Projector Destroyed"
	desc = "YOUR BODY IS FADING AWAY!!"
	icon_state = "convulsing"

/datum/status_effect/holosynth_dissolving
	id = "holo_dissolve"
	remove_on_fullheal = FALSE
	duration = 5 SECONDS
	show_duration = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/holosynth_death_alert

/datum/status_effect/holosynth_dissolving/on_creation(mob/living/new_owner, ...)
	. = ..()
	animate(owner, alpha = 0, time = duration, flags = ANIMATION_PARALLEL)

/datum/status_effect/holosynth_dissolving/tick()
	if(QDELETED(owner))
		return
	apply_wibbly_filters(owner)
	remove_wibbly_filters(owner, 0.1 SECONDS)

/datum/status_effect/holosynth_dissolving/on_remove()
	if(QDELETED(owner))
		return
	owner.gib(DROP_BRAIN & DROP_ITEMS)

#undef HOLOSYNTH_RANGE
