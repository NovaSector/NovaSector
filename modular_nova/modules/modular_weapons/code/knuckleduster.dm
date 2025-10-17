// Knuckleduster that grants Evil Boxing, damage bonus, examine concealment, and chunky fingers when worn as gloves

/obj/item/melee/knuckleduster
	name = "knuckleduster"
	desc = "Weighted rings for the knuckles. While worn, you fall back on 'Evil Boxing' techniques — no rules, just results."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
	icon_state = "knuckleduster"
	inhand_icon_state = null
	worn_icon = 'icons/mob/clothing/hands.dmi'
	worn_icon_state = "black"
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	hitsound = 'sound/items/weapons/punch1.ogg'
	force = 5
	throwforce = 4
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("clocks", "smashes", "jabs", "cracks")
	attack_verb_simple = list("clock", "smash", "jab", "crack")
	armour_penetration = 5
	wound_bonus = 10
	exposed_wound_bonus = 20
	body_parts_covered = HANDS
	slot_flags = ITEM_SLOT_GLOVES
	/// Additional force when worn in the glove slot
	var/glove_force_bonus = 20
	/// Track if currently worn as gloves
	var/is_worn_as_glove = FALSE
	/// How much stamina damage we deal on a successful hit against a living, non-cyborg mob.
	var/stamina_damage = 35
	/// How much armor does our baton ignore? This operates as armour penetration, but only applies to the stun attack.
	var/stun_armour_penetration = 15
	/// What armor does our stun attack check before delivering the attack?
	var/armour_type_against_stun = MELEE

/obj/item/melee/knuckleduster/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/boxing/evil)
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(knuckle_equipped))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(knuckle_dropped))

/obj/item/melee/knuckleduster/build_worn_icon(default_layer, default_icon_file, isinhands, female_uniform, override_state, override_file, mutant_styles)
	// Return null to make completely invisible when worn
	if(!isinhands)
		return null
	return ..()

/obj/item/melee/knuckleduster/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	// Clear all overlays to make invisible
	. = list()

/obj/item/melee/knuckleduster/proc/knuckle_equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER
	if(!istype(user))
		return

	if(slot == ITEM_SLOT_GLOVES && !is_worn_as_glove)
		// Apply all glove bonuses and effects
		force += glove_force_bonus
		is_worn_as_glove = TRUE
		ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, REF(src))
		user.add_traits(list(TRAIT_CHUNKYFINGERS), REF(src))
		user.balloon_alert(user, "knuckledusters secured")
		// Make totally transparent when worn
		user.update_worn_gloves()
	else if(slot != ITEM_SLOT_GLOVES && is_worn_as_glove)
		// Remove all effects when moved to different slot
		remove_glove_effects(user)

/obj/item/melee/knuckleduster/proc/knuckle_dropped(obj/item/source, mob/user)
	SIGNAL_HANDLER
	if(is_worn_as_glove)
		remove_glove_effects(user)

/// Helper proc to remove all glove-related effects and traits
/obj/item/melee/knuckleduster/proc/remove_glove_effects(mob/user)
	force -= glove_force_bonus
	is_worn_as_glove = FALSE
	REMOVE_TRAIT(src, TRAIT_EXAMINE_SKIP, REF(src))
	if(istype(user))
		user.remove_traits(list(TRAIT_CHUNKYFINGERS), REF(src))
		user.update_worn_gloves()

/// Right-click: stamina-only jab (no brute)
/obj/item/melee/knuckleduster/pre_attack_secondary(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(. != SECONDARY_ATTACK_CALL_NORMAL)
		return .
	if(!isliving(target))
		return SECONDARY_ATTACK_CALL_NORMAL
	// zero out brute on RMB chain; we'll apply stamina in afterattack
	SET_ATTACK_FORCE(attack_modifiers, 0)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/melee/knuckleduster/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!isliving(target) || !LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	var/effective_armour_penetration = stun_armour_penetration
	var/armour_block = target.run_armor_check(null, armour_type_against_stun, null, null, effective_armour_penetration)
	var/mob/living/living_mob = target
	living_mob.apply_damage(stamina_damage, STAMINA, blocked = armour_block) // stamina_rmb_damage as inline value
	if(hitsound)
		playsound(src, hitsound, 50, TRUE)

/obj/item/melee/knuckleduster/traitor
	name = "reinforced knuckleduster"
	desc = "Reinforced knuckle-dusters for those who don't play fair. Wearing these invokes 'Evil Boxing' instincts."
	icon_state = "knuckleduster_syndie"
	force = 5
	armour_penetration = 10
	wound_bonus = 14
	exposed_wound_bonus = 25
	glove_force_bonus = 35 // Traitor version gets better bonus
