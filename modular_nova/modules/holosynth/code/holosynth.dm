/// Holosynth Incoming Brute damage multiplier
#define HOLOSYNTH_BRUTEMULT 3
/// Holosynth Incoming Burn damage multiplier
#define HOLOSYNTH_BURNMULT 5
/// Minimum holosynth opacity (0-1). Matches the pref's 60% floor.
#define HOLOSYNTH_OPACITY_FLOOR 0.6
/datum/species/synthetic/holosynth
	name = "Holosynth"
	id = SPECIES_HOLOSYNTH
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_CAN_STRIP,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_GENELESS,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBLOOD,
		TRAIT_NO_HUSK,
		TRAIT_OXYIMMUNE,
		TRAIT_LITERATE,
		TRAIT_NOCRITDAMAGE,
		TRAIT_ROBOTIC_DNA_ORGANS,
		TRAIT_HOLOSYNTH,
	)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/synth,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/synth/holosynth,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/synth,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/synth,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/synth,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/synth,
	)

/// Holosynth chest carries the hologram-effect state so the species datum can stay stateless.
/obj/item/bodypart/chest/synth/holosynth
	/// Weakref to the holosynth pen bound to this body.
	var/datum/weakref/owner_projector_ref
	/// Emissive glow appearance applied to the mob, retained so we can cut it on species loss / re-apply.
	var/mutable_appearance/glow

/obj/item/bodypart/chest/synth/holosynth/Destroy()
	glow = null
	owner_projector_ref = null
	return ..()

/datum/species/synthetic/holosynth/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_TAIL = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SYNTH_ANTENNA = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SYNTH_SCREEN = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SYNTH_CHASSIS = MUTPART_BLUEPRINT("Human Chassis", is_randomizable = FALSE),
		FEATURE_SYNTH_HEAD = MUTPART_BLUEPRINT("Human Head", is_randomizable = FALSE),
	)

/datum/species/synthetic/holosynth/on_species_gain(mob/living/carbon/target, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/mob/living/carbon/human/species_holder = target

	species_holder.physiology.brute_mod *= HOLOSYNTH_BRUTEMULT
	species_holder.physiology.burn_mod *= HOLOSYNTH_BURNMULT
	species_holder.max_grab = GRAB_PASSIVE

	species_holder.AddComponent(/datum/component/glass_passer/holosynth)
	species_holder.AddComponent(/datum/component/holographic_nature)

	var/obj/item/bodypart/chest/synth/holosynth/chest = species_holder.get_bodypart(BODY_ZONE_CHEST)
	refresh_opacity(species_holder)
	if(chest)
		if(chest.glow)
			species_holder.cut_overlay(chest.glow)
		chest.glow = makeHologramHolosynth(species_holder)
	var/datum/action/innate/holosynth_toggle_phase/phase_toggle = new(species_holder)
	phase_toggle.Grant(species_holder)
	add_verb(species_holder, list(
		/mob/living/carbon/human/proc/holosynth_adjust_transparency,
	))

	if(!isdummy(species_holder))
		var/obj/item/holosynth_pen/owner_projector = new /obj/item/holosynth_pen(get_turf(species_holder), species_holder)
		if(chest)
			chest.owner_projector_ref = WEAKREF(owner_projector)
		species_holder.put_in_hands(owner_projector)

/datum/species/synthetic/holosynth/on_species_loss(mob/living/carbon/target, datum/species/new_species, pref_load)
	. = ..()
	var/mob/living/carbon/human/species_holder = target
	species_holder.physiology.brute_mod /= HOLOSYNTH_BRUTEMULT
	species_holder.physiology.burn_mod /= HOLOSYNTH_BURNMULT
	species_holder.max_grab = GRAB_KILL
	species_holder.remove_filter("HOLO: Color and Transparent")
	var/obj/item/bodypart/chest/synth/holosynth/chest = species_holder.get_bodypart(BODY_ZONE_CHEST)
	if(chest)
		species_holder.cut_overlay(chest.glow)
		chest.glow = null
	for(var/datum/action/innate/holosynth_toggle_phase/phase_toggle in species_holder.actions)
		qdel(phase_toggle)
	remove_verb(species_holder, list(
		/mob/living/carbon/human/proc/holosynth_adjust_transparency,
	))

	var/comps_to_delete = list(
		species_holder.GetComponent(/datum/component/glass_passer/holosynth),
		species_holder.GetComponent(/datum/component/leash),
		species_holder.GetComponent(/datum/component/holographic_nature),
	)
	for(var/comp in comps_to_delete)
		qdel(comp)

	if(chest)
		var/obj/item/holosynth_pen/pen_to_unlink = chest.owner_projector_ref?.resolve()
		if(pen_to_unlink)
			pen_to_unlink.linked_mob_ref = null
		chest.owner_projector_ref = null

/datum/species/synthetic/holosynth/get_species_lore()
	return list(\
		"Somewhere between an android and a hologram, these semi-physical autonomous units are extremely vulnerable to heat and electricity. \
		A niche choice more popular among wealthy customers (silicon and uploaded organics alike) - their lack of robustness makes them somewhat inept for physical activity but they are excellent at scouting or clerical work.",

		"As of late the design of the required holoprojection equipment has shrunk considerably. \
		With an electromagnetic controller suite, hologram projection apparatus, and a ball point writing implement all fitting into the sleek pen chassis. Holosynths are traditionally once human, but any species can become a hologram."
	)

/datum/species/synthetic/holosynth/create_pref_traits_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD_ALT,
		SPECIES_PERK_NAME = "Android Aptitude",
		SPECIES_PERK_DESC = "As a synthetic lifeform, they are immune to many forms of damage humans are susceptible to. \
			Fire, cold, heat, pressure, radiation, and toxins are all ineffective against them. \
			They also can't overdose on drugs, don't need to breathe or eat, can't catch on fire, and are immune to being pierced.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_DNA,
		SPECIES_PERK_NAME = "Not Human After All",
		SPECIES_PERK_DESC = "There is no humanity behind the eyes of the synthetic, and as such, they have no DNA to genetically alter.",
	))
	return perks

