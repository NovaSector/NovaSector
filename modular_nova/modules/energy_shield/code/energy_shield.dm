/// Filter name for the energy shield outline glow
#define ENERGY_SHIELD_FILTER "energy_shield_tint"
/// Filter name for the energy shield texture pattern
#define ENERGY_SHIELD_PATTERN_FILTER "energy_shield_pattern"
/// Trait source for the energy shield
#define ENERGY_SHIELD_TRAIT "energy_shield"
/// Trait applied to wearer to prevent stacking multiple shields
#define TRAIT_ENERGY_SHIELDED "energy_shielded"
/// Y offset for shield HUD bar so it doesn't overlap health bar
#define SHIELD_HUD_Y_OFFSET 6
/// How long the shield filters stay visible after a hit
#define SHIELD_VISUAL_LINGER 1.5 SECONDS

/obj/item/clothing/accessory/energy_shield
	name = "energy shield projector"
	desc = "A compact personal energy shield projector. Can be clipped onto clothing as an accessory. Projects a protective barrier that absorbs incoming damage."
	icon = 'icons/obj/clothing/neck.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "modlink"
	worn_icon_state = "modlink"
	slot_flags = NONE
	attachment_slot = NONE
	above_suit = FALSE
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF
	actions_types = list(/datum/action/item_action/toggle_energy_shield)
	/// Grant the action button when attached as accessory on jumpsuit
	action_slots = ITEM_SLOT_ICLOTHING

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
	/// Maximum armor rating on outer clothing before the shield refuses to activate (default)
	var/max_armor_class = 10
	/// Whether the shield is enabled by the user (toggle via action button)
	var/enabled = TRUE
	/// Fraction of shield health retained after an EMP (0 = full wipe, 0.5 = halved)
	var/emp_retention = 0
	/// Whether the shield blocks projectile damage
	var/blocks_projectiles = TRUE
	/// Whether the shield blocks melee damage
	var/blocks_melee = TRUE
	/// Whether shield visuals stay on continuously while active (until collapse)
	var/persistent_visuals = FALSE
	/// Damage absorbed in the current hit, pending application in on_after_damage
	var/pending_absorption = 0
	/// Bodypart struck in the pending hit (for visual effects)
	var/obj/item/bodypart/pending_def_zone

	COOLDOWN_DECLARE(recharge_cooldown)
	/// Controls how long filters linger after a hit
	COOLDOWN_DECLARE(visual_cooldown)

/obj/item/clothing/accessory/energy_shield/Destroy()
	if(wearer)
		UnregisterSignal(wearer, list(COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_MOB_AFTER_APPLY_DAMAGE, COMSIG_LIVING_CHECK_BLOCK))
		REMOVE_TRAIT(wearer, TRAIT_ENERGY_SHIELDED, ENERGY_SHIELD_TRAIT)
		hide_shield_visuals()
		clear_shield_hud()
		wearer = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/// Returns TRUE if the wearer's outer clothing has LASER, ENERGY, or BULLET armor above class II.
/obj/item/clothing/accessory/energy_shield/proc/wearer_has_heavy_armor()
	if(!iscarbon(wearer))
		return FALSE
	var/obj/item/clothing/suit = wearer.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(isnull(suit))
		return FALSE
	if(suit.get_armor_rating(MELEE) > max_armor_class)
		return TRUE
	if(suit.get_armor_rating(LASER) > max_armor_class)
		return TRUE
	if(suit.get_armor_rating(ENERGY) > max_armor_class)
		return TRUE
	if(suit.get_armor_rating(BULLET) > max_armor_class)
		return TRUE
	return FALSE

/obj/item/clothing/accessory/energy_shield/successful_attach(obj/item/clothing/under/attached_to)
	. = ..()
	RegisterSignal(attached_to, COMSIG_ATOM_EXAMINE, PROC_REF(on_uniform_examined))

/obj/item/clothing/accessory/energy_shield/detach(obj/item/clothing/under/detach_from)
	UnregisterSignal(detach_from, COMSIG_ATOM_EXAMINE)
	return ..()

