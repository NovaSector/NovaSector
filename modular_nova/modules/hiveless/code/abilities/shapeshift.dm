/// Preferences skipped during shapeshift so the mob stays a hiveless mechanically.
GLOBAL_LIST_INIT(hiveless_shapeshift_skipped_prefs, list(
	/datum/preference/choiced/species,
))

/// Cosmetically reshapes the hiveless to match one of the player's saved character slots.
/datum/action/cooldown/spell/hiveless/shapeshift
	name = "Persona Shift"
	desc = "Reshape your body to match one of your own saved characters. Clothing stays where it is. Costs protein."
	button_icon_state = "transform"
	cooldown_time = 10 SECONDS
	protein_cost = HIVELESS_COST_SHAPESHIFT
	/// Spawn-time appearance, used by the revert option.
	var/datum/hiveless_persona/true_form

/datum/action/cooldown/spell/hiveless/shapeshift/Grant(mob/grant_to)
	. = ..()
	if(!owner || !ishuman(owner))
		return
	if(!true_form)
		true_form = new()
	true_form.capture(owner)

/datum/action/cooldown/spell/hiveless/shapeshift/Destroy()
	QDEL_NULL(true_form)
	return ..()

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

/datum/action/cooldown/spell/hiveless/shapeshift/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/user = owner
	if(!ishuman(user))
		return FALSE
	var/datum/preferences/prefs = user.client?.prefs
	if(!prefs)
		return FALSE
	var/list/choices = build_choices(prefs)
	if(!length(choices))
		user.balloon_alert(user, "no saved forms!")
		return FALSE
	var/picked = tgui_input_list(user, "Reshape into which form?", "Persona Shift", choices)
	if(isnull(picked))
		return FALSE
	if(!can_cast_spell(feedback = TRUE))
		return FALSE
	user.visible_message(
		span_warning("[user]'s flesh writhes and rearranges itself!"),
		span_notice("We ripple our body into a new shape..."),
		span_hear("You hear wet, fibrous rearrangement."),
	)
	if(!do_after(user, 3 SECONDS, target = user, timed_action_flags = IGNORE_HELD_ITEM))
		user.balloon_alert(user, "shapeshift interrupted!")
		return FALSE
	if(!spend_protein())
		return FALSE
	spray_cast_blood(user)
	playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	if(picked == "Revert to true form")
		revert_to_true_form(user)
	else
		apply_slot_as_form(user, prefs, choices[picked])
	user.visible_message(
		span_warning("[user] settles into a new shape!"),
		span_notice("Our flesh resettles."),
	)
	return TRUE

/// Returns an assoc list of display labels to slot numbers (plus the revert entry).
/datum/action/cooldown/spell/hiveless/shapeshift/proc/build_choices(datum/preferences/prefs)
	var/list/choices = list()
	var/list/profiles = prefs.create_character_profiles()
	for(var/slot in 1 to length(profiles))
		var/entry = profiles[slot]
		if(isnull(entry))
			continue
		var/label = "Slot [slot]: [entry]"
		choices[label] = slot
	if(true_form)
		choices["Revert to true form"] = "revert"
	return choices

/datum/action/cooldown/spell/hiveless/shapeshift/proc/apply_slot_as_form(mob/living/carbon/human/user, datum/preferences/prefs, slot_number)
	var/previous_slot = prefs.default_slot
	if(!prefs.load_character(slot_number))
		user.balloon_alert(user, "memory incomplete!")
		return
	paint_prefs_onto(prefs, user)
	// Restore the player's active slot so the character menu isn't silently reassigned mid-round.
	if(previous_slot && previous_slot != slot_number)
		prefs.load_character(previous_slot)

/datum/action/cooldown/spell/hiveless/shapeshift/proc/revert_to_true_form(mob/living/carbon/human/user)
	if(!true_form)
		return
	var/datum/preferences/prefs = user.client?.prefs
	if(prefs && true_form.original_slot)
		var/previous_slot = prefs.default_slot
		if(prefs.load_character(true_form.original_slot))
			paint_prefs_onto(prefs, user)
			if(previous_slot && previous_slot != true_form.original_slot)
				prefs.load_character(previous_slot)
			return
	// Fallback: the player never had prefs (admin spawn) or the slot is gone.
	// Paint the stored DNA back on them manually, but scrub the species bits first so we
	// don't revert the mob away from being a hiveless.
	if(true_form.dna_snapshot)
		true_form.dna_snapshot.copy_dna(user.dna, COPY_DNA_SE)
	if(true_form.real_name)
		user.real_name = true_form.real_name
		user.name = true_form.real_name
	if(true_form.voice)
		user.voice = true_form.voice
		user.voice_filter = true_form.voice_filter
	if(true_form.mob_height)
		user.set_mob_height(true_form.mob_height)
	if(true_form.age)
		user.age = true_form.age
	for(var/obj/item/bodypart/limb as anything in user.get_bodyparts())
		limb.update_limb(is_creating = TRUE)
	user.updateappearance(mutcolor_update = TRUE)
	user.update_body(is_creating = TRUE)

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
	prefs.apply_prefs_to(user, icon_updates = TRUE, do_not_apply = GLOB.hiveless_shapeshift_skipped_prefs, visuals_only = TRUE)
	user.dna.species.regenerate_organs(user, user.dna.species, visual_only = TRUE)
	user.update_body(is_creating = TRUE)
