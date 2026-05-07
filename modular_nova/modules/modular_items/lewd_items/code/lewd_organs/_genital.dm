/obj/item/organ/genital
	color = "#fcccb3"
	organ_flags = parent_type::organ_flags | ORGAN_UNREMOVABLE | ORGAN_EXTERNAL | ORGAN_HIDDEN
	/// The fluid count of the genital.
	var/internal_fluid_count = 0
	/// The maximum amount of fluid that can be stored in the genital.
	var/internal_fluid_maximum = 0
	/// The datum to be used for the tracked fluid, should it need to be added to a fluid container.
	var/internal_fluid_datum
	/// The currently inserted sex toy.
	var/obj/item/inserted_item
	///Size value of the genital, needs to be translated to proper lengths/diameters/cups
	var/genital_size = 1
	///The maximum sprite affix for this type
	var/max_sprite_size_affix
	///Sprite name of the genital, it's what shows up on character creation
	var/genital_name = "Human"
	///Type of the genital. For penises tapered/horse/human etc. for breasts quadruple/sixtuple etc...
	var/genital_type = SPECIES_HUMAN
	///Used for determining what sprite is being used, derrives from size and type
	var/sprite_suffix
	///Used for input from the user whether to show a genital through clothing or not, always or never etc.
	var/visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	///Whether the organ is aroused, matters for sprites, use AROUSAL_CANT, AROUSAL_NONE, AROUSAL_PARTIAL or AROUSAL_FULL
	var/aroused = AROUSAL_NONE
	///Whether the organ is supposed to use a skintoned variant of the sprite
	var/uses_skintones = FALSE
	///Whether the organ is supposed to use the color of the holder's skin tone.
	var/uses_skin_color = FALSE
	/// Where the genital is actually located, for clothing checks.
	var/genital_location = GROIN
	/// Layering mode, determines if it tries to render above clothing or not.
	var/layer_mode = GENITAL_LAYER_NORMAL

/// Helper proc for checking if internal fluids are full or not.
/obj/item/organ/genital/proc/internal_fluid_full()
	return internal_fluid_count >= internal_fluid_maximum

/// Adds the given amount to the internal fluid count, clamping it between 0 and internal_fluid_maximum.
/obj/item/organ/genital/proc/adjust_internal_fluid(amount)
	internal_fluid_count = clamp(internal_fluid_count + amount, 0, internal_fluid_maximum)

/// Tries to add the specified amount to the target reagent container, or removes it if none are available. Keeps in mind internal_fluid_count.
/obj/item/organ/genital/proc/transfer_internal_fluid(datum/reagents/reagent_container = null, attempt_amount)
	if(!internal_fluid_datum || !internal_fluid_count || !internal_fluid_maximum)
		return FALSE

	attempt_amount = clamp(attempt_amount, 0, internal_fluid_count)
	if(reagent_container)
		reagent_container.add_reagent(internal_fluid_datum, attempt_amount)
	internal_fluid_count -= attempt_amount

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/get_sprite_size_string()
	return 0

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/update_sprite_suffix()
	sprite_suffix = "[get_sprite_size_string()]"

	var/datum/bodypart_overlay/mutant/genital/our_overlay = bodypart_overlay

	our_overlay.sprite_suffix = sprite_suffix
	our_overlay.owner = owner
	our_overlay.organ_slot = src.slot


/obj/item/organ/genital/proc/get_description_string(datum/sprite_accessory/genital/gas)
	return "You see genitals"

/obj/item/organ/genital/proc/update_genital_icon_state()
	return

/obj/item/organ/genital/proc/set_size(size)
	genital_size = size
	update_sprite_suffix()

/obj/item/organ/genital/Initialize(mapload)
	. = ..()
	update_sprite_suffix()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL

//Removes ERP organs depending on config
/obj/item/organ/genital/Insert(mob/living/carbon/M, special, movement_flags)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return
	. = ..()

/obj/item/organ/genital/Remove(mob/living/carbon/M, special = FALSE, movement_flags)
	. = ..()
	update_genital_icon_state()