/// Handles activation when attached as an accessory on a jumpsuit.
/// accessory_equipped() calls equipped(), so this single override covers it.
/obj/item/clothing/accessory/energy_shield/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_ICLOTHING))
		return
	if(!iscarbon(user))
		return
	if(HAS_TRAIT(user, TRAIT_ENERGY_SHIELDED))
		return

	wearer = user
	ADD_TRAIT(wearer, TRAIT_ENERGY_SHIELDED, ENERGY_SHIELD_TRAIT)
	RegisterSignal(wearer, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(on_damage_modifiers))
	RegisterSignal(wearer, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(on_pre_bullet))
	RegisterSignal(wearer, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(on_after_damage))
	RegisterSignal(wearer, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_check_block))

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
	UnregisterSignal(wearer, list(COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_MOB_AFTER_APPLY_DAMAGE, COMSIG_LIVING_CHECK_BLOCK))
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
	. += get_shield_status_text()

/// Returns a span-formatted string describing the shield's current status.
/obj/item/clothing/accessory/energy_shield/proc/get_shield_status_text()
	if(!enabled)
		return span_warning("The energy shield is disabled.")
	if(shield_active)
		return span_notice("The energy shield is active ([round((shield_health / max_shield_health) * 100)]% integrity).")
	if(shield_health > 0)
		return span_notice("The energy shield is recharging ([round((shield_health / max_shield_health) * 100)]% integrity).")
	return span_warning("The energy shield is offline.")

