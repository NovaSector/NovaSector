/datum/skill/language
	name = "Language"
	title = "Linguist"
	desc = "Do not limit yourself to one language. Languages are doors to different cultures."
	modifiers = list(SKILL_SPEED_MODIFIER = list(1, 0.95, 0.9, 0.85, 0.75, 0.6, 0.5))
	skill_item_path = /obj/item/book_of_babel

/datum/skill/language/level_gained(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	if(new_level >= SKILL_LEVEL_APPRENTICE && old_level < SKILL_LEVEL_APPRENTICE)
		ADD_TRAIT(mind.current, TRAIT_LITERATE, SKILL_TRAIT)
