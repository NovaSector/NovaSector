/datum/quirk/rigger
	name = "Rigger"
	desc = "You find the weaving of rope knots on the body wonderful."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_RIGGER
	medical_record_text = "Subject has increased dexterity when tying knots."
	gain_text = span_danger("Suddenly you understand rope weaving much better than before.")
	lose_text = span_notice("Rope knots looks complicated again.")
	icon = FA_ICON_CHAIN_BROKEN
	erp_quirk = TRUE

/datum/quirk/rigger/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_RIGGER, TRAIT_LEWDQUIRK)

/datum/quirk/rigger/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_RIGGER, TRAIT_LEWDQUIRK)

/datum/mood_event/sadistic
	description = span_purple("Others' suffering makes me happier.\n")
