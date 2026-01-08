/// Opens the protean modsuit UI interface. Allows access to suit modules, power, and settings.
/mob/living/carbon/proc/protean_ui()
	set name = "Open Suit UI"
	set desc = "Opens your suit UI"
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return
	if(!species.get_modsuit())
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return
	species.get_modsuit().ui_interact(src)

/// Heals and replaces damaged limbs/organs. Requires 6 metal sheets and being in suit mode. Takes 30 seconds.
/mob/living/carbon/proc/protean_heal()
	set name = "Heal Organs and Limbs"
	set desc = "Heals your replacable organs and limbs with 6 metal."
	set category = "Protean"

	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		to_chat(src, span_warning("You need a protean core to use this ability!"))
		return

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return
	if(!species.get_modsuit())
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = species.get_modsuit()
	if(incapacitated && loc != suit)
		balloon_alert(src, "incapacitated!")
		return

	brain.replace_limbs()

/// Locks/unlocks the modsuit on another person, preventing them from removing it. Requires their OOC consent via preferences.
/mob/living/carbon/proc/lock_suit()
	set name = "Lock Suit"
	set desc = "Locks your suit on someone"
	set category = "Protean"

	var/datum/species/protean/species = dna.species

	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return

	if(!species.get_modsuit())
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.get_modsuit()

	if(!suit.wearer || isprotean(suit.wearer))
		to_chat(src, span_warning("Your suit is not on someone else!"))
		return

	// Check if locking (not unlocking)
	if(!suit.modlocked)
		// Check if wearer has opted in
		if(suit.wearer.client?.prefs)
			var/allow_lock = suit.wearer.client.prefs.read_preference(/datum/preference/toggle/allow_protean_lock)
			if(!allow_lock)
				to_chat(src, span_warning("[suit.wearer]'s biometrics reject the lock command!"))
				to_chat(src, span_notice("The suit's safety protocols prevent involuntary locking."))
				to_chat(suit.wearer, span_notice("You feel the modsuit attempt to lock, but your biometric safety override prevents it."))
				suit.wearer.balloon_alert(suit.wearer, "lock rejected!")
				return

	species.get_modsuit().toggle_lock()
	var/action = suit.modlocked ? "lock" : "unlock"
	var/target_suffix = (!isprotean(suit.wearer) && loc != suit) ? " onto [suit.wearer]" : ""
	to_chat(src, span_notice("You <b>[action]</b> the suit[target_suffix]."))
	playsound(src, 'sound/machines/click.ogg', 25)

/// Toggles between humanoid and suit mode. Humanoid can move, suit mode provides protection but stuns. Takes 5 seconds.
/mob/living/carbon/proc/suit_transformation()
	set name = "Toggle Suit Transformation"
	set desc = "Either leave or enter your suit."
	set category = "Protean"
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		to_chat(src, span_warning("You need a protean core to use this ability!"))
		return
	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return
	if(!species.get_modsuit())
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	if(loc == species.get_modsuit())
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit()
		else
			balloon_alert(src, "incapacitated!")

/// Toggles low power mode to conserve metal at the cost of movement speed. Cannot be used in suit mode.
/mob/living/carbon/proc/low_power()
	set name = "Toggle Low Power Mode"
	set desc = "Toggle whether you are running on low power mode."
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		return
	var/obj/item/organ/stomach/protean/stomach = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach))
		to_chat(src, span_warning("You are missing a stomach and can't turn on low power mode"))
		return
	if(loc == species.get_modsuit())
		to_chat(src, span_notice("You can't toggle low power when in a suit form!"))
		return
	if(!do_after(src, 2.5 SECONDS)) // Long enough to where our stomach can process inbetween activations
		src.loc.balloon_alert(src, "toggle interrupted")
		return
	var/datum/status_effect/protean_low_power_mode/effect = /datum/status_effect/protean_low_power_mode/low_power
	if(istype(has_status_effect(effect), effect))
		remove_status_effect(effect)
	else
		if(species.get_modsuit().active)
			species.get_modsuit().toggle_activate(usr, TRUE)
		// Preventing low power slowdown being removed by reform cooldown
		if(has_status_effect(/datum/status_effect/protean_low_power_mode))
			remove_status_effect(/datum/status_effect/protean_low_power_mode)
		apply_status_effect(effect)

// Hijacking and mounting features removed

/// Sends a message through the modsuit's internal speakers to whoever is wearing it. Protean-only communication channel.
/mob/living/carbon/proc/speak_through_modsuit()
	set name = "Speak Through Suit"
	set desc = "Speak to whoever is wearing your modsuit through internal speakers."
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return

	if(!species.get_modsuit())
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.get_modsuit()

	// Check if someone else is wearing the suit
	if(!suit.wearer || isprotean(suit.wearer))
		to_chat(src, span_warning("Nobody else is wearing your suit!"))
		return

	// Get the message
	var/message = tgui_input_text(src, "What do you want to say through the suit's internal speakers?", "Internal Comms", max_length = 200)
	if(!message)
		return

	// Log the message for admin oversight
	src.log_message("(SUIT COMMS to [key_name(suit.wearer)]): [message]", LOG_SUBTLER)
	suit.wearer.log_message("(SUIT COMMS from [key_name(src)]): [message]", LOG_SUBTLER)

	// Send the message to the wearer
	to_chat(suit.wearer, "<span class='robot'><b>\[Suit Internal Comms\]</b> [message]</span>")
	to_chat(src, span_notice("You broadcast through the suit's speakers: \"[message]\""))

	// Play a subtle beep to the wearer
	playsound(suit.wearer, 'sound/machines/beep/twobeep_high.ogg', 25, FALSE, SHORT_RANGE_SOUND_EXTRARANGE)

/// Ejects an assimilated modsuit, returning it and all its modules to the original owner. Takes 4 seconds.
/mob/living/carbon/proc/eject_assimilated_modsuit()
	set name = "Eject Assimilated Modsuit"
	set desc = "Eject the modsuit you have assimilated, returning it to its original form."
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return

	if(!species.get_modsuit())
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.get_modsuit()

	if(!suit.stored_modsuit)
		to_chat(src, span_warning("You haven't assimilated any modsuit!"))
		return

	suit.unassimilate_modsuit(src)

