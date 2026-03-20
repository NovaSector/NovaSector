/// Filter name for the energy shield outline glow
#define ENERGY_SHIELD_FILTER "energy_shield_tint"
/// Filter name for the energy shield texture pattern
#define ENERGY_SHIELD_PATTERN_FILTER "energy_shield_pattern"
/// Trait source for temporary blood suppression during shield absorption
#define ENERGY_SHIELD_TRAIT "energy_shield"
/// Trait applied to wearer to prevent stacking multiple shields
#define TRAIT_ENERGY_SHIELDED "energy_shielded"
/// Y offset for shield HUD bar so it doesn't overlap health bar
#define SHIELD_HUD_Y_OFFSET 6
/// How long the shield filters stay visible after a hit
#define SHIELD_VISUAL_LINGER 1.5 SECONDS
/// Maximum armor rating allowed on outer clothing before the shield refuses to activate (class I = 10)
#define SHIELD_MAX_ARMOR_CLASS 10

/obj/item/clothing/accessory/energy_shield
	name = "energy shield projector"
	desc = "A compact personal energy shield projector. Can be clipped onto clothing or worn around the neck. Projects a protective barrier that absorbs incoming damage."
	icon = 'icons/obj/clothing/neck.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "modlink"
	worn_icon_state = "modlink"
	slot_flags = ITEM_SLOT_NECK
	attachment_slot = NONE
	above_suit = FALSE
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/toggle_energy_shield)
	/// Grant the action button in both neck and accessory-on-jumpsuit slots
	action_slots = ITEM_SLOT_NECK | ITEM_SLOT_ICLOTHING

	/// Current shield health — starts empty, must charge after equipping
	var/shield_health = 0
	/// Maximum shield health
	var/max_shield_health = 50
	/// Whether the shield is active (has charge and is worn)
	var/shield_active = FALSE
	/// The color tint of the shield effects
	var/shield_color = "#00aaff"
	/// Delay before recharge begins after being hit
	var/recharge_delay = 10 SECONDS
	/// Health restored per second during recharge
	var/recharge_rate = 5
	/// Cached reference to the mob wearing this item
	var/mob/living/carbon/wearer
	/// Whether the outline/pattern filters are currently applied
	var/visuals_shown = FALSE
	/// Whether the recharge visual has been shown for the current recharge cycle
	var/recharge_visual_pending = TRUE
	/// Whether filters are showing because of active recharging (persistent until full)
	var/showing_recharge = FALSE
	/// Future: multiplier applied to melee damage passing through the shield
	var/melee_multiplier = 1.25
	/// Future: list of damage types that bypass the shield entirely
	var/list/bypassed_damagetypes
	/// Maximum armor rating on outer clothing before the shield refuses to activate
	var/max_armor_class = SHIELD_MAX_ARMOR_CLASS
	/// Whether the shield is enabled by the user (toggle via action button)
	var/enabled = TRUE
	/// Fraction of shield health retained after an EMP (0 = full wipe, 0.5 = halved)
	var/emp_retention = 0

	COOLDOWN_DECLARE(recharge_cooldown)
	/// Controls how long filters linger after a hit
	COOLDOWN_DECLARE(visual_cooldown)

/// Returns TRUE if the wearer's outer clothing has LASER, ENERGY, or BULLET armor above class II.
/obj/item/clothing/accessory/energy_shield/proc/wearer_has_heavy_armor()
	if(!iscarbon(wearer))
		return FALSE
	var/obj/item/clothing/suit = wearer.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(isnull(suit))
		return FALSE
	if(suit.get_armor_rating(LASER) > max_armor_class)
		return TRUE
	if(suit.get_armor_rating(ENERGY) > max_armor_class)
		return TRUE
	if(suit.get_armor_rating(BULLET) > max_armor_class)
		return TRUE
	return FALSE

