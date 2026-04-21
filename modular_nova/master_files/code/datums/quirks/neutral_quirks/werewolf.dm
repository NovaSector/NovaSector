/// Toggle-style shapeshifting quirk: grants a cooldown action that reshapes the owner into an
/// anthropomorphic canine form (mutant parts, digitigrade legs, taur if applicable, height bump,
/// scale bump, genital variants) and back. Does NOT swap species — keeps the transform cosmetic
/// so it can't be used to bypass species-gated content.
/datum/quirk/werewolf
	name = "Werewolf"
	desc = "A beastly affliction allows you to shape-shift into a large anthropomorphic canine at will."
	value = 0
	gain_text = span_notice("You feel the full moon beckon.")
	lose_text = span_notice("The moon's call hushes into silence.")
	medical_record_text = "Patient has been reported howling at the night sky."
	mob_trait = TRAIT_WEREWOLF
	icon = FA_ICON_PAW

/datum/quirk/werewolf/add(client/client_source)
	var/datum/action/cooldown/werewolf_transform/toggle = new(quirk_holder)
	toggle.Grant(quirk_holder)

/datum/quirk/werewolf/remove()
	var/datum/action/cooldown/werewolf_transform/toggle = locate() in quirk_holder.actions
	if(QDELETED(toggle))
		return
	if(toggle.transformed && ishuman(quirk_holder))
		toggle.revert_form(quirk_holder)
	qdel(toggle)

/datum/action/cooldown/werewolf_transform
	name = "Toggle Lycanthrope Form"
	desc = "Reshape your body into a wolfish form, or back again."
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "transform"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_PHASED
	cooldown_time = 5 SECONDS
	/// TRUE while the owner is currently in wolf form.
	var/transformed = FALSE
	/// Everything we need to restore the owner exactly on revert — populated by apply_form.
	var/list/saved_state
	/// Gender-specific prefix baked into the transformation flavor text.
	var/werewolf_gender = "Lycan"
	/// Sprite-accessory names we swap to on transform, keyed by feature.
	var/static/list/wolf_feature_names = list(
		FEATURE_EARS = "Wolf",
		FEATURE_TAIL = "Otusian",
		FEATURE_SNOUT = "Sergal",
	)
	/// Genital accessory names we swap to on transform, keyed by organ slot.
	var/static/list/wolf_genital_names = list(
		ORGAN_SLOT_PENIS = "Knotted",
		ORGAN_SLOT_VAGINA = "Furred",
	)
	/// Flat color applied to a knotted penis in wolf form.
	var/static/wolf_penis_color = "#ff7c80"
	/// Size we force the knotted penis to in wolf form.
	var/static/wolf_penis_size = 6
	/// Fallback additive body_size bump, used when the caster has no client / preference.
	var/static/wolf_scale_delta_fallback = 0.2
	/// Hard cap on body_size after the bump — prevents runaway growth on already-large mobs.
	var/static/wolf_scale_cap = 1.5

/datum/action/cooldown/werewolf_transform/Activate(atom/target)
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/user = owner
	user.Shake(pixelshiftx = 0.2, pixelshifty = 0.2, duration = 1 SECONDS)
	if(transformed)
		user.visible_message(span_danger("[user] shrinks, [user.p_their()] wolfish features quickly receding."))
		revert_form(user)
	else
		apply_form(user)
		user.visible_message(span_danger("[user] shivers, [user.p_their()] flesh bursting with a sudden growth of thick fur as [user.p_their()] features contort to that of a beast, fully transforming [user.p_them()] into a [werewolf_gender]wulf!"))
	transformed = !transformed
	StartCooldown()
	return TRUE

