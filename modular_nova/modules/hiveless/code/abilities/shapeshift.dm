/// Cosmetically reshapes the hiveless to match one of the player's saved character slots.
/datum/action/cooldown/spell/hiveless/shapeshift
	name = "Persona Shift"
	desc = "Reshape your body to match one of your own saved characters. Clothing stays where it is. Costs protein."
	button_icon_state = "transform"
	cooldown_time = 10 SECONDS
	protein_cost = HIVELESS_COST_SHAPESHIFT
	/// Preferences skipped when painting a new persona
	var/static/list/skipped_prefs = list(
		/datum/preference/choiced/species,
	)
	/// Saved-slot index selected for the current cast.
	var/selected_slot

/datum/action/cooldown/spell/hiveless/shapeshift/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(owner))
		if(feedback)
			owner.balloon_alert(owner, "wrong shape!")
		return FALSE
	if(!owner.client?.prefs)
		if(feedback)
			owner.balloon_alert(owner, "no memories to shape into!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/hiveless/shapeshift/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return .
	var/mob/living/carbon/human/user = owner
	if(!ishuman(user))
		return .|SPELL_CANCEL_CAST
	var/datum/preferences/prefs = user.client?.prefs
	if(!prefs)
		return .|SPELL_CANCEL_CAST
	var/list/choices = build_choices(prefs)
	if(!length(choices))
		user.balloon_alert(user, "no saved forms!")
		return .|SPELL_CANCEL_CAST
	var/picked = tgui_input_list(user, "Reshape into which form?", "Persona Shift", choices)
	if(isnull(picked))
		return .|SPELL_CANCEL_CAST
	if(!can_cast_spell(feedback = TRUE))
		return .|SPELL_CANCEL_CAST
	selected_slot = choices[picked]
	user.visible_message(
		span_warning("[user]'s flesh writhes and rearranges itself!"),
		span_notice("We ripple our body into a new shape..."),
		span_hear("You hear wet, fibrous rearrangement."),
	)
	if(!do_after(user, 3 SECONDS, target = user, timed_action_flags = IGNORE_HELD_ITEM))
		user.balloon_alert(user, "shapeshift interrupted!")
		selected_slot = null
		return .|SPELL_CANCEL_CAST
	if(!spend_protein())
		selected_slot = null
		return .|SPELL_CANCEL_CAST
	return .

/datum/action/cooldown/spell/hiveless/shapeshift/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/user = owner
	if(!ishuman(user))
		return FALSE
	var/datum/preferences/prefs = user.client?.prefs
	if(!prefs || isnull(selected_slot))
		return FALSE
	spray_cast_blood(user)
	playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	apply_slot_as_form(user, prefs, selected_slot)
	selected_slot = null
	user.visible_message(
		span_warning("[user] settles into a new shape!"),
		span_notice("Our flesh resettles."),
	)
	return TRUE

/// Returns an assoc list of display labels to their savefile slot numbers.
/datum/action/cooldown/spell/hiveless/shapeshift/proc/build_choices(datum/preferences/prefs)
	var/list/choices = list()
	var/list/profiles = prefs.create_character_profiles()
	for(var/slot in 1 to length(profiles))
		var/entry = profiles[slot]
		if(isnull(entry))
			continue
		var/label = "Slot [slot]: [entry]"
		choices[label] = slot
	return choices

/datum/action/cooldown/spell/hiveless/shapeshift/proc/apply_slot_as_form(mob/living/carbon/human/user, datum/preferences/prefs, slot_number)
	var/previous_slot = prefs.default_slot
	if(!prefs.load_character(slot_number))
		if(previous_slot && previous_slot != slot_number)
			prefs.load_character(previous_slot)
		user.balloon_alert(user, "memory incomplete!")
		return
	paint_prefs_onto(prefs, user)
	// Restore the player's active slot so the character menu isn't silently reassigned mid-round.
	if(previous_slot && previous_slot != slot_number)
		prefs.load_character(previous_slot)

/// Applies `prefs` to `user` for a cosmetic-only persona swap. Strips out the old persona's
/// bodypart-overlay organs (snouts, ears, tails, wings, etc.) and resets mutant bodyparts
/// and body markings to species defaults, so the new prefs apply pass can build the target
/// persona's features from a clean slate and then regenerate_organs re-adds the new organs.
/datum/action/cooldown/spell/hiveless/shapeshift/proc/paint_prefs_onto(datum/preferences/prefs, mob/living/carbon/human/user)
	for(var/obj/item/organ/old_organ as anything in user.organs)
		if(!old_organ.bodypart_overlay)
			continue
		old_organ.Remove(user, special = TRUE)
		qdel(old_organ)
	if(user.dna?.species)
		user.dna.mutant_bodyparts = user.dna.species.get_mutant_bodyparts(user.dna.features)
		user.dna.body_markings = list()
	prefs.apply_prefs_to(user, icon_updates = TRUE, do_not_apply = skipped_prefs, visuals_only = TRUE)
	user.dna.species.regenerate_organs(user, user.dna.species, visual_only = TRUE)
	user.update_body(is_creating = TRUE)
