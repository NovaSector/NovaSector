/datum/component/bloodwashed_corrupted_gun
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Extra burn damage applied by projectiles fired from this gun.
	var/bonus_burn_damage = 5
	/// The filter ID used for the animated rune glow.
	var/static/rune_glow_filter = "bloodwashed_rune_glow"
	/// Cached rune line icons, masked against each corrupted gun's base icon state.
	var/static/list/rune_line_cache = list()

/datum/component/bloodwashed_corrupted_gun/Initialize(bonus_burn_damage = 5)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE

	src.bonus_burn_damage = bonus_burn_damage

/datum/component/bloodwashed_corrupted_gun/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignal(parent, COMSIG_ITEM_GET_WORN_OVERLAYS, PROC_REF(on_worn_overlays))
	RegisterSignal(parent, COMSIG_PROJECTILE_BEFORE_FIRE, PROC_REF(on_projectile_before_fire))
	RegisterSignal(parent, COMSIG_GUN_PIN_REMOVED, PROC_REF(on_pin_removed))
	ensure_cult_firing_pin()
	var/obj/item/gun/corrupted_gun = parent
	corrupted_gun.update_appearance(UPDATE_OVERLAYS)
	animate_rune_glow()

/datum/component/bloodwashed_corrupted_gun/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_UPDATE_OVERLAYS,
		COMSIG_ITEM_GET_WORN_OVERLAYS,
		COMSIG_PROJECTILE_BEFORE_FIRE,
		COMSIG_GUN_PIN_REMOVED,
	))
	if(!QDELETED(parent))
		var/obj/item/gun/corrupted_gun = parent
		corrupted_gun.remove_filter(rune_glow_filter)
		corrupted_gun.update_appearance(UPDATE_OVERLAYS)

/datum/component/bloodwashed_corrupted_gun/proc/ensure_cult_firing_pin()
	if(QDELETED(parent))
		return

	var/obj/item/gun/corrupted_gun = parent
	if(istype(corrupted_gun.pin, /obj/item/firing_pin/bloodwashed))
		return

	QDEL_NULL(corrupted_gun.pin)
	var/obj/item/firing_pin/bloodwashed/cult_pin = new
	cult_pin.gun_insert(new_gun = corrupted_gun, starting = TRUE)

/datum/component/bloodwashed_corrupted_gun/proc/animate_rune_glow()
	var/obj/item/gun/corrupted_gun = parent
	corrupted_gun.remove_filter(rune_glow_filter)
	corrupted_gun.add_filter(rune_glow_filter, 1, list(
		"type" = "outline",
		"color" = RUNE_COLOR_MEDIUMRED,
		"alpha" = 80,
		"size" = 1,
	))
	var/filter = corrupted_gun.get_filter(rune_glow_filter)
	animate(filter, alpha = 210, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 80, time = 1.5 SECONDS)

/datum/component/bloodwashed_corrupted_gun/proc/on_examine(obj/item/gun/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_cult_italic("A blasphemous film crawls over it. Blood-red lines breathe across its \
		brown metal, and its firing pin will answer only cultists.")

/datum/component/bloodwashed_corrupted_gun/proc/on_update_overlays(obj/item/gun/source, list/overlays)
	SIGNAL_HANDLER

	var/mutable_appearance/cult_body = mutable_appearance(source.icon, source.icon_state)
	cult_body.color = COLOR_DARK_BROWN
	cult_body.alpha = 155
	overlays += cult_body

	var/mutable_appearance/rune_lines = mutable_appearance(
		get_masked_rune_lines(source),
		icon_state = "",
		appearance_flags = RESET_COLOR,
	)
	rune_lines.blend_mode = BLEND_ADD
	overlays += rune_lines

/datum/component/bloodwashed_corrupted_gun/proc/get_masked_rune_lines(obj/item/gun/source)
	var/icon/gun_mask = icon(source.icon, source.icon_state)
	var/gun_width = gun_mask.Width()
	var/gun_height = gun_mask.Height()
	var/cache_key = "[REF(source.icon)]-[source.icon_state]-[gun_width]x[gun_height]"
	var/icon/cached_rune_lines = rune_line_cache[cache_key]
	if(cached_rune_lines)
		return cached_rune_lines

	gun_mask.Blend("#ffffff", ICON_ADD)

	var/icon/rune_lines = icon('modular_nova/modules/bloodwashed/icons/corrupted_gun_overlays.dmi', "runes")
	if(rune_lines.Width() != gun_width || rune_lines.Height() != gun_height)
		rune_lines.Scale(gun_width, gun_height)

	rune_lines.Blend(gun_mask, ICON_MULTIPLY)
	rune_lines = fcopy_rsc(rune_lines)
	rune_line_cache[cache_key] = rune_lines
	return rune_lines

/datum/component/bloodwashed_corrupted_gun/proc/on_worn_overlays(
	obj/item/gun/source,
	list/overlays,
	mutable_appearance/standing,
	isinhands,
	icon_file,
)
	SIGNAL_HANDLER

	var/mutable_appearance/worn_tint = new /mutable_appearance(standing)
	worn_tint.color = RUNE_COLOR_MEDIUMRED
	worn_tint.alpha = isinhands ? 140 : 95
	overlays += worn_tint

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

/datum/component/bloodwashed_corrupted_gun/proc/on_pin_removed(
	obj/item/gun/source,
	obj/item/firing_pin/old_pin,
	mob/living/user,
)
	SIGNAL_HANDLER

	if(QDELETED(source))
		return

	addtimer(CALLBACK(src, PROC_REF(ensure_cult_firing_pin)), 0)

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

/obj/item/firing_pin/bloodwashed
	name = "runed firing pin"
	desc = "A firing pin fused into a weapon by blood magic. Its crawling runes answer only cultists."
	icon_state = "firing_pin_red"
	color = RUNE_COLOR_MEDIUMRED
	fail_message = "the runes reject you!"
	pin_removable = FALSE
	default_pin_auth = FALSE

/obj/item/firing_pin/bloodwashed/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE

	return IS_CULTIST(user)
