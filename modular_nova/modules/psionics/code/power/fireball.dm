/datum/psionic_power/fireball
	required_school_points = 2
	required_powers = list(/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt)
	action_type = /datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/fireball

/datum/psionic_rank_variant/pyro_bolt/fireball
	rank = PSIONIC_RANK_BETA
	variant_name = "fireball"
	description = "An explosive knot of compressed psionic heat."
	strain_gain = 32
	cooldown_time = 30 SECONDS
	cast_range = 8
	active_msg = "A bright pressure gathers in your burning hand."
	deactive_msg = "You let the fireball gutter out."
	block_charge_cost = 2
	block_message = "flame dampened!"
	projectile_type = /obj/projectile/psionic/pyro_fireball
	projectiles_per_fire = 1
	projectile_spread = 0
	projectile_sound = 'sound/effects/magic/fireball.ogg'

/datum/psionic_rank_variant/pyro_bolt/fireball/show_activation_message(mob/living/user)
	user.visible_message(
		span_warning("[user] hurls a dense knot of orange fire."),
		span_purple("You hurl a dense knot of orange fire."),
	)

/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/fireball
	name = "Fireball"
	desc = "Compress psionic heat into an explosive fireball."
	button_icon_state = "psi_pyro_assault"
	active_msg = "A bright pressure gathers in your burning hand."
	deactive_msg = "You let the fireball gutter out."
	point_cost = 2
	rank_variant_types = list(
		/datum/psionic_rank_variant/pyro_bolt/fireball,
	)
	projectile_type = /obj/projectile/psionic/pyro_fireball
	projectiles_per_fire = 1
	projectile_spread = 0
	projectile_sound = 'sound/effects/magic/fireball.ogg'
