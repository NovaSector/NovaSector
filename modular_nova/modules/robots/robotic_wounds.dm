/datum/wound/robotic_bleed
	name = "Robotic Bleed Wound"
	undiagnosed_name = "Leak"
	sound_effect = 'modular_nova/modules/robots/sounds/oil_leak.ogg'
	processes = TRUE
	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient

/datum/wound/robotic_bleed/on_xadone(power)
	return null

/datum/wound_pregen_data/robot_pierce_slash
	abstract = TRUE

	required_limb_biostate = BIO_ROBOTIC
	require_any_biostate = TRUE

	required_wounding_type = WOUND_PIERCE_AND_SLASH

	wound_series = WOUND_SERIES_ROBOT_PIERCE_SLASH

/datum/wound_pregen_data/robot_pierce_slash/wounding_types_valid(suggested_wounding_type)
	return suggested_wounding_type == WOUND_PIERCE || suggested_wounding_type == WOUND_SLASH

/datum/wound/robotic_bleed/proc/get_blood_noun()
	var/noun_blood = "blood"
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.dna.blood_type.reagent_type)
			var/datum/reagent/blood_reagent = human_victim.dna.blood_type.reagent_type
			noun_blood = initial(lowertext(blood_reagent.name))
	return noun_blood

/datum/wound/robotic_bleed/get_self_check_description(self_aware)
	var/blood_noun = get_blood_noun()
	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return span_danger("It's leaking [blood_noun] from a small [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_MODERATE)
			return span_warning("It's leaking [blood_noun] from a [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_SEVERE)
			return span_boldwarning("It's leaking [blood_noun] from a serious [LOWER_TEXT(undiagnosed_name || name)]!")
		if(WOUND_SEVERITY_CRITICAL)
			return span_boldwarning("It's leaking [blood_noun] from a major [LOWER_TEXT(undiagnosed_name || name)]!!")

/datum/wound/robotic_bleed/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	if(limb.can_bleed() && attack_direction)
		victim.spray_blood(attack_direction, severity)
	return ..()

/datum/wound/robotic_bleed/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat == DEAD || !limb.can_bleed() || !victim.blood_volume || !prob(internal_bleeding_chance + wounding_dmg))
		return
	var/blood_noun = get_blood_noun()
	var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient) // 12 brute toolbox can cause up to 15/18/21 bloodloss on mod/sev/crit
	switch(blood_bled)
		if(1 to 6)
			victim.bleed(blood_bled, TRUE)
		if(7 to 13)
			victim.visible_message(
				span_smalldanger("[blood_noun] droplets fly from the hole in [victim]'s [limb.plaintext_zone]."),
				span_danger("You leak a bit of [blood_noun] from the blow to your [limb.plaintext_zone]."),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.bleed(blood_bled, TRUE)
		if(14 to 19)
			victim.visible_message(
				span_smalldanger("A small stream of [blood_noun] spurts from the hole in [victim]'s [limb.plaintext_zone]!"),
				span_danger("You leak a string of [blood_noun] from the blow to your [limb.plaintext_zone]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.create_splatter(victim.dir)
			victim.bleed(blood_bled)
		if(20 to INFINITY)
			victim.visible_message(
				span_danger("A spray of [blood_noun] streams from the hole in [victim]'s [limb.plaintext_zone]!"),
				span_bolddanger("You leak a spray of [blood_noun] from the blow to your [limb.plaintext_zone]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.bleed(blood_bled)
			victim.create_splatter(victim.dir)
			victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/robotic_bleed/moderate
	name = "Misaligned Coolant Tube"
	desc = "A cooolant tube has slipped out of place and is leaking."
	treat_text = "Apply percussive maintenance to the part to get the tubing back in place."
	treat_text_short = "Hit it with something blunt, like a toolbox."
	examine_desc = "is dribbling coolant from the tubing seal."
	occur_text = "starts dribbling coolant from the tubing seal"
	severity = WOUND_SEVERITY_MODERATE
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	simple_treat_text = "<b>Applying percussive maintenance</b> to the damaged part will help get the tubing back in place."
	homemade_treat_text = "<b>Applying percussive maintenance</b> to the damaged part will help get the tubing back in place."

/datum/wound/robotic_bleed/moderate/get_limb_examine_description()
	return span_warning("The coolant tube on this limb appears to be misaligned.")

/datum/wound_pregen_data/robot_pierce_slash/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/robotic_bleed/moderate
	threshold_minimum = 30

/datum/wound/robotic_bleed/moderate/receive_damage(wounding_type, wounding_dmg, wound_bonus, attack_direction, damage_source)
	if(wounding_type == WOUND_BLUNT)
		var/obj/item/possible_wrench = damage_source
		var/multiplier = 1
		if(istype(possible_wrench) && possible_wrench.tool_behaviour == TOOL_WRENCH)
			multiplier = 2 // gotta move that gear up
		if(prob(((wounding_dmg + wound_bonus) * 2) * multiplier))
			victim.balloon_alert_to_viewers("tubing re-aligned")
			remove_wound()
			return
	..()

/datum/wound/robotic_bleed/severe
	name = "Coolant Tube Hole"
	desc = "The coolant tube on this part is cut open, leaking coolant everywhere.."
	treat_text = "Apply duct tape(or any other kind of tape) to the tubing to repair it."
	treat_text_short = "Apply duct tape to the limb."
	examine_desc = "is pierced clear through, with coolant spewing from the damaged tubing"
	occur_text = "looses a violent spray of blood, revealing a pierced wound"
	severity = WOUND_SEVERITY_SEVERE
	treatable_tools = list(TOOL_DUCTTAPE)
	base_treat_time = 3 SECONDS
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	threshold_penalty = 35
	status_effect_type = /datum/status_effect/wound/pierce/severe

	simple_treat_text = "<b>Duct-taping</b> the hole shut will stop the bleeding."
	homemade_treat_text = "You can use any kind of tape to seal the hole."

/datum/wound/robotic_bleed/severe/get_limb_examine_description()
	return span_warning("The coolant tube on this limb appears to be sliced open.")

/datum/wound/robotic_bleed/severe/treat(obj/item/I, mob/user)
	victim.balloon_alert_to_viewers("taping hole")
	playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)
	if(do_after(user, base_treat_time, victim))
		var/obj/item/stack/medical/wrap/sticky_tape/duct_tape = I
		duct_tape.use(1)
		victim.balloon_alert_to_viewers("hole taped")
		qdel(src)
	else
		victim.balloon_alert_to_viewers("failed to tape hole!")

/datum/wound_pregen_data/robot_pierce_slash/severe
	abstract = FALSE

	wound_path_to_generate = /datum/wound/robotic_bleed/severe

	threshold_minimum = 50

/datum/wound/robotic_bleed/critical
	name = "Shredded Coolant Tubing"
	desc = "The part's coolant tubing is completely shredded beyond any hope of repair."
	treat_text = "Rubber coolant tubes are nearly impossible to source. Replace the limb entirely with a fresh, undamaged limb. Detatch the limb surgically \
	or remove it via blunt force trauma."
	treat_text_short = "Replace the limb."
	examine_desc = "'s coolant tube is completely shredded beyond any hope of repair."
	occur_text = "shreds the coolant tube into ribbons, spewing coolant everywhere."
	severity = WOUND_SEVERITY_CRITICAL
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.75
	threshold_penalty = 50
	status_effect_type = /datum/status_effect/wound/pierce/critical

	simple_treat_text = "<b>Replace the limb</b>."
	homemade_treat_text = "Sufficient damage to the limb will knock it off of the chassis, but you risk leaking a lot of oil doing so."

/datum/wound_pregen_data/robot_pierce_slash/critical
	abstract = FALSE

	wound_path_to_generate = /datum/wound/robotic_bleed/critical

	threshold_minimum = 100

/datum/wound/robotic_blunt
	name = "Robotic Blunt Wound"
	undiagnosed_name = "Smash"
	sound_effect = 'modular_nova/modules/robots/sounds/blunt_robot.ogg'

/datum/wound/robotic_blunt/on_xadone(power)
	return null

/datum/wound_pregen_data/robot_blunt_burn
	abstract = TRUE

	required_limb_biostate = BIO_ROBOTIC
	require_any_biostate = TRUE
	required_wounding_type = WOUND_BLUNT_AND_BURN

	wound_series = WOUND_SERIES_ROBOT_BLUNT_BURN

/datum/wound/robotic_blunt/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	do_sparks(2, FALSE, victim)
	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message(span_danger("[victim]'s [limb.plaintext_zone] drops [I] and sparks!"), span_warning("<b>The actuators in your [limb.plaintext_zone] malfunction, causing you to drop [I]!</b>"), vision_distance=COMBAT_MESSAGE_RANGE)
	update_inefficiencies()
	return ..()

/datum/wound/robotic_blunt/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOB_FIRED_GUN))
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(attack_with_hurt_hand))
		RegisterSignal(new_victim, COMSIG_MOB_FIRED_GUN, PROC_REF(firing_with_messed_up_hand))

	return ..()

/datum/wound/robotic_blunt/remove_wound(ignore_limb, replaced = FALSE, destroying = FALSE)
	limp_slowdown = 0
	limp_chance = 0
	return ..()

/datum/wound/robotic_blunt/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	SIGNAL_HANDLER

	if(victim.get_active_hand() != limb || !proximity || !victim.combat_mode || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return NONE

	// With a severe or critical wound, you have a 15% or 30% chance to proc pain on hit
	if(prob((severity - 1) * 15))
		// And you have a 70% or 50% chance to actually land the blow, respectively
		if(prob(70 - 20 * (severity - 1)))
			to_chat(victim, span_danger("The actuators in your [limb.plaintext_zone] spark and malfunction as you strike [target]!"))
			do_sparks(2, FALSE, victim)
			victim.apply_damage(rand(1, 5), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
		else
			victim.visible_message(span_danger("[victim] weakly strikes [target] with [victim.p_their()] broken [limb.plaintext_zone], sparks flying!"), \
			span_userdanger("You fail to strike [target] as the actuators in your [limb.plaintext_zone] catch and lock up!"), vision_distance=COMBAT_MESSAGE_RANGE)
			do_sparks(2, FALSE, victim)
			victim.Stun(0.5 SECONDS)
			victim.apply_damage(rand(3, 7), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
			return COMPONENT_CANCEL_ATTACK_CHAIN

	return NONE

/datum/wound/robotic_blunt/proc/firing_with_messed_up_hand(datum/source, obj/item/gun/gun, atom/firing_at, params, zone, bonus_spread_values)
	SIGNAL_HANDLER

	switch(limb.body_zone)
		if(BODY_ZONE_L_ARM)
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_LEFT_INDEX(victim.get_held_index_of_item(gun)))
				return
		if(BODY_ZONE_R_ARM)
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_RIGHT_INDEX(victim.get_held_index_of_item(gun)))
				return
		else
			return

	if(gun.recoil > 0 && severity >= WOUND_SEVERITY_SEVERE && prob(25 * (severity - 1)))
		to_chat(victim, span_danger("The actuators in your [limb.plaintext_zone] spark and malfunction as [gun] kicks back!"))
		victim.apply_damage(rand(1, 3) * (severity - 1) * gun.weapon_weight, BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
		do_sparks(2, FALSE, victim)
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += (15 * severity)


/datum/wound/robotic_blunt/moderate
	name = "Dented Frame"
	undiagnosed_name = "Dent"
	a_or_from = "a"
	desc = "Part has been dented from blunt force being applied, causing limping or reduced dexterity, and sparks."
	treat_text = "Apply percussive maintenance to the dented part to hammer it back into the correct shape."
	treat_text_short = "Hit it with something blunt, like a toolbox."
	examine_desc = "is dented"
	occur_text = "sparks, revealing a large dent"
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.3
	limp_slowdown = 3
	limp_chance = 50
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/blunt/bone/moderate

	simple_desc = "Part has been dented from blunt force being applied, causing limping or reduced dexterity, and sparks."
	simple_treat_text = "<b>Applying percussive maintenance</b> to the damaged part will help get the metal back in shape."
	homemade_treat_text = "<b>Applying percussive maintenance</b> to the damaged part will help get the metal back in shape."
	var/hit = FALSE

/datum/wound/robotic_blunt/moderate/get_limb_examine_description()
	return span_warning("The limb has a dent in it.")

/datum/wound/robotic_blunt/moderate/receive_damage(wounding_type, wounding_dmg, wound_bonus, attack_direction, damage_source)
	if(!hit) // prevents immediate wound healing
		hit = TRUE
		return ..()
	if(wounding_type == WOUND_BLUNT)
		var/obj/item/possible_wrench = damage_source
		var/multiplier = 1
		if(istype(possible_wrench) && possible_wrench.tool_behaviour == TOOL_WRENCH)
			multiplier = 2 // gotta move that gear up
		if(prob(((wounding_dmg + wound_bonus) * 2) * multiplier))
			victim.balloon_alert_to_viewers("dent fixed")
			remove_wound()
			return
	..()

/datum/wound_pregen_data/robot_blunt_burn/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/robotic_blunt/moderate
	threshold_minimum = 30

/datum/wound/robotic_blunt/severe
	name = "Broken Panel Latch"
	desc = "The part's paneling latch has been broken open and the wiring is exposed."
	treat_text = "Apply duct tape(or any other kind of tape) to the panel latch to hold it shut."
	treat_text_short = "Apply duct tape to the part."
	examine_desc = "has exposed wiring, the access panel hanging open"
	occur_text = "'s access panel swings open as the latch is smashed to pieces"
	treatable_tools = list(TOOL_DUCTTAPE)
	base_treat_time = 3 SECONDS
	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60
	threshold_penalty = 30
	status_effect_type = /datum/status_effect/wound/blunt/bone/severe
	simple_desc = "The part's paneling latch has been broken open, drastically reducing part functionality."
	simple_treat_text = "<b>Duct-taping</b> the panel shut will fix the damage."
	homemade_treat_text = "You can use any kind of tape to seal the panel."

/datum/wound/robotic_blunt/severe/treat(obj/item/I, mob/user)
	victim.balloon_alert_to_viewers("taping panel shut")
	playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)
	if(do_after(user, base_treat_time, victim))
		var/obj/item/stack/medical/wrap/sticky_tape/duct_tape = I
		duct_tape.use(1)
		victim.balloon_alert_to_viewers("panel taped shut")
		qdel(src)
	else
		victim.balloon_alert_to_viewers("failed to tape panel shut!")

/datum/wound_pregen_data/robot_blunt_burn/severe
	abstract = FALSE

	wound_path_to_generate = /datum/wound/robotic_blunt/severe

	threshold_minimum = 60

/datum/wound/robotic_blunt/critical
	name = "Smashed Circuitry"
	desc = "The part's circuitry has been smashed to bits; the part is completely unusable and needs replaced."
	treat_text = "Robotic limb replacement circuits are nearly impossible to source on their own. Replace the part entirely with a fresh, undamaged part.\
	Detatch the part surgically or remove it via blunt force trauma."
	treat_text_short = "Replace the limb."
	examine_desc = "is smashed to pieces, completely unusable."
	occur_text = "shatters, circuitboards, connectors, and chunks of metal falling to the floor"

	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 2.5
	limp_slowdown = 7
	limp_chance = 70
	threshold_penalty = 15
	disabling = TRUE

	simple_desc = "The part's circuitry has been smashed to bits, causing total immobilization of the part."
	simple_treat_text = "<b>Replace the limb</b>."
	homemade_treat_text = "Sufficient damage to the limb will knock it off of the chassis, but you risk leaking a lot of oil doing so."

/datum/wound_pregen_data/robot_blunt_burn/critical
	abstract = FALSE

	wound_path_to_generate = /datum/wound/robotic_blunt/critical

	threshold_minimum = 115
