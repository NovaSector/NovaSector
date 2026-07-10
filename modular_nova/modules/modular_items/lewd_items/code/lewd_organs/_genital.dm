/// The genital visibility options
GLOBAL_LIST_INIT(genital_visibility_options, list(
	"Never show" = GENITAL_NEVER_SHOW,
	"Hidden by clothes" = GENITAL_HIDDEN_BY_CLOTHES,
	"Custom" = GENITAL_CUSTOM,
))

/// The genital layering options
GLOBAL_LIST_INIT(genital_layering_options, list(
	"Below underwear" = GENITAL_LAYER_BELOW_UNDIES,
	"Normal" = GENITAL_LAYER_NORMAL,
	"Above underwear" = GENITAL_LAYER_ABOVE_UNDIES,
	"Above all clothing" = GENITAL_LAYER_ABOVE_ALL,
))

/// The genital arousal options
GLOBAL_LIST_INIT(genital_arousal_options, list(
	"Not aroused" = AROUSAL_NONE,
	"Partly aroused" = AROUSAL_PARTIAL,
	"Very aroused" = AROUSAL_FULL,
))

/// Reverse lookup: the label whose define matches the current value, or null.
/proc/genital_option_label(list/options, value)
	for(var/label in options)
		if(options[label] == value)
			return label
	return null

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
	///Type of the genital. For penises tapered/horse/human etc. for breasts quadruple/sixtuple etc...
	var/genital_type = SPECIES_HUMAN
	///Used for determining what sprite is being used, derives from size and type
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

/obj/item/organ/genital/proc/get_description_string(datum/sprite_accessory/genital/genital)
	return "You see genitals."

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
	genital_type = accessory.icon_state
	build_from_accessory(accessory, DNA)
	update_sprite_suffix()

	var/datum/bodypart_overlay/mutant/genital/our_overlay = bodypart_overlay

	our_overlay.color_source = uses_skin_color ? ORGAN_COLOR_INHERIT : ORGAN_COLOR_OVERRIDE
	our_overlay.owner = owner
	our_overlay.organ_slot = src.slot

/obj/item/organ/genital/proc/get_genital_descriptor(datum/sprite_accessory/genital/genital)
	var/display_name = genital.display_name
	if(!isnull(display_name))
		return display_name

	return genital.name

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

/// Whether the mob's worn clothing physically covers this genital's location.
/obj/item/organ/genital/proc/covered_by_clothing(mob/living/carbon/human/human)
	return (human.w_uniform && human.w_uniform.body_parts_covered & genital_location) \
		|| (human.wear_suit && human.wear_suit.body_parts_covered & genital_location)

/obj/item/organ/genital/proc/is_exposed()
	if(!owner)
		return TRUE

	if(!ishuman(owner))
		return TRUE

	var/mob/living/carbon/human/human = owner

	switch(visibility_preference)
		if(GENITAL_HIDDEN_BY_CLOTHES, GENITAL_CUSTOM)
			var/datum/bodypart_overlay/mutant/genital/overlay = bodypart_overlay
			if(get_effective_layer_mode() == GENITAL_LAYER_ABOVE_ALL)
				return TRUE //Renders over everything, so it's on display regardless of clothing
			//Every other case - including Custom's under-uniform layers and Custom + Normal - comes down to physical coverage.
			return !covered_by_clothing(human)
		else //Never show, and anything unexpected.
			return FALSE

/// Applies a visibility option by its menu label. Returns TRUE and refreshes the body on success.
/obj/item/organ/genital/proc/apply_visibility_label(label)
	var/value = GLOB.genital_visibility_options[label]
	if(isnull(value))
		return FALSE
	visibility_preference = value
	owner?.update_body()
	return TRUE

/// Applies a layer_mode option option by its menu label. Returns TRUE and refreshes the body on success.
/obj/item/organ/genital/proc/apply_layering_label(label)
	var/value = GLOB.genital_layering_options[label]
	if(isnull(value))
		return FALSE
	var/datum/bodypart_overlay/mutant/genital/overlay = bodypart_overlay
	overlay.layer_mode = value
	owner?.update_body()
	return TRUE