/// Handles activation for both neck slot and accessory-on-jumpsuit paths.
/// accessory_equipped() calls equipped(), so this single override covers both.
/obj/item/clothing/accessory/energy_shield/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & (ITEM_SLOT_NECK | ITEM_SLOT_ICLOTHING)))
		return
	if(!iscarbon(user))
		return
	if(HAS_TRAIT(user, TRAIT_ENERGY_SHIELDED))
		return

	wearer = user
	ADD_TRAIT(wearer, TRAIT_ENERGY_SHIELDED, ENERGY_SHIELD_TRAIT)
	RegisterSignal(wearer, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(on_damage_modifiers))
	RegisterSignal(wearer, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(on_pre_bullet))

	if(!enabled)
		to_chat(wearer, span_notice("The [src] is disabled. Use it in hand to open the control panel."))
	else if(wearer_has_heavy_armor())
		to_chat(wearer, span_warning("The [src] fails to activate — your armor is too heavy for the energy field to form."))
	else if(shield_health > 0)
		shield_active = TRUE
	else
		COOLDOWN_START(src, recharge_cooldown, recharge_delay)
	update_shield_hud()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/accessory/energy_shield/dropped(mob/living/user)
	. = ..()
	if(isnull(wearer))
		return
	UnregisterSignal(wearer, list(COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, COMSIG_ATOM_PRE_BULLET_ACT))
	REMOVE_TRAIT(wearer, TRAIT_ENERGY_SHIELDED, ENERGY_SHIELD_TRAIT)
	if(shield_health > 0)
		playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
	shield_health = 0
	shield_active = FALSE
	showing_recharge = FALSE
	recharge_visual_pending = TRUE
	hide_shield_visuals()
	clear_shield_hud()
	STOP_PROCESSING(SSobj, src)
	wearer = null

/obj/item/clothing/accessory/energy_shield/examine(mob/user)
	. = ..()
	if(!enabled)
		. += span_warning("The energy shield is disabled.")
	else if(shield_active)
		. += span_notice("The energy shield is active ([round((shield_health / max_shield_health) * 100)]% integrity).")
	else if(shield_health > 0)
		. += span_notice("The energy shield is recharging ([round((shield_health / max_shield_health) * 100)]% integrity).")
	else
		. += span_warning("The energy shield is offline.")

/// Toggles the shield on/off via the action button.
/obj/item/clothing/accessory/energy_shield/ui_action_click(mob/user, datum/action/action)
	enabled = !enabled
	if(!enabled)
		if(shield_active)
			shield_active = FALSE
			shield_health = 0
			showing_recharge = FALSE
			hide_shield_visuals()
			update_shield_hud()
			playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
		to_chat(wearer, span_notice("You deactivate the energy shield."))
	else if(wearer)
		COOLDOWN_START(src, recharge_cooldown, recharge_delay)
		recharge_visual_pending = TRUE
		to_chat(wearer, span_notice("You activate the energy shield. It will begin charging shortly."))
	action.build_all_button_icons()

/// Drains shield health on EMP. Amount retained is controlled by emp_retention.
/obj/item/clothing/accessory/energy_shield/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(isnull(wearer))
		return
	if(shield_health <= 0 && !shield_active)
		return

	shield_health = round(shield_health * emp_retention)
	if(shield_health <= 0)
		shield_active = FALSE
	COOLDOWN_START(src, recharge_cooldown, recharge_delay)
	update_shield_hud()
	playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
	wearer.visible_message(span_warning("[wearer]'s energy shield shorts out!"))
	do_sparks(3, TRUE, wearer)

/// Fully blocks projectiles when the shield can absorb the entire hit.
/// This prevents embedding, wounding, and blood splatter from blocked bullets.
/// Partial absorption falls through to on_damage_modifiers instead.
/obj/item/clothing/accessory/energy_shield/proc/on_pre_bullet(mob/living/carbon/source, obj/projectile/proj, def_zone, piercing_hit)
	SIGNAL_HANDLER

	if(shield_health <= 0 || !shield_active)
		return
	if(proj.damage <= 0)
		return
	// Only fully block if we can absorb the entire raw hit
	if(shield_health < proj.damage)
		return

	shield_health -= proj.damage

	COOLDOWN_START(src, recharge_cooldown, recharge_delay)
	recharge_visual_pending = TRUE
	showing_recharge = FALSE
	COOLDOWN_START(src, visual_cooldown, SHIELD_VISUAL_LINGER)
	show_shield_visuals()
	update_shield_visuals()

	// Flash the hit limb
	var/obj/item/bodypart/limb = wearer.get_bodypart(check_zone(def_zone))
	if(limb)
		flash_limb(limb)

	if(shield_health <= 0)
		shield_collapse()

	update_shield_hud()
	return COMPONENT_BULLET_BLOCKED

