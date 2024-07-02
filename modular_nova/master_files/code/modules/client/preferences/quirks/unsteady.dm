/datum/preference/numeric/unsteady
	abstract_type = /datum/preference/numeric/unsteady
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

	step = 0.1

// chance to activate after getting hurt
/datum/preference/numeric/unsteady/unsteady_hurtfactor
	savefile_key = "unsteady_hurtfactor"

	minimum = 5
	maximum = 100

// length of the stun after falling over
/datum/preference/numeric/unsteady/unsteady_stunlength
	savefile_key = "unsteady_stunlength"

	minimum = UNSTEADY_DEFAULT_STUNLENGTH
	maximum = 4 SECONDS

// minimum damage required
/datum/preference/numeric/unsteady/unsteady_damagethreshold
	savefile_key = "unsteady_damagethreshold"

	minimum = 0
	maximum = 100

/datum/preference/numeric/unsteady/unsteady_hurtfactor/create_default_value()
	return UNSTEADY_DEFAULT_DAMAGECHANCE

/datum/preference/numeric/unsteady/unsteady_stunlength/create_default_value()
	return UNSTEADY_DEFAULT_STUNLENGTH

/datum/preference/numeric/unsteady/unsteady_damagethreshold/create_default_value()
	return UNSTEADY_DEFAULT_DAMAGETHRESHOLD

/datum/preference/numeric/unsteady/unsteady_stunlength/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/numeric/unsteady/unsteady_damagethreshold/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/numeric/unsteady/unsteady_hurtfactor/apply_to_human(mob/living/carbon/human/target, value)
	return