/// Applies an arousal option by its menu label. Returns TRUE and refreshes the body on success.
/obj/item/organ/genital/proc/apply_arousal_label(label)
	var/value = GLOB.genital_arousal_options[label]
	if(isnull(value))
		return FALSE
	if(aroused == AROUSAL_CANT) // Not arousable - don't let UIs force it.
		return FALSE
	aroused = value
	update_sprite_suffix() // suffix has to be rebuilt before the update because the sprite changes
	owner?.update_body()
	return TRUE

/obj/item/organ/genital/proc/get_effective_layer_mode()
	if(visibility_preference != GENITAL_CUSTOM)
		return GENITAL_LAYER_NORMAL
	var/datum/bodypart_overlay/mutant/genital/overlay = bodypart_overlay
	return overlay?.layer_mode || GENITAL_LAYER_NORMAL

/// The per-genital config entry every configuring UI sends to tgui.
/obj/item/organ/genital/proc/get_layering_ui_entry()
	var/datum/bodypart_overlay/mutant/genital/overlay = bodypart_overlay
	return list(
		"name" = capitalize(name),
		"ref" = REF(src),
		"visibility" = genital_option_label(GLOB.genital_visibility_options, visibility_preference),
		"layering" = genital_option_label(GLOB.genital_layering_options, overlay.layer_mode),
		"custom" = (visibility_preference == GENITAL_CUSTOM),
		"arousal" = genital_option_label(GLOB.genital_arousal_options, aroused),
		"can_arouse" = (aroused != AROUSAL_CANT),
	)

/// Every genital that should appear in configuration menus.
/mob/living/carbon/human/proc/get_configurable_genitals()
	var/list/result = list()
	for(var/obj/item/organ/genital/genital in organs)
		if(genital.visibility_preference != GENITAL_SKIP_VISIBILITY)
			result += genital
	return result

/datum/bodypart_overlay/mutant/genital
	layers = list(
		EXTERNAL_FRONT_UNDER_CLOTHES = UNDER_UNIFORM_LAYER,
	)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = LOWER_BODY
	draw_on_husks = HUSK_OVERLAY_NONE
	/// The suffix appended to the feature_key for the overlays.
	var/sprite_suffix
	/// Owning human.  Used to adjust layers depending on underwear
	var/mob/living/carbon/human/owner
	/// Organ slot, used to get reference to the actual organ this is attached to without angering the CI gods.
	var/organ_slot
	/// Layering mode, determines if it tries to render above clothing or not.
	var/layer_mode = GENITAL_LAYER_NORMAL
	/// Layer used when FORCED ABOVE ALL CLOTHING.
	var/layer_above_all = -(BODY_FRONT_LAYER - 0.006)
	/// Layer used when ABOVE UNDERWEAR
	var/layer_above_undies = -(UNDER_UNDER_UNIFORM_LAYER - 0.006)
	/// Ditto, but for BELOW UNDERWEAR
	var/layer_below_undies = -(UNDER_UNDER_UNIFORM_LAYER + 0.006)

/datum/bodypart_overlay/mutant/genital/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/genital/get_base_icon_state()
	return sprite_suffix

/// Whether the owning organ is set to Custom visibility, i.e. manual layer control.
/datum/bodypart_overlay/mutant/genital/proc/is_custom_layered()
	if(layer_mode == GENITAL_LAYER_NORMAL)
		return FALSE
	if(!istype(owner))
		return FALSE
	var/obj/item/organ/genital/organ = owner.get_organ_slot(organ_slot)
	return organ?.visibility_preference == GENITAL_CUSTOM

/datum/bodypart_overlay/mutant/genital/icon_render_key(obj/item/bodypart/limb)
	. = ..()
	. += is_custom_layered() ? "[layer_mode]" : "default"

/datum/bodypart_overlay/mutant/genital/get_overlay(obj/item/bodypart/limb, layer_index, layer_real)
	if(layer_index == EXTERNAL_FRONT_UNDER_CLOTHES && is_custom_layered())
		switch(layer_mode)
			if(GENITAL_LAYER_BELOW_UNDIES)
				layer_real = layer_below_undies
			if(GENITAL_LAYER_ABOVE_UNDIES)
				layer_real = layer_above_undies
			if(GENITAL_LAYER_ABOVE_ALL)
				layer_real = layer_above_all
	return ..()

