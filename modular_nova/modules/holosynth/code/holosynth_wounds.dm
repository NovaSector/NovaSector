/// Holosynth-flavored replacements for synth wound text.
/// Keyed by wound typepath; each value is `list("name", "occur_text", "undiagnosed_name")`.
/// * name — diagnosed label shown in scanners and the apply announcement.
/// * occur_text — the "it just happened" chat line inserted into "[victim]'s [limb] [occur_text]!".
/// * undiagnosed_name — layperson label shown in plain examine / self-check.
GLOBAL_LIST_INIT(holosynth_wound_flavor, list(
	/datum/wound/electrical_damage/slash/moderate = list(
		"Dataline Stutter",
		"flickers, trailing static from a severed dataline",
		"Static Flicker",
	),
	/datum/wound/electrical_damage/slash/severe = list(
		"Corrupted Pathways",
		"erupts in garbled static, the projection bleeding into itself",
		"Bleeding Static",
	),
	/datum/wound/electrical_damage/slash/critical = list(
		"Holographic Cascade",
		"collapses into angry geometry, the projection screaming as it tries to reform",
		"Shattering Projection",
	),
	/datum/wound/electrical_damage/pierce/moderate = list(
		"Pierced Projection",
		"ejects a burst of corrupted pixels",
		"Pixel Leak",
	),
	/datum/wound/electrical_damage/pierce/severe = list(
		"Destabilized Emitter",
		"desyncs for a moment, the projection fuzzing and leaking motes of light",
		"Projection Tear",
	),
	/datum/wound/electrical_damage/pierce/critical = list(
		"Ruptured Core Matrix",
		"convulses with blinding holographic noise, screaming the whine of a dying emitter",
		"Collapsing Projection",
	),
	/datum/wound/burn/robotic/overheat/moderate = list(
		"Projection Instability",
		"flickers unsteadily, the projection shimmering with red noise",
		"Flickering Glow",
	),
	/datum/wound/burn/robotic/overheat/severe = list(
		"Emitter Burnout",
		"wavers violently, the projection fraying at the edges",
		"Burning Projection",
	),
	/datum/wound/burn/robotic/overheat/critical = list(
		"Projection Cascade",
		"burns itself into solid static, pixels melting off in streams of light",
		"Melting Light",
	),
	/datum/wound/muscle/robotic/moderate = list(
		"Stuttering Geometry",
		"stutters, desync rippling through the projection",
		"Jittering Projection",
	),
	/datum/wound/muscle/robotic/severe = list(
		"Frozen Projection",
		"freezes mid-motion, stuck in a single keyframe",
		"Frozen Geometry",
	),
	/datum/wound/blunt/robotic/moderate = list(
		"Misaligned Mesh",
		"distorts, vertices drifting out of alignment",
		"Wobbly Pixels",
	),
	/datum/wound/blunt/robotic/secures_internals/severe = list(
		"Fractured Projection",
		"fragments violently, pixels spraying in all directions",
		"Fractured Pixels",
	),
	/datum/wound/blunt/robotic/secures_internals/critical = list(
		"Collapsed Mesh",
		"implodes, geometry shattering into a blinding burst of light",
		"Shattered Geometry",
	),
))

/// Rewrites a synth wound's display text to its holosynth flavor if the victim is a holosynth.
/// Called from each synth wound parent's `update_descriptions` override, which apply_wound invokes
/// before the "occur_text" announcement — so the initial wound chat line already reads as holographic.
/datum/wound/proc/apply_holosynth_flavor()
	if(!victim || !HAS_TRAIT(victim, TRAIT_HOLOSYNTH))
		return
	var/list/flavor = GLOB.holosynth_wound_flavor[type]
	if(!flavor)
		return
	name = flavor[1]
	occur_text = flavor[2]
	undiagnosed_name = flavor[3]

/datum/wound/electrical_damage/update_descriptions()
	. = ..()
	apply_holosynth_flavor()

/// Accumulated seconds of holosynth pen aura exposure. Default heal path qdels the wound once it passes `resolve_seconds`.
/datum/wound/var/holo_aura_progress = 0

/// Per-tick heal hook the pen aura calls on each flavored wound on a linked holosynth.
/// Default path: accumulate exposure, qdel past the threshold. Override on wounds with a native heal API.
/datum/wound/proc/holo_aura_tick(seconds_per_tick, intensity_rate, resolve_seconds)
	if(!resolve_seconds)
		return
	holo_aura_progress += seconds_per_tick
	if(holo_aura_progress >= resolve_seconds)
		qdel(src)

/datum/wound/electrical_damage/holo_aura_tick(seconds_per_tick, intensity_rate, resolve_seconds)
	adjust_intensity(-intensity_rate * seconds_per_tick)

/datum/wound/muscle/robotic/update_descriptions()
	. = ..()
	apply_holosynth_flavor()

/datum/wound/burn/robotic/update_descriptions()
	. = ..()
	apply_holosynth_flavor()

/datum/wound/blunt/robotic/update_descriptions()
	. = ..()
	apply_holosynth_flavor()
