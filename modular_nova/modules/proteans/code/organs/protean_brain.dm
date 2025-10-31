#define TRANSFORM_TRAITS list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTHEAT, TRAIT_RESISTCOLD)

/**
 * HANDLES ALL OF PROTEAN EXISTENCE CODE.
 * Very snowflakey species. This is the communication chain.
 * Brain > Refactory > Modsuit Core > Modsuit
 * Brain > Orchestrator
 * Brain > Murder every other organ you try to shove in this thing.
 */

/obj/item/organ/brain/protean
	name = "protean core"
	desc = "An advanced positronic brain, typically found in the core of a protean."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "posi1"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	/// Whether or not the protean is stuck in their suit or not.
	var/dead = FALSE
	/// Timer ID for going into suit animation
	var/going_into_suit_timer
	/// Timer ID for leaving suit animation
	var/leaving_suit_timer
	COOLDOWN_DECLARE(message_cooldown)
	COOLDOWN_DECLARE(refactory_cooldown)
	COOLDOWN_DECLARE(orchestrator_cooldown)

/obj/item/organ/brain/protean/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(on_fully_healed))

/obj/item/organ/brain/protean/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_LIVING_POST_FULLY_HEAL)

/// Handler for admin heal - forces limb replacement without metal cost or suit requirement
/obj/item/organ/brain/protean/proc/on_fully_healed(datum/source, heal_flags)
	SIGNAL_HANDLER

	if(heal_flags & HEAL_ADMIN)
		INVOKE_ASYNC(src, PROC_REF(replace_limbs), TRUE)

