/obj/item/organ/internal/ears/teshari
	name = "teshari ears"
	desc = "A set of four long rabbit-like ears, a Teshari's main tool while hunting."
	damage_multiplier = 2

/obj/item/organ/internal/ears/teshari/on_mob_insert(mob/living/carbon/ear_owner)
	. = ..()
	ADD_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

/obj/item/organ/internal/ears/teshari/on_mob_remove(mob/living/carbon/ear_owner)
	. = ..()
	REMOVE_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