/// Snapshots the owner's relevant state, then applies every wolf-form mutation in one pass.
/datum/action/cooldown/werewolf_transform/proc/apply_form(mob/living/carbon/human/user)
	werewolf_gender = gender_prefix(user.gender)
	var/list/colors = wolf_mutant_colors(user)
	saved_state = list(
		"custom_species" = user.dna.features["custom_species"],
		"legs" = user.dna.features[FEATURE_LEGS],
		"blooper_id" = user.blooper_id,
		"mob_height" = user.get_base_mob_height(),
		"body_size" = user.dna.features["body_size"] || BODY_SIZE_NORMAL,
		"mutant_color" = user.dna.features[FEATURE_MUTANT_COLOR],
		"mutant_color_two" = user.dna.features[FEATURE_MUTANT_COLOR_TWO],
		"mutant_color_three" = user.dna.features[FEATURE_MUTANT_COLOR_THREE],
		"mutant_bodyparts" = list(),
		"genitals" = list(),
		"legs_changed" = FALSE,
	)
	for(var/feature_key in wolf_feature_names)
		saved_state["mutant_bodyparts"][feature_key] = user.dna.mutant_bodyparts[feature_key]
		user.dna.mutant_bodyparts[feature_key] = build_mutant_part(wolf_feature_names[feature_key], colors)
	// Tint the main body sprite too, for species that render with TRAIT_MUTANT_COLORS (lizards,
	// vulpkanins, etc). No effect on fixed-color or skin-tone-based species.
	user.dna.features[FEATURE_MUTANT_COLOR] = colors[1]
	user.dna.features[FEATURE_MUTANT_COLOR_TWO] = colors[2]
	user.dna.features[FEATURE_MUTANT_COLOR_THREE] = colors[3]
	user.dna.features["custom_species"] = "[werewolf_gender]wulf"
	user.set_blooper("Pugg")
	// Only switch taur if the owner already has one — don't grow taur legs on a biped.
	var/datum/mutant_bodypart/existing_taur = user.dna.mutant_bodyparts[FEATURE_TAUR]
	if(existing_taur)
		saved_state["mutant_bodyparts"][FEATURE_TAUR] = existing_taur
		user.dna.mutant_bodyparts[FEATURE_TAUR] = build_mutant_part("Canine", colors)
	if(user.dna.species?.digitigrade_customization == DIGITIGRADE_OPTIONAL && user.dna.features[FEATURE_LEGS] != DIGITIGRADE_LEGS)
		user.dna.features[FEATURE_LEGS] = DIGITIGRADE_LEGS
		saved_state["legs_changed"] = TRUE
	apply_wolf_genitals(user, colors)
	user.set_mob_height(min(user.get_base_mob_height() + 2, HUMAN_HEIGHT_TALLEST), update_dna = FALSE)
	// Bump body_size by the caster's chosen delta preference, clamped at wolf_scale_cap.
	// update_body_size handles transform Scale + southern-bound translation + maptext_height in
	// one pass, and writes back to dna.current_body_size so the revert is exact.
	var/size_delta = user.client?.prefs?.read_preference(/datum/preference/numeric/werewolf_size_delta)
	if(isnull(size_delta))
		size_delta = wolf_scale_delta_fallback
	var/current_body_size = user.dna.features["body_size"] || BODY_SIZE_NORMAL
	var/target_body_size = min(current_body_size + size_delta, wolf_scale_cap)
	if(target_body_size > current_body_size)
		user.dna.features["body_size"] = target_body_size
		user.dna.update_body_size()
	user.dna.species.regenerate_organs(user, user.dna.species, visual_only = TRUE)
	if(saved_state["legs_changed"])
		// replace_body is expensive but required for the leg-geometry swap.
		user.dna.species.replace_body(user, user.dna.species)
	user.update_body(is_creating = TRUE)

/// Restores the exact state captured by apply_form.
/datum/action/cooldown/werewolf_transform/proc/revert_form(mob/living/carbon/human/user)
	if(!islist(saved_state))
		return
	user.dna.features["custom_species"] = saved_state["custom_species"]
	user.dna.features[FEATURE_MUTANT_COLOR] = saved_state["mutant_color"]
	user.dna.features[FEATURE_MUTANT_COLOR_TWO] = saved_state["mutant_color_two"]
	user.dna.features[FEATURE_MUTANT_COLOR_THREE] = saved_state["mutant_color_three"]
	var/list/saved_parts = saved_state["mutant_bodyparts"]
	for(var/key in saved_parts)
		user.dna.mutant_bodyparts[key] = saved_parts[key]
	if(saved_state["blooper_id"])
		user.set_blooper(saved_state["blooper_id"])
	if(saved_state["legs_changed"])
		user.dna.features[FEATURE_LEGS] = saved_state["legs"]
	revert_wolf_genitals(user)
	user.set_mob_height(saved_state["mob_height"], update_dna = FALSE)
	user.dna.features["body_size"] = saved_state["body_size"]
	user.dna.update_body_size()
	user.dna.species.regenerate_organs(user, user.dna.species, visual_only = TRUE)
	if(saved_state["legs_changed"])
		user.dna.species.replace_body(user, user.dna.species)
	user.update_body(is_creating = TRUE)
	saved_state = null

