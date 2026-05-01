#define COLD_ADAPTED_LUNGS "cold"
#define HOT_ADAPTED_LUNGS "hot"
#define TOX_ADAPTED_LUNGS "toxic"
#define LOW_O2_ADAPTED_LUNGS "low_oxygen"

GLOBAL_LIST_INIT(possible_adapted_lungs, list(
	"Cold adapted lungs" = COLD_ADAPTED_LUNGS,
	"Heat adapted lungs" = HOT_ADAPTED_LUNGS,
	"Toxic adapted lungs" = TOX_ADAPTED_LUNGS,
	"Low-oxygen adapted lungs" = LOW_O2_ADAPTED_LUNGS,
))

/datum/quirk/adapted_lungs
	name = "Adapted Lungs"
	desc = "Your lungs have adapted to be resistant to certain atmospheric conditions, at the cost of being more vulnerable to others."
	medical_record_text = "Patient has abnormal lungs." // this gets overwritten
	icon = FA_ICON_WIND
	value = 0
	/// the choice of lungs the player has selected
	var/desired_lungs

/datum/quirk/adapted_lungs/add_unique(client/client_source)
	if(!quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS))
		to_chat(quirk_holder, span_warning("Your [name] quirk couldn't properly execute due to your species/body lacking a pair of lungs!"))
		qdel(src)
		return

	desired_lungs = GLOB.possible_adapted_lungs[client_source?.prefs?.read_preference(/datum/preference/choiced/adapted_lungs)]
	if(isnull(desired_lungs))  //Client gone or they chose random
		desired_lungs = GLOB.possible_adapted_lungs[pick(GLOB.possible_adapted_lungs)]

	// always update lungs to respect the quirk, even if the organ isn't from roundstart
	RegisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))

/datum/quirk/adapted_lungs/proc/on_gain_organ()
	SIGNAL_HANDLER
	add_adaptation()

///actually add the lungs tweaks with a switch statement
/datum/quirk/adapted_lungs/proc/add_adaptation()
	// this proc is guaranteed to be called multiple times
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return

	switch(desired_lungs)
		if(COLD_ADAPTED_LUNGS)
			add_cold(target_lungs)
		if(HOT_ADAPTED_LUNGS)
			add_hot(target_lungs)
		if(TOX_ADAPTED_LUNGS)
			add_toxic(target_lungs)
		if(LOW_O2_ADAPTED_LUNGS)
			add_low_oxy(target_lungs)

/datum/quirk/adapted_lungs/post_add()
	add_adaptation()
	medical_record_text = "Patient has lungs adapted to [desired_lungs] environments."
	gain_text = span_notice("Your lungs are adapted to [desired_lungs] environments.")
	lose_text = span_warning("Your lungs are no longer adapted to [desired_lungs] environments.")

/datum/quirk/adapted_lungs/remove()
	UnregisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return
	target_lungs.safe_oxygen_min = initial(target_lungs.safe_oxygen_min)
	target_lungs.safe_plasma_max = initial(target_lungs.safe_plasma_max)
	target_lungs.safe_co2_max = initial(target_lungs.safe_co2_max)
	target_lungs.cold_message = initial(target_lungs.cold_message)
	target_lungs.cold_level_1_threshold = initial(target_lungs.cold_level_1_threshold)
	target_lungs.cold_level_2_threshold = initial(target_lungs.cold_level_2_threshold)
	target_lungs.cold_level_3_threshold = initial(target_lungs.cold_level_3_threshold)
	target_lungs.cold_level_1_damage = initial(target_lungs.cold_level_1_damage)
	target_lungs.cold_level_2_damage = initial(target_lungs.cold_level_2_damage)
	target_lungs.cold_level_3_damage = initial(target_lungs.cold_level_3_damage)
	target_lungs.cold_damage_type = initial(target_lungs.cold_damage_type)

	target_lungs.hot_message = initial(target_lungs.hot_message)
	target_lungs.heat_level_1_threshold = initial(target_lungs.heat_level_1_threshold)
	target_lungs.heat_level_2_threshold = initial(target_lungs.heat_level_2_threshold)
	target_lungs.heat_level_3_threshold = initial(target_lungs.heat_level_3_threshold)
	target_lungs.heat_level_1_damage = initial(target_lungs.heat_level_1_damage)
	target_lungs.heat_level_2_damage = initial(target_lungs.heat_level_2_damage)
	target_lungs.heat_level_3_damage = initial(target_lungs.heat_level_3_damage)
	target_lungs.heat_damage_type = initial(target_lungs.heat_damage_type)

