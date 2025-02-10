/**
 * The mauling element, adapted nearly wholesale from kneecapping, replaces the item's secondary attack with an aimed attack at limbs under certain circumstances.
 *
 * Element is incompatible with non-items. Requires the parent item to have a force equal to or greater than WOUND_MINIMUM_DAMAGE.
 * Also requires that the parent can actually get past pre_secondary_attack without the attack chain cancelling.
 *
 * As kneecapping, mauling attacks have a wounding bonus between severe and critical+10 wound thresholds. Without some serious wound protecting
 * armour this all but guarantees a wound of some sort. The attack is directed specifically at a limb and the limb takes the damage.
 *
 * Requires the attacker to be aiming for a limb, which will be targeted specifically. They will than have a 3-second long
 * do_after before executing the attack.
 *
 * Mauling, much like kneecapping, requires the target to either be on the floor, immobilised or buckled to something. And also to have an appropriate limb.
 *
 * Passing all the checks will cancel the entire attack chain.
 */
/datum/element/mauling

/datum/element/mauling/Attach(datum/target)
	if(!isitem(target))
		stack_trace("Mauling element added to non-item object: \[[target]\]")
		return ELEMENT_INCOMPATIBLE

	var/obj/item/target_item = target

	if(target_item.force < WOUND_MINIMUM_DAMAGE)
		stack_trace("Mauling element added to item with too little force to wound: \[[target]\]")
		return ELEMENT_INCOMPATIBLE

	. = ..()

	if(. == ELEMENT_INCOMPATIBLE)
		return

	RegisterSignal(target, COMSIG_ITEM_ATTACK_SECONDARY , PROC_REF(try_maul_target))

/datum/element/mauling/Detach(datum/target)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK_SECONDARY)

	return ..()

/**
 * Signal handler for COMSIG_ITEM_ATTACK_SECONDARY. Does checks for pacifism, zones and target state before either returning nothing
 * if the special attack could not be attempted, performing the ordinary attack procs instead - Or cancelling the attack chain if
 * the attack can be started.
 */
/datum/element/mauling/proc/try_maul_target(obj/item/source, mob/living/carbon/target, mob/attacker, params)
	SIGNAL_HANDLER

	if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
		return

	if(!iscarbon(target))
		return

	if(!target.buckled && !HAS_TRAIT(target, TRAIT_FLOORED) && !HAS_TRAIT(target, TRAIT_IMMOBILIZED))
		return

	var/obj/item/bodypart/limb_target = target.get_bodypart(attacker.zone_selected)

	if(!limb_target)
		return

	. = COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

	INVOKE_ASYNC(src, PROC_REF(do_maul_target), source, limb_target, target, attacker)

/**
 * After a short do_after, attacker applies damage to the given limb with a significant wounding bonus, applying the weapon's force as damage.
 */
/datum/element/mauling/proc/do_maul_target(obj/item/weapon, obj/item/bodypart/limb, mob/living/carbon/target, mob/attacker)
	if(LAZYACCESS(attacker.do_afters, weapon))
		return

	attacker.visible_message(span_warning("[attacker] carefully aims [attacker.p_their()] [weapon] at [target]'s [limb.plaintext_zone]!"), span_danger("You carefully aim \the [weapon] for a swing at [target]'s [limb.plaintext_zone]!"))
	log_combat(attacker, target, "started aiming a swing to maul", weapon)

	if(do_after(attacker, 3 SECONDS, target, interaction_key = weapon))
		attacker.visible_message(span_warning("[attacker] swings [attacker.p_their()] [weapon] at [target]'s [limb.plaintext_zone]!"), span_danger("You swing \the [weapon] at [target]'s [limb.plaintext_zone]!"))
		var/wound_to_inflict = WOUND_BLUNT
		if(weapon.sharpness & SHARP_EDGED)
			wound_to_inflict = WOUND_SLASH
		else if(weapon.sharpness & SHARP_POINTY)
			wound_to_inflict = WOUND_PIERCE
		var/min_wound = limb.get_wound_threshold_of_wound_type(wound_to_inflict, WOUND_SEVERITY_SEVERE, return_value_if_no_wound = 30, wound_source = weapon)
		var/max_wound = limb.get_wound_threshold_of_wound_type(wound_to_inflict, WOUND_SEVERITY_CRITICAL, return_value_if_no_wound = 50, wound_source = weapon)

		limb.receive_damage(brute = weapon.force, wound_bonus = rand(min_wound, max_wound + 10), sharpness = weapon.sharpness, damage_source = "mauling")
		// make sure we're actually able to feel pain
		if(!target.has_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy))
			target.emote("scream")
		log_combat(attacker, target, "mauled", weapon)
		target.update_damage_overlays()
		attacker.do_attack_animation(target, used_item = weapon)
		playsound(source = get_turf(weapon), soundin = weapon.hitsound, vol = weapon.get_clamped_volume(), vary = TRUE)