/// Snapshots and swaps each genital organ present on the mob to its wolf-variant accessory.
/// Breasts get only a color tint (no wolf-specific accessory); the penis also gets a fixed
/// wolf color and size bump.
/datum/action/cooldown/werewolf_transform/proc/apply_wolf_genitals(mob/living/carbon/human/user, list/colors)
	for(var/organ_slot in wolf_genital_names)
		var/obj/item/organ/genital/organ = user.get_organ_slot(organ_slot)
		if(isnull(organ))
			continue
		saved_state["genitals"][organ_slot] = list(
			"mutant_bodypart" = user.dna.mutant_bodyparts[organ_slot],
			"size" = organ.genital_size,
			"color" = organ.color,
		)
		user.dna.mutant_bodyparts[organ_slot] = build_mutant_part(wolf_genital_names[organ_slot], colors)
		organ.build_from_dna(user.dna, organ_slot)
		if(organ_slot == ORGAN_SLOT_PENIS)
			organ.color = wolf_penis_color
			organ.set_size(wolf_penis_size)
	var/obj/item/organ/genital/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts)
		saved_state["genitals"][ORGAN_SLOT_BREASTS] = list("color" = breasts.color)
		breasts.color = colors[1]
		breasts.update_sprite_suffix()

/datum/action/cooldown/werewolf_transform/proc/revert_wolf_genitals(mob/living/carbon/human/user)
	var/list/saved_genitals = saved_state["genitals"]
	for(var/organ_slot in wolf_genital_names)
		var/list/snapshot = saved_genitals[organ_slot]
		var/obj/item/organ/genital/organ = user.get_organ_slot(organ_slot)
		if(isnull(organ) || !islist(snapshot))
			continue
		user.dna.mutant_bodyparts[organ_slot] = snapshot["mutant_bodypart"]
		organ.build_from_dna(user.dna, organ_slot)
		organ.color = snapshot["color"]
		organ.set_size(snapshot["size"])
	var/list/breast_snapshot = saved_genitals[ORGAN_SLOT_BREASTS]
	var/obj/item/organ/genital/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts && islist(breast_snapshot))
		breasts.color = breast_snapshot["color"]
		breasts.update_sprite_suffix()

/// Pelt tint used by every wolf-form feature (ears / tail / snout / taur / breast color).
/// Priority: the player's Werewolf-quirk fur-color preference → the mob's own mutant colors →
/// a grey-brown fallback. One color is spread across all three slots because the quirk exposes
/// a single "fur color" knob; mix-and-match is handled by the base species mutant colors.
/datum/action/cooldown/werewolf_transform/proc/wolf_mutant_colors(mob/living/carbon/human/user)
	var/fur_color = user.client?.prefs?.read_preference(/datum/preference/color/werewolf_fur_color)
	if(fur_color)
		return list(fur_color, fur_color, fur_color)
	return list(
		user.dna.features[FEATURE_MUTANT_COLOR] || "#775533",
		user.dna.features[FEATURE_MUTANT_COLOR_TWO] || "#775533",
		user.dna.features[FEATURE_MUTANT_COLOR_THREE] || "#775533",
	)

/// Old-English-flavored gendered prefix for the "[prefix]wulf" custom species name.
/datum/action/cooldown/werewolf_transform/proc/gender_prefix(user_gender)
	switch(user_gender)
		if(MALE)
			return "Wer"
		if(FEMALE)
			return "Wīf"
		if(PLURAL)
			return "Hie"
		if(NEUTER)
			return "Þing"
	return "Lycan"
