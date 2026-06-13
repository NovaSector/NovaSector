/datum/component/bloodwashed_corrupted_gun
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Extra burn damage applied by projectiles fired from this gun.
	var/bonus_burn_damage = 5

/datum/component/bloodwashed_corrupted_gun/Initialize(bonus_burn_damage = 5)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE

	src.bonus_burn_damage = bonus_burn_damage

/datum/component/bloodwashed_corrupted_gun/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignal(parent, COMSIG_PROJECTILE_BEFORE_FIRE, PROC_REF(on_projectile_before_fire))
	var/obj/item/gun/corrupted_gun = parent
	corrupted_gun.update_appearance(UPDATE_OVERLAYS)

/datum/component/bloodwashed_corrupted_gun/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE, COMSIG_ATOM_UPDATE_OVERLAYS, COMSIG_PROJECTILE_BEFORE_FIRE))
	if(!QDELETED(parent))
		var/obj/item/gun/corrupted_gun = parent
		corrupted_gun.update_appearance(UPDATE_OVERLAYS)

/datum/component/bloodwashed_corrupted_gun/proc/on_examine(obj/item/gun/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_cult_italic("A blasphemous film crawls over it. Shots fired from it carry a little extra \
		burning spite.")

/datum/component/bloodwashed_corrupted_gun/proc/on_update_overlays(obj/item/gun/source, list/overlays)
	SIGNAL_HANDLER

	var/mutable_appearance/corruption_overlay = mutable_appearance(source.icon, source.icon_state)
	corruption_overlay.color = RUNE_COLOR_DARKRED
	corruption_overlay.alpha = 120
	overlays += corruption_overlay

/datum/component/bloodwashed_corrupted_gun/proc/on_projectile_before_fire(
	obj/item/gun/source,
	obj/projectile/fired_projectile,
	atom/original,
)
	SIGNAL_HANDLER

	if(QDELETED(fired_projectile))
		return

	fired_projectile.add_atom_colour(RUNE_COLOR_MEDIUMRED, TEMPORARY_COLOUR_PRIORITY)
	fired_projectile.hitsound = SFX_DESECRATION
	fired_projectile.hitsound_wall = SFX_DESECRATION
	fired_projectile.hitscan_light_color_override = LIGHT_COLOR_BLOOD_MAGIC
	fired_projectile.muzzle_flash_color_override = LIGHT_COLOR_BLOOD_MAGIC
	fired_projectile.impact_light_color_override = LIGHT_COLOR_BLOOD_MAGIC
	fired_projectile.AddComponent(/datum/component/bloodwashed_corrupted_projectile, bonus_burn_damage)
	playsound(source, 'sound/effects/magic/enter_blood.ogg', 35, TRUE)

/datum/component/bloodwashed_corrupted_projectile
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Extra burn damage applied when the projectile hits a living target.
	var/bonus_burn_damage = 5

/datum/component/bloodwashed_corrupted_projectile/Initialize(bonus_burn_damage = 5)
	. = ..()
	if(!isprojectile(parent))
		return COMPONENT_INCOMPATIBLE

	src.bonus_burn_damage = bonus_burn_damage

/datum/component/bloodwashed_corrupted_projectile/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(on_projectile_hit))

/datum/component/bloodwashed_corrupted_projectile/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_PROJECTILE_SELF_ON_HIT)

/datum/component/bloodwashed_corrupted_projectile/proc/on_projectile_hit(
	obj/projectile/source,
	atom/movable/firer,
	atom/target,
	angle,
	hit_zone,
	blocked,
	pierce_hit,
)
	SIGNAL_HANDLER

	if(!isliving(target))
		return

	var/mob/living/living_target = target
	living_target.apply_damage(bonus_burn_damage, BURN, hit_zone, blocked, wound_bonus = CANT_WOUND)
	new /obj/effect/temp_visual/cult/sparks(get_turf(living_target))
