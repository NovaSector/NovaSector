/datum/mood_event/brushed
	description = "Someone brushed me recently, that felt great!"
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/brushed/add_effects(mob/brusher, brush_target)
	description = "[brusher == owner ? "I" : brusher.name] brushed my [brush_target] recently, that felt great!"

/datum/mood_event/brushed/self
	description = "I brushed myself recently!"
	mood_change = 2		// You can't hit all the right spots yourself, or something

/datum/mood_event/brushed/self/add_effects(brush_target)
	description = "I brushed my [brush_target] recently!"

/datum/mood_event/brushed/self/expert // For those with self-awareness trait
	description = "I expertly brushed myself recently!"
	mood_change = 3		// Unless you know what you're doing

/datum/mood_event/brushed/self/expert/add_effects(brush_target)
	description = "I expertly brushed my [brush_target] recently, that felt great!"

/datum/mood_event/brushed/pet/add_effects(mob/brushed_pet)
	description = "I brushed [brushed_pet] recently, they're so cute!"

// Negative

/datum/mood_event/harshly_brushed
	description = "Oww! That brushing was too rough!"
	mood_change = -3

/datum/mood_event/harsh_brushed/add_effects(brush_target)
	description = "Oww! That brushing on my [brush_target] was too rough!"
