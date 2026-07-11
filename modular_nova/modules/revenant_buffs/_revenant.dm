// Add a large variety of buffs and extra capabilities to the Revenant meant to make them more roleplay engaging and not just a vehicle for mechanics.

/mob/living/basic/revenant
	/// Starting essence: Buffed from 75 -> 200
	essence = 200
	/// Starting natural regen for Revenants: Buffed from 75 -> 100
	max_essence = 100
	/// Some starting essence so you aren't sitting there puppy-eyed during greenshift.
	essence_excess = 100

/// Adds languages and manifest
/mob/living/basic/revenant/proc/add_roleplay_powers()
	// Gives the manifest power
	var/datum/action/cooldown/spell/revenant_manifest/manifest_action = new(src)
	manifest_action.Grant(src)

	// Gives all languages except secret ones.
	for(var/datum/language/language_type as anything in GLOB.all_languages)
		var/datum/language/language = GLOB.language_datum_instances[language_type]
		if(isnull(language))
			continue
		if(language.secret)
			continue
		grant_language(language.type, ALL, source = LANGUAGE_SPAWNER)

// Makes you appear. For when you want to be visible while monologueing. Or stalk people spooky style.
/datum/action/cooldown/spell/revenant_manifest
	name = "Manifest"
	desc = "Manifests you into the realm of the living for all to see. Unlike your other powers, this keeps you perpetually visible until you activate this ability again."
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	button_icon_state = "r_nightvision"
	cooldown_time = 1
	spell_requirements = NONE

/datum/action/cooldown/spell/revenant_manifest/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	// This shouldn't happen.
	if(!isrevenant(owner))
		stack_trace("[type] was owned by a non-revenant mob, please don't.")
		return FALSE

	// Can't cast while CC'd.
	var/mob/living/basic/revenant/ghost = owner
	if(ghost.dormant || HAS_TRAIT(ghost, TRAIT_REVENANT_INHIBITED))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/revenant_manifest/cast(mob/living/basic/revenant/cast_on)
	. = ..()
	// Decativates if active.
	if(cast_on.has_status_effect(/datum/status_effect/revenant/revealed/manifest))
		cast_on.remove_status_effect(/datum/status_effect/revenant/revealed/manifest)
		cast_on.balloon_alert(cast_on, "unmanifested")
		return

	// If not active: applies an unique status effect responsible for the manifesting.
	cast_on.apply_status_effect(/datum/status_effect/revenant/revealed/manifest, STATUS_EFFECT_PERMANENT)
	cast_on.balloon_alert(cast_on, "manifested")
