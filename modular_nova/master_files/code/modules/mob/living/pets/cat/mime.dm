/mob/living/basic/pet/cat/mime
	name = "mime cat"
	desc = "Almost invisible, this little fella eats mice you can't even see!"
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "catmime"
	icon_living = "catmime"
	icon_dead = "catmime_dead"
	ai_controller = /datum/ai_controller/basic_controller/cat/mime
	speak_emote = list("...",)
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
		/obj/item/clothing/mask/gas/mime = 1,
	)

/datum/ai_controller/basic_controller/cat/mime
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/catmime,
	)

/datum/ai_planning_subtree/random_speech/catmime
	speech_chance = 1
	speak = list(
		"...",
		"....",
	)
	emote_see = list("cowers in fear.", "surrenders.", "plays dead.","looks as though there is a tiny cat shaped wall in front of them.")
