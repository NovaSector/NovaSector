/datum/action/cooldown/psionic
	name = "Psionic Ability"
	desc = "Project a psionic discipline."
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED
	button_icon = 'modular_nova/modules/psionics/icons/actions.dmi'
	button_icon_state = "spell_default"
	background_icon_state = "bg_tech_blue"
	active_background_icon_state = "bg_tech_blue_active"
	overlay_icon_state = "bg_tech_blue_border"
	active_overlay_icon_state = "bg_spell_border_active_blue"

	/// Profile point cost when learned through imprinting.
	var/point_cost = 1
	/// Strain gained when this ability is successfully used.
	var/strain_gain = 0
	/// Psionic category flags used by counters.
	var/psionic_flags = PSIONIC_INTRUSIVE
	/// Anomaly resonance school this ability belongs to.
	var/datum/psionic_school/school
	/// If TRUE, higher-rank psions may disrupt nearby technology when using this action.
	/// Disruption strength scales with effective psionic rank and this action's point_cost.
	var/causes_interference = TRUE
	/// If TRUE, this action can be used during burnout.
	var/can_use_during_burnout = FALSE

/datum/action/cooldown/psionic/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!profile)
		if(feedback)
			living_owner.balloon_alert(living_owner, "not awakened!")
		return FALSE

	profile.decay_strain()
	if(!can_use_during_burnout && profile.is_burned_out())
		if(feedback)
			living_owner.balloon_alert(living_owner, "psionic burnout!")
		return FALSE

	if(!living_owner.can_cast_psionics(psionic_flags))
		if(feedback)
			living_owner.balloon_alert(living_owner, "psionics dampened!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!profile)
		return FALSE

	if(!is_valid_target(target))
		return FALSE
	if(!before_psionic(target))
		return FALSE
	if(strain_gain && !profile.try_gain_strain(strain_gain))
		return FALSE
	if(!psionic_activate(target))
		return FALSE

	profile.emit_interference(src)
	StartCooldown()
	return TRUE

/datum/action/cooldown/psionic/proc/is_valid_target(atom/target)
	return TRUE

/datum/action/cooldown/psionic/proc/before_psionic(atom/target)
	return TRUE

/datum/action/cooldown/psionic/proc/psionic_activate(atom/target)
	return TRUE

/datum/action/cooldown/psionic/pointed
	click_to_activate = TRUE

	/// Message shown when the ability is readied.
	var/active_msg
	/// Message shown when the ability is cancelled.
	var/deactive_msg
	/// Maximum range in tiles.
	var/cast_range = 7
	/// If TRUE, clicking a turf targets a living mob on it where possible.
	var/aim_assist = TRUE

/datum/action/cooldown/psionic/pointed/New(Target, original = TRUE)
	. = ..()
	if(!active_msg)
		active_msg = "You focus [src] on a target..."
	if(!deactive_msg)
		deactive_msg = "You let [src] fade."

/datum/action/cooldown/psionic/pointed/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("[active_msg] <b>Left-click a target.</b>"))
	build_all_button_icons()

/datum/action/cooldown/psionic/pointed/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("[deactive_msg]"))
	build_all_button_icons()

/datum/action/cooldown/psionic/pointed/InterceptClickOn(mob/living/clicker, params, atom/target)
	var/atom/aim_assist_target
	if(aim_assist)
		aim_assist_target = aim_assist(clicker, target)
	return ..(clicker, params, aim_assist_target || target)

/datum/action/cooldown/psionic/pointed/proc/aim_assist(mob/living/clicker, atom/target)
	if(!isturf(target))
		return

	return locate(/mob/living/carbon/human) in target || locate(/mob/living) in target

/datum/action/cooldown/psionic/pointed/is_valid_target(atom/target)
	if(target == owner)
		to_chat(owner, span_warning("You cannot focus [src] on yourself."))
		return FALSE
	if(!get_turf(target) || get_dist(get_turf(owner), get_turf(target)) > cast_range)
		owner.balloon_alert(owner, "too far away!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/open_menu
	name = "Psionic Imprinting"
	desc = "Review strain and imprint new psionic disciplines."
	button_icon_state = "spell_default"
	psionic_flags = NONE
	point_cost = 0
	strain_gain = 0
	cooldown_time = 0
	can_use_during_burnout = TRUE
	causes_interference = FALSE

/datum/action/cooldown/psionic/open_menu/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!profile)
		return FALSE

	profile.open_power_menu(living_owner)
	return TRUE
