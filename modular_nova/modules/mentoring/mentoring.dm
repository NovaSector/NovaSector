#define AUTHOR_LEVEL_NOVICE 2
#define AUTHOR_LEVEL_APPRENTICE 3
#define AUTHOR_LEVEL_JOURNEYMAN 4
#define AUTHOR_LEVEL_EXPERT 5
#define AUTHOR_LEVEL_MASTER 6

/datum/crafting_recipe/mentoring_book
	name = "Mentoring Book"
	result = /obj/item/mentoring_book
	time = 5 SECONDS
	reqs = list(
		/obj/item/stack/sheet/leather = 1,
		/obj/item/paper = 5,
	)
	category = CAT_ENTERTAINMENT

/obj/item/mentoring_book
	name = "mentoring book"
	desc = "Written on the pages are countless tales of the author's experiences in certain skills. Perhaps reading will help you."
	icon = 'modular_nova/modules/mentoring/mentoring.dmi'
	icon_state = "book"

	///the skill that is written within the book that will be taught
	var/datum/skill/taught_skill

	///the skill level of the author minus one; people will be one level below the author
	var/author_level

	///if selected, this is the language that will be taught to the reader
	var/datum/language/taught_language

	///if selected, will teach sign-language-- because it isn't a language...?
	var/teach_sign = FALSE

	///the list of sentences sent to the author as they write the book
	var/static/list/writing_sentences = list(
		"You philosophize the pedagogical approach for this term...",
		"You wonder if this concept is important for learning...",
		"You have a grand epiphany regarding the societal connections of the skill...",
		"You give pause for marvels of the geniuses that came before...",
		"You write down the creator and father of the skill...",
		"You tap your pen softly against the book, then resume writing...",
	)

	var/static/list/learning_sentences = list(
		"You look at the new word and try to gain context...",
		"You gaze down at the sentence, and wonder how the author arrived at this conclusion...",
		"You ponder the connections between the last word, this word, and the next word...",
		"You realize a commonality between the geniuses written down...",
		"You touch the spine of the book, and then resume reading...",
		"You jot down some notes in the book, then scribble it out...",
	)

/obj/item/mentoring_book/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/obj/item/mentoring_book/Destroy(force)
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)
	return ..()

/obj/item/mentoring_book/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/level_name
	if(author_level)
		switch(author_level)
			if(AUTHOR_LEVEL_NOVICE)
				level_name = "novice"

			if(AUTHOR_LEVEL_APPRENTICE)
				level_name = "apprentice"

			if(AUTHOR_LEVEL_JOURNEYMAN)
				level_name = "journeyman"

			if(AUTHOR_LEVEL_EXPERT)
				level_name = "expert"

			if(AUTHOR_LEVEL_MASTER)
				level_name = "master"

	if(taught_skill)
		examine_list += "This book can teach you to become a(n) [level_name] [initial(taught_skill.title)]."

	if(taught_language)
		examine_list += "This book can teach you to become fluent in [initial(taught_language.name)]."

	if(teach_sign)
		examine_list += "This book can teach you sign language."

	examine_list += "Using a pen will allow you to impart your knowledge about language or skills to the book!"

/// when given a message and an amount of time, requires the user to stand still while receiving the message
/obj/item/mentoring_book/proc/timed_sentence(mob/user, var/sent_message, var/time_amount)
	to_chat(user, span_notice(sent_message))
	playsound(src, SFX_PAGE_TURN, 30, TRUE)
	if(!do_after(user, time_amount, target = src))
		to_chat(user, span_notice("You put the book down..."))
		return FALSE

	return TRUE

/obj/item/mentoring_book/attack_self(mob/user, modifiers)
	if(isnull(taught_skill) && isnull(taught_language) && !teach_sign)
		for(var/scribble_iteration in 1 to 50)
			var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/language, SKILL_SPEED_MODIFIER)
			if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
				to_chat(user, span_notice("You put [src] down."))
				return

			user.mind?.adjust_experience(/datum/skill/language, 5)

		return

	if(taught_skill)
		var/user_level = user.mind?.get_skill_level(taught_skill)
		if(user_level >= author_level)
			to_chat(user, span_notice("You already know all that is in this book."))
			return

		var/learning_exp = 10
		while(user_level < author_level)
			if(!timed_sentence(user, pick(learning_sentences), 6 SECONDS))
				return
			user.mind?.adjust_experience(taught_skill, learning_exp)
			user_level = user.mind?.get_skill_level(taught_skill)
			learning_exp += 5 //this means that it won't take 40 minutes to get from beginner to master... I definitely wouldn't know ;-;

		to_chat(user, span_notice("You have learned all you can learn from [src]."))
		return

	if(taught_language)
		if(user.has_language(taught_language))
			to_chat(user, span_notice("You already know [initial(taught_language.name)]."))
			return

		for(var/language_learning in 1 to 5)
			if(!timed_sentence(user, pick(learning_sentences), 6 SECONDS))
				return

		user.remove_blocked_language(taught_language, source = LANGUAGE_BABEL)
		user.grant_language(taught_language, source = LANGUAGE_BABEL)
		to_chat(user, span_notice("You have fully learned [initial(taught_language.name)]"))
		return

	if(teach_sign)
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.has_quirk(/datum/quirk/item_quirk/signer))
				to_chat(living_user, span_warning("You already know all about sign language!"))
				return

			for(var/language_learning in 1 to 5)
				if(!timed_sentence(living_user, pick(learning_sentences), 6 SECONDS))
					return

			living_user.add_quirk(/datum/quirk/item_quirk/signer)
			to_chat(living_user, span_notice("You have fully learned sign language!"))
			return

		else
			if(user.GetComponent(/datum/component/sign_language))
				to_chat(user, span_warning("You already know all about sign language!"))
				return

			for(var/language_learning in 1 to 5)
				if(!timed_sentence(user, pick(learning_sentences), 6 SECONDS))
					return

			user.AddComponent(/datum/component/sign_language)
			to_chat(user, span_notice("You have fully learned sign language!"))
			return

	return ..()

