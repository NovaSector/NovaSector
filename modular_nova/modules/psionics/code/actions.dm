/datum/psionic_rank_variant
	/// Rank required to unlock this selectable form.
	var/rank = PSIONIC_DEFAULT_RANK
	/// Player-facing form name.
	var/variant_name
	/// Optional player-facing description. If unset, the form name is used.
	var/description
	/// Strain gained when this form is used. If unset, the action's normal strain is used.
	var/strain_gain
	/// Strain gained each second while this form is maintained. If unset, the action's normal active strain is used.
	var/active_strain_gain_per_second
	/// Cooldown applied when this form is used. If unset, the action's normal cooldown is used.
	var/cooldown_time
	/// Range used by pointed actions. If unset, the action's normal range is used.
	var/cast_range
	/// Readied message used by pointed actions. If unset, the action's normal message is used.
	var/active_msg
	/// Cancel message used by pointed actions. If unset, the action's normal message is used.
	var/deactive_msg

/datum/psionic_rank_variant/proc/get_name(datum/action/cooldown/psionic/action)
	return variant_name || rank

/datum/psionic_rank_variant/proc/get_strain_gain(datum/action/cooldown/psionic/action)
	if(!isnull(strain_gain))
		return strain_gain

	return action.strain_gain

/datum/psionic_rank_variant/proc/get_active_strain_gain_per_second(datum/action/cooldown/psionic/action)
	if(!isnull(active_strain_gain_per_second))
		return active_strain_gain_per_second

	return action.active_strain_gain_per_second

/datum/psionic_rank_variant/proc/get_cooldown_time(datum/action/cooldown/psionic/action)
	if(!isnull(cooldown_time))
		return cooldown_time

	return action.cooldown_time

/datum/psionic_rank_variant/proc/get_cast_range(datum/action/cooldown/psionic/pointed/action)
	if(!isnull(cast_range))
		return cast_range

	return action.cast_range

/datum/psionic_rank_variant/proc/get_active_msg(datum/action/cooldown/psionic/pointed/action)
	return active_msg || action.active_msg

/datum/psionic_rank_variant/proc/get_deactive_msg(datum/action/cooldown/psionic/pointed/action)
	return deactive_msg || action.deactive_msg

/datum/psionic_rank_variant/proc/get_description(datum/action/cooldown/psionic/action)
	var/form_description = description || get_name(action)
	var/strain_description = "[get_strain_gain(action)] strain"
	var/active_strain_gain = get_active_strain_gain_per_second(action)
	if(active_strain_gain > 0)
		strain_description += ", [active_strain_gain] strain/s"
	return "[form_description] ([strain_description], [get_cooldown_time(action) / 10]s cooldown)"

/datum/action/cooldown/psionic
	name = "Psionic Ability"
	desc = "Project a psionic discipline."
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED
	button_icon = 'modular_nova/modules/psionics/icons/actions.dmi'
	button_icon_state = "psi_imprint"
	background_icon_state = "bg_tech_blue"
	active_background_icon_state = "bg_tech_blue_active"
	overlay_icon_state = "bg_tech_blue_border"
	active_overlay_icon_state = "bg_spell_border_active_blue"

	/// Profile point cost when learned through imprinting.
	var/point_cost = 1
	/// Strain gained when this ability is successfully used.
	var/strain_gain = 0
	/// Strain gained each second while this ability is maintained.
	var/active_strain_gain_per_second = 0
	/// Psionic category flags used by counters.
	var/psionic_flags = PSIONIC_INTRUSIVE
	/// Anomaly resonance school this ability belongs to.
	var/datum/psionic_school/school
	/// If TRUE, this action can be used during burnout.
	var/can_use_during_burnout = FALSE
	/// If TRUE, this action requires usable hands.
	var/needs_hands = FALSE
	/// If TRUE, this action requires the psion to stand still and avoid severe pain while active.
	var/requires_concentration = FALSE
	/// Turf the psion must remain on while concentrating.
	var/turf/concentration_turf
	/// Ordered psionic rank variant datum types this action can use.
	var/list/rank_variant_types
	/// Cached rank variant datums.
	var/list/rank_variants

/datum/action/cooldown/psionic/Destroy()
	for(var/datum/psionic_rank_variant/variant as anything in rank_variants)
		qdel(variant)
	rank_variants = null
	return ..()

/datum/action/cooldown/psionic/Remove(mob/remove_from)
	stop_concentration(remove_from)
	return ..()

