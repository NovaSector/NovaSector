/**
 * The mauling element, adapted nearly wholesale from kneecapping, replaces the item's secondary attack with an aimed attack at limbs under certain circumstances.
 *
 * Element is incompatible with non-items. Requires the parent item to have a force equal to or greater than WOUND_MINIMUM_DAMAGE.
 * Also requires that the parent can actually get past pre_secondary_attack without the attack chain cancelling.
 *
 * As kneecapping, mauling attacks have a wounding bonus between severe and critical+10 wound thresholds. Without some serious wound protecting
 * armour this all but guarantees a wound of some sort. The attack is directed specifically at a limb and the limb takes the damage.
 *
 * Requires the attacker to be aiming for a limb, which will be targeted specifically.
 * They will than have a do_after determined by `swing_delay` before executing the attack.
 * The attack may have a damage multiplier, determined by `mauling_damage_mult`.
 *
 * Mauling, much like kneecapping, requires the target to either be on the floor, immobilised or buckled to something. And also to have an appropriate limb.
 *
 * Passing all the checks will cancel the entire attack chain.
 */
/datum/element/mauling
	/// How long do we wind up our swing for?
	var/swing_delay = 2 SECONDS
	/// What multiplier do we apply to our force on a successful mauling?
	var/mauling_damage_mult = 1.5

/datum/element/mauling/Attach(datum/target, swing_delay, mauling_damage_mult)

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

	src.swing_delay = swing_delay
	src.mauling_damage_mult = mauling_damage_mult

	RegisterSignal(target, COMSIG_ITEM_ATTACK_SECONDARY, PROC_REF(try_maul_target))

/datum/element/mauling/Detach(datum/target)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK_SECONDARY)

	return ..()

/**
 * Signal handler for COMSIG_ITEM_ATTACK_SECONDARY. Does checks for pacifism and valid target before either returning nothing
 * if the special attack could not be attempted, performing the ordinary attack procs instead,
 * or cancelling the attack chain if the attack can be started.
 */
/datum/element/mauling/proc/try_maul_target(obj/item/source, mob/living/carbon/target, mob/attacker, params)
	SIGNAL_HANDLER

	if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
		return

	if(!iscarbon(target))
		return

	. = COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

	INVOKE_ASYNC(src, PROC_REF(do_maul_target), source, target, attacker)

/**
 * After a short do_after, attacker applies damage to the given limb with a significant wounding bonus,
 * applying the weapon's force (multiplied by `mauling_damage_mult`) as damage.
 */
/datum/element/mauling/proc/do_maul_target(obj/item/weapon, mob/living/carbon/target, mob/attacker)
	if(LAZYACCESS(attacker.do_afters, weapon))
		return

	var/obj/item/bodypart/limb_target = target.get_bodypart(attacker.zone_selected)
	if(!limb_target)
		return

	attacker.changeNext_move(CLICK_CD_MELEE) // let's not stack swings that easily, pal
	// question: should the windup be reduced if the target is incapacitated, somehow?

	attacker.visible_message(span_warning("[attacker] carefully aims [weapon] at [target]'s [limb_target.plaintext_zone]!"), span_danger("You carefully aim [weapon] at [target]'s [limb_target.plaintext_zone]!"))
	log_combat(attacker, target, "started aiming to maul", weapon)

	if(!do_after(attacker, swing_delay, target, interaction_key = weapon))
		return

	attacker.visible_message(span_warning("[attacker] swings [weapon] at [target]'s [limb_target.plaintext_zone]!"), span_danger("You swing \the [weapon] at [target]'s [limb_target.plaintext_zone]!"))
	var/wound_to_inflict = WOUND_BLUNT
	if(weapon.sharpness & SHARP_EDGED)
		wound_to_inflict = WOUND_SLASH
	else if(weapon.sharpness & SHARP_POINTY)
		wound_to_inflict = WOUND_PIERCE
	else if(weapon.damtype == BURN)
		wound_to_inflict = WOUND_BURN
	var/min_wound = limb_target.get_wound_threshold_of_wound_type(wound_to_inflict, WOUND_SEVERITY_SEVERE, return_value_if_no_wound = 30, wound_source = weapon)
	var/max_wound = limb_target.get_wound_threshold_of_wound_type(wound_to_inflict, WOUND_SEVERITY_CRITICAL, return_value_if_no_wound = 50, wound_source = weapon)

	target.apply_damage(weapon.force * mauling_damage_mult, weapon.damtype, limb_target, wound_bonus = rand(min_wound, max_wound + 10), sharpness = weapon.sharpness, attacking_item = weapon)

	// make sure we're actually able to feel pain
	if(!target.has_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy))
		target.emote("scream")

	log_combat(attacker, target, "mauled", weapon)
	target.update_damage_overlays()
	attacker.do_attack_animation(target, used_item = weapon)
	playsound(source = get_turf(weapon), soundin = weapon.hitsound, vol = weapon.get_clamped_volume(), vary = TRUE)