/// Per-organ menu for genital visibility + render layering.
/// Options and apply logic live in the shared GLOBs and organ procs above.
/datum/genital_layering_panel
	/// The mob whose genitals we're editing.
	var/mob/living/carbon/human/owner
	/// The organ the tabs currently have selected.
	var/obj/item/organ/genital/selected_organ

/datum/genital_layering_panel/New(mob/living/carbon/human/owner)
	src.owner = owner
	var/list/eligible = eligible_genitals()
	if(length(eligible))
		selected_organ = eligible[1]

/datum/genital_layering_panel/Destroy()
	if(owner?.genital_layering_panel == src)
		owner.genital_layering_panel = null
	owner = null
	selected_organ = null
	return ..()

/// Every genital that should appear in the menu.
/datum/genital_layering_panel/proc/eligible_genitals()
	return owner?.get_configurable_genitals() || list()

/datum/genital_layering_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "GenitalLayering", "Expose/Hide genitals")
		ui.open()

/datum/genital_layering_panel/ui_status(mob/user, datum/ui_state/state)
	// Self-service only, conscious only, and close if every genital vanished.
	if(QDELETED(owner) || user != owner || user.stat != CONSCIOUS || !length(eligible_genitals()))
		return UI_CLOSE
	return UI_INTERACTIVE

/datum/genital_layering_panel/ui_close(mob/user)
	qdel(src)

/datum/genital_layering_panel/ui_static_data(mob/user)
	var/list/data = list()
	data["visibility_options"] = assoc_to_keys(GLOB.genital_visibility_options)
	data["layering_options"] = assoc_to_keys(GLOB.genital_layering_options)
	return data

/datum/genital_layering_panel/ui_data(mob/user)
	var/list/eligible = eligible_genitals()
	// Selected organ can be removed (surgery, config qdel) while the window is open.
	if(!(selected_organ in eligible))
		selected_organ = length(eligible) ? eligible[1] : null

	var/list/data = list()
	data["genitals"] = list()
	for(var/obj/item/organ/genital/genital as anything in eligible)
		data["genitals"] += list(genital.get_layering_ui_entry())
	data["selected"] = selected_organ ? REF(selected_organ) : null

	if(selected_organ)
		var/datum/bodypart_overlay/mutant/genital/overlay = selected_organ.bodypart_overlay
		data["visibility"] = genital_option_label(GLOB.genital_visibility_options, selected_organ.visibility_preference)
		data["layering"] = genital_option_label(GLOB.genital_layering_options, overlay.layer_mode)
		data["custom"] = (selected_organ.visibility_preference == GENITAL_CUSTOM)
	return data

/datum/genital_layering_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(action == "select_organ")
		var/obj/item/organ/genital/organ = locate(params["ref"]) in eligible_genitals()
		if(!organ)
			return
		selected_organ = organ
		return TRUE // Pushes fresh ui_data; no body update needed for a tab switch.

	if(isnull(selected_organ))
		return

	switch(action)
		if("set_visibility")
			if(!selected_organ.apply_visibility_label(params["option"]))
				return
			ui.user.balloon_alert(ui.user, "[selected_organ.name] set to [LOWER_TEXT(params["option"])]")
			return TRUE
		if("set_layering")
			if(!selected_organ.apply_layering_label(params["option"]))
				return
			ui.user.balloon_alert(ui.user, "[selected_organ.name] layering set to [LOWER_TEXT(params["option"])]")
			return TRUE

/mob/living/carbon/human/verb/toggle_genitals()
	set category = "IC"
	set name = "Expose/Hide genitals"
	set desc = "Change which genitals show through clothes and how they layer."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle genitals visibility right now..."))
		return

	if(isnull(genital_layering_panel))
		genital_layering_panel = new(src)

	if(isnull(genital_layering_panel.selected_organ)) //There is nothing to expose
		QDEL_NULL(genital_layering_panel)
		return

	genital_layering_panel.ui_interact(src)

/mob/living/carbon/human/verb/toggle_arousal()
	set category = "IC"
	set name = "Toggle Arousal"
	set desc = "Allows you to toggle how aroused your private parts are."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle arousal right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/genital in organs)
		if(genital.aroused != AROUSAL_CANT)
			genital_list += genital

	if(!length(genital_list)) //There is nothing to modify.
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
