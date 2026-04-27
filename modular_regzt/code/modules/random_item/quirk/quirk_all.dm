/datum/quirk/no_breath
	name = "no breath"
	desc = "You just don't breathe, it doesn't matter with the help of genes or magic."
	gain_text = span_notice("you feel like you don't need to breathe to live")
	lose_text = span_danger("you feel like you need to breathe again")
	medical_record_text = "the patient is not breathing"
	value = 6
	mob_trait = TRAIT_NOBREATH
	icon = FA_ICON_MASK_VENTILATOR
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/neat_self_surgery
	name = "self surgery"
	desc = "You think you can perform surgery on yourself or replace your own parts."
	gain_text = span_notice("you feel like you can manipulate your insides.")
	lose_text = span_danger("You feel like you can't manipulate your insides.")
	medical_record_text = "the patient is neat self surgery"
	value = 12
	mob_trait = TRAIT_NEAT_SELF_SURGERY
	icon = FA_ICON_MEDKIT
	quirk_flags = QUIRK_HUMAN_ONLY
