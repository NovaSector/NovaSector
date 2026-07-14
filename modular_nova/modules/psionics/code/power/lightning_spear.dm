/datum/psionic_power/lightning_spear
	required_school_points = 3
	required_powers = list(/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt)
	action_type = /datum/action/cooldown/psionic/pointed/projectile/lightning_spear

/datum/psionic_rank_variant/lightning_spear
	rank = PSIONIC_RANK_ALPHA
	variant_name = "lightning spear"
	description = "A charged spear of psionic lightning that violently shocks the target."
	strain_gain = 45
	cooldown_time = 12 SECONDS
	cast_range = 10
	block_charge_cost = 3
	block_message = "lightning grounded!"
	/// Time spent gathering electrical pressure before launching the spear.
	var/charge_time = 3 SECONDS
	/// Damage delivered by the spear's electrical discharge.
	var/shock_damage = 30

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear
	name = "Lightning Spear"
	desc = "Charge and hurl a spear of psionic lightning that shocks the target."
	button_icon_state = "psi_lightning_spear"
	point_cost = 3
	psionic_flags = PSIONIC_THERMAL
	school = PSIONIC_SCHOOL_FLUX
	needs_hands = TRUE
	requires_concentration = TRUE
	rank_variant_types = list(/datum/psionic_rank_variant/lightning_spear)
	projectile_type = /obj/projectile/psionic/lightning_spear
	projectile_sound = 'sound/effects/magic/lightningshock.ogg'
	active_msg = "Electric pressure gathers around your hand."
	deactive_msg = "The electrical pressure dissipates."
	/// TRUE while the spear is being charged, before its cooldown begins.
	var/is_charging = FALSE

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear/is_action_active(atom/movable/screen/movable/action_button/current_button)
	if(is_charging)
		return TRUE

	return ..()

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear/try_block_target(atom/target, datum/component/psionic_profile/profile)
	return FALSE

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/psionic_rank_variant/lightning_spear/form = get_selected_variant_as_type(/datum/psionic_rank_variant/lightning_spear)
	if(!istype(living_owner) || !form)
		return FALSE
	is_charging = TRUE
	build_all_button_icons()

	var/manifestation_color = get_manifestation_color()
	var/mutable_appearance/charge_aura = mutable_appearance('icons/effects/effects.dmi', "electricity")
	charge_aura.color = manifestation_color
	charge_aura.alpha = 200
	charge_aura.transform = matrix().Scale(1.3)
	var/mutable_appearance/charge_sparks = mutable_appearance('icons/effects/effects.dmi', "shieldsparkles")
	charge_sparks.color = manifestation_color
	charge_sparks.alpha = 220
	var/list/charge_overlays = list(charge_aura, charge_sparks)
	for(var/mutable_appearance/charge_overlay as anything in charge_overlays)
		living_owner.add_overlay(charge_overlay)
	var/mutable_appearance/charge_orb_appearance = mutable_appearance('modular_nova/modules/psionics/icons/lightning_spear.dmi', "charge_orb")
	charge_orb_appearance.color = manifestation_color
	charge_orb_appearance.alpha = 180
	charge_orb_appearance.pixel_x = get_charge_hand_offset(living_owner)
	charge_orb_appearance.pixel_y = -6
	var/atom/movable/flick_visual/charge_orb = living_owner.flick_overlay_view(charge_orb_appearance, form.charge_time)
	if(charge_orb)
		charge_orb.transform = matrix().Scale(0.35)
		animate(charge_orb, alpha = 255, transform = matrix().Scale(1.25), time = form.charge_time, easing = SINE_EASING)
	living_owner.visible_message(
		span_warning("A crackling psionic aura and sparks gather around [living_owner]'s raised hand."),
		span_purple("You gather a spear of crackling psionic lightning."),
	)
	playsound(living_owner, 'sound/effects/magic/lightning_chargeup.ogg', 60, FALSE, channel = CHANNEL_CHARGED_SPELL)
	if(!do_after(living_owner, form.charge_time, target = target, timed_action_flags = IGNORE_HELD_ITEM))
		living_owner.balloon_alert(living_owner, "charge interrupted!")
		clear_charge_effects(living_owner, charge_overlays, charge_orb)
		return FALSE
	clear_charge_effects(living_owner, charge_overlays, charge_orb)

	. = ..()

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear/proc/clear_charge_effects(mob/living/living_owner, list/charge_overlays, atom/movable/flick_visual/charge_orb)
	for(var/mutable_appearance/charge_overlay as anything in charge_overlays)
		living_owner.cut_overlay(charge_overlay)
	if(charge_orb)
		qdel(charge_orb)
	living_owner.stop_sound_channel(CHANNEL_CHARGED_SPELL)
	stop_concentration(living_owner)
	is_charging = FALSE
	build_all_button_icons()

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear/proc/get_charge_hand_offset(mob/living/living_owner)
	var/hand_offset = IS_LEFT_INDEX(living_owner.active_hand_index) ? -7 : 7
	switch(living_owner.dir)
		if(NORTH)
			return -hand_offset
		if(EAST)
			return 7
		if(WEST)
			return -7
	return hand_offset

/datum/action/cooldown/psionic/pointed/projectile/lightning_spear/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration, fire_count = 1, fire_spread = 0)
	. = ..()
	if(!.)
		return

	var/obj/projectile/psionic/lightning_spear/lightning_spear = to_fire
	if(!istype(lightning_spear))
		return .

	var/datum/psionic_rank_variant/lightning_spear/form = get_selected_variant_as_type(/datum/psionic_rank_variant/lightning_spear)
	if(!form)
		return .

	lightning_spear.psionic_charge_cost = form.get_block_charge_cost(src)
	lightning_spear.psionic_block_message = form.get_block_message(src)
	lightning_spear.shock_damage = form.shock_damage
	lightning_spear.light_color = get_manifestation_color()

/obj/projectile/psionic/lightning_spear
	name = "psionic lightning spear"
	icon = 'modular_nova/modules/psionics/icons/lightning_spear.dmi'
	icon_state = "lightning_spear"
	damage = 0
	damage_type = BURN
	armor_flag = ENERGY
	range = 10
	speed = 2.5
	hitsound = 'sound/effects/magic/lightningshock.ogg'
	psionic_charge_cost = 3
	psionic_block_message = "lightning grounded!"
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1.5
	light_color = PSIONIC_DEFAULT_COLOR
	/// Damage dealt by the lightning strike when the projectile connects with a living target.
	var/shock_damage = 30

/obj/projectile/psionic/lightning_spear/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!. || !isliving(target))
		return

	var/mob/living/living_target = target
	var/turf/target_turf = get_turf(living_target)
	if(target_turf)
		new /obj/effect/temp_visual/thunderbolt(target_turf)
		new /obj/effect/temp_visual/emp/pulse(target_turf)

	living_target.electrocute_act(shock_damage, src, flags = SHOCK_TESLA|SHOCK_NOGLOVES)
	living_target.emp_act(EMP_LIGHT)
	living_target.visible_message(
		span_danger("[living_target] is struck by a spear of psionic lightning!"),
		span_userdanger("A spear of psionic lightning tears through you!"),
	)