/obj/item/mentoring_book/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/pen))
		if(taught_skill || taught_language)
			to_chat(user, span_warning("There is already some knowledge stored inside this book-- would you like erase it?"))
			var/erase_choice = tgui_input_list(user, "Erase Knowledge?", "Book Choice", list("Yes", "No"))
			if(isnull(erase_choice))
				return ITEM_INTERACT_BLOCKING

			if(erase_choice != "Yes")
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_warning("You begin to erase the knowledge from [src]!"))
			if(!do_after(user, 10 SECONDS, target = src))
				to_chat(user, span_notice("You decide against erasing the knowledge..."))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_warning("You erased the knowledge!"))
			playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
			taught_skill = null
			author_level = null
			taught_language = null
			teach_sign = FALSE
			return ITEM_INTERACT_SUCCESS

		var/writing_choice = tgui_input_list(user, "What would you like to write in the book?", "Book Choice", list("Languages", "Skills"))
		if(isnull(writing_choice))
			return ITEM_INTERACT_BLOCKING

		switch(writing_choice)
			if("Languages")
				var/current_lang = user.mind?.get_skill_level(/datum/skill/language)
				var/datum/language_holder/lang_holder = user.get_language_holder()
				var/list/language_list = list()
				if(current_lang >= SKILL_LEVEL_MASTER)
					language_list += lang_holder.understood_languages

				if(user.GetComponent(/datum/component/sign_language))
					language_list += list("/datum/language/sign_language")

				if(length(language_list) < 1 || current_lang < SKILL_LEVEL_MASTER)
					to_chat(user, span_warning("You are not a master at languages, and therefore cannot write books teaching languages."))
					return ITEM_INTERACT_BLOCKING

				var/language_choice = tgui_input_list(user, "Which language would you like to write about?", "Language Selection", language_list)
				if(isnull(language_choice))
					to_chat(user, span_notice("You decide against writing."))
					return ITEM_INTERACT_BLOCKING

				for(var/language_iteration in 1 to 5)
					if(!timed_sentence(user, pick(writing_sentences), 6 SECONDS))
						return ITEM_INTERACT_BLOCKING

				to_chat(user, span_notice("You finish writing inside the book about your language."))
				playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
				if(language_choice == "/datum/language/sign_language")
					teach_sign = TRUE

				else
					taught_language = language_choice
					author_level = current_lang - 1

				return ITEM_INTERACT_SUCCESS

			if("Skills")
				var/skill_choice = tgui_input_list(user, "Which skill would you like to write about?", "Skill Selection", user.mind?.known_skills)
				if(isnull(skill_choice))
					return ITEM_INTERACT_BLOCKING

				var/skill_level = user.mind?.get_skill_level(skill_choice)
				if(skill_level < SKILL_LEVEL_APPRENTICE)
					to_chat(user, span_warning("You are not skilled enough to write about this skill!"))
					return ITEM_INTERACT_BLOCKING

				for(var/skill_iteration in 1 to 5)
					if(!timed_sentence(user, pick(writing_sentences), 6 SECONDS))
						return ITEM_INTERACT_BLOCKING

				to_chat(user, span_notice("You finish writing inside the book about your skill."))
				playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
				taught_skill = skill_choice
				author_level = skill_level - 1
				return ITEM_INTERACT_SUCCESS

	return ..()

#undef AUTHOR_LEVEL_NOVICE
#undef AUTHOR_LEVEL_APPRENTICE
#undef AUTHOR_LEVEL_JOURNEYMAN
#undef AUTHOR_LEVEL_EXPERT
#undef AUTHOR_LEVEL_MASTER
