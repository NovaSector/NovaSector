/datum/emote/living/laugh
	mob_type_allowed_typecache = list(/mob/living/carbon/human, /mob/living/silicon/pai)
	sounds_by_mobtype = list(
		/mob/living/carbon/human = list(
			MALE = list(
				'sound/mobs/humanoids/human/laugh/manlaugh1.ogg',
				'sound/mobs/humanoids/human/laugh/manlaugh2.ogg',
			),
			FEMALE = list(
				'modular_nova/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
				'modular_nova/modules/emotes/sound/emotes/female/female_giggle_2.ogg',
			),
		),
	)

// This sucks and is not how we should be allowing pais to use these emotes
// for humans use selected_laugh, otherwise default to the species-specific laughs.
/datum/emote/living/laugh/get_sound(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user)) // pais
		return

	if(isnull(human_user.selected_laugh)) //For things that don't have a selected laugh(npcs)
		return ..()

	var/datum/laugh_type/laugh_type = human_user.selected_laugh
	if(human_user.gender == MALE || isnull(laugh_type.female_laugh_type))
		return pick(laugh_type.laugh_sounds)
	else
		var/datum/laugh_type/female_laugh = GLOB.laugh_types[laugh_type.female_laugh_type]
		return pick(female_laugh.laugh_sounds)
