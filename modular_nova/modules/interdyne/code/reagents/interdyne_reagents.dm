// Interdyne Pharmaceuticals — Proprietary Reagents
// These chemicals are exclusive to the Interdyne chem dispenser.

///////////////////////////////////////////////////////////////////////////////
// PRECURSOR: DYNEXIL
///////////////////////////////////////////////////////////////////////////////

/datum/reagent/medicine/interdyne
	abstract_type = /datum/reagent/medicine/interdyne
	taste_description = "corporate aftertaste"

/datum/reagent/medicine/interdyne/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Interdyne drug interaction — mixing Interdyne chems causes liver damage
	if(istype(src, /datum/reagent/medicine/interdyne/dynexil) || istype(src, /datum/reagent/medicine/interdyne/catalyzine))
		return
	for(var/datum/reagent/other as anything in affected_mob.reagents.reagent_list)
		if(other == src)
			continue
		if(istype(other, /datum/reagent/medicine/interdyne))
			continue
		if(istype(other, /datum/reagent/drug/interdyne))
			continue
		if(istype(other, /datum/reagent/medicine) || istype(other, /datum/reagent/drug))
			if(affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 2.5 * seconds_per_tick, required_organ_flag = affected_organ_flags))
				. = UPDATE_MOB_HEALTH
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Your liver burns — the Interdyne compound is reacting badly with other chemicals in your system!"))
			return

/datum/reagent/medicine/interdyne/dynexil
	name = "Dynexil"
	description = "A proprietary stabilizing compound produced exclusively by Interdyne Pharmaceuticals. \
		Required as a precursor for all Interdyne pharmaceutical formulations. Patent-protected until 2789."
	color = "#2E8B57"
	taste_description = "smooth bitterness"
	ph = 7

/obj/item/reagent_containers/cup/bottle/interdyne_dynexil
	name = "Dynexil bottle"
	desc = "A bottle of Interdyne's proprietary Dynexil stabilizing compound. Required for Interdyne pharmaceutical formulations."
	list_reagents = list(/datum/reagent/medicine/interdyne/dynexil = 30)

///////////////////////////////////////////////////////////////////////////////
// HEALING MEDICINES (crafted from Dynexil + base reagents)
///////////////////////////////////////////////////////////////////////////////