/// lungs which can breathe cold but not hot
/datum/quirk/adapted_lungs/proc/add_cold(obj/item/organ/lungs/target_lungs)
	target_lungs.cold_message = "a slightly painful, though bearable, cold sensation"
	target_lungs.cold_level_1_threshold = 208
	target_lungs.cold_level_2_threshold = 200
	target_lungs.cold_level_3_threshold = 170
	target_lungs.cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	target_lungs.cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	target_lungs.cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	target_lungs.cold_damage_type = BURN

	target_lungs.hot_message = "the searing heat with every breath you take"
	target_lungs.heat_level_1_threshold = 318
	target_lungs.heat_level_2_threshold = 348
	target_lungs.heat_level_3_threshold = 1000
	target_lungs.heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	target_lungs.heat_damage_type = BURN

/// lungs which can breathe hot but not cold
/datum/quirk/adapted_lungs/proc/add_hot(obj/item/organ/lungs/target_lungs)
	target_lungs.cold_message = "the freezing cold with every breath you take"
	target_lungs.cold_level_1_threshold = 248
	target_lungs.cold_level_2_threshold = 220
	target_lungs.cold_level_3_threshold = 170
	target_lungs.cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	target_lungs.cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	target_lungs.cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	target_lungs.cold_damage_type = BURN

	target_lungs.hot_message = "a slightly painful, though bearable, warmth"
	target_lungs.heat_level_1_threshold = 373
	target_lungs.heat_level_2_threshold = 473
	target_lungs.heat_level_3_threshold = 523
	target_lungs.heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	target_lungs.heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_1
	target_lungs.heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_damage_type = BURN

/// lungs which can breathe toxic but not hot or cold
/datum/quirk/adapted_lungs/proc/add_toxic(obj/item/organ/lungs/target_lungs)
	target_lungs.safe_plasma_max = 27
	target_lungs.safe_co2_max = 27

	target_lungs.cold_message = "the freezing cold with every breath you take"
	target_lungs.cold_level_1_threshold = 248
	target_lungs.cold_level_2_threshold = 220
	target_lungs.cold_level_3_threshold = 170
	target_lungs.cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	target_lungs.cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	target_lungs.cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	target_lungs.cold_damage_type = BRUTE

	target_lungs.hot_message = "the searing heat with every breath you take"
	target_lungs.heat_level_1_threshold = 318
	target_lungs.heat_level_2_threshold = 348
	target_lungs.heat_level_3_threshold = 1000
	target_lungs.heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	target_lungs.heat_damage_type = BURN

/// lungs which can breathe low oxy but not hot or cold
/datum/quirk/adapted_lungs/proc/add_low_oxy(obj/item/organ/lungs/target_lungs)
	target_lungs.safe_oxygen_min = 5

	target_lungs.hot_message = "the searing heat with every breath you take"
	target_lungs.heat_level_1_threshold = 318
	target_lungs.heat_level_2_threshold = 348
	target_lungs.heat_level_3_threshold = 1000
	target_lungs.heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	target_lungs.heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	target_lungs.heat_damage_type = BURN

	target_lungs.cold_message = "the freezing cold with every breath you take"
	target_lungs.cold_level_1_threshold = 248
	target_lungs.cold_level_2_threshold = 220
	target_lungs.cold_level_3_threshold = 170
	target_lungs.cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	target_lungs.cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	target_lungs.cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	target_lungs.cold_damage_type = BURN

// preference data
/datum/quirk_constant_data/adapted_lungs
	associated_typepath = /datum/quirk/adapted_lungs
	customization_options = list(/datum/preference/choiced/adapted_lungs)

/datum/preference/choiced/adapted_lungs
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "adapted_lungs"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/adapted_lungs/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_adapted_lungs)

/datum/preference/choiced/adapted_lungs/create_default_value()
	return "Random"

/datum/preference/choiced/adapted_lungs/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Adapted Lungs" in preferences.all_quirks

/datum/preference/choiced/adapted_lungs/apply_to_human(mob/living/carbon/human/target, value)
	return

#undef COLD_ADAPTED_LUNGS
#undef HOT_ADAPTED_LUNGS
#undef TOX_ADAPTED_LUNGS
#undef LOW_O2_ADAPTED_LUNGS
