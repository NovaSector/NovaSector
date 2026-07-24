/datum/quirk/ropebunny
	name = "Rope bunny"
	desc = "You love being tied up."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_ROPEBUNNY
	medical_record_text = "Subject has a fondness for restraints."
	gain_text = span_danger("You really want to be restrained for some reason.")
	lose_text = span_notice("Being restrained doesn't arouse you anymore.")
	icon = FA_ICON_HANDCUFFS
	erp_quirk = TRUE

/datum/quirk/ropebunny/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_ROPEBUNNY, TRAIT_LEWDQUIRK)

/datum/quirk/ropebunny/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_ROPEBUNNY, TRAIT_LEWDQUIRK)