/datum/reagent/medicine/interdyne/bicardyne
	name = "Bicardyne"
	description = "Interdyne's patented tissue regeneration compound. Accelerates bruise healing beyond standard pharmaceutical limits."
	color = "#C8A2C8"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/interdyne/bicardyne/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_brute_loss(-5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/interdyne/bicardyne/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_brute_loss())
		if(affected_mob.adjust_brute_loss(5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC))
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/interdyne/thermapyne
	name = "Thermapyne"
	description = "Interdyne's advanced burn treatment serum. Promotes rapid dermal regeneration in severely burned tissue."
	color = "#FF6347"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/interdyne/thermapyne/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_fire_loss(-5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/interdyne/thermapyne/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_fire_loss())
		if(affected_mob.adjust_fire_loss(5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC))
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/interdyne/omnidyne
	name = "Omnidyne"
	description = "Interdyne's flagship broad-spectrum regenerative. Heals all damage types simultaneously with improved efficacy. \
		The corporate logo is printed on every molecule."
	color = "#7CFC00"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/interdyne/omnidyne/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/heal = -1.3 * normalise_creation_purity() * metabolization_ratio * seconds_per_tick // -0.65 per type at full purity
	var/need_mob_update
	need_mob_update = affected_mob.adjust_tox_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(heal, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
	need_mob_update += affected_mob.adjust_brute_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/interdyne/omnidyne/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/hurt = 3.5 * metabolization_ratio * seconds_per_tick
	var/need_mob_update
	need_mob_update = affected_mob.adjust_tox_loss(hurt, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(hurt, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
	need_mob_update += affected_mob.adjust_brute_loss(hurt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(hurt, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

///////////////////////////////////////////////////////////////////////////////
// METABOLISM BOOSTER
///////////////////////////////////////////////////////////////////////////////

/datum/reagent/medicine/interdyne/catalyzine
	name = "Catalyzine"
	description = "Interdyne's metabolic accelerator compound. Dramatically increases the body's ability to process \
		chemicals by stimulating hepatic enzyme production. Interdyne recommends pairing with their full product line \
		for 'optimal pharmaceutical synergy.'"
	color = "#FFD700"
	taste_description = "metallic sweetness"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	/// The multiplier applied to metabolism_efficiency while active
	var/metabolism_boost = 1.5

/datum/reagent/medicine/interdyne/catalyzine/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.metabolism_efficiency *= metabolism_boost

/datum/reagent/medicine/interdyne/catalyzine/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.metabolism_efficiency /= metabolism_boost

/datum/reagent/medicine/interdyne/catalyzine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Liver strain from the accelerated enzyme production
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 0.3 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags))
		. = UPDATE_MOB_HEALTH

/datum/reagent/medicine/interdyne/catalyzine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update = FALSE
	// Liver takes serious damage from overdrive enzyme production
	need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 2 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
	// Toxin buildup from metabolic waste
	need_mob_update += affected_mob.adjust_tox_loss(1.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(SPT_PROB(8, seconds_per_tick))
		to_chat(affected_mob, span_userdanger("Your insides burn as your metabolism spirals out of control!"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

///////////////////////////////////////////////////////////////////////////////
// EXOTIC CHEMICALS
///////////////////////////////////////////////////////////////////////////////

// --- PANACLARIN-Z: The Omniheal Trip ---

/datum/reagent/drug/interdyne
	abstract_type = /datum/reagent/drug/interdyne
	taste_description = "corporate pharmaceuticals"

/datum/reagent/drug/interdyne/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Interdyne drug interaction — mixing Interdyne chems causes liver damage
	for(var/datum/reagent/other as anything in affected_mob.reagents.reagent_list)
		if(other == src)
			continue
		if(istype(other, /datum/reagent/medicine/interdyne))
			continue
		if(istype(other, /datum/reagent/drug/interdyne))
			continue
		if(istype(other, /datum/reagent/medicine) || istype(other, /datum/reagent/drug))
			if(affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 2.5 * seconds_per_tick, required_organ_flag = affected_organ_flags))
				. = UPDATE_MOB_HEALTH
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Your liver burns — the Interdyne compound is reacting badly with other chemicals in your system!"))
			return

/datum/reagent/drug/interdyne/panaclarinz
	name = "Panaclarin-Z"
	description = "An Interdyne broad-spectrum regenerative compound. Clinical trials were suspended after test subjects \
		began 'seeing through time.' Interdyne's legal department insists the temporal hallucinations are a feature."
	color = "#8A2BE2"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 6
	addiction_types = list(/datum/addiction/hallucinogens = 35)
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/drug/interdyne/panaclarinz/on_mob_metabolize(mob/living/psychonaut)
	. = ..()
	psychonaut.add_mood_event("panaclarinz", /datum/mood_event/high)
	if(!psychonaut.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	// Saturation pulsing — colors oscillate between washed out and oversaturated
	var/list/col_normal = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_saturated = list(1,0,0,0, 0,1.4,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_desaturated = list(1,0,0,0, 0,0.6,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

	game_plane_master_controller.add_filter("panaclarinz_color", 10, color_matrix_filter(col_normal, FILTER_COLOR_HSL))

	for(var/filter in game_plane_master_controller.get_filters("panaclarinz_color"))
		animate(filter, color = col_saturated, time = 3 SECONDS, loop = -1, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
		animate(color = col_desaturated, time = 3 SECONDS, easing = SINE_EASING)
		animate(color = col_normal, time = 3 SECONDS, easing = SINE_EASING)

	// Gentle wave — reality shimmers
	game_plane_master_controller.add_filter("panaclarinz_wave", 1, list("type" = "wave", "size" = 1, "x" = 64, "y" = 64))

	for(var/filter in game_plane_master_controller.get_filters("panaclarinz_wave"))
		animate(filter, time = 32 SECONDS, loop = -1, easing = LINEAR_EASING, offset = 32, flags = ANIMATION_PARALLEL)

/datum/reagent/drug/interdyne/panaclarinz/on_mob_end_metabolize(mob/living/psychonaut)
	. = ..()
	psychonaut.clear_mood_event("panaclarinz")
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("panaclarinz_color")
	game_plane_master_controller.remove_filter("panaclarinz_wave")

/datum/reagent/drug/interdyne/panaclarinz/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Healing — all 4 damage types at 0.5/tick
	var/heal = -1 * metabolization_ratio * seconds_per_tick
	var/need_mob_update
	need_mob_update = affected_mob.adjust_tox_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(heal, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
	need_mob_update += affected_mob.adjust_brute_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)

	// Brain damage — the cost of seeing through time
	need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.15 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)

	// Escalating side effects
	if(current_cycle > 10 && SPT_PROB(5, seconds_per_tick))
		affected_mob.emote(pick("twitch", "shiver"))
	if(current_cycle > 20 && SPT_PROB(3, seconds_per_tick))
		if(isturf(affected_mob.loc) && !isspaceturf(affected_mob.loc) && !HAS_TRAIT(affected_mob, TRAIT_IMMOBILIZED))
			step(affected_mob, pick(GLOB.cardinals))

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/drug/interdyne/panaclarinz/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_hallucinations(15 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1.5 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags))
		. = UPDATE_MOB_HEALTH
	if(SPT_PROB(15, seconds_per_tick))
		shake_camera(affected_mob, 10, 2)
		to_chat(affected_mob, span_userdanger("Reality fractures \u2014 you can see every possible timeline at once!"))

// --- VELOCITOL: The Accelerant ---

/datum/reagent/drug/interdyne/velocitol
	name = "Velocitol"
	description = "Interdyne's kinetic enhancement serum. Developed for corporate rapid-response teams. \
		Side effects include involuntary acceleration and existential dread. Not approved for low-gravity environments."
	color = "#00CED1"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 8
	addiction_types = list(/datum/addiction/stimulants = 55)
	metabolized_traits = list(TRAIT_STIMULATED, TRAIT_IGNORESLOWDOWN)
	/// Attack speed multiplier — lower is faster
	var/attack_speed_boost = 0.8

/datum/reagent/drug/interdyne/velocitol/on_mob_metabolize(mob/living/speedster)
	. = ..()
	speedster.add_actionspeed_modifier(/datum/actionspeed_modifier/interdyne_velocitol)
	speedster.next_move_modifier *= attack_speed_boost
	if(!speedster.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = speedster.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	// Tunnel vision — radial blur pulsing
	game_plane_master_controller.add_filter("velocitol_blur", 1, list("type" = "radial_blur", "size" = 0))

	for(var/filter in game_plane_master_controller.get_filters("velocitol_blur"))
		animate(filter, size = 0.03, time = 1.5 SECONDS, loop = -1, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
		animate(size = 0, time = 1.5 SECONDS, easing = SINE_EASING)

	// Cyan tint — reduced red channel
	var/list/col_filter_cyan = list(0.6,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	game_plane_master_controller.add_filter("velocitol_color", 10, color_matrix_filter(col_filter_cyan, FILTER_COLOR_RGB))

/datum/reagent/drug/interdyne/velocitol/on_mob_end_metabolize(mob/living/speedster)
	. = ..()
	speedster.remove_actionspeed_modifier(/datum/actionspeed_modifier/interdyne_velocitol)
	speedster.next_move_modifier /= attack_speed_boost
	if(!speedster.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = speedster.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("velocitol_blur")
	game_plane_master_controller.remove_filter("velocitol_color")

/datum/reagent/drug/interdyne/velocitol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update = FALSE

	// Stamina recovery
	need_mob_update = affected_mob.adjust_stamina_loss(-2 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)

	// Liver damage — the cost of speed
	need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 0.4 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)

	// Over-acceleration — involuntary random steps
	if(SPT_PROB(8, seconds_per_tick))
		if(isturf(affected_mob.loc) && !isspaceturf(affected_mob.loc) && !HAS_TRAIT(affected_mob, TRAIT_IMMOBILIZED))
			step(affected_mob, pick(GLOB.cardinals))

	// Hands too fast for grip
	if(SPT_PROB(3, seconds_per_tick))
		var/obj/item/held = affected_mob.get_active_held_item()
		if(held)
			affected_mob.dropItemToGround(held)
			to_chat(affected_mob, span_warning("Your hands move faster than your grip can hold!"))

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/drug/interdyne/velocitol/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update = FALSE

	// Constant random movement
	if(isturf(affected_mob.loc) && !isspaceturf(affected_mob.loc) && !HAS_TRAIT(affected_mob, TRAIT_IMMOBILIZED))
		for(var/i in 1 to 3)
			step(affected_mob, pick(GLOB.cardinals))

	// Heart damage
	need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_HEART, 1 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)

	// Screen shake
	shake_camera(affected_mob, 5, 3)

	if(SPT_PROB(10, seconds_per_tick))
		to_chat(affected_mob, span_userdanger("You can't slow down!"))
		affected_mob.emote("twitch")

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/actionspeed_modifier/interdyne_velocitol
	multiplicative_slowdown = -0.3

// --- NEUROPHRENE: The Nootropic ---

/datum/reagent/drug/interdyne/neurophrene
	name = "Neurophrene"
	description = "A nootropic from Interdyne's NeuroSciences division. Sharpens mental acuity while dissolving \
		the blood-brain barrier. Interdyne recommends no more than two doses per solar cycle. Their top salespeople take six."
	color = "#ADFF2F"
	metabolization_rate = 0.3 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 7.5
	addiction_types = list(/datum/addiction/stimulants = 40)
	metabolized_traits = list(TRAIT_SLEEPIMMUNE)
	/// Messages the user hears as phantom whispers
	var/static/list/whisper_messages = list(
		"You hear whispers just beyond comprehension...",
		"Numbers cascade behind your eyelids...",
		"You feel your thoughts accelerate beyond your control...",
		"Patterns emerge in the static of reality...",
		"Your synapses fire in perfect synchrony... almost too perfect...",
	)

/datum/reagent/drug/interdyne/neurophrene/on_mob_metabolize(mob/living/thinker)
	. = ..()
	thinker.add_mood_event("neurophrene", /datum/mood_event/high)
	if(!thinker.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = thinker.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	// Hyper-saturated — everything looks crisp and vivid
	var/list/col_vivid = list(1,0,0,0, 0,1.5,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_vivid_pulse = list(1,0,0,0, 0,1.3,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

	game_plane_master_controller.add_filter("neurophrene_color", 10, color_matrix_filter(col_vivid, FILTER_COLOR_HSL))

	for(var/filter in game_plane_master_controller.get_filters("neurophrene_color"))
		animate(filter, color = col_vivid_pulse, time = 2 SECONDS, loop = -1, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
		animate(color = col_vivid, time = 2 SECONDS, easing = SINE_EASING)

	// Edge glow — sharpened perception outline
	game_plane_master_controller.add_filter("neurophrene_outline", 1, outline_filter(0.5, "#FFFFFF40"))

/datum/reagent/drug/interdyne/neurophrene/on_mob_end_metabolize(mob/living/thinker)
	. = ..()
	thinker.clear_mood_event("neurophrene")
	thinker.clear_fullscreen("neurophrene_od")
	if(!thinker.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = thinker.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("neurophrene_color")
	game_plane_master_controller.remove_filter("neurophrene_outline")

/datum/reagent/drug/interdyne/neurophrene/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update = FALSE

	// Clear confusion and dizziness each tick
	affected_mob.remove_status_effect(/datum/status_effect/confusion)
	affected_mob.remove_status_effect(/datum/status_effect/dizziness)

	// Partial anti-stun
	affected_mob.AdjustAllImmobility(-8 * metabolization_ratio * seconds_per_tick)

	// Brain damage — ironic cost of a nootropic
	need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)

	// Toxin damage
	need_mob_update += affected_mob.adjust_tox_loss(0.15 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)

	// Phantom whispers
	if(SPT_PROB(5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[pick(whisper_messages)]"))

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/drug/interdyne/neurophrene/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update = FALSE

	// Heavy brain damage
	need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)

	// Hallucinations
	affected_mob.adjust_hallucinations(20 SECONDS * metabolization_ratio * seconds_per_tick)

	// TV static overlay
	affected_mob.overlay_fullscreen("neurophrene_od", /atom/movable/screen/fullscreen/flash/static)

	// Forced screaming
	if(SPT_PROB(8, seconds_per_tick))
		affected_mob.emote("scream")
		to_chat(affected_mob, span_userdanger("You can feel every neuron firing simultaneously!"))

	if(need_mob_update)
		return UPDATE_MOB_HEALTH
