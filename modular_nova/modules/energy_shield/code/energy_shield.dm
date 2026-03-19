/// Limb color priority for energy shield glow effect
#define LIMB_COLOR_ENERGY_SHIELD 3
/// Filter name for the energy shield body tint
#define ENERGY_SHIELD_FILTER "energy_shield_tint"
/// Filter name for the energy shield hex pattern
#define ENERGY_SHIELD_PATTERN_FILTER "energy_shield_pattern"
/// Trait source for temporary blood suppression during shield absorption
#define ENERGY_SHIELD_TRAIT "energy_shield"
/// Y offset for shield HUD bar so it doesn't overlap health bar
#define SHIELD_HUD_Y_OFFSET -6

/obj/item/clothing/neck/energy_shield
	name = "energy shield necklace"
	desc = "A compact personal energy shield projector worn around the neck. Projects a protective barrier that absorbs incoming damage."
	icon_state = "modlink"
	worn_icon_state = "modlink"
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL

	/// Current shield health
	var/shield_health = 100
	/// Maximum shield health
	var/max_shield_health = 100
	/// Whether the shield overlay is active and visible
	var/shield_active = FALSE
	/// The color tint of the shield
	var/shield_color = "#00aaff"
	/// Delay before recharge begins after being hit
	var/recharge_delay = 15 SECONDS
	/// Health restored per second during recharge
	var/recharge_rate = 5
	/// Cached reference to the mob wearing this item
	var/mob/living/carbon/wearer

	COOLDOWN_DECLARE(recharge_cooldown)

/obj/item/clothing/neck/energy_shield/equipped(mob/living/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_NECK)
		return
	if(!iscarbon(user))
		return

	wearer = user
	RegisterSignal(wearer, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(on_damage_modifiers))

	if(shield_health > 0)
		shield_active = TRUE
	update_shield_visuals()
	update_shield_hud()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/neck/energy_shield/dropped(mob/living/user)
	. = ..()
	if(isnull(wearer))
		return
	UnregisterSignal(wearer, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS)
	shield_active = FALSE
	wearer.remove_filter(ENERGY_SHIELD_FILTER)
	wearer.remove_filter(ENERGY_SHIELD_PATTERN_FILTER)
	clear_shield_hud()
	STOP_PROCESSING(SSobj, src)
	wearer = null

/obj/item/clothing/neck/energy_shield/examine(mob/user)
	. = ..()
	if(shield_active)
		. += span_notice("The energy shield is active ([round((shield_health / max_shield_health) * 100)]% integrity).")
	else if(shield_health > 0)
		. += span_notice("The energy shield is recharging ([round((shield_health / max_shield_health) * 100)]% integrity).")
	else
		. += span_warning("The energy shield is offline.")

// --- DAMAGE ABSORPTION ---

