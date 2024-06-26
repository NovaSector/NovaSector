/datum/preference/numeric/unsteady
	abstract_type = /datum/preference/numeric/unsteady
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

	step = .1

// chance to activate after getting pushed over
/datum/preference/numeric/unsteady/unsteady_pushfactor
	savefile_key = "unsteady_pushfactor"

	minimum = 5
	maximum = 100

// chance to activate after getting hurt
/datum/preference/numeric/unsteady/unsteady_hurtfactor
	savefile_key = "unsteady_hurtfactor"

	minimum = 5
	maximum = 100

// length of the stun after falling over
/datum/preference/numeric/unsteady/unsteady_stunlength
	savefile_key = "unsteady_stunlength"

	minimum = .5
	maximum = 4

// minimum damage required
/datum/preference/numeric/unsteady/unsteady_stunlength
	savefile_key = "unsteady_stunlength"

	minimum = 0
	maximum = 100