/obj/item/organ/genital/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/datum/mutant_bodypart/bodypart = DNA.mutant_bodyparts[associated_key]
	if(isnull(bodypart))
		return

	var/datum/sprite_accessory/genital/accessory = SSaccessories.sprite_accessories[associated_key][bodypart.name]
	genital_name = accessory.name
	genital_type = accessory.icon_state
	build_from_accessory(accessory, DNA)
	update_sprite_suffix()

	var/datum/bodypart_overlay/mutant/genital/our_overlay = bodypart_overlay

	our_overlay.color_source = uses_skin_color ? ORGAN_COLOR_INHERIT : ORGAN_COLOR_OVERRIDE
	our_overlay.owner = owner
	our_overlay.organ_slot = src.slot

/// for specific build_from_dna behavior that also checks the genital accessory.
/obj/item/organ/genital/proc/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(isnull(max_sprite_size_affix))
		// snowflake for skintone alt human penis, which only has sprites up to size 4 as opposed to the non-skintone which goes to 5. and similar...
		// This SUCKS. genitals code is simply HORRIBLE and rotted to its core. TODO: destroy and rewrite it ALL. from fucking scratch.
		if(uses_skintones)
			max_sprite_size_affix = accessory.skintone_max_sprite_size_affix || accessory.max_sprite_size_affix
		else
			max_sprite_size_affix = accessory.max_sprite_size_affix
	return

/obj/item/organ/genital/proc/is_exposed()
	if(!owner)
		return TRUE

	if(!ishuman(owner))
		return TRUE

	var/mob/living/carbon/human/human = owner

	switch(visibility_preference)
		if(GENITAL_ALWAYS_SHOW)
			return TRUE
		if(GENITAL_HIDDEN_BY_CLOTHES)
			if((human.w_uniform && human.w_uniform.body_parts_covered & genital_location) || (human.wear_suit && human.wear_suit.body_parts_covered & genital_location))
				return FALSE
			else
				return TRUE
		else
			return FALSE

/datum/bodypart_overlay/mutant/genital
	layers = EXTERNAL_FRONT_UNDER_CLOTHES
	color_source = ORGAN_COLOR_OVERRIDE
	/// The suffix appended to the feature_key for the overlays.
	var/sprite_suffix
	/// Owning human.  Used to adjust layers depending on underwear
	var/mob/living/carbon/human/owner
	/// Organ slot, used to get reference to the actual organ this is attached to without angering the CI gods.
	var/organ_slot

	/// Layer used when FORCED ABOVE ALL CLOTHING.
	var/layer_above_all = -(BODY_FRONT_LAYER - 0.06)
	/// Layer used when ABOVE UNDERWEAR
	var/layer_above_undies = -(UNIFORM_LAYER - 0.06)
	/// Ditto, but for BELOW UNDERWEAR
	var/layer_below_undies = -(UNIFORM_LAYER + 0.06)
	draw_on_husks = FALSE

/datum/bodypart_overlay/mutant/genital/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/genital/get_base_icon_state()
	return sprite_suffix

/datum/bodypart_overlay/mutant/genital/get_color_layer_names(icon_state_to_lookup)
	if(length(sprite_datum.color_layer_names))
		return sprite_datum.color_layer_names

	sprite_datum.color_layer_names = list()
	if (!SSaccessories.cached_mutant_icon_files[sprite_datum.icon])
		SSaccessories.cached_mutant_icon_files[sprite_datum.icon] = icon_states(new /icon(sprite_datum.icon))

	var/list/cached_mutant_icon_states = SSaccessories.cached_mutant_icon_files[sprite_datum.icon]

	for (var/layer in all_layers)
		if(!(layer & layers))
			continue

		var/layertext = mutant_bodyparts_layertext(bitflag_to_layer(layer))
		if ("m_[feature_key]_[get_base_icon_state()]_[layertext]_primary" in cached_mutant_icon_states)
			sprite_datum.color_layer_names["1"] = "primary"
		if ("m_[feature_key]_[get_base_icon_state()]_[layertext]_secondary" in cached_mutant_icon_states)
			sprite_datum.color_layer_names["2"] = "secondary"
		if ("m_[feature_key]_[get_base_icon_state()]_[layertext]_tertiary" in cached_mutant_icon_states)
			sprite_datum.color_layer_names["3"] = "tertiary"

	return sprite_datum.color_layer_names