/datum/species/synthetic/holosynth/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD_HEART,
		SPECIES_PERK_NAME = "Some Components Optional",
		SPECIES_PERK_DESC = "Synthetics have very few internal organs. While they can survive without many of them, \
			they don't have any benefits from them either.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_ROBOT,
		SPECIES_PERK_NAME = "Synthetic",
		SPECIES_PERK_DESC = "Being synthetic, they are vulnernable to EMPs.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_MAGNIFYING_GLASS,
		SPECIES_PERK_NAME = "Translucency",
		SPECIES_PERK_DESC = "Holosynths can pass through glass, though you'll leave any physical items behind.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_NOTES_MEDICAL,
		SPECIES_PERK_NAME = "Regenerator",
		SPECIES_PERK_DESC = "Being made of light, your projector and controller will mend tears in your form.",
	))
	return perks

/datum/species/synthetic/holosynth/get_species_description()
	return "Holosynths are a subtype of machines; they're made of soft-light, only semi-solid and dependant on a projection device."

/datum/species/synthetic/holosynth/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.set_haircolor("#D8D8D8", update = FALSE)
	human_for_preview.set_hairstyle("Oxton", update = TRUE)
	human_for_preview.set_hair_gradient_color("#7C6AB7")
	human_for_preview.set_hair_gradient_style("Wavy")
	human_for_preview.dna.features["holo_color"] = "#ECB3DD"
	human_for_preview.set_eye_color("#5AADD6")
	human_for_preview.dna.mutant_bodyparts[FEATURE_SYNTH_HEAD] = build_mutant_part("Human Head", list("#EDCDB0"))
	human_for_preview.dna.mutant_bodyparts[FEATURE_SYNTH_CHASSIS] = build_mutant_part("Human Chassis", list("#EDCDB0"))
	apply_supplementary_body_changes(human_for_preview, visuals_only = TRUE)
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/synthetic/holosynth/preview_icon_after_effects(datum/universal_icon/dummy_icon, mob/living/carbon/human/target)
	dummy_icon.blend_color("#ECB3DD", ICON_MULTIPLY)
	dummy_icon.change_opacity(0.65)

/datum/species/synthetic/holosynth/proc/get_holosynth_visual(mob/living/carbon/human/target)
	var/list/rgb_list = rgb2num(read_color(target))
	return list(
		"r" = rgb_list[1],
		"g" = rgb_list[2],
		"b" = rgb_list[3],
		"alpha" = read_opacity(target)
	)

/// Re-reads the opacity + color state and reapplies the color filter.
/datum/species/synthetic/holosynth/proc/refresh_opacity(mob/living/carbon/human/target)
	target.remove_filter("HOLO: Color and Transparent")
	var/list/visuals = get_holosynth_visual(target)
	target.add_filter("HOLO: Color and Transparent", 1, color_matrix_filter(rgb(visuals["r"], visuals["g"], visuals["b"], visuals["alpha"] * 255)))

/// Inlines makeHologram's emissive-glow portion only — skips its scanline filter (which cropped
/// oversized mutant parts) and its scanline add_overlay (which inflated the hitbox).
/datum/species/synthetic/holosynth/proc/makeHologramHolosynth(atom/target)
	if(!target.render_target)
		var/static/uid = 0
		target.render_target = "HOLOGRAM [uid++]"
	var/static/atom/movable/render_step/emissive/glow_source
	if(!glow_source)
		glow_source = new(null)
	glow_source.render_source = target.render_target
	SET_PLANE_EXPLICIT(glow_source, initial(glow_source.plane), target)
	var/mutable_appearance/glow_appearance = new(glow_source)
	target.add_overlay(glow_appearance)
	LAZYADD(target.update_overlays_on_z, glow_appearance)
	return glow_appearance

/datum/species/synthetic/holosynth/proc/read_color(mob/living/carbon/human/target)
	return target.client?.prefs?.read_preference(/datum/preference/color/mutant/holosynth_color) \
		|| target.dna?.features["holo_color"] \
		|| rgb(125, 180, 225)

/datum/species/synthetic/holosynth/proc/read_opacity(mob/living/carbon/human/target)
	var/raw = target.dna?.features["holo_transparency"]
	return raw ? clamp(raw / 100, HOLOSYNTH_OPACITY_FLOOR, 1) : HOLOSYNTH_OPACITY_FLOOR

// -- Runtime verbs -------------------------------------------------------
// Added on species gain, removed on species loss. Both update the dna feature and ask the species to refresh.

/mob/living/carbon/human/proc/holosynth_adjust_transparency()
	set name = "Adjust Hologram Transparency"
	set category = "IC"
	set src = usr

	var/datum/species/synthetic/holosynth/species = dna?.species
	if(!istype(species))
		return
	var/new_value = tgui_input_number(src, "Set transparency. 60 = most see-through, 100 = fully solid.", "Hologram Transparency", (dna?.features["holo_transparency"] || 60), 100, 60)
	if(!new_value)
		return
	dna?.features["holo_transparency"] = new_value
	species.refresh_opacity(src)

/mob/living/carbon/human/species/holosynth
	race = /datum/species/synthetic/holosynth

#undef HOLOSYNTH_BRUTEMULT
#undef HOLOSYNTH_BURNMULT
#undef HOLOSYNTH_OPACITY_FLOOR
