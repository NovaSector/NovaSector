/// How opaque vs. see-through holosynths are
#define HOLOSYNTH_OPACITY 0.6

/datum/component/holosynth_effects
	/// Tracks the emissive overlay glow for later deletion
	var/mutable_appearance/glow
	/// Our Parent as a human since some of the fields we're accessing aren't on /datum
	var/mob/living/carbon/human/parent_as_human

/datum/component/holosynth_effects/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	parent_as_human = parent
	. = ..()

/datum/component/holosynth_effects/RegisterWithParent()
	make_hologram_glowless()
	glow = make_emissive()

/datum/component/holosynth_effects/UnregisterFromParent()
	parent_as_human.remove_filter(list("HOLO: Color and Transparent","HOLO: Scanline"))
	parent_as_human.cut_overlay(glow)


/datum/component/holosynth_effects/proc/make_hologram_glowless()
	// allow players to customize holo colour via preferences; fall back to stored DNA value or the original blueish holo color
	var/col_pref = parent_as_human.client?.prefs?.read_preference(/datum/preference/color/mutant/holosynth_color)
	var/color_hex = col_pref || parent_as_human.dna?.features["holo_color"] || rgb(125,180,225)
	var/list/rgb_list = rgb2num(color_hex)
	parent_as_human.add_filter("HOLO: Color and Transparent", 1, color_matrix_filter(rgb(rgb_list[1], rgb_list[2], rgb_list[3], HOLOSYNTH_OPACITY * 255)))
	var/atom/movable/scanline = new(null)
	scanline.icon = 'icons/effects/effects.dmi'
	scanline.icon_state = "scanline"
	scanline.appearance_flags |= RESET_TRANSFORM
	var/static/uid_scan = 0
	scanline.render_target = "*HoloScanline [uid_scan]"
	uid_scan++
	parent_as_human.add_filter("HOLO: Scanline", 2, alpha_mask_filter(render_source = scanline.render_target))
	parent_as_human.add_overlay(scanline)
	qdel(scanline)

/datum/component/holosynth_effects/proc/make_emissive()
	if(!parent_as_human.render_target)
		var/static/uid = 0
		parent_as_human.render_target = "HOLOGRAM [uid]"
		uid++
	var/static/atom/movable/render_step/emissive/glow
	if(!glow)
		glow = new(null)
	glow.render_source = parent_as_human.render_target
	SET_PLANE_EXPLICIT(glow, initial(glow.plane), parent_as_human)
	var/mutable_appearance/glow_appearance = new(glow)
	parent_as_human.add_overlay(glow_appearance)
	LAZYADD(parent_as_human.update_overlays_on_z, glow_appearance)
	return glow_appearance

#undef HOLOSYNTH_OPACITY
