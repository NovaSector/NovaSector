///Number of seconds to wait before incrementing stage
#define REJECTION_STAGE_DELAY 180
///Minimum amount of time between jittering and heartbeat sound effects
#define HEARTBEAT_SFX_DELAY 30 SECONDS

/datum/disease/organ_rejection
	form = "Condition"
	name = "Organ Rejection Syndrome"
	max_stages = 4
	stage_prob = 0
	cure_text = "Removal of rejected organs"
	cures = list(/datum/reagent/consumable/sugar)
	cure_chance = 15
	agent = "Transplanted Organ Rejection"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "Also known as Graft Versus Host Disease. If left untreated the subject will suffer from dysfunction of incompatible organs leading to toxin buildup, rashes, nausea, lethargy, and eventually death."
	severity = DISEASE_SEVERITY_DANGEROUS
	disease_flags = CHRONIC
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	spread_text = "Organ failure"
	visibility_flags = HIDDEN_PANDEMIC
	bypasses_immunity = TRUE
	///Number of seconds remaining until the next stage.
	var/stage_timer = REJECTION_STAGE_DELAY
	///Associative list of organ typepaths to organ weakrefs
	var/list/datum/weakref/rejected_organs = list()
	///Cooldown between heartbeat sound effects
	COOLDOWN_DECLARE(heartbeat_cooldown)
	///Cooldown between itching emotes
	COOLDOWN_DECLARE(itch_cooldown)

/datum/disease/organ_rejection/New(obj/item/organ/rejected_organ)
	. = ..()
	if(!isnull(rejected_organ))
		add_organ(rejected_organ)

