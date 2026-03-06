/datum/quirk/heavyset
	name = "Heavyset"
	desc = "You weigh significantly more than most. It's harder for you to move around and for other people to move you around."
	icon = FA_ICON_WEIGHT_HANGING
	value = 0
	gain_text = span_notice("You feel heavy.")
	lose_text = span_notice("You feel light.")
	medical_record_text = "The patient is far above average weight."

	mob_trait = TRAIT_HEAVYSET

/datum/movespeed_modifier/heavyset
	multiplicative_slowdown = 0.3
	blacklisted_movetypes = FLOATING|FLYING

/datum/quirk/heavyset/add(client/client_source)
	ADD_TRAIT(quirk_holder, TRAIT_NO_SLIP_SLIDE, QUIRK_TRAIT)
	quirk_holder.add_movespeed_modifier(/datum/movespeed_modifier/heavyset)

/datum/quirk/heavyset/remove()
	REMOVE_TRAIT(quirk_holder, TRAIT_NO_SLIP_SLIDE, QUIRK_TRAIT)
	quirk_holder.remove_movespeed_modifier(/datum/movespeed_modifier/heavyset)