/// Appends shield status when examining the uniform this shield is attached to.
/obj/item/clothing/accessory/energy_shield/proc/on_uniform_examined(obj/item/clothing/under/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += get_shield_status_text()

/// Toggles the shield on/off via the action button.
/obj/item/clothing/accessory/energy_shield/ui_action_click(mob/user, datum/action/action)
	if(!enabled)
		enabled = TRUE
		if(wearer_has_heavy_armor())
			enabled = FALSE
			to_chat(wearer, span_warning("The [src] fails to activate — your armor is too heavy for the energy field to form."))
		else if(wearer)
			COOLDOWN_START(src, recharge_cooldown, recharge_delay)
			recharge_visual_pending = TRUE
			to_chat(wearer, span_notice("You activate the energy shield. It will begin charging shortly."))
	else
		enabled = FALSE
		if(shield_active)
			shield_active = FALSE
			shield_health = 0
			showing_recharge = FALSE
			hide_shield_visuals()
			update_shield_hud()
			playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
		to_chat(wearer, span_notice("You deactivate the energy shield."))
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
	COOLDOWN_START(src, recharge_cooldown, recharge_delay)
	if(shield_health <= 0)
		shield_collapse()
	else
		update_shield_hud()

/// Shared post-hit logic: deducts shield health, triggers cooldowns, visuals, and collapse check.
/obj/item/clothing/accessory/energy_shield/proc/apply_shield_hit(absorbed, obj/item/bodypart/limb)
	shield_health -= absorbed
	COOLDOWN_START(src, recharge_cooldown, recharge_delay)
	recharge_visual_pending = TRUE
	showing_recharge = FALSE
	if(!persistent_visuals)
		COOLDOWN_START(src, visual_cooldown, SHIELD_VISUAL_LINGER)
		show_shield_visuals()
	update_shield_visuals()
	shield_hit_effect(limb)
	if(shield_health <= 0)
		shield_collapse()
	update_shield_hud()

/// Absorbs projectile damage and stamina with the shield. Brute first, then stamina with leftover.
/// Fully blocked projectiles return COMPONENT_BULLET_BLOCKED (prevents wounds/embed/blood).
/// Partially absorbed projectiles have their damage/stamina reduced and proceed normally.
/obj/item/clothing/accessory/energy_shield/proc/on_pre_bullet(mob/living/carbon/source, obj/projectile/proj, def_zone, piercing_hit)
	SIGNAL_HANDLER

	if(!blocks_projectiles)
		return
	if(shield_health <= 0 || !shield_active)
		return
	var/total_damage = proj.damage + proj.stamina
	if(total_damage <= 0)
		return

	var/remaining_shield = shield_health
	// Absorb brute first
	var/brute_absorbed = min(proj.damage, remaining_shield)
	remaining_shield -= brute_absorbed
	// Then stamina with whatever shield is left
	var/stamina_absorbed = min(proj.stamina, remaining_shield)

	var/total_absorbed = brute_absorbed + stamina_absorbed
	var/obj/item/bodypart/limb = wearer.get_bodypart(check_zone(def_zone))
	apply_shield_hit(total_absorbed, limb)

	// Reduce the projectile's damage for whatever passes through
	proj.damage -= brute_absorbed
	proj.stamina -= stamina_absorbed

	// Fully absorbed — block the bullet entirely
	if(proj.damage <= 0 && proj.stamina <= 0)
		return COMPONENT_BULLET_BLOCKED

/// Fully blocks melee and thrown attacks when the shield can absorb the entire hit.
/// Mirrors on_pre_bullet for projectiles — prevents wounds, embeds, and blood naturally.
/obj/item/clothing/accessory/energy_shield/proc/on_check_block(mob/living/carbon/source, atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	if(!blocks_melee)
		return FAILED_BLOCK
	if(shield_health <= 0 || !shield_active)
		return FAILED_BLOCK
	if(damage <= 0 || shield_health < damage)
		return FAILED_BLOCK

	var/obj/item/bodypart/limb
	var/mob/living/attacker = isliving(hit_by) ? hit_by : GET_ASSAILANT(hit_by)
	if(attacker)
		limb = wearer.get_bodypart(check_zone(attacker.zone_selected))
	if(!limb)
		limb = wearer.get_bodypart(check_zone(wearer.get_random_valid_zone(BODY_ZONE_CHEST, 65)))
	apply_shield_hit(damage, limb)
	return SUCCESSFUL_BLOCK

/// Computes the damage modifier for melee/self-attack shield absorption.
/// Projectiles are fully handled by on_pre_bullet — this skips them.
/// Full melee blocks are handled by on_check_block.
/// This covers partial melee absorption and self-attacks (where check_block is skipped).
/// Must remain pure — side effects are in on_after_damage via COMSIG_MOB_AFTER_APPLY_DAMAGE.
/obj/item/clothing/accessory/energy_shield/proc/on_damage_modifiers(mob/living/carbon/source, list/damage_mods, damage, damagetype, def_zone, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(shield_health <= 0)
		return
	if(damage <= 0)
		return
	// Projectiles are handled entirely by on_pre_bullet (brute + stamina absorption)
	if(isprojectile(attacking_item))
		return
	// Only absorb external attacks (melee, thrown) — not embeds, wounds, or reagent damage.
	// External attacks have an attack_direction or an attacking_item; internal sources have neither.
	if(isnull(attack_direction) && isnull(attacking_item))
		return
	if(!blocks_melee)
		return

	var/absorbed = min(damage, shield_health)
	pending_absorption = absorbed
	pending_def_zone = isbodypart(def_zone) ? def_zone : wearer.get_bodypart(check_zone(def_zone))
	// Use a tiny minimum so apply_damage doesn't early-return at 0, allowing on_after_damage to fire
	damage_mods += max((damage - absorbed) / damage, 0.001)

/// Applies shield health deduction and visual/audio feedback after damage is dealt.
/// Consumes the pending absorption computed by on_damage_modifiers.
/obj/item/clothing/accessory/energy_shield/proc/on_after_damage(mob/living/carbon/source, damage_dealt, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(pending_absorption <= 0)
		return

	var/absorbed = pending_absorption
	var/hit_limb = pending_def_zone
	pending_absorption = 0
	pending_def_zone = null

	apply_shield_hit(absorbed, hit_limb)

/// Builds a "#RRGGBBAA" color string with alpha proportional to current shield health.
/obj/item/clothing/accessory/energy_shield/proc/get_shield_tint_color()
	var/tint_alpha = shield_health > 0 ? round((shield_health / max_shield_health) * 200 + 5) : 5
	var/static/hex_digits = "0123456789abcdef"
	return "[shield_color][hex_digits[round(tint_alpha / 16) + 1]][hex_digits[(tint_alpha % 16) + 1]]"

/// Applies outline glow and texture pattern filters to the wearer.
/obj/item/clothing/accessory/energy_shield/proc/show_shield_visuals()
	if(visuals_shown)
		return
	visuals_shown = TRUE
	wearer.add_filter(ENERGY_SHIELD_FILTER, 1, outline_filter(size = 1, color = get_shield_tint_color()))
	wearer.add_filter(ENERGY_SHIELD_PATTERN_FILTER, 2, layering_filter(icon = icon('icons/mob/human/textures.dmi', "fishscale"), color = shield_color, blend_mode = BLEND_INSET_OVERLAY))

/// Removes the outline glow and texture pattern filters from the wearer.
/obj/item/clothing/accessory/energy_shield/proc/hide_shield_visuals()
	if(!visuals_shown)
		return
	visuals_shown = FALSE
	wearer.remove_filter(ENERGY_SHIELD_FILTER)
	wearer.remove_filter(ENERGY_SHIELD_PATTERN_FILTER)

/// Updates the outline filter alpha to reflect current shield health.
/obj/item/clothing/accessory/energy_shield/proc/update_shield_visuals()
	if(!visuals_shown)
		return
	wearer.remove_filter(ENERGY_SHIELD_FILTER)
	wearer.add_filter(ENERGY_SHIELD_FILTER, 1, outline_filter(size = 1, color = get_shield_tint_color()))

/// Flashes the wearer with the shield color and spawns a ripple at the struck limb's position.
/obj/item/clothing/accessory/energy_shield/proc/shield_hit_effect(obj/item/bodypart/limb)
	playsound(wearer, 'sound/items/weapons/tap.ogg', 20)
	var/original_color = wearer.color
	wearer.color = shield_color
	animate(wearer, color = original_color, time = 0.3 SECONDS)
	// Spawn concentric ripple at the hit limb's position
	if(limb)
		INVOKE_ASYNC(src, PROC_REF(spawn_shield_ripple), limb)

/// Spawns the concentric ripple effect at a limb's position. Separate proc because new() can yield.
/obj/item/clothing/accessory/energy_shield/proc/spawn_shield_ripple(obj/item/bodypart/limb)
	if(!wearer)
		return
	var/turf/wearer_turf = get_turf(wearer)
	if(!wearer_turf)
		return
	var/obj/effect/temp_visual/energy_shield_ripple/ripple = new(wearer_turf, wearer)
	ripple.color = shield_color
	// Scale ripple with mob height and body size
	var/mob/living/carbon/human/human_wearer = wearer
	var/scale = 0.35 * wearer.current_size * (istype(human_wearer) ? (human_wearer.mob_height / HUMAN_HEIGHT_MEDIUM) : 1)
	// Offset to the struck limb's approximate position on the sprite
	var/off_x = 0
	var/off_y = 0
	switch(limb.body_zone)
		if(BODY_ZONE_HEAD)
			off_y = 14
		if(BODY_ZONE_L_ARM)
			off_x = 10
			off_y = 2
		if(BODY_ZONE_R_ARM)
			off_x = -10
			off_y = 2
		if(BODY_ZONE_L_LEG)
			off_x = 4
			off_y = -16
		if(BODY_ZONE_R_LEG)
			off_x = -4
			off_y = -16
	ripple.transform = matrix(scale, 0, off_x * scale, 0, scale, off_y * scale)

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
	if(!wearer?.hud_list)
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
	if(!wearer?.hud_list)
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
	shield_active = FALSE
	hide_shield_visuals()
	update_shield_hud()
	playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
	wearer.visible_message(span_warning("[wearer]'s energy shield collapses!"))
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(do_sparks), 3, TRUE, wearer)

/// Handles passive recharge after the cooldown expires.
/obj/item/clothing/accessory/energy_shield/process(seconds_per_tick)
	// Don't recharge or activate while disabled
	if(!enabled)
		return

	// Disable shield while wearing heavy armor
	if(wearer_has_heavy_armor())
		enabled = FALSE
		shield_active = FALSE
		shield_health = 0
		showing_recharge = FALSE
		hide_shield_visuals()
		update_shield_hud()
		playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
		to_chat(wearer, span_warning("Your heavy armor disrupts the energy shield! Disabling.."))
		return

	if(!persistent_visuals)
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
		if(persistent_visuals)
			show_shield_visuals()

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
	return ..()

#undef ENERGY_SHIELD_FILTER
#undef ENERGY_SHIELD_PATTERN_FILTER
#undef ENERGY_SHIELD_TRAIT
#undef TRAIT_ENERGY_SHIELDED
#undef SHIELD_HUD_Y_OFFSET
#undef SHIELD_VISUAL_LINGER
