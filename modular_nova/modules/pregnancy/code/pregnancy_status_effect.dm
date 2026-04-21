/datum/status_effect/pregnancy
	id = "pregnancy"
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/pregnancy
	remove_on_fullheal = FALSE

	/// Living mob type to spawn as offspring; humans get DNA blending.
	var/mob/living/baby_type = /mob/living/carbon/human
	var/atom/movable/egg_type = /obj/item/food/egg/oviposition

	var/datum/dna/mother_dna
	var/datum/dna/father_dna
	var/mother_name
	var/father_name
	var/baby_name
	var/egg_skin

	var/pregnancy_genetic_distribution = PREGNANCY_GENETIC_DISTRIBUTION_DEFAULT
	var/pregnancy_flags = NONE
	var/pregnancy_duration = PREGNANCY_DURATION_DEFAULT * PREGNANCY_DURATION_MULTIPLIER
	var/pregnancy_progress = 0
	var/pregnancy_stage = 0

/datum/status_effect/pregnancy/Destroy()
	if(owner)
		UnregisterSignal(owner, list(\
			SIGNAL_ADDTRAIT(TRAIT_INFERTILE),\
			COMSIG_ATOM_ATTACKBY,\
			COMSIG_LIVING_DEATH,\
			COMSIG_LIVING_HEALTHSCAN,\
		))
		owner.clear_mood_event("pregnancy")
	return ..()

/datum/status_effect/pregnancy/on_creation(mob/living/new_owner, mob/living/mother, mob/living/father, baby_type_override, egg_type_override)
	if(ispath(baby_type_override, /mob/living))
		src.baby_type = baby_type_override
	if(ispath(egg_type_override, /atom/movable))
		src.egg_type = egg_type_override

	mother_dna = new()
	if(ishuman(mother))
		var/mob/living/carbon/human/mother_human = mother
		mother_human.dna.update_dna_identity()
		mother_human.dna.copy_dna(mother_dna)
		mother_name = mother_human.real_name
	else
		mother_dna.initialize_dna(random_human_blood_type())

	father_dna = new()
	if(ishuman(father))
		var/mob/living/carbon/human/father_human = father
		father_human.dna.update_dna_identity()
		father_human.dna.copy_dna(father_dna)
		father_name = father_human.real_name
	else
		father_dna.initialize_dna(random_human_blood_type())

	inherit_preferences(new_owner)
	. = ..()
	if(QDELETED(src))
		return

	RegisterSignal(new_owner, SIGNAL_ADDTRAIT(TRAIT_INFERTILE), PROC_REF(on_infertile))
	RegisterSignal(new_owner, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attacked_by))
	RegisterSignal(new_owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(new_owner, COMSIG_LIVING_HEALTHSCAN, PROC_REF(on_health_scan))

/datum/status_effect/pregnancy/proc/inherit_preferences(mob/living/gestator)
	var/client/preference_source = GET_CLIENT(gestator)
	if(!preference_source)
		return FALSE

	pregnancy_flags = NONE
	if(preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/cryptic))
		pregnancy_flags |= PREGNANCY_FLAG_CRYPTIC
	if(preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/belly_inflation))
		pregnancy_flags |= PREGNANCY_FLAG_BELLY_INFLATION
	if(preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/inert))
		pregnancy_flags |= PREGNANCY_FLAG_INERT
	if(preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/nausea))
		pregnancy_flags |= PREGNANCY_FLAG_NAUSEA

	pregnancy_duration = preference_source.prefs.read_preference(/datum/preference/numeric/pregnancy/duration) * PREGNANCY_DURATION_MULTIPLIER
	egg_skin = preference_source.prefs.read_preference(/datum/preference/choiced/pregnancy/egg_skin)

/datum/status_effect/pregnancy/proc/try_rename_baby(mob/user)
	var/target_name = reject_bad_name(tgui_input_text(user, "What will be the name of [mother_name || "someone"]'s offspring?", "The miracle of birth"))
	if(!target_name || !user.Adjacent(owner))
		return

	baby_name = target_name
	owner.visible_message(span_notice("[user] writes \"[target_name]\" on [owner]'s belly."), \
		span_notice("[user] writes \"[target_name]\" on your belly."))

