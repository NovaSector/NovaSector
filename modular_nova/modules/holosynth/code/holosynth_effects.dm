/// Minimum holosynth opacity (0-1). Matches the pref's 60% floor.
#define HOLOSYNTH_OPACITY_FLOOR 0.6

/// Tints the holosynth via color/opacity prefs and applies an optional scanline filter.
/// `dna.features` is the single runtime source of truth — prefs seed it, IC verbs mutate it.
/// Write the feature, then call `refresh_opacity()` / `refresh_scanline()` to re-read and re-apply.
/datum/component/holosynth_effects
	var/mutable_appearance/glow

/datum/component/holosynth_effects/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	return ..()

/datum/component/holosynth_effects/RegisterWithParent()
	var/mob/living/carbon/human/parent_as_human = parent
	glow = parent_as_human.makeHologram(read_opacity(), read_color())
	refresh_scanline()

/datum/component/holosynth_effects/UnregisterFromParent()
	var/mob/living/carbon/human/parent_as_human = parent
	parent_as_human.remove_filter(list("HOLO: Color and Transparent", "HOLO: Scanline"))
	parent_as_human.cut_overlay(glow)

/datum/component/holosynth_effects/proc/refresh_opacity()
	var/mob/living/carbon/human/parent_as_human = parent
	var/list/rgb_list = rgb2num(read_color())
	parent_as_human.remove_filter("HOLO: Color and Transparent")
	parent_as_human.add_filter("HOLO: Color and Transparent", 1, color_matrix_filter(rgb(rgb_list[1], rgb_list[2], rgb_list[3], read_opacity() * 255)))

/datum/component/holosynth_effects/proc/refresh_scanline()
	var/mob/living/carbon/human/parent_as_human = parent
	parent_as_human.remove_filter("HOLO: Scanline")
	if(!read_scanline())
		return
	var/atom/movable/scanline = new(null)
	scanline.icon = 'icons/effects/effects.dmi'
	scanline.icon_state = "scanline"
	scanline.appearance_flags |= RESET_TRANSFORM
	var/static/uid = 0
	scanline.render_target = "*HoloScanline [uid++]"
	parent_as_human.add_filter("HOLO: Scanline", 2, alpha_mask_filter(render_source = scanline.render_target))
	parent_as_human.add_overlay(scanline)
	qdel(scanline)

/datum/component/holosynth_effects/proc/read_color()
	var/mob/living/carbon/human/parent_as_human = parent
	return parent_as_human.client?.prefs?.read_preference(/datum/preference/color/mutant/holosynth_color) \
		|| parent_as_human.dna?.features["holo_color"] \
		|| rgb(125, 180, 225)

/datum/component/holosynth_effects/proc/read_opacity()
	var/mob/living/carbon/human/parent_as_human = parent
	var/raw = parent_as_human.dna?.features["holo_transparency"]
	return raw ? clamp(raw / 100, HOLOSYNTH_OPACITY_FLOOR, 1) : HOLOSYNTH_OPACITY_FLOOR

/datum/component/holosynth_effects/proc/read_scanline()
	var/mob/living/carbon/human/parent_as_human = parent
	var/feature = parent_as_human.dna?.features["holo_scanline"]
	return isnull(feature) ? TRUE : feature

/mob/living/carbon/human/proc/holosynth_adjust_transparency()
	set name = "Adjust Hologram Transparency"
	set category = "IC"
	set src = usr

	var/datum/component/holosynth_effects/effects = GetComponent(/datum/component/holosynth_effects)
	if(!effects)
		return
	var/new_value = tgui_input_number(src, "Set transparency. 60 = most see-through, 100 = fully solid.", "Hologram Transparency", (dna?.features["holo_transparency"] || 60), 100, 60)
	if(!new_value)
		return
	dna?.features["holo_transparency"] = new_value
	effects.refresh_opacity()

/mob/living/carbon/human/proc/holosynth_toggle_scanline()
	set name = "Toggle Hologram Flicker"
	set category = "IC"
	set src = usr

	var/datum/component/holosynth_effects/effects = GetComponent(/datum/component/holosynth_effects)
	if(!effects)
		return
	var/new_state = !effects.read_scanline()
	dna?.features["holo_scanline"] = new_state
	effects.refresh_scanline()
	to_chat(src, span_notice("You [new_state ? "enable" : "disable"] your hologram flicker."))

#undef HOLOSYNTH_OPACITY_FLOOR
