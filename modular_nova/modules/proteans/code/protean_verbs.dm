/mob/living/carbon/proc/protean_ui()
	set name = "Open Suit UI"
	set desc = "Opens your suit UI"
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return
	if(!species.species_modsuit)
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return
	species.species_modsuit.ui_interact(src)

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
	if(!species.species_modsuit)
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(incapacitated && loc != suit)
		balloon_alert(src, "incapacitated!")
		return

	brain.replace_limbs()

/mob/living/carbon/proc/lock_suit()
	set name = "Lock Suit"
	set desc = "Locks your suit on someone"
	set category = "Protean"

	var/datum/species/protean/species = dna.species

	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return

	if(!species.species_modsuit)
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit

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

	species.species_modsuit.toggle_lock()
	to_chat(src, span_notice("You [suit.modlocked ? "<b>lock</b>" : "<b>unlock</b>"] the suit [isprotean(suit.wearer) || loc == suit ? "" : "onto [suit.wearer]"]"))
	playsound(src, 'sound/machines/click.ogg', 25)

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
	if(!species.species_modsuit)
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	if(loc == species.species_modsuit)
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit()
		else
			balloon_alert(src, "incapacitated!")

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
	if(loc == species.species_modsuit)
		to_chat(src, span_notice("You can't toggle low power when in a suit form!"))
		return
	if(!do_after(src, 2.5 SECONDS)) // Long enough to where our stomach can process inbetween activations
		src.loc.balloon_alert(src, "toggle interrupted")
		return
	var/datum/status_effect/protean_low_power_mode/effect = /datum/status_effect/protean_low_power_mode/low_power
	if(istype(has_status_effect(effect), effect))
		remove_status_effect(effect)
	else
		if(species.species_modsuit.active)
			species.species_modsuit.toggle_activate(usr, TRUE)
		// Preventing low power slowdown being removed by reform cooldown
		if(has_status_effect(/datum/status_effect/protean_low_power_mode))
			remove_status_effect(/datum/status_effect/protean_low_power_mode)
		apply_status_effect(effect)

// Hijacking and mounting features removed

/mob/living/carbon/proc/speak_through_modsuit()
	set name = "Speak Through Suit"
	set desc = "Speak to whoever is wearing your modsuit through internal speakers."
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		to_chat(src, span_warning("You are not a protean!"))
		return

	if(!species.species_modsuit)
		to_chat(src, span_warning("ERROR: Missing species modsuit! Report this bug."))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit

	// Check if someone else is wearing the suit
	if(!suit.wearer || isprotean(suit.wearer))
		to_chat(src, span_warning("Nobody else is wearing your suit!"))
		return

	// Get the message
	var/message = tgui_input_text(src, "What do you want to say through the suit's internal speakers?", "Internal Comms", max_length = 200)
	if(!message)
		return

	// Send the message to the wearer
	to_chat(suit.wearer, "<span class='robot'><b>\[Suit Internal Comms\]</b> [message]</span>")
	to_chat(src, span_notice("You broadcast through the suit's speakers: \"[message]\""))

	// Play a subtle beep to the wearer
	playsound(suit.wearer, 'sound/machines/beep/twobeep_high.ogg', 25, FALSE, SHORT_RANGE_SOUND_EXTRARANGE)

