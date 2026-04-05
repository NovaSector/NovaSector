/datum/blood_type/nabber
	name = BLOOD_TYPE_NABBER
	color = BLOOD_COLOR_NABBER
	compatible_types = list(
		/datum/blood_type/nabber,
	)

/datum/blood_type/vox
	name = BLOOD_TYPE_VOX
	color = BLOOD_COLOR_VOX
	compatible_types = list(
		/datum/blood_type/vox,
	)

/datum/blood_type/insect
	name = BLOOD_TYPE_INSECT
	color = BLOOD_COLOR_INSECT
	compatible_types = list(
		/datum/blood_type/insect,
	)

/datum/blood_type/skrell
	name = BLOOD_TYPE_SKRELL
	color = /datum/reagent/copper::color
	compatible_types = list(
		/datum/blood_type/skrell,
	)

/datum/blood_type/polysmorph
	name = BLOOD_TYPE_POLYSMORPH
	color = /datum/reagent/toxin/acid::color
	reagent_type = /datum/reagent/toxin/acid

/datum/blood_type/holosynth
	name = BLOOD_TYPE_HOLOGEL
	color = BLOOD_COLOR_HOLOGEL
	restoration_chem = /datum/reagent/silicon
	compatible_types = list(
		/datum/blood_type/holosynth,
	)

/datum/blood_type/holosynth/get_emissive_alpha(atom/source, is_worn = FALSE)
	if (is_worn)
		return 102
	return 125

/datum/blood_type/holosynth/set_up_blood(obj/effect/decal/cleanable/blood/blood, new_splat = FALSE)
	. = ..()
	blood.emissive_alpha = max(blood.emissive_alpha, new_splat ? 125 : 63)
	if (new_splat)
		return
	blood.can_dry = FALSE
