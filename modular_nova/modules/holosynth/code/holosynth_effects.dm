/// How opaque vs. see-through holosynths are
#define HOLOSYNTH_OPACITY 0.6

/datum/component/holosynth_effects
	/// Tracks the emissive overlay glow for later deletion
	var/mutable_appearance/glow

/datum/component/holosynth_effects/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	return ..()

/datum/component/holosynth_effects/RegisterWithParent()
	var/mob/living/carbon/human/parent_as_human = parent
	var/col_pref = parent_as_human.client?.prefs?.read_preference(/datum/preference/color/mutant/holosynth_color)
	var/color_hex = col_pref || parent_as_human.dna?.features["holo_color"] || rgb(125, 180, 225)
	glow = parent_as_human.makeHologram(HOLOSYNTH_OPACITY, color_hex)

/datum/component/holosynth_effects/UnregisterFromParent()
	var/mob/living/carbon/human/parent_as_human = parent
	parent_as_human.remove_filter(list("HOLO: Color and Transparent", "HOLO: Scanline"))
	parent_as_human.cut_overlay(glow)

#undef HOLOSYNTH_OPACITY
