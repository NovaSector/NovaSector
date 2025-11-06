#define CONSTANT_DOSE_SAFE_LIMIT 60

#define TWITCH_SCREEN_FILTER "twitch_screen_filter"
#define TWITCH_SCREEN_BLUR "twitch_screen_blur"

#define TWITCH_BLUR_EFFECT "twitch_dodge_blur"
#define TWITCH_OVERDOSE_BLUR_EFFECT "twitch_overdose_blur"

// Reaction to make twitch, makes 10u from 17u input reagents
/datum/chemical_reaction/twitch
	results = list(
		/datum/reagent/drug/twitch = 10,
	)
	required_reagents = list(
		/datum/reagent/impedrezene = 5,
		/datum/reagent/bluespace = 10,
		/datum/reagent/consumable/liquidelectricity/enriched = 2,
	)
	mob_react = FALSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

// Twitch drug, makes the takers of it faster and able to dodge bullets while in their system, to potentially bad side effects
/datum/reagent/drug/twitch
	name = "TWitch"
	description = "A drug originally developed by and for Plutonians to assist them during raids. \
		Does not see wide use, due to the whole reality-disassociation and acute heart disease thing afterwards. \
		Can be intentionally overdosed to increase the drug's effects."
	color = "#c22a44"
	taste_description = "television static"
	metabolization_rate = 0.65 * REAGENTS_METABOLISM
	ph = 3
	overdose_threshold = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/stimulants = 20)
	process_flags = REAGENT_ORGANIC
	/// How much time has the drug been in them?
	var/constant_dose_time = 0
	/// What type of span class do we change heard speech to?
	var/speech_effect_span
	/// How much the mob heating is multiplied by, if the target is a robot or has muscled veins
	var/mob_heating_muliplier = 5


/datum/reagent/drug/twitch/on_mob_metabolize(mob/living/our_guy)
	. = ..()

	our_guy.add_movespeed_modifier(/datum/movespeed_modifier/reagent/twitch)
	our_guy.next_move_modifier *= 0.7 // For the duration of this you move and attack faster

	our_guy.sound_environment_override = SOUND_ENVIRONMENT_DIZZY

	speech_effect_span = "green"

	RegisterSignal(our_guy, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	RegisterSignal(our_guy, COMSIG_MOVABLE_HEAR, PROC_REF(distort_hearing))
	if(!HAS_TRAIT(our_guy, TRAIT_RELAYING_ATTACKER))
		our_guy.AddElement(/datum/element/relay_attackers)
	RegisterSignal(our_guy, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))
	RegisterSignal(our_guy, COMSIG_ATOM_PREHITBY, PROC_REF(on_hitby))

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/static/list/col_filter_green = list(0.5,0,0,0, 0,1,0,0, 0,0,0.5,0, 0,0,0,1)
	var/static/list/col_filter_purple = list(1,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1)

	var/color_filter_to_use = col_filter_green
	if(overdosed)
		color_filter_to_use = col_filter_purple

	game_plane_master_controller.add_filter(TWITCH_SCREEN_FILTER, 10, color_matrix_filter(color_filter_to_use, FILTER_COLOR_RGB))

	game_plane_master_controller.add_filter(TWITCH_SCREEN_BLUR, 1, list("type" = "radial_blur", "size" = 0.02))