/datum/bodypart_overlay/mutant/genital/mutant_bodyparts_layertext(layer)
	if(layer == layer_below_undies || layer == layer_above_undies || layer == layer_above_all)
		return "FRONT"
	else
		return ..()

/// Return TRUE if this should overlay below underwear, otherwise it'll layer above it and the uniform.
/datum/bodypart_overlay/mutant/genital/proc/underwear_check()
	return FALSE

/// Helper function - if the organ this overlay is tied to has been set to layer above clothing, return TRUE
/datum/bodypart_overlay/mutant/genital/proc/layer_mode_check()
	if(istype(owner))
		var/obj/item/organ/genital/owning_organ = owner.get_organ_slot(organ_slot)
		if(owning_organ?.layer_mode == GENITAL_LAYER_HIGH)
			return TRUE
	return FALSE

/datum/bodypart_overlay/mutant/genital/bitflag_to_layer(layer)
	if(layer == EXTERNAL_FRONT_UNDER_CLOTHES)
		if(layer_mode_check() == TRUE)
			return layer_above_all
		else if(underwear_check() == FALSE)
			return layer_above_undies
		else
			return layer_below_undies
	else
		return ..()

/mob/living/carbon/human/verb/toggle_genitals()
	set category = "IC"
	set name = "Expose/Hide genitals"
	set desc = "Allows you to toggle which genitals should show through clothes or not."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle genitals visibility right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/genital in organs)
		if(!genital.visibility_preference == GENITAL_SKIP_VISIBILITY)
			genital_list += genital

	if(!genital_list.len) //There is nothing to expose
		return

	var/obj/item/organ/genital/picked_organ = tgui_input_list(src, "Choose which genitalia to expose/hide", "Expose/Hide genitals", genital_list)

	if(!picked_organ || !(picked_organ in organs))
		return

	var/static/list/gen_vis_trans = list(
		"Never show" = GENITAL_NEVER_SHOW,
		"Hidden by clothes" = GENITAL_HIDDEN_BY_CLOTHES,
		"Always show" = GENITAL_ALWAYS_SHOW,
		"Layer Normally" = GENITAL_LAYER_NORMAL,
		"Layer Above Clothes" = GENITAL_LAYER_HIGH,
	)

	var/picked_visibility = tgui_input_list(src, "Choose visibility setting", "Expose/Hide genitals", gen_vis_trans)

	if(!picked_visibility || !picked_organ || !(picked_organ in organs))
		return

	if(gen_vis_trans[picked_visibility] == GENITAL_LAYER_NORMAL || gen_vis_trans[picked_visibility] == GENITAL_LAYER_HIGH)
		picked_organ.layer_mode = gen_vis_trans[picked_visibility]
		balloon_alert(src, "set layering to [LOWER_TEXT(picked_visibility)]")
		update_body()
		return

	picked_organ.visibility_preference = gen_vis_trans[picked_visibility]
	balloon_alert(src, "set to [LOWER_TEXT(picked_visibility)]")
	update_body()

/mob/living/carbon/human/verb/toggle_arousal()
	set category = "IC"
	set name = "Toggle Arousal"
	set desc = "Allows you to toggle how aroused your private parts are."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle arousal right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/genital in organs)
		if(!genital.aroused == AROUSAL_CANT)
			genital_list += genital

	if(!genital_list.len) //There is nothing to modify.
		return

	var/obj/item/organ/genital/picked_organ = tgui_input_list(src, "Choose which genitalia to the change arousal of", "Expose/Hide genitals", genital_list)

	if(!picked_organ || !(picked_organ in organs))
		return

	var/list/gen_arous_trans = list(
		"Not aroused" = AROUSAL_NONE,
		"Partly aroused" = AROUSAL_PARTIAL,
		"Very aroused" = AROUSAL_FULL,
	)

	var/picked_arousal = tgui_input_list(src, "Choose arousal", "Toggle Arousal", gen_arous_trans)

	if(!picked_arousal || !picked_organ || !(picked_organ in organs))
		return

	picked_organ.aroused = gen_arous_trans[picked_arousal]
	picked_organ.update_sprite_suffix()
	balloon_alert(src, "set to [LOWER_TEXT(picked_arousal)]")
	update_body()
