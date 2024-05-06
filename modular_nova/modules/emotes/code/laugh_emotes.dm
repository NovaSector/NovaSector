/datum/emote/living/laugh
	mob_type_allowed_typecache = list(/mob/living/carbon/human, /mob/living/silicon/pai)

// This sucks and is not how we should be allowing pais to use these emotes
// for humans use selected_laugh, otherwise default to the species-specific laughs.
/datum/emote/living/laugh/get_sound(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user)) // pais
		human_user = null
		var/mob/living/silicon/pai/pai_user = user
		if(!istype(pai_user))
			return
		return get_pai_laugh_sound(user)

	if(isnull(human_user.selected_laugh)) //For things that don't have a selected laugh(npcs)
		return ..()

	if(human_user.physique == MALE || !LAZYLEN(human_user.selected_laugh.female_laughsounds))
		return pick(human_user.selected_laugh.male_laughsounds)
	else
		return pick(human_user.selected_laugh.female_laughsounds)

/datum/emote/living/laugh/proc/get_pai_laugh_sound(mob/living/silicon/pai/user)
	if(!istype(user))
		return

	if(user.gender == MALE)
		return pick(
			'sound/voice/human/manlaugh1.ogg',
			'sound/voice/human/manlaugh2.ogg',
		)
	else
		return pick(
			'modular_nova/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
			'modular_nova/modules/emotes/sound/emotes/female/female_giggle_2.ogg',
		)

// human laugh - for males use tg audio females use our version
/datum/species/human/get_laugh_sound(mob/living/carbon/human/human)
	if(!ishuman(human))
		return
	if(human.physique == FEMALE)
		return pick(
				'modular_nova/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
				'modular_nova/modules/emotes/sound/emotes/female/female_giggle_2.ogg',

		)
	return pick(
		'sound/voice/human/manlaugh1.ogg',
		'sound/voice/human/manlaugh2.ogg',
	)