/// Intercepts incoming damage via modifier system. Absorbs damage and triggers limb glow on hit.
/// For projectiles, this only fires when the shield couldn't fully block (partial absorption).
/// For melee and other external attacks, this is the primary absorption path.
/obj/item/clothing/accessory/energy_shield/proc/on_damage_modifiers(mob/living/carbon/source, list/damage_mods, damage, damagetype, def_zone, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(shield_health <= 0)
		return
	if(damage <= 0)
		return
	// Only absorb external attacks (projectiles, melee) — not embeds, wounds, or reagent damage.
	// External attacks always have an attack_direction; internal sources don't.
	if(isnull(attack_direction))
		return

	var/absorbed = min(damage, shield_health)
	var/fully_absorbed = absorbed >= damage
	if(fully_absorbed)
		damage_mods += 0
	else
		damage_mods += (damage - absorbed) / damage
	shield_health -= absorbed

	// Temporarily suppress blood splatter when fully absorbing hits.
	// CAN_HAVE_BLOOD is a cached bitflag — TRAIT_NOBLOOD alone won't update it in time.
	// We directly clear the flag for this call stack frame and restore it next tick.
	if(fully_absorbed && CAN_HAVE_BLOOD(wearer))
		wearer.living_flags &= ~LIVING_CAN_HAVE_BLOOD
		addtimer(CALLBACK(src, PROC_REF(restore_blood_flag)), 0)

	COOLDOWN_START(src, recharge_cooldown, recharge_delay)
	recharge_visual_pending = TRUE
	showing_recharge = FALSE
	// Show filters on hit; they'll linger for SHIELD_VISUAL_LINGER then hide in process()
	COOLDOWN_START(src, visual_cooldown, SHIELD_VISUAL_LINGER)
	show_shield_visuals()
	update_shield_visuals()

	if(isbodypart(def_zone))
		flash_limb(def_zone)

	if(shield_health <= 0)
		shield_collapse()

	update_shield_hud()

/// Restores the LIVING_CAN_HAVE_BLOOD flag after the current tick.
/obj/item/clothing/accessory/energy_shield/proc/restore_blood_flag()
	if(!QDELETED(wearer) && wearer.can_have_blood())
		wearer.living_flags |= LIVING_CAN_HAVE_BLOOD

/// Builds a "#RRGGBBAA" color string with alpha proportional to current shield health.
/obj/item/clothing/accessory/energy_shield/proc/get_shield_tint_color()
	var/tint_alpha = shield_health > 0 ? round((shield_health / max_shield_health) * 200 + 5) : 5
	var/static/hex_digits = "0123456789abcdef"
	return "[shield_color][hex_digits[round(tint_alpha / 16) + 1]][hex_digits[(tint_alpha % 16) + 1]]"

/// Applies outline glow and texture pattern filters to the wearer.
/obj/item/clothing/accessory/energy_shield/proc/show_shield_visuals()
	if(QDELETED(wearer) || visuals_shown)
		return
	visuals_shown = TRUE
	wearer.add_filter(ENERGY_SHIELD_FILTER, 1, outline_filter(size = 1, color = get_shield_tint_color()))
	wearer.add_filter(ENERGY_SHIELD_PATTERN_FILTER, 2, layering_filter(icon = icon('icons/mob/human/textures.dmi', "fishscale"), color = shield_color, blend_mode = BLEND_INSET_OVERLAY))

/// Removes the outline glow and texture pattern filters from the wearer.
/obj/item/clothing/accessory/energy_shield/proc/hide_shield_visuals()
	if(QDELETED(wearer) || !visuals_shown)
		return
	visuals_shown = FALSE
	wearer.remove_filter(ENERGY_SHIELD_FILTER)
	wearer.remove_filter(ENERGY_SHIELD_PATTERN_FILTER)

/// Updates the outline filter alpha to reflect current shield health.
/obj/item/clothing/accessory/energy_shield/proc/update_shield_visuals()
	if(QDELETED(wearer) || !visuals_shown)
		return
	wearer.remove_filter(ENERGY_SHIELD_FILTER)
	wearer.add_filter(ENERGY_SHIELD_FILTER, 1, outline_filter(size = 1, color = get_shield_tint_color()))

/// Briefly pulses the whole mob with the shield color and spawns a ripple at the hit limb.
/// Uses animate() so the flash is visible through worn clothing (KEEP_TOGETHER composites everything).
/obj/item/clothing/accessory/energy_shield/proc/flash_limb(obj/item/bodypart/limb)
	if(QDELETED(wearer))
		return
	playsound(wearer, 'sound/items/weapons/tap.ogg', 20)
	var/original_color = wearer.color
	wearer.color = shield_color
	animate(wearer, color = original_color, time = 0.3 SECONDS)
	// Spawn concentric ripple at the hit limb's position
	if(!QDELETED(limb))
		INVOKE_ASYNC(src, PROC_REF(spawn_shield_ripple), limb)

/// Spawns the concentric ripple effect at a limb's position. Separate proc because new() can yield.
/obj/item/clothing/accessory/energy_shield/proc/spawn_shield_ripple(obj/item/bodypart/limb)
	var/turf/wearer_turf = get_turf(wearer)
	if(!wearer_turf)
		return
	var/obj/effect/temp_visual/energy_shield_ripple/ripple = new(wearer_turf, wearer)
	ripple.color = shield_color
	// Scale ripple with mob height (0.35x at medium height, proportional otherwise)
	var/mob/living/carbon/human/human_wearer = wearer
	var/scale = 0.35 * (istype(human_wearer) ? (human_wearer.mob_height / HUMAN_HEIGHT_MEDIUM) : 1)
	ripple.transform = matrix(scale, 0, 0, 0, scale, 0)
	// Offset to the struck limb's approximate position on the sprite
	switch(limb.body_zone)
		if(BODY_ZONE_HEAD)
			ripple.pixel_y = 8
		if(BODY_ZONE_CHEST)
			ripple.pixel_y = 0
		if(BODY_ZONE_L_ARM)
			ripple.pixel_x = 10
			ripple.pixel_y = 2
		if(BODY_ZONE_R_ARM)
			ripple.pixel_x = -10
			ripple.pixel_y = 2
		if(BODY_ZONE_L_LEG)
			ripple.pixel_x = 4
			ripple.pixel_y = -10
		if(BODY_ZONE_R_LEG)
			ripple.pixel_x = -4
			ripple.pixel_y = -10

/// Concentric ripple effect spawned at the struck limb on shield hit.
/obj/effect/temp_visual/energy_shield_ripple
	name = "energy shield ripple"
	icon = 'icons/effects/effects.dmi'
	icon_state = "at_shield2"
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	duration = 6
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.8

/obj/effect/temp_visual/energy_shield_ripple/Initialize(mapload, atom/target)
	. = ..()
	if(target)
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, orbit), target, 0, FALSE, 0, 0, FALSE, TRUE)

