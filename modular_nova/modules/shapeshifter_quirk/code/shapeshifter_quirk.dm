/datum/quirk/shapeshifter
	name = "Shapeshifter"
	desc = "You are able to shapeshift your body at-will."
	icon = FA_ICON_SHAPES
	gain_text = span_purple("Your body feels alterable, malleable.")
	lose_text = span_notice("Your body loses its alterable feeling.")
	medical_record_text = "Patient has an unusual physiology that allows them to physically transform their body."
	value = 8
	veteran_only = TRUE
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/shapeshifter/add(client/client_source)
	var/datum/action/innate/alter_form/quirk/shapeshift_action = new
	shapeshift_action.Grant(quirk_holder)

/datum/quirk/shapeshifter/remove()
	var/datum/action/action_to_remove = locate(/datum/action/innate/alter_form/quirk) in quirk_holder.actions
	if(action_to_remove)
		qdel(action_to_remove)