/datum/action/cooldown/psionic/Trigger(mob/clicker, trigger_flags, atom/target)
	if((trigger_flags & TRIGGER_SECONDARY_ACTION) && length(get_rank_variants()))
		var/mob/living/living_owner = owner
		if(istype(living_owner))
			return cycle_rank_variant(living_owner)

	return ..()

/datum/action/cooldown/psionic/update_button_name(atom/movable/screen/movable/action_button/button, force = FALSE)
	. = ..()
	if(!length(get_rank_variants()))
		return

	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(!variant)
		return

	button.name = "[name] ([get_rank_variant_name(variant)])"
	if(desc)
		button.desc = "[desc]<br><b>Selected:</b> [get_rank_variant_description(variant)]."
		if(length(get_unlocked_rank_variants(profile)) > 1)
			button.desc += "<br><b>Right-click</b> to cycle unlocked forms."

/datum/action/cooldown/psionic/proc/get_rank_variants()
	if(rank_variants)
		return rank_variants

	rank_variants = list()
	for(var/variant_type in rank_variant_types)
		if(!ispath(variant_type, /datum/psionic_rank_variant))
			continue

		var/datum/psionic_rank_variant/variant = new variant_type
		rank_variants += variant

	return rank_variants

/datum/action/cooldown/psionic/proc/get_rank_variant(variant_rank)
	for(var/datum/psionic_rank_variant/variant as anything in get_rank_variants())
		if(variant.rank == variant_rank)
			return variant

	return null

/datum/action/cooldown/psionic/proc/get_unlocked_rank_variants(datum/component/psionic_profile/profile)
	var/list/unlocked_variants = list()
	if(!profile)
		return unlocked_variants

	var/profile_rank_level = get_psionic_rank_level(profile.psionic_rank)
	for(var/datum/psionic_rank_variant/variant as anything in get_rank_variants())
		if(profile_rank_level >= get_psionic_rank_level(variant.rank))
			unlocked_variants += variant

	return unlocked_variants

/datum/action/cooldown/psionic/proc/get_selected_rank_variant(datum/component/psionic_profile/profile)
	var/list/unlocked_variants = get_unlocked_rank_variants(profile)
	if(!length(unlocked_variants))
		return null

	var/stored_variant_rank = profile.get_power_rank_variant(type)
	var/datum/psionic_rank_variant/stored_variant = get_rank_variant(stored_variant_rank)
	if(stored_variant && (stored_variant in unlocked_variants))
		return stored_variant

	return unlocked_variants[length(unlocked_variants)]

/datum/action/cooldown/psionic/proc/cycle_rank_variant(mob/living/living_owner)
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	var/list/unlocked_variants = get_unlocked_rank_variants(profile)
	if(!length(unlocked_variants))
		return FALSE
	if(length(unlocked_variants) == 1)
		living_owner.balloon_alert(living_owner, "only one form!")
		return TRUE

	var/datum/psionic_rank_variant/current_variant = get_selected_rank_variant(profile)
	var/current_index = unlocked_variants.Find(current_variant)
	if(!current_index)
		current_index = length(unlocked_variants)
	var/datum/psionic_rank_variant/new_variant = unlocked_variants[(current_index % length(unlocked_variants)) + 1]
	profile.set_power_rank_variant(type, new_variant.rank)
	on_rank_variant_selected(living_owner, new_variant)
	build_all_button_icons(UPDATE_BUTTON_NAME)
	return TRUE

/datum/action/cooldown/psionic/proc/get_rank_variant_name(datum/psionic_rank_variant/variant)
	return variant?.get_name(src)

/datum/action/cooldown/psionic/proc/get_rank_variant_description(datum/psionic_rank_variant/variant)
	return variant?.get_description(src)

/datum/action/cooldown/psionic/proc/on_rank_variant_selected(mob/living/living_owner, datum/psionic_rank_variant/variant)
	living_owner.balloon_alert(living_owner, "[LOWER_TEXT(get_rank_variant_name(variant))] selected")
	to_chat(living_owner, span_notice("[name] will manifest as [get_rank_variant_description(variant)]."))

/datum/action/cooldown/psionic/proc/get_psionic_strain_gain(datum/component/psionic_profile/profile)
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(variant)
		return variant.get_strain_gain(src)

	return strain_gain

/datum/action/cooldown/psionic/proc/get_psionic_active_strain_gain_per_second(datum/component/psionic_profile/profile)
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(variant)
		return variant.get_active_strain_gain_per_second(src)

	return active_strain_gain_per_second

