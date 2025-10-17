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
	/// Additional force bonus applied when worn in the glove slot
	var/glove_force_bonus = 20
	/// Tracks whether the item is currently worn as gloves (used to manage bonuses and effects)
	var/is_worn_as_glove = FALSE
	/// Amount of stamina damage dealt on right-click attacks against living targets
	var/stamina_damage = 35
	/// Armor penetration value that only applies to stamina-based stun attacks
	var/stun_armour_penetration = 15
	/// The armor type checked against when performing stamina attacks (defaults to MELEE)
	var/armour_type_against_stun = MELEE

/// Sets up the martial art component and registers equipment/drop signals
/obj/item/melee/knuckleduster/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/boxing/evil)
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(knuckle_equipped))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(knuckle_dropped))

/**
 * Overrides worn icon generation to make the knuckledusters invisible when worn as gloves.
 * Returns null for worn sprites to achieve complete concealment on the character sprite.
 */
/obj/item/melee/knuckleduster/build_worn_icon(default_layer, default_icon_file, isinhands, female_uniform, override_state, override_file, mutant_styles)
	if(!isinhands)
		return null // Make invisible when worn as gloves
	return ..()

/**
 * Clears all worn overlays to ensure complete invisibility when equipped.
 * Works in conjunction with build_worn_icon() for total concealment.
 */
/obj/item/melee/knuckleduster/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	. = list() // Clear all overlays for invisibility

/**
 * Signal handler for when the knuckledusters are equipped.
 * Applies bonuses and effects when worn in the glove slot, including:
 * - Increased force damage
 * - Examine concealment (TRAIT_EXAMINE_SKIP)
 * - Chunky fingers trait to prevent fine manipulation
 *
 * Arguments:
 * * source - The item being equipped (src)
 * * user - The mob equipping the item
 * * slot - The inventory slot the item is being equipped to
 */
/obj/item/melee/knuckleduster/proc/knuckle_equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER
	if(!istype(user))
		return

	if(slot == ITEM_SLOT_GLOVES && !is_worn_as_glove)
		force += glove_force_bonus
		is_worn_as_glove = TRUE
		ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, REF(src))
		user.add_traits(list(TRAIT_CHUNKYFINGERS), REF(src))
		user.balloon_alert(user, "knuckledusters secured")
		user.update_worn_gloves()
	else if(slot != ITEM_SLOT_GLOVES && is_worn_as_glove)
		remove_glove_effects(user)

/**
 * Signal handler for when the knuckledusters are dropped or unequipped.
 * Ensures all glove effects are properly removed.
 *
 * Arguments:
 * * source - The item being dropped (src)
 * * user - The mob dropping the item
 */
/obj/item/melee/knuckleduster/proc/knuckle_dropped(obj/item/source, mob/user)
	SIGNAL_HANDLER
	if(is_worn_as_glove)
		remove_glove_effects(user)

/**
 * Removes all glove-related bonuses, effects, and traits.
 * Called when the knuckledusters are unequipped from the glove slot.
 *
 * Arguments:
 * * user - The mob that was wearing the knuckledusters
 */
/obj/item/melee/knuckleduster/proc/remove_glove_effects(mob/user)
	force -= glove_force_bonus
	is_worn_as_glove = FALSE
	REMOVE_TRAIT(src, TRAIT_EXAMINE_SKIP, REF(src))
	if(istype(user))
		user.remove_traits(list(TRAIT_CHUNKYFINGERS), REF(src))
		user.update_worn_gloves()

/**
 * Handles right-click attacks to perform non-lethal stamina damage instead of brute.
 * Zeros out the brute force damage for right-click attacks; stamina is applied in afterattack().
 *
 * Arguments:
 * * target - The atom being attacked
 * * user - The mob performing the attack
 * * modifiers - List of click modifiers (contains RIGHT_CLICK info)
 * * attack_modifiers - List of attack parameters that can be modified
 *
 * Returns SECONDARY_ATTACK_CONTINUE_CHAIN to proceed with the attack chain
 */
/obj/item/melee/knuckleduster/pre_attack_secondary(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(. != SECONDARY_ATTACK_CALL_NORMAL)
		return .
	if(!isliving(target))
		return SECONDARY_ATTACK_CALL_NORMAL
	SET_ATTACK_FORCE(attack_modifiers, 0) // Zero out brute damage for stamina attack
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/**
 * Applies stamina damage on right-click attacks against living targets.
 * Checks armor with penetration before applying stamina damage and plays hit sound.
 *
 * Arguments:
 * * target - The atom being attacked
 * * user - The mob performing the attack
 * * modifiers - List of click modifiers (checked for RIGHT_CLICK)
 * * attack_modifiers - List of attack parameters
 */
/obj/item/melee/knuckleduster/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!isliving(target) || !LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	var/mob/living/living_mob = target
	var/effective_armour_penetration = stun_armour_penetration
	var/armour_block = living_mob.run_armor_check(null, armour_type_against_stun, null, null, effective_armour_penetration)
	living_mob.apply_damage(stamina_damage, STAMINA, blocked = armour_block)
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
	glove_force_bonus = 35 // Enhanced bonus for traitor version
