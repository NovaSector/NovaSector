// Overwriting to get our custom screams from the character selection.

/datum/emote/living/scream/get_sound(mob/living/user)
	if(issilicon(user))
		var/mob/living/silicon/silicon_user = user
		var/datum/scream_type/selected_scream = silicon_user.selected_scream
		if(isnull(selected_scream))
			return 'modular_nova/modules/emotes/sound/voice/scream_silicon.ogg'
		if(user.gender == FEMALE && LAZYLEN(selected_scream.female_screamsounds))
			return pick(selected_scream.female_screamsounds)
		else
			return pick(selected_scream.male_screamsounds)
	if(ismonkey(user))
		return 'modular_nova/modules/emotes/sound/voice/scream_monkey.ogg'
	if (isdrone(user))
		return 'modular_nova/modules/emotes/sound/voice/scream_silicon.ogg'
	if(istype(user, /mob/living/basic/gorilla))
		return 'sound/mobs/non-humanoids/gorilla/gorilla.ogg'
	if(isalien(user))
		return 'sound/mobs/non-humanoids/hiss/hiss6.ogg'
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/scream_type/selected_scream = human_user.selected_scream
		if(isnull(selected_scream) || !(LAZYLEN(selected_scream.male_screamsounds) || LAZYLEN(selected_scream.female_screamsounds))) //For things that don't have a selected scream(npcs)
			if(prob(1))
				return 'sound/mobs/humanoids/human/scream/wilhelm_scream.ogg'
			return human_user.dna.species.get_scream_sound(human_user)
		if(user.gender == FEMALE && LAZYLEN(selected_scream.female_screamsounds))
			return pick(selected_scream.female_screamsounds)
		else
			return pick(selected_scream.male_screamsounds)
	return ..()

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional, params)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user

		if(robot_user.cell?.charge < STANDARD_CELL_CHARGE * 0.2)
			to_chat(robot_user , span_warning("Scream module deactivated. Please recharge."))
			return FALSE
		robot_user.cell.use(STANDARD_CELL_CHARGE * 0.2)
	return ..()
