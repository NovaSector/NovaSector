/// Toggleable ranged spit. Click the action to arm/disarm, middle-click a target to fire.
/datum/action/cooldown/spell/hiveless/spine_spit
	name = "Spine Spit"
	desc = "Arm to launch chitinous spines. While armed, middle-click a target to fire. Costs protein."
	button_icon = 'modular_nova/modules/hiveless/icons/hiveless_actions.dmi'
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	active_overlay_icon_state = "bg_spell_border_active_red"
	button_icon_state = "spine_spit"
	cooldown_time = 0.5 SECONDS
	protein_cost = HIVELESS_COST_SPIT
	/// Maximum range in tiles.
	var/cast_range = 9
	/// Projectile type fired.
	var/obj/projectile/projectile_type = /obj/projectile/hiveless_spine
	/// Whether middle-click will fire. Toggled by clicking the action button.
	var/armed = FALSE

/datum/action/cooldown/spell/hiveless/spine_spit/Grant(mob/grant_to)
	. = ..()
	if(owner)
		RegisterSignal(owner, COMSIG_MOB_MIDDLECLICKON, PROC_REF(on_middle_click))

/datum/action/cooldown/spell/hiveless/spine_spit/Remove(mob/living/remove_from)
	UnregisterSignal(remove_from, COMSIG_MOB_MIDDLECLICKON)
	return ..()

/// Toggles the armed state; when armed, the button border turns red and middle-click fires.
/datum/action/cooldown/spell/hiveless/spine_spit/Trigger(trigger_flags, atom/target)
	if(!owner)
		return FALSE
	armed = !armed
	owner.balloon_alert(owner, armed ? "spines primed" : "spines holstered")
	build_all_button_icons()
	return FALSE

/datum/action/cooldown/spell/hiveless/spine_spit/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return armed

/// Signal handler: fires the spine at whatever was middle-clicked, but only while armed.
/// Availability check is silent here — rapid middle-clicks would otherwise spam the balloon.
/datum/action/cooldown/spell/hiveless/spine_spit/proc/on_middle_click(mob/source, atom/clicked)
	SIGNAL_HANDLER
	if(!armed)
		return
	if(!isliving(source) || source.stat != CONSCIOUS)
		return
	if(clicked == source)
		return
	if(!IsAvailable(feedback = FALSE))
		return COMSIG_MOB_CANCEL_CLICKON
	INVOKE_ASYNC(src, PROC_REF(PreActivate), clicked)
	return COMSIG_MOB_CANCEL_CLICKON

/datum/action/cooldown/spell/hiveless/spine_spit/is_valid_target(atom/cast_on)
	if(cast_on == owner)
		return FALSE
	if(get_dist(get_turf(owner), get_turf(cast_on)) > cast_range)
		owner.balloon_alert(owner, "too far!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/hiveless/spine_spit/cast(atom/cast_on)
	. = ..()
	if(!spend_protein())
		return FALSE
	var/turf/caster_turf = get_turf(owner)
	if(!caster_turf)
		return FALSE
	owner.visible_message(
		span_warning("[owner] recoils and spits out a barbed spine at [cast_on]!"),
		span_notice("We launch a spine from our throat."),
	)
	playsound(owner, 'modular_nova/modules/hiveless/sound/spine_spit.ogg', 55, TRUE)
	var/spit_dir = get_dir(caster_turf, get_turf(cast_on)) || owner.dir
	new /obj/effect/temp_visual/dir_setting/bloodsplatter(caster_turf, spit_dir, "#2d4d2a")
	var/obj/projectile/spine = new projectile_type(caster_turf)
	spine.firer = owner
	spine.fired_from = owner
	spine.def_zone = owner.zone_selected
	spine.aim_projectile(cast_on, owner)
	spine.fire()
	return TRUE
