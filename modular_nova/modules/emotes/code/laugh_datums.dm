GLOBAL_LIST_EMPTY(laugh_types)
GLOBAL_LIST_EMPTY(laugh_types_by_name)

/datum/laugh_type
	abstract_type = /datum/laugh_type
	var/name
	var/list/male_laughsounds
	var/list/female_laughsounds

/datum/laugh_type/Destroy(force)
	if(!force)
		stack_trace("Something is trying to delete a singleton [type]")
		return QDEL_HINT_LETMELIVE
	return ..()

/datum/laugh_type/none //Why would you want this?
	name = "No Laugh"
	male_laughsounds = null
	female_laughsounds = null

/datum/laugh_type/human
	name = "Human Laugh"
	male_laughsounds = list('sound/mobs/humanoids/human/laugh/manlaugh1.ogg',
						'sound/mobs/humanoids/human/laugh/manlaugh2.ogg',)
	female_laughsounds = null
var/datum/laugh_type/female_laugh_type = /datum/laugh_type/human/female


/datum/laugh_type/humanfemme
	name = "Feminine Human Laugh"
	male_laughsounds = list(
		'modular_nova/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
		'modular_nova/modules/emotes/sound/emotes/female/female_giggle_2.ogg'
	)
	female_laughsounds = null

/datum/laugh_type/felinid
	name = "Felinid Laugh"
	male_laughsounds = list('modular_nova/modules/emotes/sound/emotes/nyahaha1.ogg',
			'modular_nova/modules/emotes/sound/emotes/nyahaha2.ogg',
			'modular_nova/modules/emotes/sound/emotes/nyaha.ogg',
			'modular_nova/modules/emotes/sound/emotes/nyahehe.ogg')
	female_laughsounds = null

/datum/laugh_type/moth
	name = "Insect Laugh (Moth)"
	male_laughsounds = list('sound/mobs/humanoids/moth/moth_laugh1.ogg')
	female_laughsounds = null

/datum/laugh_type/lizard
	name = "Lizard Laugh"
	male_laughsounds = list('sound/mobs/humanoids/lizard/lizard_laugh1.ogg')
	female_laughsounds = null

/datum/laugh_type/skrell
	name = "Skrell Laugh"
	male_laughsounds = list(
		'modular_nova/modules/emotes/sound/emotes/skrelllaugh1.ogg',
		'modular_nova/modules/emotes/sound/emotes/skrelllaugh2.ogg',
	)
	female_laughsounds = null

/datum/laugh_type/slugcat
	name = "Slugcat Laugh"
	male_laughsounds = list('modular_nova/modules/emotes/sound/voice/scuglaugh_1.ogg')
	female_laughsounds = null

/datum/laugh_type/clown
	name = "Clown Laugh"
	male_laughsounds = list(
		'sound/mobs/non-humanoids/clown/hohoho.ogg',
		'sound/mobs/non-humanoids/clown/hehe.ogg',
	)
	female_laughsounds = null
