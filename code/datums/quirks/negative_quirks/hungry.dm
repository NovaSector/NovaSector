#define QUIRK_HUNGRY_MOD 2

/datum/quirk/hungry
	name = "Hungry"
	desc = "You have an accelerated metabolism. In other words, your stomach is bottomless. In any way, you need to eat much more than others."
	value = -2
	icon = FA_ICON_BOWL_FOOD
	mob_trait = TRAIT_HUNGRY
	gain_text = span_notice("You feel like your stomach is bottomless.")
	lose_text = span_notice("You no longer feel like your stomach is bottomless.")
	medical_record_text = "Patient exhibits a significantly faster metabolism."
	mail_goodies = list(/obj/item/food/chips)

/datum/quirk/hungry/add(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	if(istype(H))
		H.physiology.hunger_mod *= QUIRK_HUNGRY_MOD

/datum/quirk/hungry/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(istype(H))
		H.physiology.hunger_mod /= QUIRK_HUNGRY_MOD

#undef QUIRK_HUNGRY_MOD
