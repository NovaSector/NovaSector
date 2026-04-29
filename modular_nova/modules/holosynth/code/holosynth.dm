/// Holosynth Incoming Brute damage multiplier
#define HOLOSYNTH_BRUTEMULT 3
/// Holosynth Incoming Burn damage multiplier
#define HOLOSYNTH_BURNMULT 5
/// Minimum holosynth opacity (0-1). Matches the pref's 60% floor.
#define HOLOSYNTH_OPACITY_FLOOR 0.6
/// Visual cycle length of the scanline animation — how long it takes a stripe to traverse the
/// mob. Doubles as the periodic-refresh interval, so the boundary lands at a cycle endpoint
/// (visually seamless). Anything that disrupts the animation between refreshes is healed within
/// at most one full cycle.
#define HOLOSYNTH_SCANLINE_CYCLE (2 SECONDS)
/// identified signals that we can recover from faster
#define HOLOSYNTH_SCANLINE_QUICK_REFRESH (0.5 SECONDS)

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
		TRAIT_RESISTHEAT,
		TRAIT_RESISTCOLD,
		TRAIT_NOFIRE,
		TRAIT_NODISMEMBER,
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
	/// The scanline effect, needs to be an actual thing for vis_contents
	var/obj/effect/abstract/scanline

/obj/item/bodypart/chest/synth/holosynth/Destroy()
	glow = null
	owner_projector_ref = null
	owner?.vis_contents -= scanline
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
	apply_holosynth_limb_text(species_holder)
	if(chest)
		if(chest.glow)
			species_holder.cut_overlay(chest.glow)
		chest.glow = makeHologramHolosynth(species_holder)
	var/datum/action/innate/holosynth_toggle_phase/phase_toggle = new(species_holder)
	phase_toggle.Grant(species_holder)
	if(!isdummy(species_holder))
		RegisterSignal(species_holder, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED, PROC_REF(attach_scanline), override = TRUE)
	RegisterSignal(species_holder, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_mob_disrupted))
	RegisterSignal(species_holder, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(on_mob_disrupted))
	RegisterSignal(species_holder, COMSIG_LIVING_ELECTROCUTE_ACT, PROC_REF(on_mob_disrupted))
	add_verb(species_holder, list(
		/mob/living/carbon/human/proc/holosynth_adjust_transparency,
		/mob/living/carbon/human/proc/holosynth_toggle_scanline,
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
	UnregisterSignal(species_holder, list(COMSIG_MOB_APPLY_DAMAGE, COMSIG_LIVING_SET_BODY_POSITION, COMSIG_LIVING_ELECTROCUTE_ACT))
	species_holder.remove_filter("HOLO: Color and Transparent")
	target.remove_filter(HOLOSYNTH_SCANLINE_FILTER_ID)
	var/obj/item/bodypart/chest/synth/holosynth/chest = species_holder.get_bodypart(BODY_ZONE_CHEST)
	if(chest)
		species_holder.cut_overlay(chest.glow)
		chest.glow = null
	for(var/datum/action/innate/holosynth_toggle_phase/phase_toggle in species_holder.actions)
		qdel(phase_toggle)
	remove_verb(species_holder, list(
		/mob/living/carbon/human/proc/holosynth_adjust_transparency,
		/mob/living/carbon/human/proc/holosynth_toggle_scanline,
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
	// we have to do all this manually to recreate a transparent/tinted effect, for the sake of the preview because filters suck

	// tint
	dummy_icon.blend_color("#ECB3DD", ICON_MULTIPLY)
	// opacity
	dummy_icon.change_opacity(0.65)

/datum/species/synthetic/holosynth/proc/attach_scanline(datum/source)
	SIGNAL_HANDLER
	refresh_scanline(source)
	UnregisterSignal(source, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED)

/datum/species/synthetic/holosynth/proc/get_holosynth_visual(mob/living/carbon/human/target)
	var/list/rgb_list = rgb2num(read_color(target))
	return list(
		"r" = rgb_list[1],
		"g" = rgb_list[2],
		"b" = rgb_list[3],
		"alpha" = read_opacity(target)
	)

/// Replaces the synth bodyparts' default damage flavor ("dented", "denting", "limp and lifeless"...)
/// with holosynth-themed text on every limb.
/datum/species/synthetic/holosynth/proc/apply_holosynth_limb_text(mob/living/carbon/human/target)
	for(var/obj/item/bodypart/limb as anything in target.get_bodyparts())
		limb.light_brute_msg = "flickering"
		limb.medium_brute_msg = "scrambled"
		limb.heavy_brute_msg = "fragmenting"
		limb.light_burn_msg = "destabilized"
		limb.medium_burn_msg = "corrupted"
		limb.heavy_burn_msg = "burning out"
		limb.damage_examines = list(
			BRUTE = "fragmentation",
			BURN = "destabilization",
		)

/// Re-reads the opacity + color state and reapplies the color filter.
/datum/species/synthetic/holosynth/proc/refresh_opacity(mob/living/carbon/human/target)
	target.remove_filter("HOLO: Color and Transparent")
	var/list/visuals = get_holosynth_visual(target)
	target.add_filter("HOLO: Color and Transparent", 1, color_matrix_filter(rgb(visuals["r"], visuals["g"], visuals["b"], visuals["alpha"] * 255)))

/obj/effect/abstract/holo_scanline
	name = "holosynth scanline effect"
	icon = 'modular_nova/modules/holosynth/icons/scanline_mask.dmi'
	icon_state = "scanline"
	appearance_flags = parent_type::appearance_flags | RESET_TRANSFORM
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE
	blocks_emissive = EMISSIVE_BLOCK_NONE
	pixel_x = -16
	render_target = "*HoloScanline"

GLOBAL_DATUM_INIT(holo_scanline, /obj/effect/abstract/holo_scanline, new)

/// Periodic-rotation refresh:
/datum/species/synthetic/holosynth/proc/refresh_scanline(mob/living/carbon/human/target)
	if(QDELETED(target))
		return
	if(isdummy(target))
		return
	target.remove_filter(HOLOSYNTH_SCANLINE_FILTER_ID)
	if(!read_scanline(target))
		return

	// Adapted from makeHologram - We do it this roundabout way because apparently animated filter icons do not work properly atm.
	var/obj/effect/abstract/holo_scanline/scanline
	if(isnull(GLOB.holo_scanline))
		GLOB.holo_scanline = new(null)

	scanline = GLOB.holo_scanline

	// Now we add it as a filter, and overlay the appearance so the render source is always around
	target.add_filter(HOLOSYNTH_SCANLINE_FILTER_ID, 2, alpha_mask_filter(render_source = scanline.render_target))
	target.vis_contents += scanline

/// Common disruption handler
/datum/species/synthetic/holosynth/proc/on_mob_disrupted(mob/living/source)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(refresh_scanline), source), HOLOSYNTH_SCANLINE_QUICK_REFRESH, TIMER_UNIQUE | TIMER_OVERRIDE)

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

/datum/species/synthetic/holosynth/proc/read_scanline(mob/living/carbon/human/target)
	var/feature = target.dna?.features["holo_scanline"]
	return isnull(feature) ? TRUE : feature

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

/mob/living/carbon/human/proc/holosynth_toggle_scanline()
	set name = "Toggle Hologram Flicker"
	set category = "IC"
	set src = usr

	var/datum/species/synthetic/holosynth/species = dna?.species
	if(!istype(species))
		return
	var/new_state = !species.read_scanline(src)
	dna?.features["holo_scanline"] = new_state
	species.refresh_scanline(src)
	to_chat(src, span_notice("You [new_state ? "enable" : "disable"] your hologram flicker."))

/// Drops everything the holosynth has equipped except items in the slots they get to keep
/// (ID + pockets).
/proc/holosynth_drop_unkept_items(mob/living/carbon/human/holosynth)
	var/obj/item/back_item = holosynth.get_item_by_slot(ITEM_SLOT_BACK)
	if(back_item)
		holosynth.dropItemToGround(back_item, force = TRUE)

	for(var/obj/item/equipped as anything in holosynth.get_equipped_items(INCLUDE_HELD))
		var/slot = holosynth.get_slot_by_item(equipped)
		if(slot & (ITEM_SLOT_ID | ITEM_SLOT_LPOCKET | ITEM_SLOT_RPOCKET | ITEM_SLOT_ICLOTHING))
			continue
		holosynth.dropItemToGround(equipped, force = TRUE)

/mob/living/carbon/human/species/holosynth
	race = /datum/species/synthetic/holosynth

#undef HOLOSYNTH_BRUTEMULT
#undef HOLOSYNTH_BURNMULT
#undef HOLOSYNTH_OPACITY_FLOOR
