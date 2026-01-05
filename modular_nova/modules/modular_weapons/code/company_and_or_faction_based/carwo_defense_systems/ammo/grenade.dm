#define AMMO_MATS_GRENADE list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, \
)

#define AMMO_MATS_GRENADE_SHRAPNEL list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
	/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2, \
)

#define AMMO_MATS_GRENADE_INCENDIARY list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
	/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2, \
)

#define GRENADE_SMOKE_RANGE 0.75

// .980 grenades
// Grenades that can be given a range to detonate at by their firing gun

/obj/item/ammo_casing/c980grenade
	name = ".980 Tydhouer practice grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Practice shells disintegrate into harmless sparks."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "980_solid"

	caliber = CALIBER_980TYDHOUER
	projectile_type = /obj/projectile/bullet/c980grenade

	custom_materials = AMMO_MATS_GRENADE

	harmful = FALSE //Erm, technically
	ammo_categories = AMMO_CLASS_NONE
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c980


/obj/item/ammo_casing/c980grenade/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	var/obj/item/gun/ballistic/automatic/sol_grenade_launcher/firing_launcher = fired_from
	if(istype(firing_launcher))
		loaded_projectile.range = firing_launcher.target_range
	else if(istype(fired_from, /obj/item/gun/ballistic/shotgun/shell_launcher))
		loaded_projectile.range = 5
	else if(istype(fired_from, /obj/item/gun/ballistic/pump_launcher/c980))
		loaded_projectile.range = get_dist(user, target)
	. = ..()


/obj/projectile/bullet/c980grenade
	name = ".980 Tydhouer practice grenade"
	damage = 20
	stamina = 30

	range = 14

	speed = 1

	sharpness = NONE


/obj/projectile/bullet/c980grenade/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	fuse_activation(target)
	return BULLET_ACT_HIT


/obj/projectile/bullet/c980grenade/on_range()
	fuse_activation(get_turf(src))
	return ..()


/// Generic proc that is called when the projectile should 'detonate', being either on impact or when the range runs out
/obj/projectile/bullet/c980grenade/proc/fuse_activation(atom/target)
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 50, TRUE, -3)
	do_sparks(3, FALSE, src)


/obj/item/ammo_box/c980grenade
	name = "ammo box (.980 Tydhouer practice)"
	desc = "A box of four .980 Tydhouer practice grenades. Instructions on the box indicate these are dummy practice rounds that will disintegrate into sparks on detonation. Neat!"

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "980box_solid"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_980TYDHOUER
	ammo_type = /obj/item/ammo_casing/c980grenade
	max_ammo = 4


// .980 smoke grenade

/obj/item/ammo_casing/c980grenade/smoke
	name = ".980 Tydhouer smoke grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Bursts into a laser-weakening smoke cloud."

	icon_state = "980_smoke"

	projectile_type = /obj/projectile/bullet/c980grenade/smoke


/obj/projectile/bullet/c980grenade/smoke
	name = ".980 Tydhouer smoke grenade"


/obj/projectile/bullet/c980grenade/smoke/fuse_activation(atom/target)
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 50, TRUE, -3)
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/fluid_spread/smoke/bad/smoke = new
	smoke.set_up(GRENADE_SMOKE_RANGE, holder = src, location = src)
	smoke.start()


/obj/item/ammo_box/c980grenade/smoke
	name = "ammo box (.980 Tydhouer smoke)"
	desc = "A box of four .980 Tydhouer smoke grenades. Instructions on the box indicate these are smoke rounds that will make a small cloud of laser-dampening smoke on detonation."

	icon_state = "980box_smoke"

	ammo_type = /obj/item/ammo_casing/c980grenade/smoke


// .980 shrapnel grenade

/obj/item/ammo_casing/c980grenade/shrapnel
	name = ".980 Tydhouer shrapnel grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Explodes into shrapnel on detonation."

	icon_state = "980_explosive"

	projectile_type = /obj/projectile/bullet/c980grenade/shrapnel

	custom_materials = AMMO_MATS_GRENADE_SHRAPNEL
	ammo_categories = AMMO_CLASS_LETHAL

	harmful = TRUE


/obj/projectile/bullet/c980grenade/shrapnel
	name = ".980 Tydhouer shrapnel grenade"

	/// What type of casing should we put inside the bullet to act as shrapnel later
	var/casing_to_spawn = /obj/item/grenade/c980payload