/obj/item/organ/brain/protean/on_life(seconds_per_tick, times_fired)
	. = ..()
	if(dead)
		return
	handle_refactory(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
	handle_orchestrator(owner.get_organ_slot(ORGAN_SLOT_HEART))
	// Proteans retract into their suit when they hit hard crit
	// Check if we're already going into suit to prevent double-execution
	if(owner.stat >= HARD_CRIT && !dead && !timeleft(going_into_suit_timer))
		to_chat(owner, span_red("Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."))
		dead = TRUE
		owner.revive(list(HEAL_DAMAGE, HEAL_ORGANS), TRUE, TRUE) // So we dont get dead human inside of suit
		qdel(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
		go_into_suit(TRUE)
		owner.add_traits(list(TRAIT_CRITICAL_CONDITION)) // Just to make crew monitoring console scream
		// Start emergency recovery cycle
		revive_timer()

/// Checks if protean has refactory (stomach) organ, applies damage if missing. Deals 3 brute per tick, warns every 30s.
/obj/item/organ/brain/protean/proc/handle_refactory(obj/item/organ)
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
		return
	if(isnull(organ) || !istype(organ, /obj/item/organ/stomach/protean))
		owner.adjustBruteLoss(3, forced = TRUE)
		if(COOLDOWN_FINISHED(src, refactory_cooldown))
			to_chat(owner, span_warning("Your mass is slowly degrading without your refactory!"))
			COOLDOWN_START(src, refactory_cooldown, 30 SECONDS)

/// Checks if protean has orchestrator (heart) organ, impairs movement if missing. Knocks down and applies 2x slowdown every 30s.
/obj/item/organ/brain/protean/proc/handle_orchestrator(obj/item/organ)
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
		return
	if(!COOLDOWN_FINISHED(src, orchestrator_cooldown))
		return

	if(isnull(organ) || !istype(organ, /obj/item/organ/heart/protean))
		owner.KnockToFloor(TRUE, TRUE, 1 SECONDS)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
		to_chat(owner, span_warning("You're struggling to walk without your orchestrator!"))
	else
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)

	COOLDOWN_START(src, orchestrator_cooldown, 30 SECONDS)

/datum/movespeed_modifier/protean_slowdown
	variable = TRUE

/// Transforms protean into suit mode, moving them inside their modsuit. Protean is stunned but can speak/use radio. Takes 5s unless forced.
/obj/item/organ/brain/protean/proc/go_into_suit(forced)
	var/datum/species/protean/protean = owner.dna?.species
	if(!istype(protean) || owner.loc == protean.species_modsuit)
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = protean.species_modsuit
	if(!forced)
		if(!do_after(owner, 5 SECONDS))
			return

	// Safety check: ensure suit has a valid location before transforming
	// This handles edge cases like admin ghost spawns with backpacks
	if(!suit.loc || (!isturf(suit.loc) && suit.loc != owner))
		// Suit is in a weird state, try to fix it
		var/obj/item/back_item = owner.get_item_by_slot(ITEM_SLOT_BACK)
		if(back_item && back_item != suit)
			// Something else is in back slot, drop it
			owner.dropItemToGround(back_item, force = TRUE)
		// Make sure suit is in a valid location
		if(!suit.loc || !isturf(get_turf(suit)))
			suit.forceMove(get_turf(owner))
		// Try to equip the suit properly
		owner.equip_to_slot_if_possible(suit, ITEM_SLOT_BACK, disable_warning = TRUE)

	owner.visible_message(span_warning("[owner] retreats into [suit]!"))
	owner.extinguish_mob()
	owner.invisibility = 101
	new /obj/effect/temp_visual/protean_to_suit(owner.loc, owner.dir)
	owner.Stun(INFINITY, TRUE)
	owner.add_traits(TRANSFORM_TRAITS, PROTEAN_TRAIT)
	owner.remove_status_effect(/datum/status_effect/protean_low_power_mode/low_power)
	suit.drop_suit()
	owner.forceMove(suit)
	// Lock camera perspective to the suit
	owner.reset_perspective(suit)
	protean.prevent_perspective_change = TRUE
	// Use timer instead of sleep() to avoid blocking on_life() processing
	going_into_suit_timer = addtimer(VARSET_CALLBACK(owner, invisibility, initial(owner.invisibility)), 1.2 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)

/// Transforms protean from suit mode back to humanoid form. Takes 5s, equips suit to back, applies "Freshly Reformed" debuff.
/obj/item/organ/brain/protean/proc/leave_modsuit()
	if(timeleft(leaving_suit_timer))
		return
	var/datum/species/protean/protean = owner.dna?.species
	if(!istype(protean))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = protean.species_modsuit
	if(dead)
		to_chat(owner, span_warning("Your mass is destroyed. You are unable to leave."))
		return
	if(!do_after(owner, 5 SECONDS, suit, IGNORE_INCAPACITATED))
		return
	var/mob/living/carbon/mob = suit.loc
	if(istype(mob))
		mob.dropItemToGround(suit, TRUE)
	var/datum/storage/storage = suit.loc.atom_storage
	if(istype(storage))
		storage.remove_single(null, suit, get_turf(suit), TRUE)

	// Determine safe exit location - MUST be a turf to avoid trapping in containers
	var/turf/exit_turf = get_turf(suit)

	// If suit is inside any other container (e.g., display case), force it out
	if(!isturf(suit.loc))
		suit.forceMove(exit_turf)

	suit.invisibility = 101
	new /obj/effect/temp_visual/protean_from_suit(exit_turf, owner.dir)
	// Brief delay for visual effect using timer instead of sleep()
	leaving_suit_timer = addtimer(CALLBACK(src, PROC_REF(complete_exit_transformation), suit, exit_turf), 1.2 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)

/// Completes the exit transformation after visual effect delay
/obj/item/organ/brain/protean/proc/complete_exit_transformation(obj/item/mod/control/pre_equipped/protean/suit, turf/exit_turf)
	var/datum/species/protean/protean = owner.dna?.species
	if(!istype(protean))
		return
	suit.drop_suit()
	owner.forceMove(exit_turf)
	if(owner.get_item_by_slot(ITEM_SLOT_BACK))
		owner.dropItemToGround(owner.get_item_by_slot(ITEM_SLOT_BACK), TRUE, TRUE, TRUE)
	owner.equip_to_slot_if_possible(suit, ITEM_SLOT_BACK, disable_warning = TRUE)
	suit.invisibility = initial(suit.invisibility)
	owner.SetStun(0)
	owner.remove_traits(TRANSFORM_TRAITS, PROTEAN_TRAIT)
	// Restore camera perspective to the protean
	protean.prevent_perspective_change = FALSE
	owner.reset_perspective(owner)
	owner.apply_status_effect(/datum/status_effect/protean_low_power_mode/reform)
	owner.visible_message(span_warning("[owner] reforms from [suit]!"))
	if(!HAS_TRAIT(suit, TRAIT_NODROP))
		ADD_TRAIT(suit, TRAIT_NODROP, "protean")

/// Heals and replaces damaged limbs/organs using 6 metal sheets. Requires being in suit mode, takes 30s.
/// If force = TRUE (admin heal), bypasses all checks and costs.
/obj/item/organ/brain/protean/proc/replace_limbs(force = FALSE)
	var/obj/item/organ/stomach/protean/stomach = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/obj/item/organ/eyes/robotic/protean/eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	var/obj/item/organ/tongue/cybernetic/protean/tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	var/obj/item/organ/ears/cybernetic/protean/ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
	var/obj/item/organ/liver/protean/liver = owner.get_organ_slot(ORGAN_SLOT_LIVER)

	if(!force)
		if(stomach.metal <= PROTEAN_STOMACH_FULL * 0.6 && istype(stomach))
			to_chat(owner, span_warning("Not enough metal to heal body!"))
			return
		if(!istype(owner.loc, /obj/item/mod/control))
			to_chat(owner, span_warning("Not in the open. You must be inside your suit!"))
			return
		var/datum/species/protean/species = owner.dna.species
		if(!do_after(owner, 30 SECONDS, species.species_modsuit, IGNORE_INCAPACITATED))
			return

		stomach.metal = clamp(stomach.metal - (PROTEAN_STOMACH_FULL * 0.6), 0, 10)

	// Force mode (admin heal) - no cost, instant
	owner.fully_heal(HEAL_LIMBS)
	if(isnull(eyes))
		eyes = new /obj/item/organ/eyes/robotic/protean
		eyes.on_bodypart_insert()
		eyes.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		eyes.set_organ_damage(0)

	if(isnull(tongue))
		tongue = new /obj/item/organ/tongue/cybernetic/protean
		tongue.on_bodypart_insert()
		tongue.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		tongue.set_organ_damage(0)

	if(isnull(ears))
		ears = new /obj/item/organ/ears/cybernetic/protean
		ears.on_bodypart_insert()
		ears.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		ears.set_organ_damage(0)

	if(isnull(liver))
		liver = new /obj/item/organ/liver/protean
		liver.on_bodypart_insert()
		liver.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		liver.set_organ_damage(0)

/// Brings the protean back from "dead" state. Fully heals them and restores refactory function.
/// Called after assisted or automatic recovery.
/obj/item/organ/brain/protean/proc/revive()
	dead = FALSE
	playsound(owner, 'sound/machines/ping.ogg', 30)
	to_chat(owner, span_warning("You have regained all your mass!"))
	owner.fully_heal()
	owner.remove_traits(list(TRAIT_CRITICAL_CONDITION))

/obj/item/organ/brain/protean/proc/revive_timer()
	balloon_alert_to_viewers("repairing")

	// Notify the protean that emergency recovery has begun
	to_chat(owner, span_userdanger("<B>EMERGENCY RECOVERY CYCLE INITIATED</B>"))
	to_chat(owner, span_warning("Your core has detected critical damage and begun emergency protocols."))
	to_chat(owner, span_notice("<b>Assisted Recovery:</b> If someone installs a refactory, you will recover in <b>15 seconds</b>."))
	to_chat(owner, span_notice("<b>Auto-Recovery:</b> If left alone for <b>10-15 minutes</b>, emergency self-repair will activate."))
	to_chat(owner, span_notice("Your modsuit is currently non-functional. You can still observe and communicate."))

	addtimer(CALLBACK(src, PROC_REF(revive)), 5 MINUTES)
	// Auto self-revival after 10 minutes if unreachable
	addtimer(CALLBACK(src, PROC_REF(check_auto_revival)), 10 MINUTES)

/obj/item/organ/brain/protean/proc/check_auto_revival()
	// If they're still dead and nobody installed a refactory, auto-revive
	if(!dead)
		return

	var/datum/species/protean/species = owner?.dna.species
	if(!istype(species))
		return

	var/obj/item/organ/stomach/protean/stomach = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(stomach) // Someone helped them
		return

	// Check if anyone is nearby who could help
	var/mob/living/nearby_help = null
	for(var/mob/living/potential_helper in orange(7, species.species_modsuit))
		if(potential_helper.stat == CONSCIOUS && potential_helper.client)
			nearby_help = potential_helper
			break

	if(nearby_help)
		// Someone is nearby but hasn't helped - give them more time
		addtimer(CALLBACK(src, PROC_REF(check_auto_revival)), 5 MINUTES)
		to_chat(owner, span_notice("Emergency protocols detecting nearby lifeforms... Delaying auto-recovery for <b>5 more minutes</b> to allow assistance."))
		return

	// Nobody around to help, auto-revive with minimal metal
	to_chat(owner, span_userdanger("<B>EMERGENCY SELF-REPAIR ACTIVATED</B>"))
	to_chat(owner, span_notice("No assistance detected within range. Fabricating minimal refactory from reserve nanite materials..."))
	to_chat(owner, span_boldwarning("WARNING: You will recover with only 1 unit of metal. Find more immediately!"))
	species.species_modsuit.visible_message(span_warning("[species.species_modsuit] emits a series of mechanical whirs and clicks as it begins emergency self-repair!"))

	// Create a basic refactory with minimal metal
	var/obj/item/organ/stomach/protean/emergency_stomach = new()
	emergency_stomach.metal = 1 // Start with only 1 metal - they'll need to find more
	emergency_stomach.Insert(owner, TRUE, DELETE_IF_REPLACED)

	addtimer(CALLBACK(src, PROC_REF(revive)), 30 SECONDS) // Give them time to see the messages

/obj/effect/temp_visual/protean_to_suit
	name = "to_suit"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "to_puddle"
	duration = 12

/obj/effect/temp_visual/protean_from_suit
	name = "from_suit"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "from_puddle"
	duration = 12

/obj/item/organ/brain/protean/emp_act(severity) // technically, a protean brain isn't a cybernetic brain, so it's not inherting the normal cybernetic proc.
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(owner.stat == DEAD)
		return
	switch(severity)
		if (EMP_HEAVY)
			to_chat(owner, span_boldwarning("Your core nanites [pick("buzz erratically", "surge chaotically")]!"))
			owner.set_drugginess_if_lower(40 SECONDS)
		if (EMP_LIGHT)
			to_chat(owner, span_warning("Your core nanites feel [pick("fuzzy", "unruly", "sluggish")]."))
			owner.set_drugginess_if_lower(20 SECONDS)

#undef TRANSFORM_TRAITS