/// Intercepts incoming damage via modifier system. Absorbs damage and triggers limb glow.
/obj/item/clothing/neck/energy_shield/proc/on_damage_modifiers(mob/living/carbon/source, list/damage_mods, damage, damagetype, def_zone, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(shield_health <= 0)
		return
	if(damage <= 0)
		return

	var/absorbed = min(damage, shield_health)
	var/fully_absorbed = absorbed >= damage
	if(fully_absorbed)
		damage_mods += 0
	else
		damage_mods += (damage - absorbed) / damage
	shield_health -= absorbed

	// Temporarily suppress blood splatter when fully absorbing projectile hits.
	// The trait is active for this call stack frame (apply_damage -> create_projectile_hit_effects)
	// and removed next tick via timer.
	if(fully_absorbed && !HAS_TRAIT(wearer, TRAIT_NOBLOOD))
		ADD_TRAIT(wearer, TRAIT_NOBLOOD, ENERGY_SHIELD_TRAIT)
		addtimer(CALLBACK(src, PROC_REF(remove_noblood_trait)), 0)

	COOLDOWN_START(src, recharge_cooldown, recharge_delay)

	if(isbodypart(def_zone))
		INVOKE_ASYNC(src, PROC_REF(flash_limb), def_zone)

	if(shield_health <= 0)
		INVOKE_ASYNC(src, PROC_REF(shield_collapse))
	else
		update_shield_visuals()

	update_shield_hud()

/// Removes the temporary TRAIT_NOBLOOD after the current tick.
/obj/item/clothing/neck/energy_shield/proc/remove_noblood_trait()
	if(!QDELETED(wearer))
		REMOVE_TRAIT(wearer, TRAIT_NOBLOOD, ENERGY_SHIELD_TRAIT)

// --- VISUAL EFFECTS ---

/// Briefly tints the struck limb with the shield color to indicate impact.
/obj/item/clothing/neck/energy_shield/proc/flash_limb(obj/item/bodypart/limb)
	if(QDELETED(limb) || QDELETED(wearer))
		return
	playsound(wearer, 'sound/items/weapons/tap.ogg', 20)
	limb.add_color_override(shield_color, LIMB_COLOR_ENERGY_SHIELD)
	limb.update_limb()
	wearer.update_body_parts()
	sleep(0.3 SECONDS)
	if(QDELETED(limb) || QDELETED(wearer))
		return
	limb.remove_color_override(LIMB_COLOR_ENERGY_SHIELD)
	limb.update_limb()
	wearer.update_body_parts()

/// Updates the outline filter and hex pattern layering filter on the wearer.
/obj/item/clothing/neck/energy_shield/proc/update_shield_visuals()
	if(QDELETED(wearer))
		return
	if(!shield_active || shield_health <= 0)
		wearer.remove_filter(ENERGY_SHIELD_FILTER)
		wearer.remove_filter(ENERGY_SHIELD_PATTERN_FILTER)
		return
	// Outline glow — encode alpha into color since BYOND outline filters don't support a separate alpha param
	var/tint_alpha = round((shield_health / max_shield_health) * 150 + 30)
	var/static/hex_digits = "0123456789abcdef"
	var/tint_color = "[shield_color][hex_digits[round(tint_alpha / 16) + 1]][hex_digits[(tint_alpha % 16) + 1]]"
	// Always remove and re-add to ensure color+alpha updates properly
	wearer.remove_filter(ENERGY_SHIELD_FILTER)
	wearer.add_filter(ENERGY_SHIELD_FILTER, 1, outline_filter(size = 1, color = tint_color))
	// Texture pattern clipped to body silhouette via layering_filter + BLEND_INSET_OVERLAY
	if(!wearer.get_filter(ENERGY_SHIELD_PATTERN_FILTER))
		wearer.add_filter(ENERGY_SHIELD_PATTERN_FILTER, 2, layering_filter(icon = icon('icons/mob/human/textures.dmi', "fishscale"), color = shield_color, blend_mode = BLEND_INSET_OVERLAY))

// --- SHIELD HUD ---

/// Updates the shield health bar visible to medical HUD users.
/// Reuses existing health bar icon states from hud.dmi, colored blue.
/obj/item/clothing/neck/energy_shield/proc/update_shield_hud()
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
/obj/item/clothing/neck/energy_shield/proc/clear_shield_hud()
	if(QDELETED(wearer) || !wearer.hud_list)
		return
	var/image/holder = wearer.hud_list[SHIELD_HUD]
	if(!holder)
		return
	holder.icon_state = ""
	holder.color = null

/// Maps shield percentage to existing health bar icon state names.
/obj/item/clothing/neck/energy_shield/proc/round_shield_for_hud(percent)
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

// --- SHIELD COLLAPSE & RECHARGE ---

/// Called when shield health reaches zero. Visual and audio feedback for collapse.
/obj/item/clothing/neck/energy_shield/proc/shield_collapse()
	if(QDELETED(wearer))
		return
	shield_active = FALSE
	update_shield_visuals()
	update_shield_hud()
	playsound(wearer, 'sound/vehicles/mecha/mech_shield_drop.ogg', 40, TRUE)
	wearer.visible_message(span_warning("[wearer]'s energy shield collapses!"))
	do_sparks(3, TRUE, wearer)

/// Handles passive recharge after the cooldown expires.
/obj/item/clothing/neck/energy_shield/process(seconds_per_tick)
	if(QDELETED(wearer))
		return

	if(shield_health >= max_shield_health)
		return

	if(!COOLDOWN_FINISHED(src, recharge_cooldown))
		return

	var/was_inactive = !shield_active
	shield_health = min(shield_health + (recharge_rate * seconds_per_tick), max_shield_health)

	if(was_inactive && shield_health > 0)
		shield_active = TRUE
		playsound(wearer, 'sound/items/eshield_recharge.ogg', 50, TRUE)
		wearer.visible_message(span_notice("[wearer]'s energy shield hums back to life."))

	update_shield_visuals()
	update_shield_hud()

#undef LIMB_COLOR_ENERGY_SHIELD
#undef ENERGY_SHIELD_FILTER
#undef ENERGY_SHIELD_PATTERN_FILTER
#undef ENERGY_SHIELD_TRAIT
#undef SHIELD_HUD_Y_OFFSET