/obj/projectile/bullet/c980grenade/shrapnel/fuse_activation(atom/target)
	var/obj/item/grenade/shrapnel_maker = new casing_to_spawn(get_turf(target))
	shrapnel_maker.detonate()
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 50, TRUE, -3)
	qdel(shrapnel_maker)


/obj/item/ammo_box/c980grenade/shrapnel
	name = "ammo box (.980 Tydhouer shrapnel)"
	desc = "A box of four .980 Tydhouer shrapnel grenades. Instructions on the box indicate these are shrapnel rounds. It's also covered in hazard signs, odd."

	icon_state = "980box_explosive"

	ammo_type = /obj/item/ammo_casing/c980grenade/shrapnel


/obj/item/grenade/c980payload
	shrapnel_type = /obj/projectile/bullet/shrapnel/shorter_range
	shrapnel_radius = 3
	ex_dev = 0
	ex_heavy = 0
	ex_light = 0
	ex_flame = 0


/obj/projectile/bullet/shrapnel/shorter_range
	range = 2

// .980 stingball grenade (be very careful)
/obj/item/ammo_casing/c980grenade/shrapnel/stingball
	name = ".980 Tydhouer stingball grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Explodes into stingballs on detonation."
	icon_state = "980_stingball"

	projectile_type = /obj/projectile/bullet/c980grenade/shrapnel/stingball

	custom_materials = AMMO_MATS_GRENADE
	ammo_categories = AMMO_CLASS_NICHE_LTL

/obj/item/ammo_box/c980grenade/shrapnel/stingball
	name = "ammo box (.980 Tydhouer stingball)"
	desc = "A box of four .980 Tydhouer stingball grenades. Instructions on the box indicate these are stingball rounds. It's also covered in hazard signs, odd."

	icon_state = "980box_stingball"

	ammo_type = /obj/item/ammo_casing/c980grenade/shrapnel/stingball

/obj/projectile/bullet/c980grenade/shrapnel/stingball
	name = ".980 Tydhouer stingball grenade"

	casing_to_spawn = /obj/item/grenade/c980payload/stingball

/obj/item/grenade/c980payload/stingball
	shrapnel_type = /obj/projectile/bullet/pellet/stingball/shorter_range
	shrapnel_radius = 3

/obj/projectile/bullet/pellet/stingball/shorter_range
	range = 10

// .980 phosphor grenade

/obj/item/ammo_casing/c980grenade/shrapnel/phosphor
	name = ".980 Tydhouer phosphor grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Explodes into smoke and flames on detonation."

	icon_state = "980_gas_alternate"

	projectile_type = /obj/projectile/bullet/c980grenade/shrapnel/phosphor
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_GRENADE_INCENDIARY


/obj/projectile/bullet/c980grenade/shrapnel/phosphor
	name = ".980 Tydhouer phosphor grenade"

	casing_to_spawn = /obj/item/grenade/c980payload/phosphor


/obj/projectile/bullet/c980grenade/shrapnel/phosphor/fuse_activation(atom/target)
	. = ..()

	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/fluid_spread/smoke/quick/smoke = new
	smoke.set_up(GRENADE_SMOKE_RANGE, holder = src, location = src)
	smoke.start()


/obj/item/ammo_box/c980grenade/shrapnel/phosphor
	name = "ammo box (.980 Tydhouer phosphor)"
	desc = "A box of four .980 Tydhouer phosphor grenades. Instructions on the box indicate these are incendiary explosive rounds. It's also covered in hazard signs, odd."

	icon_state = "980box_gas_alternate"

	ammo_type = /obj/item/ammo_casing/c980grenade/shrapnel/phosphor


/obj/item/grenade/c980payload/phosphor
	shrapnel_type = /obj/projectile/bullet/incendiary/fire/backblast/short_range


/obj/projectile/bullet/incendiary/fire/backblast/short_range
	range = 2


// .980 tear gas grenade

/obj/item/ammo_casing/c980grenade/riot
	name = ".980 Tydhouer tear gas grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Bursts into a tear gas cloud."

	icon_state = "980_gas"
	ammo_categories = AMMO_CLASS_NICHE_LTL
	projectile_type = /obj/projectile/bullet/c980grenade/riot