/datum/action/cooldown/psionic/proc/try_gain_active_strain(datum/component/psionic_profile/profile, seconds_per_tick)
	if(!profile)
		return FALSE

	var/active_strain_gain = get_psionic_active_strain_gain_per_second(profile)
	if(active_strain_gain <= 0 || seconds_per_tick <= 0)
		return TRUE

	var/strain_to_gain = round(active_strain_gain * seconds_per_tick)
	if(strain_to_gain <= 0)
		return TRUE

	return profile.try_gain_strain(strain_to_gain, src)

/datum/action/cooldown/psionic/proc/get_psionic_cooldown_time(datum/component/psionic_profile/profile)
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(variant)
		return variant.get_cooldown_time(src)

	return cooldown_time

/datum/action/cooldown/psionic/proc/can_use_hands(mob/living/living_owner, feedback = FALSE)
	if(!needs_hands)
		return TRUE
	if(!HAS_TRAIT(living_owner, TRAIT_HANDS_BLOCKED))
		return TRUE
	if(feedback)
		living_owner.balloon_alert(living_owner, "hands blocked!")
	return FALSE

/datum/action/cooldown/psionic/proc/can_concentrate(mob/living/living_owner, datum/component/psionic_profile/profile, feedback = FALSE)
	if(!requires_concentration)
		return TRUE
	if(action_disabled || !istype(living_owner) || !profile)
		return FALSE
	if(living_owner.stat != CONSCIOUS)
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_INCAPACITATED))
		return FALSE
	if(!isturf(living_owner.loc))
		return FALSE
	if(living_owner.body_position != STANDING_UP)
		if(feedback)
			living_owner.balloon_alert(living_owner, "stand up!")
		return FALSE
	if(profile.is_burned_out())
		return FALSE
	if(concentration_turf && get_turf(living_owner) != concentration_turf)
		if(feedback)
			living_owner.balloon_alert(living_owner, "stand still!")
		return FALSE
	if(is_concentration_painful(living_owner))
		if(feedback)
			living_owner.balloon_alert(living_owner, "pain breaks focus!")
		return FALSE
	if(!living_owner.can_cast_psionics(psionic_flags))
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/proc/start_concentration(mob/living/living_owner, datum/component/psionic_profile/profile, feedback = FALSE)
	if(!requires_concentration)
		return TRUE
	if(!can_concentrate(living_owner, profile, feedback))
		return FALSE

	concentration_turf = get_turf(living_owner)
	RegisterSignal(living_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_concentration_moved))
	RegisterSignal(living_owner, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(on_concentration_health_update))
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_concentration_life))
	return TRUE

/datum/action/cooldown/psionic/proc/stop_concentration(mob/living/living_owner)
	if(!requires_concentration)
		return

	if(istype(living_owner))
		UnregisterSignal(living_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_concentration_moved))
		UnregisterSignal(living_owner, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(on_concentration_health_update))
		UnregisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_concentration_life))
	concentration_turf = null

/datum/action/cooldown/psionic/proc/is_concentration_painful(mob/living/living_owner)
	if(!istype(living_owner))
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_ANALGESIA))
		return FALSE

	var/brute_loss = living_owner.get_brute_loss()
	var/burn_loss = living_owner.get_fire_loss()
	if(brute_loss > PSIONIC_CONCENTRATION_PAIN_THRESHOLD)
		return TRUE

	return burn_loss > PSIONIC_CONCENTRATION_PAIN_THRESHOLD

/datum/action/cooldown/psionic/proc/on_concentration_moved(datum/source)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	if(!istype(living_owner))
		living_owner = owner
	if(istype(living_owner))
		living_owner.balloon_alert(living_owner, "focus broken!")
	on_concentration_broken(living_owner)

/datum/action/cooldown/psionic/proc/on_concentration_health_update(datum/source)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	if(!is_concentration_painful(living_owner))
		return

	living_owner.balloon_alert(living_owner, "pain breaks focus!")
	on_concentration_broken(living_owner)

/datum/action/cooldown/psionic/proc/on_concentration_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	if(!istype(living_owner))
		living_owner = owner
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(can_concentrate(living_owner, profile))
		return

	on_concentration_broken(living_owner)

/datum/action/cooldown/psionic/proc/on_concentration_broken(mob/living/living_owner)
	stop_concentration(living_owner)
	return FALSE

