#define MARTIALART_STREET_BOXING "street boxing"

/obj/item/melee/knuckleduster
	name = "knuckleduster"
	desc = "Weighted rings for the knuckles. While worn, you fistfight like a dishonorable \"street\" boxer, proving formidable in a brawl."
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
	/// Tracks whether the item is currently worn as gloves (used to manage bonuses and effects)
	var/is_worn_as_glove = FALSE
	/// Amount of stamina damage dealt on right-click attacks against living targets
	var/stamina_damage = 35
	/// Armor penetration value that only applies to stamina-based stun attacks
	var/stun_armour_penetration = 15
	/// The armor type checked against when performing stamina attacks (defaults to MELEE)
	var/armour_type_against_stun = MELEE
	/// What martial art do we grant when equipped?
	var/datum/martial_art/granted_style = /datum/martial_art/boxing/street

/// Sets up the martial art component and registers equipment/drop signals
/obj/item/melee/knuckleduster/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, granted_style)
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
		user.add_traits(list(TRAIT_CHUNKYFINGERS), REF(src))
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
	is_worn_as_glove = FALSE
	if(istype(user))
		user.remove_traits(list(TRAIT_CHUNKYFINGERS), REF(src))

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
	desc = "Reinforced knuckle-dusters for those who don't play fair. The added weight and reinforcement make these quite suitable for \"evil boxing,\" \
		with devastating knockout strikes being quite doable with enough training."
	icon_state = "knuckleduster_syndie"
	force = 5
	armour_penetration = 10
	wound_bonus = 14
	exposed_wound_bonus = 25
	granted_style = /datum/martial_art/boxing/evil

/// Street Boxing; for the rough-and-tumble spaceman. Has no honor, making it more lethal (and therefore unable to be used by pacifists).
/// Not as evil as evil boxing because it doesn't sleep on crit, but does a pretty hard knockdown.
/datum/martial_art/boxing/street
	name = "Street Boxing"
	id = MARTIALART_STREET_BOXING
	pacifist_style = FALSE
	honorable_boxer = FALSE
	boxing_traits = list(TRAIT_BOXING_READY)

/**
 * Our crit effect.
 * Against staggered people, if we're boxing someone who's also a boxer, we sleep for 3sec and knockdown for 6sec.
 * If not, we check if they're baton resistant:
 * If they are, we stagger for STAGGERED_SLOWDOWN_LENGTH and apply 20 stamina damage (respecting armor).
 * If they *aren't*, we knock down for 5 seconds and apply 30 stamina damage (again, respecting armor).
 * Against non-staggered people, we stagger, opening them up for further crits.
 */
/datum/martial_art/boxing/street/crit_effect(mob/living/attacker, mob/living/defender, armor_block = 0, damage_type = STAMINA, damage = 0)
	if(defender.get_timed_status_effect_duration(/datum/status_effect/staggered))
		if(HAS_TRAIT(defender, TRAIT_BOXING_READY))
			// boxer on boxer violence results in full boxing shenanigans. ggs
			defender.visible_message(
				span_danger("[attacker] knocks [defender] out with a haymaker!"),
				span_userdanger("You're knocked unconscious by [attacker]!"),
				span_hear("You hear a sickening sound of flesh hitting flesh!"),
				COMBAT_MESSAGE_RANGE,
				attacker,
			)
			to_chat(attacker, span_danger("You knock [defender] out with a haymaker!"))
			defender.apply_effect(6 SECONDS, EFFECT_KNOCKDOWN, armor_block)
			defender.SetSleeping(3 SECONDS) // this is still punishing enough i think
			log_combat(attacker, defender, "knocked out (boxing) ")
		else
			// otherwise, if baton resistant, more stagger and stamina damage
			if(HAS_TRAIT(defender, TRAIT_BATON_RESISTANCE))
				defender.visible_message(
					span_danger("[attacker] knocks [defender] down with a haymaker!"),
					span_userdanger("You're knocked down by [attacker]!"),
					span_hear("You hear a sickening sound of flesh hitting flesh!"),
					COMBAT_MESSAGE_RANGE,
					attacker,
				)
				to_chat(attacker, span_danger("You knock [defender] down with a haymaker!"))
				defender.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH, 10 SECONDS)
				defender.apply_damage(20, STAMINA, blocked = armor_block)
				log_combat(attacker, defender, "knocked down (boxing) ")
			else
			// otherwise, sit down buddy (if you got crit once you're probably lined up to eat more crits)
				defender.visible_message(
					span_danger("[attacker] knocks [defender] down with a haymaker!"),
					span_userdanger("You're knocked down by [attacker]!"),
					span_hear("You hear a sickening sound of flesh hitting flesh!"),
					COMBAT_MESSAGE_RANGE,
					attacker,
				)
				to_chat(attacker, span_danger("You knock [defender] down with a haymaker!"))
				defender.apply_effect(5 SECONDS, EFFECT_KNOCKDOWN, armor_block)
				defender.apply_damage(30, STAMINA, blocked = armor_block)
				log_combat(attacker, defender, "knocked down (boxing) ")
	else
		defender.visible_message(
			span_danger("[attacker] staggers [defender] with a haymaker!"),
			span_userdanger("You're nearly knocked off your feet by [attacker]!"),
			span_hear("You hear a sickening sound of flesh hitting flesh!"),
			COMBAT_MESSAGE_RANGE,
			attacker,
		)
		defender.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH, 10 SECONDS)
		to_chat(attacker, span_danger("You stagger [defender] with a haymaker!"))
		log_combat(attacker, defender, "staggered (boxing) ")
