/datum/psionic_power/kinetic_bolt
	required_school_points = 1
	action_type = /datum/action/cooldown/psionic/pointed/projectile/kinetic_bolt

/datum/psionic_rank_variant/kinetic_bolt
	rank = PSIONIC_RANK_DELTA
	variant_name = "bolt"
	description = "A repeating kinetic bolt, paced by strain rather than recharge."
	strain_gain = 8
	cooldown_time = 0
	cast_range = 9
	block_charge_cost = 1
	block_message = "force scattered!"
	/// Brute damage dealt by one bolt of this form.
	var/impact_damage = 12
	/// Armour penetration applied to this form's bolts.
	var/impact_armour_penetration = 0

/// Reworded from the shared format: this discipline has no cooldown, so strain per shot is the only pacing.
/datum/psionic_rank_variant/kinetic_bolt/get_description(datum/action/cooldown/psionic/action)
	var/form_description = description || get_name(action)
	return "[form_description] ([impact_damage] damage, [get_value(action, "strain_gain")] strain per shot)"

/datum/psionic_rank_variant/kinetic_bolt/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "lance"
	description = "A tighter kinetic lance that bites through armour."
	strain_gain = 10
	impact_damage = 16
	impact_armour_penetration = 10

/datum/psionic_rank_variant/kinetic_bolt/alpha
	rank = PSIONIC_RANK_ALPHA
	variant_name = "torrent"
	description = "An unbroken torrent of kinetic pressure."
	strain_gain = 13
	impact_damage = 20
	impact_armour_penetration = 10

/datum/action/cooldown/psionic/pointed/projectile/kinetic_bolt
	name = "Kinetic Bolt"
	desc = "Shape a repeating kinetic bolt. It stays readied between shots and is paced by strain instead of a recharge, \
		so it falls silent long before your reserves run dry."
	button_icon_state = "psi_kinetic_bolt"
	active_msg = "Kinetic pressure gathers over your palm."
	deactive_msg = "The kinetic pressure bleeds away."
	click_cd_override = CLICK_CD_RANGE
	point_cost = 1
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	needs_hands = TRUE
	variant_type = /datum/psionic_rank_variant/kinetic_bolt
	rank_variant_types = list(
		/datum/psionic_rank_variant/kinetic_bolt,
		/datum/psionic_rank_variant/kinetic_bolt/beta,
		/datum/psionic_rank_variant/kinetic_bolt/alpha,
	)
	projectile_type = /obj/projectile/psionic/kinetic_bolt
	projectile_hand_visual_type = /obj/item/psionic_kinetic_hand
	projectile_sound = 'sound/items/weapons/fwoosh.ogg'
	projectile_sound_volume = 45

// The projectile carries the block charge itself, so the action-level check would charge the target twice.
/datum/action/cooldown/psionic/pointed/projectile/kinetic_bolt/try_block_target(atom/target, datum/component/psionic_profile/profile)
	return FALSE

/// A basic attack must run dry rather than burn its psion out, or the top of the strain bar is unusable.
/datum/action/cooldown/psionic/pointed/projectile/kinetic_bolt/before_psionic(atom/target)
	var/mob/living/living_owner = owner
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!profile)
		return FALSE

	profile.decay_strain()
	// Mirrors the burnout condition in try_gain_strain(), including the school discount.
	var/shot_strain = profile.get_action_strain_gain(get_variant_value(profile, "strain_gain"), src)
	if(profile.strain + shot_strain >= profile.max_strain)
		living_owner.balloon_alert(living_owner, "not enough focus!")
		return FALSE

	return TRUE

/// The readied hand uses the greyscale hand sprite, so it tints to match the bolts it throws.
/datum/action/cooldown/psionic/pointed/projectile/kinetic_bolt/create_projectile_hand_visual(mob/on_who)
	. = ..()
	if(!.)
		return

	projectile_hand_visual.color = get_manifestation_color()

/datum/action/cooldown/psionic/pointed/projectile/kinetic_bolt/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration, fire_count = 1, fire_spread = 0)
	. = ..()
	if(!.)
		return

	var/obj/projectile/psionic/kinetic_bolt/kinetic_projectile = to_fire
	var/datum/psionic_rank_variant/kinetic_bolt/form = get_form()
	if(!istype(kinetic_projectile) || !form)
		return .

	kinetic_projectile.damage = form.impact_damage
	kinetic_projectile.armour_penetration = form.impact_armour_penetration
	kinetic_projectile.psionic_charge_cost = form.block_charge_cost
	kinetic_projectile.psionic_block_message = form.block_message
	// The bolt sprite is greyscale, so a plain multiply lands the psion's configured colour
	// exactly. apply_manifestation_color()'s HSL filter is for sprites that already have a hue.
	var/manifestation_color = get_manifestation_color()
	kinetic_projectile.color = manifestation_color
	kinetic_projectile.set_light_color(manifestation_color)

/obj/item/psionic_kinetic_hand
	name = "\improper psionic pressure"
	desc = "A ball of kinetic pressure coiling around the hand."
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "greyscale"
	inhand_icon_state = "greyscale"
	color = PSIONIC_DEFAULT_COLOR
	item_flags = ABSTRACT | HAND_ITEM | DROPDEL | NOBLUDGEON
	w_class = WEIGHT_CLASS_HUGE
	force = 0
	throwforce = 0
	throw_range = 0
	throw_speed = 0

/obj/item/psionic_kinetic_hand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, PSIONIC_TRAIT_SOURCE)

/obj/projectile/psionic/kinetic_bolt
	name = "kinetic bolt"
	icon = 'modular_nova/modules/psionics/icons/kinetic_bolt.dmi'
	icon_state = "kinetic_bolt"
	damage = 12
	damage_type = BRUTE
	armor_flag = MELEE
	range = 9
	hitsound = 'sound/effects/hit_punch.ogg'
	impact_effect_type = /obj/effect/temp_visual/kinetic_blast
	psionic_flags = PSIONIC_KINETIC
	psionic_block_message = "force scattered!"
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 1.2
	light_color = PSIONIC_DEFAULT_COLOR