/// Updates the shield health bar visible to medical HUD users.
/// Reuses existing health bar icon states from hud.dmi, colored blue.
/obj/item/clothing/accessory/energy_shield/proc/update_shield_hud()
	if(QDELETED(wearer) || !wearer.hud_list)
		return
	var/image/holder = wearer.hud_list[SHIELD_HUD]
	if(!holder)
		return
	if(!shield_active && shield_health <= 0)
		holder.icon_state = ""
		holder.color = null
		return
	var/shield_percent = (shield_health / max_shield_health) * 100
	holder.icon_state = "hud[round_shield_for_hud(shield_percent)]"
	holder.color = shield_color
	wearer.adjust_hud_position(holder)
	holder.pixel_z += SHIELD_HUD_Y_OFFSET

/// Clears the shield HUD bar on the wearer.
/obj/item/clothing/accessory/energy_shield/proc/clear_shield_hud()
	if(QDELETED(wearer) || !wearer.hud_list)
		return
	var/image/holder = wearer.hud_list[SHIELD_HUD]
	if(!holder)
		return
	holder.icon_state = ""
	holder.color = null

/// Maps shield percentage to existing health bar icon state names.
/obj/item/clothing/accessory/energy_shield/proc/round_shield_for_hud(percent)
	switch(percent)
		if(100 to INFINITY)
			return "health100"
		if(90.625 to 100)
			return "health93.75"
		if(84.375 to 90.625)
			return "health87.5"
		if(78.125 to 84.375)
			return "health81.25"
		if(71.875 to 78.125)
			return "health75"
		if(65.625 to 71.875)
			return "health68.75"
		if(59.375 to 65.625)
			return "health62.5"
		if(53.125 to 59.375)
			return "health56.25"
		if(46.875 to 53.125)
			return "health50"
		if(40.625 to 46.875)
			return "health43.75"
		if(34.375 to 40.625)
			return "health37.5"
		if(28.125 to 34.375)
			return "health31.25"
		if(21.875 to 28.125)
			return "health25"
		if(15.625 to 21.875)
			return "health18.75"
		if(9.375 to 15.625)
			return "health12.5"
		if(1 to 9.375)
			return "health6.25"
		else
			return "health0"