/datum/action/cooldown/psionic/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE
	if(ismecha(living_owner.loc))
		if(feedback)
			living_owner.balloon_alert(living_owner, "inside mech!")
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

	if(length(get_rank_variants()) && !length(get_unlocked_rank_variants(profile)))
		if(feedback)
			living_owner.balloon_alert(living_owner, "rank too low!")
		return FALSE

	if(!can_use_hands(living_owner, feedback))
		return FALSE

	if(!living_owner.can_cast_psionics(psionic_flags))
		if(feedback)
			living_owner.balloon_alert(living_owner, "psionics dampened!")
		return FALSE
	if(!can_concentrate(living_owner, profile, feedback))
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
	if(!IsAvailable(feedback = TRUE))
		return FALSE
	if(!is_valid_target(target))
		return FALSE
	var/activation_strain_gain = get_psionic_strain_gain(profile)
	if(activation_strain_gain && !profile.try_gain_strain(activation_strain_gain, src))
		return FALSE
	if(!start_concentration(living_owner, profile, TRUE))
		return FALSE
	if(!psionic_activate(target))
		stop_concentration(living_owner)
		return FALSE

	StartCooldown(get_psionic_cooldown_time(profile))
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

/datum/action/cooldown/psionic/pointed/New(Target, original = TRUE)
	. = ..()
	if(!active_msg)
		active_msg = "You focus [src] on a target..."
	if(!deactive_msg)
		deactive_msg = "You let [src] fade."

/datum/action/cooldown/psionic/pointed/set_click_ability(mob/on_who)
	if(!IsAvailable(feedback = TRUE))
		return FALSE

	. = ..()
	if(!.)
		return

	var/datum/component/psionic_profile/profile
	var/mob/living/living_owner = on_who
	if(istype(living_owner))
		profile = living_owner.get_psionic_profile()
	to_chat(on_who, span_notice("[get_psionic_active_msg(profile)] <b>Left-click a target.</b>"))
	build_all_button_icons()

/datum/action/cooldown/psionic/pointed/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		var/datum/component/psionic_profile/profile
		var/mob/living/living_owner = on_who
		if(istype(living_owner))
			profile = living_owner.get_psionic_profile()
		to_chat(on_who, span_notice("[get_psionic_deactive_msg(profile)]"))
	build_all_button_icons()

/datum/action/cooldown/psionic/pointed/InterceptClickOn(mob/living/clicker, params, atom/target)
	var/was_unset_after_click = unset_after_click
	if(unset_after_click)
		unset_after_click = should_unset_after_psionic_click(clicker)
	. = ..(clicker, params, target)
	unset_after_click = was_unset_after_click

/datum/action/cooldown/psionic/pointed/proc/should_unset_after_psionic_click(mob/living/clicker)
	if(!istype(clicker))
		return TRUE

	var/datum/component/psionic_profile/profile = clicker.get_psionic_profile()
	return !profile || get_psionic_cooldown_time(profile) > 0

/datum/action/cooldown/psionic/pointed/is_valid_target(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	if(target == living_owner)
		to_chat(living_owner, span_warning("You cannot focus [src] on yourself."))
		return FALSE
	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!get_turf(target) || get_dist(get_turf(living_owner), get_turf(target)) > get_psionic_cast_range(profile))
		living_owner.balloon_alert(living_owner, "too far away!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/proc/get_psionic_cast_range(datum/component/psionic_profile/profile)
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(variant)
		return variant.get_cast_range(src)

	return cast_range

/datum/action/cooldown/psionic/pointed/proc/get_psionic_active_msg(datum/component/psionic_profile/profile)
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(variant)
		return variant.get_active_msg(src)

	return active_msg

/datum/action/cooldown/psionic/pointed/proc/get_psionic_deactive_msg(datum/component/psionic_profile/profile)
	var/datum/psionic_rank_variant/variant = get_selected_rank_variant(profile)
	if(variant)
		return variant.get_deactive_msg(src)

	return deactive_msg

/datum/action/cooldown/psionic/pointed/living_target
	/// If TRUE, dead living mobs can be targeted.
	var/allow_dead_targets = FALSE
	/// Balloon alert shown when the clicked target is not living.
	var/no_living_target_alert = "no living target!"
	/// Balloon alert shown when the clicked target is dead.
	var/dead_target_alert = "no living mind!"

/datum/action/cooldown/psionic/pointed/living_target/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(target))
		owner.balloon_alert(owner, no_living_target_alert)
		return FALSE

	var/mob/living/living_target = target
	if(!allow_dead_targets && living_target.stat == DEAD)
		owner.balloon_alert(owner, dead_target_alert)
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/projectile
	/// Projectile type launched by this psionic discipline.
	var/obj/projectile/projectile_type
	/// Optional hand item shown while this projectile discipline is readied.
	var/obj/item/projectile_hand_visual_type
	/// Hand item instance currently shown while this projectile discipline is readied.
	var/obj/item/projectile_hand_visual
	/// TRUE while the hand visual is being intentionally removed.
	var/removing_projectile_hand_visual = FALSE
	/// Number of projectiles released by one activation.
	var/projectiles_per_fire = 1
	/// Degrees between projectiles in a multi-projectile spread.
	var/projectile_spread = 0
	/// Sound played once when projectiles are launched.
	var/projectile_sound

