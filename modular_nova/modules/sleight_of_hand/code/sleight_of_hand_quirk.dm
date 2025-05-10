/datum/quirk/sleight_of_hand
	name = "Sleight of Hand"
	desc = "You're renowned for your card tricks! You're able to shuffle card decks while maintaining the position of the card at the top, along with hiding the result of coin tosses from others."
	gain_text = span_notice("You feel a newfound dexterity in your hands.")
	lose_text = span_notice("Your hands feel clumsy, as if the magic has left them.")
	medical_record_text = "Patient appears to be exceptionally dexterous."
	value = 2
	mob_trait = TRAIT_SLEIGHT_OF_HAND
	icon = FA_ICON_HANDS_HOLDING_CIRCLE
	quirk_flags = QUIRK_HUMAN_ONLY