/datum/status_effect/pregnancy/proc/on_death(datum/source)
	SIGNAL_HANDLER
	qdel(src)

/datum/status_effect/pregnancy/proc/on_attacked_by(datum/source, obj/item/pen, mob/living/attacker, params)
	SIGNAL_HANDLER

	if(attacker.combat_mode || !istype(pen, /obj/item/pen) || (attacker.zone_selected != BODY_ZONE_PRECISE_GROIN))
		return

	INVOKE_ASYNC(src, PROC_REF(try_rename_baby), attacker)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/status_effect/pregnancy/proc/on_health_scan(datum/source, list/render_list, advanced, mob/user, mode, tochat)
	SIGNAL_HANDLER

	if(pregnancy_flags & PREGNANCY_FLAG_CRYPTIC)
		return

	if(pregnancy_stage >= PREGNANCY_STAGE_LABOR)
		render_list += conditional_tooltip("<span class='alert ml-1'>Subject is going into labor!</span>", "Patient may suffer from extreme nausea and fatigue until they deliver their baby.", tochat)
	else if((pregnancy_stage >= PREGNANCY_STAGE_PRESSURE) || advanced)
		render_list += conditional_tooltip("<span class='alert ml-1'>Subject is pregnant[advanced ? " (Stage [pregnancy_stage])" : "."]</span>", "Wait until patient goes into labor, or perform an abortion.", tochat)
	render_list += "<br>"

/datum/status_effect/pregnancy/proc/on_infertile(atom/source)
	SIGNAL_HANDLER

	if(iscarbon(source))
		var/mob/living/carbon/pregnant_carbon = source
		if(pregnancy_flags & PREGNANCY_FLAG_NAUSEA)
			pregnant_carbon.vomit(vomit_flags = MOB_VOMIT_STUN | MOB_VOMIT_HARM | MOB_VOMIT_BLOOD, lost_nutrition = 20)
		to_chat(pregnant_carbon, span_userdanger("Your belly shrivels up!"))
	qdel(src)

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
			owner.add_mood_event("preggers", /datum/mood_event/pregnant_labor)
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
				owner.add_mood_event("preggers", /datum/mood_event/pregnant_relief)
				if(!QDELETED(src))
					qdel(src)

/datum/status_effect/pregnancy/proc/lay_egg(atom/location, egg_species, egg_skin = src.egg_skin)
	var/atom/movable/egg = new egg_type(location)
	if(istype(egg, /obj/item/food/egg/oviposition))
		var/obj/item/food/egg/oviposition/actually_an_egg = egg
		actually_an_egg.name = "[egg_species || "nondescript"] egg"
		if(egg_skin)
			var/egg_icon_state = GLOB.pregnancy_egg_skins[egg_skin]
			if(egg_icon_state)
				actually_an_egg.icon_state = egg_icon_state
				actually_an_egg.base_icon_state = egg_icon_state
				actually_an_egg.update_appearance(UPDATE_ICON)

	if(pregnancy_flags & PREGNANCY_FLAG_INERT)
		return

	var/mob/living/baby = new baby_type(location)
	if(ishuman(baby))
		var/mob/living/carbon/human/human_baby = baby
		determine_baby_dna(human_baby, src.mother_dna, src.father_dna, src.pregnancy_genetic_distribution)
		if(baby_name)
			human_baby.real_name = baby_name
			human_baby.name = baby_name
			human_baby.updateappearance()
		human_baby.set_resting(new_resting = TRUE, silent = TRUE, instant = TRUE)
	baby.AdjustUnconscious(30 SECONDS)

	egg.AddComponent(/datum/component/pregnant, baby, mother_name, father_name, baby_name, mother_dna, father_dna, pregnancy_genetic_distribution)

/atom/movable/screen/alert/status_effect/pregnancy
	name = "Pregnant"
	desc = "Something grows inside you."
	icon = 'modular_nova/modules/pregnancy/icons/screen_alert.dmi'
	icon_state = "baby"
