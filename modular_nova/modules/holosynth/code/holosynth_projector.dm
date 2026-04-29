/// How far a holosynth can stray from their projector pen
#define HOLOSYNTH_RANGE 9
/// Tiles around the pen within which its aura heals.
#define HOLOSYNTH_AURA_RANGE 1
/// Intensity (deciseconds) the pen aura subtracts from electrical-damage wounds per real second.
/// Must outpace the wound's own progression (~10 ds/sec) to actually heal.
#define HOLOSYNTH_WOUND_HEAL_RATE_DS 12
/// Seconds of in-range pen exposure needed to dissolve a non-intensity synth wound
#define HOLOSYNTH_WOUND_RESOLVE_SECONDS 15

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
	AddElement(/datum/element/strippable/holosynth_pen, GLOB.strippable_human_items, TYPE_PROC_REF(/mob/living/carbon/human/, should_strip))
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
		/datum/component/aura_healing/holosynth,\
		range = HOLOSYNTH_AURA_RANGE,\
		brute_heal = 1,\
		burn_heal = 1.5,\
		simple_heal = 1.2,\
		wound_clotting = 0.1,\
		wound_intensity_heal = HOLOSYNTH_WOUND_HEAL_RATE_DS,\
		wound_resolve_seconds = HOLOSYNTH_WOUND_RESOLVE_SECONDS,\
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
		holosynth_drop_unkept_items(linked_mob)
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
	var/turf/death_turf = get_turf(linked_mob)
	saved_loc_ref = WEAKREF(death_turf)
	new /obj/effect/temp_visual/guardian/phase/out(death_turf)
	holosynth_drop_unkept_items(linked_mob)
	// Drop the pen on its own turf — wherever it currently is — so a pen carried by another player
	// stays with them rather than teleporting to where the mob died.
	var/turf/pen_turf = get_turf(src)
	if(pen_turf)
		forceMove(pen_turf)
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

/// aura_healing subclass that also resolves holosynth-style wounds on candidates in range.
/// Inherits all the base healing knobs (brute/burn/organs/etc.) and adds two synth-wound knobs:
/// * wound_intensity_heal — deciseconds of electrical-damage intensity drained per second.
/// * wound_resolve_seconds — seconds of exposure needed to dissolve a non-intensity synth wound (muscle/burn/blunt).
/datum/component/aura_healing/holosynth
	var/wound_intensity_heal = 0
	var/wound_resolve_seconds = 0

/datum/component/aura_healing/holosynth/Initialize(
	range = 5,
	requires_visibility = TRUE,
	brute_heal = 0,
	burn_heal = 0,
	toxin_heal = 0,
	suffocation_heal = 0,
	stamina_heal = 0,
	blood_heal = 0,
	wound_clotting = 0,
	organ_healing = null,
	simple_heal = 0,
	limit_to_trait = null,
	healing_color = COLOR_GREEN,
	self_heal = TRUE,
	wound_intensity_heal = 0,
	wound_resolve_seconds = 0,
)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	src.wound_intensity_heal = wound_intensity_heal
	src.wound_resolve_seconds = wound_resolve_seconds

/datum/component/aura_healing/holosynth/process(seconds_per_tick)
	. = ..()

	var/list/candidates = requires_visibility ? view(range, parent) : range(range, parent)
	for(var/mob/living/carbon/candidate in candidates)
		if(limit_to_trait && !HAS_TRAIT(candidate, limit_to_trait))
			continue
		for(var/datum/wound/iter_wound as anything in candidate.all_wounds)
			if(GLOB.holosynth_wound_flavor[iter_wound.type])
				iter_wound.holo_aura_tick(seconds_per_tick, wound_intensity_heal, wound_resolve_seconds)

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
		if(linked_mob.loc == src)
			. += span_notice("<b>Ctrl+Shift click</b> to strip-search [linked_mob].")

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
	// Qdel to preven runtime from remove_wibbly_filters in holographic_nature
	var/datum/component/nature = owner.GetComponent(/datum/component/holographic_nature)
	if(nature)
		qdel(nature)

/datum/status_effect/holosynth_dissolving/tick()
	if(QDELETED(owner))
		return
	apply_wibbly_filters(owner)
	remove_wibbly_filters(owner, 0.1 SECONDS)

/datum/status_effect/holosynth_dissolving/on_remove()
	if(QDELETED(owner))
		return
	owner.gib(DROP_BRAIN & DROP_ITEMS)

/// Ctrl+Shift clicking the pen opens the strip menu of the mob sealed inside
/datum/element/strippable/holosynth_pen

/datum/element/strippable/holosynth_pen/Attach(datum/target, list/items, should_strip_proc_path)
	. = ..()
	if(. == ELEMENT_INCOMPATIBLE)
		return
	RegisterSignal(target, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(on_ctrl_shift_click))

/datum/element/strippable/holosynth_pen/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_CLICK_CTRL_SHIFT)

/datum/element/strippable/holosynth_pen/proc/on_ctrl_shift_click(datum/source, mob/user)
	SIGNAL_HANDLER
	var/obj/item/holosynth_pen/pen = source
	if(!istype(pen))
		return
	var/mob/living/carbon/human/linked_mob = pen.linked_mob_ref?.resolve()
	if(QDELETED(linked_mob) || linked_mob == user)
		return
	if(linked_mob.loc != pen) // if the mob is out, normal stripping applies to them directly
		return
	if(!isnull(should_strip_proc_path) && !call(linked_mob, should_strip_proc_path)(user))
		return
	pen.balloon_alert_to_viewers("stripping")
	user.visible_message(span_warning("[user] begins to dump the contents of [pen]!"))
	INVOKE_ASYNC(src, PROC_REF(open_strip_menu), linked_mob, user)

/datum/element/strippable/holosynth_pen/proc/open_strip_menu(mob/living/carbon/human/linked_mob, mob/user)
	var/datum/strip_menu/holosynth_pen/strip_menu = LAZYACCESS(strip_menus, linked_mob)
	if(isnull(strip_menu))
		strip_menu = new(linked_mob, src)
		LAZYSET(strip_menus, linked_mob, strip_menu)
	strip_menu.ui_interact(user)

/// Strip menu rooted at the pen's location — the owner mob sits inside the pen (its loc is the
/// pen itself), so the adjacency / visibility checks wouldn't pass against the mob directly.
/datum/strip_menu/holosynth_pen

/datum/strip_menu/holosynth_pen/ui_status(mob/user, datum/ui_state/state)
	var/obj/item/holosynth_pen/pen = owner.loc
	if(!istype(pen))
		return UI_CLOSE
	return min(
		ui_status_only_living(user, pen),
		ui_status_user_has_free_hands(user, pen),
		ui_status_user_is_adjacent(user, pen, allow_tk = FALSE),
		HAS_TRAIT(user, TRAIT_CAN_STRIP) ? UI_INTERACTIVE : UI_UPDATE,
		max(
			ui_status_user_is_conscious_and_lying_down(user),
			ui_status_user_is_abled(user, pen),
		),
	)

#undef HOLOSYNTH_RANGE
#undef HOLOSYNTH_AURA_RANGE
#undef HOLOSYNTH_WOUND_HEAL_RATE_DS
#undef HOLOSYNTH_WOUND_RESOLVE_SECONDS
