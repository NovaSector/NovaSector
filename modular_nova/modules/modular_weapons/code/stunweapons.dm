/obj/item/melee/baton/security/stun_gun/stun_knife
	name = "\improper Stun Knife"
	desc = "A small tanto style knife that has been modified with a high-voltage current running through the blade. \
			It hums softly with electric energy, and the blade itself crackles faintly when drawn. \
			Functions like a normal knife when inactive, elsewise it delivers a non-lethal electric shock on contact."
	desc_controls = "Left click to stun, right click to 'harm'."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/stunweapon.dmi'
	icon_state = "stunknifeprime"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/stun_weapon_l.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/stun_weapon_r.dmi'
	inhand_icon_state = "stunknifeprime"
	base_icon_state = "stunknifeprime"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "seclite"
	icon_angle = 0
	force = 19
	throwforce = 15
	wound_bonus = 5
	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("thrusts")
	attack_verb_simple = list("thrust")
	force_say_chance = 40
	stamina_damage = 27
	armour_type_against_stun = MELEE
	knockdown_time = null
	clumsy_knockdown_time = null
	cooldown = 0.6 SECONDS
	light_color = LIGHT_COLOR_ELECTRIC_CYAN
	light_power = 0.25
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high
	throw_stun_chance = 15
	cell_hit_cost = STANDARD_CELL_CHARGE*0.75
	convertible = FALSE
	active_changes_inhand = TRUE
	can_remove_cell = FALSE // TO DO blacklist these from rechargers, too

/obj/item/melee/baton/security/stun_gun/stun_knife/Initialize(mapload)
	. = ..()
 // TO DO: company??

/obj/item/melee/baton/security/stun_gun/stun_knife/update_icon_state()
	var/base_inhand = base_inhand_state || base_icon_state
	if(active)
		icon_state = "[base_icon_state]_on"
		if(active_changes_inhand)
			inhand_icon_state = "[base_inhand]_on"
		return ..()
	icon_state = base_icon_state
	inhand_icon_state = base_inhand
	return ..()



/obj/item/melee/baton/security/stun_gun/stun_knife/baton_effect(mob/living/target, mob/living/user, list/modifiers, stun_override)
	if(!deductcharge(cell_hit_cost))
		return FALSE
	target.set_jitter_if_lower(6 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_confusion_if_lower(5 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_stutter_if_lower(3 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_eye_blur_if_lower(5 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	var/armour_block = target.run_armor_check(null, armour_type_against_stun, null, null, stun_armour_penetration)
	target.apply_damage(stamina_damage, STAMINA, blocked = armour_block)
	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
	stun_override = FALSE

/obj/item/melee/baton/security/stun_gun/stun_knife/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.") // NOT YET

/obj/item/melee/baton/security/stun_gun/stun_knife/examine_more(mob/user)
	. = ..()

	. += "where duh lore at"