/datum/reagent/drug/twitch/on_mob_end_metabolize(mob/living/carbon/our_guy)
	. = ..()

	our_guy.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/twitch)
	our_guy.next_move_modifier /= (overdosed ? 0.49 : 0.7)

	our_guy.sound_environment_override = NONE

	speech_effect_span = "hierophant"

	UnregisterSignal(our_guy, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(our_guy, COMSIG_MOVABLE_HEAR)
	if(overdosed)
		UnregisterSignal(our_guy, COMSIG_ATOM_PRE_BULLET_ACT)
	UnregisterSignal(our_guy, COMSIG_ATOM_WAS_ATTACKED)
	UnregisterSignal(our_guy, COMSIG_ATOM_PREHITBY)
	our_guy.RemoveElement(/datum/element/relay_attackers)

	if(constant_dose_time < CONSTANT_DOSE_SAFE_LIMIT) // Anything less than this and you'll come out fiiiine, aside from a big hit of stamina damage
		if(!(our_guy.mob_biotypes & MOB_ROBOTIC))
			our_guy.visible_message(
				span_danger("[our_guy] suddenly slows from [our_guy.p_their()] inhuman speeds, coming back with a wicked nosebleed!"),
				span_danger("You suddenly slow back to normal, a stream of blood gushing from your nose!")
			)
		else
			our_guy.visible_message(
				span_danger("[our_guy] suddenly slows from [our_guy.p_their()] inhuman speeds!"),
				span_danger("You suddenly slow back to normal speed!")
			)
		our_guy.adjustStaminaLoss(constant_dose_time)

	else // Much longer than that however, and you're not gonna have a good day
		if(!(our_guy.mob_biotypes & MOB_ROBOTIC))
			our_guy.spray_blood(our_guy.dir, 2) // The before mentioned coughing up blood
			our_guy.emote("cough")
			our_guy.visible_message(
				span_danger("[our_guy] suddenly snaps back from [our_guy.p_their()] inhuman speeds, coughing up a spray of blood!"),
				span_danger("As you snap back to normal speed you cough up a worrying amount of blood. You feel like you've just been run over by a power loader.")
			)
		else
			our_guy.visible_message(
				span_danger("[our_guy] suddenly snaps back from [our_guy.p_their()] inhuman speeds!"),
				span_danger("You suddenly snap back to normal speeds. You feel like you've just been run over by a power loader.")
			)
		our_guy.adjustStaminaLoss(constant_dose_time)
		if(!HAS_TRAIT(our_guy, TRAIT_TWITCH_ADAPTED))
			our_guy.adjustOrganLoss(ORGAN_SLOT_HEART, 0.3 * constant_dose_time) // Basically you might die

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.remove_filter(TWITCH_SCREEN_FILTER)
	game_plane_master_controller.remove_filter(TWITCH_SCREEN_BLUR)

/// Signal sent by the relay_attackers element. If the attacker was too close for comfort (in melee range), apply a stagger.
/datum/reagent/drug/twitch/proc/on_attacked(mob/source, mob/attacker, attack_flags)
	SIGNAL_HANDLER
	if(!isliving(source))
		return
	var/mob/living/our_guy = source
	if(get_dist(attacker, source) <= 1)
		our_guy.visible_message(span_warning("[our_guy] is thrown off-balance by [attacker], staggering them badly!"),
		span_warning("Being struck by [attacker] in such close range while TWitched staggers you!"),
		span_warning("You hear the sound of someone being hit by something up close, and a subsequent loss of footing."))
		our_guy.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * 2, STAGGERED_SLOWDOWN_LENGTH * 4) // staggers for +6 seconds, caps at 12

/// Signal sent by COMSIG_ATOM_PREHITBY (from being hit with a thrown item). If someone hits you with a thrown, apply a stagger.
/datum/reagent/drug/twitch/proc/on_hitby(atom/target, atom/movable/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	if(!isliving(target))
		return
	var/mob/living/our_guy = target
	if(!isitem(hit_atom))
		return
	var/obj/item/hit_item = hit_atom
	if(!hit_item.throwforce)
		return
	our_guy.visible_message(span_warning("[our_guy] is thrown off-balance by [hit_atom], staggering them!"),
	span_warning("Being struck by [hit_atom] while TWitched staggers you!"),
	span_warning("You hear the sound of someone being hit by something, and a subsequent loss of footing."))
	our_guy.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH, STAGGERED_SLOWDOWN_LENGTH) // staggers for +3 seconds, caps at 3

/// Leaves an afterimage behind the mob when they move
/datum/reagent/drug/twitch/proc/on_movement(mob/living/carbon/our_guy, atom/old_loc)
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/decoy/twitch_afterimage(old_loc, our_guy)

