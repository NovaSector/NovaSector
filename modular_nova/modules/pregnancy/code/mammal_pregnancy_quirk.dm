/datum/quirk/mammal_pregnancy
	name = "Mammal Pregnancy"
	desc = "You can become pregnant through enabled insemination routes."
	icon = FA_ICON_PERSON_PREGNANT
	value = 0
	gain_text = span_notice("You feel fertile.")
	lose_text = span_warning("You no longer feel fertile.")
	medical_record_text = "Patient is capable of mammalian pregnancy."
	erp_quirk = TRUE

/datum/quirk/mammal_pregnancy/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_POST_CLIMAX, PROC_REF(try_pregnancy_from_climax))

/datum/quirk/mammal_pregnancy/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_POST_CLIMAX, PROC_REF(try_pregnancy_from_climax))

/datum/quirk_constant_data/mammal_pregnancy
	associated_typepath = /datum/quirk/mammal_pregnancy
	customization_options = list(
		/datum/preference/numeric/pregnancy/chance,
		/datum/preference/numeric/pregnancy/duration,
		/datum/preference/toggle/pregnancy/cryptic,
		/datum/preference/toggle/pregnancy/belly_inflation,
		/datum/preference/toggle/pregnancy/nausea,
		/datum/preference/toggle/pregnancy/vaginal_insemination,
		/datum/preference/toggle/pregnancy/anal_insemination,
		/datum/preference/toggle/pregnancy/oral_insemination,
		/datum/preference/choiced/pregnancy/egg_skin,
	)