/obj/projectile/bullet/c980grenade/riot
	name = ".980 Tydhouer tear gas grenade"

/obj/projectile/bullet/c980grenade/riot/fuse_activation(atom/target)
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 50, TRUE, -3)
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/fluid_spread/smoke/chem/smoke = new()
	smoke.chemholder.add_reagent(/datum/reagent/consumable/condensedcapsaicin, 10)
	smoke.set_up(GRENADE_SMOKE_RANGE, holder = src, location = src)
	smoke.start()


/obj/item/ammo_box/c980grenade/riot
	name = "ammo box (.980 Tydhouer tear gas)"
	desc = "A box of four .980 Tydhouer tear gas grenades. Instructions on the box indicate these are smoke rounds that will make a small cloud of laser-dampening smoke on detonation."

	icon_state = "980box_gas"

	ammo_type = /obj/item/ammo_casing/c980grenade/riot

// .980 kinetic concussive grenade (throw people around. ruin interior decorations. maybe actually give someone a concussion.)
/obj/item/ammo_casing/c980grenade/concussive
	name = ".980 Tydhouer kinetic concussive grenade"
	desc = "A large grenade shell that will detonate at a range given to it by the gun that fires it. Creates a kinetic shockwave optimized for \
		throwing things around, including people, and disorienting people via pressure wave."

	icon_state = "980_concussive"
	ammo_categories = AMMO_CLASS_NICHE
	projectile_type = /obj/projectile/bullet/c980grenade/concussive

/obj/projectile/bullet/c980grenade/concussive
	name = ".980 Tydhouer kinetic concussive grenade"

	/// Knockback wave size, see forced_throw_vortex.
	var/knockback_size = 3
	/// Concussion wave size. If you're in this distance from the airburst detonation, you eat a stagger.
	var/stagger_size = 2

/obj/projectile/bullet/c980grenade/concussive/fuse_activation(atom/target)
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 50, TRUE, -3)
	var/turf/burst_turf = get_turf(src)
	for(var/mob/living/brainbonked in view(stagger_size, burst_turf))
		var/distance = get_dist(brainbonked, burst_turf)
		brainbonked.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * (stagger_size - distance), STAGGERED_SLOWDOWN_LENGTH * 3)
	new /obj/effect/temp_visual/kinetic_blast(get_turf(src))
	forced_throw_vortex(get_turf(src), TRUE, knockback_size)

/obj/item/ammo_box/c980grenade/concussive
	name = "ammo box (.980 Tydhouer kinetic concussive)"
	desc = "A box of four .980 Tydhouer concussive grenades. Instructions on the box indicate these are \
		kinetic concussive rounds that generate a wave of force that debilitates those in its blast radius. \
		A disclaimer notes that these may cause complaints from interior decorators, and that, for best effects, \
		to airburst adjacent to the target."

	icon_state = "980box_concussive"

	ammo_type = /obj/item/ammo_casing/c980grenade/concussive

/**
 * Magical move-wooney but it always throws you that happens sometimes, adapted from goonchem_vortex
 *
 * Simulates a vortex that moves nearby movable atoms towards or away from the turf T.
 * Range also determines the strength of the effect. Always throws. Parameters decide how hard it throws.
 * Arguments:
 * * T - turf where it happens
 * * is_pulling - true if throwing things away from the starting turf
 * * range - range.
 */
/proc/forced_throw_vortex(turf/starting_turf, is_pulling, range)
	for(var/atom/movable/hucked in range(range, starting_turf))
		if(hucked.anchored)
			continue
		if(iseffect(hucked) || iseyemob(hucked) || isdead(hucked))
			continue
		var/distance = get_dist(hucked, starting_turf)
		var/moving_power = max(range - distance, 1)
		if(is_pulling)
			var/atom/throw_target = get_edge_target_turf(hucked, get_dir(hucked, get_step_away(hucked, starting_turf)))
			hucked.throw_at(throw_target, moving_power * 1.5, moving_power)
		else
			hucked.throw_at(starting_turf, moving_power * 1.5, moving_power)

#undef AMMO_MATS_GRENADE
#undef AMMO_MATS_GRENADE_SHRAPNEL
#undef AMMO_MATS_GRENADE_INCENDIARY

#undef GRENADE_SMOKE_RANGE
