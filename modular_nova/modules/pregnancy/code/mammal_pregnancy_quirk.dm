/datum/quirk/mammal_pregnancy
	name = "Mammal Pregnancy"
	desc = "You can become pregnant when someone climaxes inside you."
	icon = FA_ICON_PERSON_PREGNANT
	value = 0
	gain_text = span_notice("You feel fertile.")
	lose_text = span_warning("You no longer feel fertile.")
	medical_record_text = "Patient is capable of mammalian pregnancy."
	erp_quirk = TRUE
	/// Percent chance that an internal climax causes pregnancy.
	var/pregnancy_chance = PREGNANCY_CHANCE_DEFAULT
	/// Pregnancy duration in deciseconds.
	var/pregnancy_duration = PREGNANCY_DURATION_DEFAULT * PREGNANCY_DURATION_MULTIPLIER
	/// Runtime pregnancy behavior flags.
	var/pregnancy_flags = PREGNANCY_FLAG_INERT | PREGNANCY_FLAGS_DEFAULT
	/// Selected egg sprite key.
	var/egg_skin

/datum/quirk/mammal_pregnancy/add(client/client_source)
	read_customization(client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_POST_CLIMAX, PROC_REF(try_pregnancy_from_climax))

/datum/quirk/mammal_pregnancy/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_POST_CLIMAX, PROC_REF(try_pregnancy_from_climax))

/datum/quirk/mammal_pregnancy/proc/read_customization(client/client_source)
	if(!client_source?.prefs)
		egg_skin = GLOB.pregnancy_egg_skins[GLOB.pregnancy_egg_skins.Find("Chicken") || 1]
		return

	pregnancy_chance = client_source.prefs.read_preference(/datum/preference/numeric/pregnancy/chance)
	pregnancy_duration = client_source.prefs.read_preference(/datum/preference/numeric/pregnancy/duration) * PREGNANCY_DURATION_MULTIPLIER

	pregnancy_flags = PREGNANCY_FLAG_INERT
	if(client_source.prefs.read_preference(/datum/preference/toggle/pregnancy/cryptic))
		pregnancy_flags |= PREGNANCY_FLAG_CRYPTIC
	if(client_source.prefs.read_preference(/datum/preference/toggle/pregnancy/belly_inflation))
		pregnancy_flags |= PREGNANCY_FLAG_BELLY_INFLATION
	if(client_source.prefs.read_preference(/datum/preference/toggle/pregnancy/nausea))
		pregnancy_flags |= PREGNANCY_FLAG_NAUSEA

	egg_skin = client_source.prefs.read_preference(/datum/preference/choiced/pregnancy/egg_skin)

/datum/quirk_constant_data/mammal_pregnancy
	associated_typepath = /datum/quirk/mammal_pregnancy
	customization_options = list(
		/datum/preference/numeric/pregnancy/chance,
		/datum/preference/numeric/pregnancy/duration,
		/datum/preference/toggle/pregnancy/cryptic,
		/datum/preference/toggle/pregnancy/belly_inflation,
		/datum/preference/toggle/pregnancy/nausea,
		/datum/preference/choiced/pregnancy/egg_skin,
	)
