/datum/status_effect/pregnancy
	id = "pregnancy"
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/pregnancy
	remove_on_fullheal = FALSE

	/// Type path used only to label the egg's species in birth messages.
	/// No mob is spawned; eggs are inert.
	var/mob/living/baby_type = /mob/living/carbon/human

	var/egg_skin

	var/pregnancy_flags = PREGNANCY_FLAG_INERT | PREGNANCY_FLAGS_DEFAULT
	var/pregnancy_duration = PREGNANCY_DURATION_DEFAULT * PREGNANCY_DURATION_MULTIPLIER
	var/pregnancy_progress = 0
	var/pregnancy_stage = 0

/datum/status_effect/pregnancy/Destroy()
	if(owner)
		UnregisterSignal(owner, list(\
			COMSIG_LIVING_DEATH,\
			COMSIG_LIVING_HEALTHSCAN,\
		))
		owner.clear_mood_event("pregnancy_labor")
	return ..()

/datum/status_effect/pregnancy/on_creation(mob/living/new_owner, source_data, baby_type_override)
	if(istype(source_data, /datum/quirk/mammal_pregnancy))
		var/datum/quirk/mammal_pregnancy/source_quirk = source_data
		inherit_quirk(source_quirk)
	else if(ispath(source_data, /mob/living))
		baby_type = source_data
	if(ispath(baby_type_override, /mob/living))
		baby_type = baby_type_override

	. = ..()
	if(QDELETED(src))
		return

	RegisterSignal(new_owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(new_owner, COMSIG_LIVING_HEALTHSCAN, PROC_REF(on_health_scan))

/// Copies runtime settings from the quirk instance that caused this pregnancy.
/datum/status_effect/pregnancy/proc/inherit_quirk(datum/quirk/mammal_pregnancy/source_quirk)
	pregnancy_flags = source_quirk.pregnancy_flags
	pregnancy_duration = source_quirk.pregnancy_duration
	egg_skin = source_quirk.egg_skin

/// Miscarriage on death; drops the pregnancy status effect entirely.
/datum/status_effect/pregnancy/proc/on_death(datum/source)
	SIGNAL_HANDLER
	qdel(src)

/// Appends pregnancy info to the health analyzer readout unless the pregnancy is cryptic.
/datum/status_effect/pregnancy/proc/on_health_scan(datum/source, list/render_list, advanced, mob/user, mode, tochat)
	SIGNAL_HANDLER

	if(pregnancy_flags & PREGNANCY_FLAG_CRYPTIC)
		return

	if(pregnancy_stage >= PREGNANCY_STAGE_LABOR)
		render_list += conditional_tooltip("<span class='alert ml-1'>Subject is going into labor!</span>", "Patient may suffer from extreme nausea and fatigue until they deliver their egg.", tochat)
	else if((pregnancy_stage >= PREGNANCY_STAGE_PRESSURE) || advanced)
		render_list += conditional_tooltip("<span class='alert ml-1'>Subject is pregnant[advanced ? " (Stage [pregnancy_stage])" : "."]</span>", "Wait until patient goes into labor, or perform an abortion.", tochat)
	render_list += "<br>"

/datum/status_effect/pregnancy/tick(seconds_between_ticks)
	. = ..()

	pregnancy_progress += (seconds_between_ticks SECONDS)
	var/previous_stage = pregnancy_stage
	pregnancy_stage = min(FLOOR((pregnancy_progress / pregnancy_duration) * PREGNANCY_STAGE_MAX, 1), PREGNANCY_STAGE_MAX)

	if(pregnancy_stage >= PREGNANCY_STAGE_PRESSURE)
		if(previous_stage < PREGNANCY_STAGE_PRESSURE)
			to_chat(owner, span_warning("You can feel some pressure build up against your chest cavity."))
		else if(SPT_PROB(PREGNANCY_KICK_CHANCE, seconds_between_ticks))
			if(pregnancy_flags & PREGNANCY_FLAG_NAUSEA)
				owner.adjust_disgust(PREGNANCY_NAUSEA_DISGUST)
			to_chat(owner, span_warning("Something [pick("squirms", "shakes", "kicks")] inside you."))

	if(pregnancy_stage >= PREGNANCY_STAGE_SWELL)
		if(previous_stage < PREGNANCY_STAGE_SWELL)
			if(pregnancy_flags & PREGNANCY_FLAG_BELLY_INFLATION)
				to_chat(owner, span_warning("Your belly swells as your egg grows."))
		else if(owner.get_stamina_loss() < PREGNANCY_STAMINA_SOFT_CAP)
			owner.adjust_stamina_loss(PREGNANCY_SWELL_STAMINA_PER_SECOND * seconds_between_ticks)

	if(pregnancy_stage >= PREGNANCY_STAGE_LABOR)
		if(previous_stage < PREGNANCY_STAGE_LABOR)
			owner.add_mood_event("pregnancy_labor", /datum/mood_event/pregnant_labor)
			owner.adjust_stamina_loss(rand(PREGNANCY_STAMINA_SOFT_CAP, PREGNANCY_STAMINA_HARD_CAP))
			owner.emote("scream")
			to_chat(owner, span_userdanger("Your water broke! You need to lay down and squeeze the egg out!"))
		else
			var/can_deliver = (owner.body_position == LYING_DOWN)
			if(can_deliver && ishuman(owner))
				var/mob/living/carbon/human/pregnant_human = owner
				var/obj/item/bodypart/covered = pregnant_human.get_bodypart(deprecise_zone(BODY_ZONE_PRECISE_GROIN))
				can_deliver = (!covered || !length(pregnant_human.get_clothing_on_part(covered)))
			if(!can_deliver || !SPT_PROB(PREGNANCY_DELIVERY_CHANCE, seconds_between_ticks))
				if(pregnancy_flags & PREGNANCY_FLAG_NAUSEA)
					owner.adjust_disgust(PREGNANCY_LABOR_DISGUST_PER_SECOND * seconds_between_ticks)
				if((owner.get_stamina_loss() < PREGNANCY_STAMINA_HARD_CAP) && SPT_PROB(PREGNANCY_DELIVERY_CHANCE, seconds_between_ticks))
					owner.emote("scream")
					to_chat(owner, "You REALLY need to give birth!")
			else
				var/egg_species = "animal"
				if(ishuman(owner) && ispath(baby_type, /mob/living/carbon/human))
					var/mob/living/carbon/human/pregnant_human = owner
					egg_species = LOWER_TEXT(pregnant_human.dna.species.name)
				else
					egg_species = LOWER_TEXT(initial(baby_type.name))
				owner.visible_message(\
					span_nicegreen("[owner] gives birth to \a [egg_species] egg!"), \
					span_nicegreen("You give birth to \a [egg_species] egg!"))

				lay_egg(get_turf(owner), egg_species, egg_skin)
				owner.add_mood_event("pregnancy_relief", /datum/mood_event/pregnant_relief)
				if(!QDELETED(src))
					qdel(src)

/// Spawns the oviposition egg at `location`, names it after `egg_species`, and applies the
/// chosen skin icon_state. Eggs are always inert; no baby is ever spawned.
/datum/status_effect/pregnancy/proc/lay_egg(atom/location, egg_species, egg_skin = src.egg_skin)
	var/obj/item/food/egg/oviposition/egg = new(location)
	egg.name = "[egg_species || "nondescript"] egg"
	if(egg_skin)
		var/egg_icon_state = GLOB.pregnancy_egg_skins[egg_skin] || egg_skin
		if(egg_icon_state)
			if(egg_icon_state != "egg" && findtext(egg_icon_state, "egg_") != 1)
				egg_icon_state = "egg_[egg_icon_state]"
			egg.icon_state = egg_icon_state
			egg.base_icon_state = egg_icon_state
			egg.update_appearance(UPDATE_ICON)

/atom/movable/screen/alert/status_effect/pregnancy
	name = "Pregnant"
	desc = "Something grows inside you."
	icon = 'modular_nova/modules/pregnancy/icons/screen_alert.dmi'
	icon_state = "baby"