/// Called when shield health reaches zero. Visual and audio feedback for collapse.
/obj/item/clothing/accessory/energy_shield/proc/shield_collapse()
	if(QDELETED(wearer))
		return
	shield_active = FALSE
	hide_shield_visuals()
	update_shield_hud()
	playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
	wearer.visible_message(span_warning("[wearer]'s energy shield collapses!"))
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(do_sparks), 3, TRUE, wearer)

/// Handles passive recharge after the cooldown expires.
/obj/item/clothing/accessory/energy_shield/process(seconds_per_tick)
	if(QDELETED(wearer))
		return

	// Don't recharge or activate while disabled
	if(!enabled)
		return

	// Suppress shield while wearing heavy armor
	if(wearer_has_heavy_armor())
		if(shield_active)
			shield_active = FALSE
			hide_shield_visuals()
			update_shield_hud()
			playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
			to_chat(wearer, span_warning("Your heavy armor disrupts the energy shield!"))
		return

	// Hide hit-flash after linger expires, but only if not in recharge display mode
	if(visuals_shown && !showing_recharge && COOLDOWN_FINISHED(src, visual_cooldown))
		hide_shield_visuals()

	// Hide recharge display when shield reaches full
	if(visuals_shown && showing_recharge && shield_health >= max_shield_health)
		showing_recharge = FALSE
		hide_shield_visuals()

	if(shield_health >= max_shield_health)
		return

	if(!COOLDOWN_FINISHED(src, recharge_cooldown))
		return

	var/was_inactive = !shield_active
	shield_health = min(shield_health + (recharge_rate * seconds_per_tick), max_shield_health)

	if(was_inactive && shield_health > 0)
		shield_active = TRUE

	// Show filters and play sound when recharge starts — works at any shield percentage
	if(recharge_visual_pending)
		recharge_visual_pending = FALSE
		showing_recharge = TRUE
		playsound(wearer, 'sound/items/eshield_recharge.ogg', 50, TRUE)
		wearer.visible_message(span_notice("[wearer]'s energy shield hums back to life."))
		show_shield_visuals()

	if(visuals_shown)
		update_shield_visuals()
	update_shield_hud()

/// Action button for toggling the energy shield on/off.
/datum/action/item_action/toggle_energy_shield
	name = "Toggle Energy Shield"
	desc = "Enable or disable your energy shield projector."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_shield"

/datum/action/item_action/toggle_energy_shield/apply_button_icon(atom/movable/screen/movable/action_button/button, force)
	var/obj/item/clothing/accessory/energy_shield/shield = target
	if(istype(shield))
		button.color = shield.enabled ? shield.shield_color : "#888888"
	return ..()

#undef ENERGY_SHIELD_FILTER
#undef ENERGY_SHIELD_PATTERN_FILTER
#undef ENERGY_SHIELD_TRAIT
#undef TRAIT_ENERGY_SHIELDED
#undef SHIELD_HUD_Y_OFFSET
#undef SHIELD_VISUAL_LINGER
#undef SHIELD_MAX_ARMOR_CLASS