// Organ Rejection symptoms worsen and increase in variety as stage progresses:
// Stage 1 (alarming): Itchy rash.
// Stage 2 (annoying): Jitters, mild cough.
// Stage 3 (disabling): Nausea, lethargy, coughing fits. Minor toxins.
// Stage 4 (dangerous): Elevated heartbeat, drowsiness, blurred vision. Major toxins.
/datum/disease/organ_rejection/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	if(!length(rejected_organs))
		qdel(src)
		return

	// Increments stage on a delay
	if(stage < max_stages)
		stage_timer -= seconds_per_tick
		if(stage_timer < 1)
			stage_timer = REJECTION_STAGE_DELAY
			update_stage(stage + 1)

	// Stage 1: Looks like Lady Luck just gave you the finger
	// Itchy rashes
	if(SPT_PROB(4, seconds_per_tick) && !affected_mob.IsUnconscious())
		var/obj/item/organ/rejected_organ = pick_affected_organ()
		// Prevent processing of missing or qdeleting rejected organs
		if(isnull(rejected_organ))
			return
		var/obj/item/bodypart/affected_bodypart = rejected_organ.bodypart_owner
		if(IS_ORGANIC_LIMB(affected_bodypart))
			affected_mob.itch(
				target_part = affected_bodypart,
				damage = 0.2 * seconds_per_tick,
				can_scratch = stage > 1,
				silent = !COOLDOWN_FINISHED(src, itch_cooldown)
			)
			COOLDOWN_START(src, itch_cooldown, 5 SECONDS)

	if(stage == 1)
		return

	// Stage 2: Step right up and get some
	if((stage < 4) && SPT_PROB(2.5, seconds_per_tick))
		// Jitters
		to_chat(affected_mob, span_warning(pick("You find it hard to stay still.", "Your heart beats quickly.", "You feel nervous.")))
		affected_mob.adjust_jitter_up_to(10 SECONDS, 30 SECONDS)

	if(stage == 2)
		// Coughing
		if(SPT_PROB(2.5, seconds_per_tick) && !affected_mob.IsUnconscious() && !HAS_TRAIT(affected_mob, TRAIT_SOOTHED_THROAT))
			to_chat(affected_mob, span_danger(pick("Your throat feels itchy.", "Your throat itches incessantly...")))
			affected_mob.emote("cough")
		return

	// Stage 3: There's more where that came from
	// Nausea and vomiting
	if(SPT_PROB(2.5, seconds_per_tick))
		affected_mob.adjust_disgust(33)
	// Excessive coughing
	else if(SPT_PROB(2.5, seconds_per_tick) && !affected_mob.IsUnconscious() && !HAS_TRAIT(affected_mob, TRAIT_SOOTHED_THROAT))
		to_chat(affected_mob, span_userdanger("[pick("You hack and cough!", "You have a coughing fit!", "You can't stop coughing!")]"))
		affected_mob.Immobilize(2 SECONDS)
		affected_mob.emote("cough")
		addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/, emote), "cough"), 0.6 SECONDS)
		addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/, emote), "cough"), 1.2 SECONDS)
		addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/, emote), "cough"), 1.8 SECONDS)

	if(stage == 3)
		// Minor organ decay
		damage_rejected_organs(seconds_per_tick, multiplier = 0.3)
		// Lethargy
		if(SPT_PROB(2.5, seconds_per_tick) && !affected_mob.IsUnconscious())
			to_chat(affected_mob, span_warning(pick("Your muscles feel oddly faint.", "You feel lethargic.", "You feel tired.", "You feel very sleepy.")))
			affected_mob.adjust_stamina_loss(40, FALSE)
		return

	// Stage 4: Let god sort them out
	//Major organ decay
	damage_rejected_organs(seconds_per_tick)
	// Extreme lethargy
	if(SPT_PROB(2.5, seconds_per_tick) && !affected_mob.IsUnconscious())
		to_chat(affected_mob, span_warning(pick("You feel extremely lethargic!", "You have a hard time keeping your eyes open!", "You feel like you are going to pass out at any moment!")))
		affected_mob.adjust_stamina_loss(50, FALSE)
		affected_mob.adjust_eye_blur_up_to(10 SECONDS, 20 SECONDS)
		affected_mob.adjust_drowsiness_up_to(10 SECONDS, 20 SECONDS)
	// Extreme heart-rate
	if(SPT_PROB(2.5, seconds_per_tick) && COOLDOWN_FINISHED(src, heartbeat_cooldown))
		to_chat(affected_mob, span_warning(pick("You feel your heart lurching in your chest!", "Your heart is beating so fast, it hurts!", "You feel your heart practically beating out of your chest!")))
		affected_mob.playsound_local(affected_mob, 'sound/effects/health/fastbeat.ogg', 40, FALSE, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
		affected_mob.set_jitter_if_lower(HEARTBEAT_SFX_DELAY)
		COOLDOWN_START(src, heartbeat_cooldown, HEARTBEAT_SFX_DELAY)

///Stores a weakref to a rejected organ.
///Replaces existing organ weakrefs of the same type.
/datum/disease/organ_rejection/proc/add_organ(obj/item/organ/rejected_organ)
	if(QDELING(rejected_organ.bodypart_owner))
		CRASH("Organ passed to /datum/disease/organ_rejection/proc/add_organ() has a missing or qdeleted bodypart_owner!")

	var/already_had_organ = (rejected_organ.type in rejected_organs)
	rejected_organs[rejected_organ.type] = WEAKREF(rejected_organ)
	if(already_had_organ)
		return
	var/obj/item/bodypart/affected_bodypart = rejected_organ.bodypart_owner
	if(!IS_ORGANIC_LIMB(affected_bodypart))
		return
	var/bodypart_string = isnull(affected_bodypart) ? "side" : affected_bodypart.plaintext_zone
	// The end is nigh...
	to_chat(rejected_organ.owner, span_warning("Your [bodypart_string] develops a painful and itchy rash!"))

///Deletes a rejected organ weakref and then qdels itself if the weakref list becomes empty
/datum/disease/organ_rejection/proc/remove_organ(obj/item/organ/organ_or_type)
	var/obj/item/organ/organ_type = organ_or_type
	if(istype(organ_type))
		organ_type = organ_type.type
	rejected_organs -= organ_type
	if(!length(rejected_organs))
		qdel(src)

///Returns a random rejected organ, otherwise returns null.
///Also deletes any qdeleted organ weakrefs from the rejected_organs list.
/datum/disease/organ_rejection/proc/pick_affected_organ()
	while(length(rejected_organs))
		var/organ_type = pick(rejected_organs)
		var/datum/weakref/organ_ref = rejected_organs[organ_type]
		var/obj/item/organ/rejected_organ = organ_ref.resolve()
		if(QDELETED(rejected_organ) || QDELETED(rejected_organ.bodypart_owner))
			remove_organ(organ_type)
			continue
		return rejected_organ

///Decay every rejected organ if the mob isn't frozen
/datum/disease/organ_rejection/proc/damage_rejected_organs(seconds_per_tick, multiplier = 1)
	for(var/organ_type in rejected_organs)
		var/datum/weakref/organ_ref = rejected_organs[organ_type]
		var/obj/item/organ/rejected_organ = organ_ref.resolve()
		if(QDELETED(rejected_organ) || QDELETED(rejected_organ.bodypart_owner))
			remove_organ(organ_type)
			continue
		if(affected_mob.bodytemperature > T0C)
			var/air_temperature_factor = min((affected_mob.bodytemperature - T0C) / 20, 1)
			var/decay_amount = rejected_organ.decay_factor * rejected_organ.maxHealth * seconds_per_tick * air_temperature_factor
			rejected_organ.apply_organ_damage(multiplier * decay_amount)


#undef REJECTION_STAGE_DELAY
#undef HEARTBEAT_SFX_DELAY