/// Tries to dodge incoming bullets if we aren't disabled for any reasons
/datum/reagent/drug/twitch/proc/dodge_bullets(mob/living/carbon/human/source, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	if(HAS_TRAIT(source, TRAIT_INCAPACITATED)) // if downed, no bullet dodge
		return NONE
	if(source.get_timed_status_effect_duration(/datum/status_effect/staggered)) // if staggered, no bullet dodge
		return NONE
	if(source.legcuffed) // if legcuffed, no bullet dodge
		return NONE
	source.visible_message(
		span_danger("[source] effortlessly dodges [hitting_projectile]!"),
		span_userdanger("You effortlessly evade [hitting_projectile]!"),
	)
	playsound(source, pick('sound/items/weapons/bulletflyby.ogg', 'sound/items/weapons/bulletflyby2.ogg', 'sound/items/weapons/bulletflyby3.ogg'), 75, TRUE)
	source.add_filter(TWITCH_BLUR_EFFECT, 2, gauss_blur_filter(5))
	addtimer(CALLBACK(source, TYPE_PROC_REF(/datum, remove_filter), TWITCH_BLUR_EFFECT), 0.5 SECONDS)
	return COMPONENT_BULLET_PIERCED


/datum/reagent/drug/twitch/on_mob_life(mob/living/carbon/our_guy, seconds_per_tick, times_fired)
	. = ..()

	constant_dose_time += seconds_per_tick

	// If the target is a robot, or has muscle veins, then they get an effect similar to herignis, heating them up quite a bit
	if((our_guy.mob_biotypes & MOB_ROBOTIC) || HAS_TRAIT(our_guy, TRAIT_STABLEHEART))
		var/heating = mob_heating_muliplier * creation_purity * REM * seconds_per_tick
		our_guy.reagents?.chem_temp += heating
		our_guy.adjust_bodytemperature(heating * TEMPERATURE_DAMAGE_COEFFICIENT)
		if(!ishuman(our_guy))
			return
		var/mob/living/carbon/human/human = our_guy
		human.adjust_coretemperature(heating * TEMPERATURE_DAMAGE_COEFFICIENT)
	else
		our_guy.adjustOrganLoss(ORGAN_SLOT_HEART, 0.1 * REM * seconds_per_tick)

	if(locate(/datum/reagent/drug/kronkaine) in our_guy.reagents.reagent_list) // Kronkaine, another heart-straining drug, could cause problems if mixed with this
		our_guy.ForceContractDisease(new /datum/disease/adrenal_crisis(), FALSE, TRUE)


/datum/reagent/drug/twitch/overdose_start(mob/living/our_guy)
	. = ..()

	RegisterSignal(our_guy, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(dodge_bullets))

	our_guy.next_move_modifier *= 0.7 // Overdosing makes you a liiitle faster but you know has some really bad consequences

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_ourple = list(1,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1)

	for(var/filter in game_plane_master_controller.get_filters(TWITCH_SCREEN_FILTER))
		animate(filter, loop = -1, color = col_filter_ourple, time = 4 SECONDS, easing = BOUNCE_EASING)


/datum/reagent/drug/twitch/overdose_process(mob/living/carbon/our_guy, seconds_per_tick, times_fired)
	. = ..()
	our_guy.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)

	// If the target is a robot, or has muscle veins, then they get an effect similar to herignis, heating them up quite a bit
	if((our_guy.mob_biotypes & MOB_ROBOTIC) || HAS_TRAIT(our_guy, TRAIT_STABLEHEART))
		var/heating = (mob_heating_muliplier * 2) * creation_purity * REM * seconds_per_tick
		our_guy.reagents?.chem_temp += heating
		our_guy.adjust_bodytemperature(heating * TEMPERATURE_DAMAGE_COEFFICIENT)
		if(!ishuman(our_guy))
			return
		var/mob/living/carbon/human/human = our_guy
		human.adjust_coretemperature(heating * TEMPERATURE_DAMAGE_COEFFICIENT)
	else
		our_guy.adjustOrganLoss(ORGAN_SLOT_HEART, 1 * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	our_guy.adjustToxLoss(1 * REM * seconds_per_tick, updating_health = FALSE, forced = TRUE, required_biotype = affected_biotype)

	if(SPT_PROB(5, seconds_per_tick) && !(our_guy.mob_biotypes & MOB_ROBOTIC))
		to_chat(our_guy, span_danger("You cough up a splatter of blood!"))
		our_guy.spray_blood(our_guy.dir, 1)
		our_guy.emote("cough")

	if(SPT_PROB(10, seconds_per_tick))
		our_guy.add_filter(TWITCH_OVERDOSE_BLUR_EFFECT, 2, phase_filter(8))
		addtimer(CALLBACK(our_guy, TYPE_PROC_REF(/datum, remove_filter), TWITCH_OVERDOSE_BLUR_EFFECT), 0.5 SECONDS)

/// Changes heard message spans into that defined on the drug earlier
/datum/reagent/drug/twitch/proc/distort_hearing(datum/source, list/hearing_args)
	SIGNAL_HANDLER
	hearing_args[HEARING_RAW_MESSAGE] = "<span class='[speech_effect_span]'>[hearing_args[HEARING_RAW_MESSAGE]]</span>"


/// Cool filter that I'm using for some of this :)))
/proc/phase_filter(size)
	. = list("type" = "wave")
	.["x"] = 1
	if(!isnull(size))
		.["size"] = size


// Temp visual that changes color for that bootleg sandevistan effect
/obj/effect/temp_visual/decoy/twitch_afterimage
	duration = 0.75 SECONDS
	/// The color matrix it should be at spawn
	var/list/matrix_start = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0.1,0.4,0)
	/// The color matrix it should be by the time it despawns
	var/list/matrix_end = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0.5,0,0)

/obj/effect/temp_visual/decoy/twitch_afterimage/Initialize(mapload)
	. = ..()
	color = matrix_start
	animate(src, color = matrix_end, time = duration, easing = EASE_OUT)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

// Movespeed modifier used by twitch when someone has it in their system
/datum/movespeed_modifier/reagent/twitch
	multiplicative_slowdown = -0.4

#undef TWITCH_SCREEN_FILTER
#undef TWITCH_SCREEN_BLUR

#undef TWITCH_BLUR_EFFECT
#undef TWITCH_OVERDOSE_BLUR_EFFECT
