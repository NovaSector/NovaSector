/datum/emote/living/scream
	vary = TRUE
	mob_type_blacklist_typecache = list(/mob/living/carbon/human, /mob/living/basic/slime, /mob/living/brain) //Humans get specialized scream.

/datum/emote/living/scream/get_sound(mob/living/user)
	if(user.is_muzzled())
		return
	if(iscyborg(user))
		return 'modular_nova/modules/emotes/sound/voice/scream_silicon.ogg'
	if(ismonkey(user))
		return 'modular_nova/modules/emotes/sound/voice/scream_monkey.ogg'
	if(istype(user, /mob/living/basic/gorilla))
		return 'sound/creatures/gorilla.ogg'
	if(isalien(user))
		return 'sound/voice/hiss6.ogg'
	if(ishuman(user))
		var/datum/emote/living/carbon/human/scream/human_scream = new
		. = human_scream.get_sound(user)
		qdel(human_scream)
		return

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user

		if(robot_user.cell?.charge < 200)
			to_chat(robot_user , span_warning("Scream module deactivated. Please recharge."))
			return FALSE
		robot_user.cell.use(200)
	return ..()

/datum/emote/living/carbon/human/scream
	only_forced_audio = FALSE

/datum/emote/living/carbon/human/scream/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(user.is_muzzled())
		return
	if(isnull(user.selected_scream) || (LAZYLEN(user.selected_scream.male_screamsounds) && LAZYLEN(user.selected_scream.female_screamsounds))) //For things that don't have a selected scream(npcs)
		if(prob(1))
			return 'sound/voice/human/wilhelm_scream.ogg'
		return user.dna.species.get_scream_sound(user)
	if(user.physique == FEMALE && LAZYLEN(user.selected_scream.female_screamsounds))
		return pick(user.selected_scream.female_screamsounds)
	else
		return pick(user.selected_scream.male_screamsounds)