/datum/action/cooldown/psionic/pointed/projectile/Remove(mob/living/remove_from)
	remove_projectile_hand_visual(remove_from)
	return ..()

/datum/action/cooldown/psionic/pointed/projectile/set_click_ability(mob/on_who)
	if(!IsAvailable(feedback = TRUE))
		return FALSE

	if(projectile_hand_visual_type && !create_projectile_hand_visual(on_who))
		return FALSE

	. = ..()
	if(!.)
		remove_projectile_hand_visual(on_who)

/datum/action/cooldown/psionic/pointed/projectile/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	remove_projectile_hand_visual(on_who)

/datum/action/cooldown/psionic/pointed/projectile/psionic_activate(atom/target)
	if(!projectile_type)
		return FALSE
	if(!isturf(owner.loc))
		return FALSE

	if(projectile_sound)
		playsound(get_turf(owner), projectile_sound, 65, TRUE)

	var/fired_projectile = FALSE
	for(var/i in 1 to projectiles_per_fire)
		var/obj/projectile/to_fire = new projectile_type()
		if(!ready_projectile(to_fire, target, owner, i))
			qdel(to_fire)
			continue

		to_fire.fire()
		fired_projectile = TRUE

	return fired_projectile

/datum/action/cooldown/psionic/pointed/projectile/proc/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	to_fire.firer = user
	to_fire.fired_from = src

	var/deviation = 0
	if(projectile_spread && projectiles_per_fire > 1)
		deviation = (iteration - ((projectiles_per_fire + 1) / 2)) * projectile_spread

	return to_fire.aim_projectile(target, user, null, deviation)

/datum/action/cooldown/psionic/pointed/projectile/proc/create_projectile_hand_visual(mob/on_who)
	if(projectile_hand_visual && !QDELETED(projectile_hand_visual))
		if(projectile_hand_visual.loc == on_who)
			return TRUE
		remove_projectile_hand_visual(on_who)

	var/obj/item/new_hand_visual = new projectile_hand_visual_type(on_who)
	if(!on_who.put_in_hands(new_hand_visual, del_on_fail = TRUE))
		on_who.balloon_alert(on_who, "free a hand!")
		to_chat(on_who, span_warning("You need a free hand to focus [src]."))
		return FALSE

	projectile_hand_visual = new_hand_visual
	RegisterSignal(projectile_hand_visual, COMSIG_QDELETING, PROC_REF(on_projectile_hand_visual_deleted))
	RegisterSignal(projectile_hand_visual, COMSIG_ITEM_DROPPED, PROC_REF(on_projectile_hand_visual_dropped))
	return TRUE

/datum/action/cooldown/psionic/pointed/projectile/proc/remove_projectile_hand_visual(mob/hand_owner)
	if(!projectile_hand_visual || QDELETED(projectile_hand_visual))
		projectile_hand_visual = null
		return

	removing_projectile_hand_visual = TRUE
	UnregisterSignal(projectile_hand_visual, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED))
	hand_owner?.temporarilyRemoveItemFromInventory(projectile_hand_visual, force = TRUE)
	QDEL_NULL(projectile_hand_visual)
	removing_projectile_hand_visual = FALSE

/datum/action/cooldown/psionic/pointed/projectile/proc/on_projectile_hand_visual_deleted(datum/source)
	SIGNAL_HANDLER

	projectile_hand_visual = null
	if(removing_projectile_hand_visual || QDELETED(owner))
		return
	if(owner.click_intercept == src)
		unset_click_ability(owner, refund_cooldown = TRUE)

/datum/action/cooldown/psionic/pointed/projectile/proc/on_projectile_hand_visual_dropped(datum/source, mob/living/dropper)
	SIGNAL_HANDLER

	projectile_hand_visual = null
	if(removing_projectile_hand_visual || QDELETED(owner))
		return
	if(owner.click_intercept == src)
		unset_click_ability(owner, refund_cooldown = TRUE)

/datum/action/cooldown/psionic/open_menu
	name = "Psionic Imprinting"
	desc = "Review strain and imprint new psionic disciplines."
	button_icon_state = "psi_imprint"
	psionic_flags = NONE
	point_cost = 0
	strain_gain = 0
	cooldown_time = 0
	can_use_during_burnout = TRUE

/datum/action/cooldown/psionic/open_menu/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!profile)
		return FALSE

	profile.open_power_menu(living_owner)
	return TRUE
