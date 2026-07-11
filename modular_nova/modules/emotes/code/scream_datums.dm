GLOBAL_LIST_EMPTY(scream_types)
GLOBAL_LIST_EMPTY(scream_types_by_name)

/datum/scream_type
	abstract_type = /datum/scream_type
	var/name
	/// The list of scream sounds to use for this scream_type
	var/list/scream_sounds
	/// The female scream_type datum to use for this scream_type, if it exists
	var/datum/scream_type/female_scream_type

/datum/scream_type/Destroy(force)
	if(!force)
		stack_trace("Something is trying to delete a singleton [type]")
		return QDEL_HINT_LETMELIVE
	return ..()

/datum/scream_type/none //Why would you want this?
	name = "No Scream"
	scream_sounds = null

/datum/scream_type/human
	name = "Human Scream"
	scream_sounds = list(
		'sound/mobs/humanoids/human/scream/malescream_1.ogg',
		'sound/mobs/humanoids/human/scream/malescream_2.ogg',
		'sound/mobs/humanoids/human/scream/malescream_3.ogg',
		'sound/mobs/humanoids/human/scream/malescream_4.ogg',
		'sound/mobs/humanoids/human/scream/malescream_5.ogg',
		'sound/mobs/humanoids/human/scream/malescream_6.ogg',
	)
	female_scream_type = /datum/scream_type/human/female

/datum/scream_type/human/male
	name = "Human Scream (Masculine)"
	female_scream_type = null

/datum/scream_type/human/female
	name = "Human Scream (Feminine)"
	scream_sounds = list(
		'modular_nova/modules/emotes/sound/voice/scream_f1.ogg',
		'modular_nova/modules/emotes/sound/voice/scream_f2.ogg',
		'modular_nova/modules/emotes/sound/voice/scream_f3.ogg',
	)

/datum/scream_type/human_two
	name = "Human Scream 2"
	scream_sounds = list(
		'sound/mobs/humanoids/human/scream/malescream_1.ogg',
		'sound/mobs/humanoids/human/scream/malescream_2.ogg',
		'sound/mobs/humanoids/human/scream/malescream_3.ogg',
		'sound/mobs/humanoids/human/scream/malescream_4.ogg',
		'sound/mobs/humanoids/human/scream/malescream_5.ogg',
		'sound/mobs/humanoids/human/scream/malescream_6.ogg',
	)
	female_scream_type = /datum/scream_type/human_two/female

/datum/scream_type/human_two/male
	name = "Human Scream 2 (Masculine)"
	female_scream_type = null

/datum/scream_type/human_two/female
	name = "Human Scream 2 (Feminine)"
	scream_sounds = list(
		'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
	)

/datum/scream_type/wilhelm
	name = "Classic Scream"
	scream_sounds = list('sound/mobs/humanoids/human/scream/wilhelm_scream.ogg')

/datum/scream_type/robotic
	name = "Robotic Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/voice/scream_silicon.ogg')

/datum/scream_type/lizard
	name = "Lizard Scream"
	scream_sounds = list(
		'sound/mobs/humanoids/lizard/lizard_scream_1.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_2.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_3.ogg',
	)

/datum/scream_type/lizard2
	name = "Lizard Scream 2"
	scream_sounds = list('modular_nova/modules/emotes/sound/voice/scream_lizard.ogg')

/datum/scream_type/cat
	name = "Cat Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/voice/scream_cat.ogg')

/datum/scream_type/moth
	name = "Moth Scream"
	scream_sounds = list('sound/mobs/humanoids/moth/scream_moth.ogg')

/datum/scream_type/jelly
	name = "Jelly Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/emotes/jelly_scream.ogg')

/datum/scream_type/vox
	name = "Vox Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/emotes/voxscream.ogg')

/datum/scream_type/xeno
	name = "Xeno Scream"
	scream_sounds = list('sound/mobs/non-humanoids/hiss/hiss6.ogg')

/datum/scream_type/raptor //This is the Teshari scream ported from CitRP which was a cockatoo scream edited by BlackMajor.
	name = "Raptor Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/emotes/raptorscream.ogg')

/datum/scream_type/rodent //Ported from Polaris/Virgo.
	name = "Rodent Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/emotes/rodentscream.ogg')

/datum/scream_type/chicken
	name = "Chicken Scream"
	scream_sounds = list('sound/mobs/non-humanoids/chicken/bagawk.ogg')

/datum/scream_type/ethereal
	name = "Ethereal Scream"
	scream_sounds = list(
		'sound/mobs/humanoids/ethereal/ethereal_scream_1.ogg',
		'sound/mobs/humanoids/ethereal/ethereal_scream_2.ogg',
		'sound/mobs/humanoids/ethereal/ethereal_scream_3.ogg')

/datum/scream_type/slugcat
	name = "Slugcat Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/voice/scugscream_1.ogg')

//DONATOR SCREAMS
/datum/scream_type/zombie
	name = "Zombie Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/emotes/zombie_scream.ogg')

/datum/scream_type/monkey
	name = "Monkey Scream"
	scream_sounds = list(
		'modular_nova/modules/emotes/sound/voice/scream_monkey.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_1.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_2.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_3.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_4.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_5.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_6.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_7.ogg',
	)

/datum/scream_type/gorilla
	name = "Gorilla Scream"
	scream_sounds = list('sound/mobs/non-humanoids/gorilla/gorilla.ogg')

/datum/scream_type/skeleton
	name = "Skeleton Scream"
	scream_sounds = list('modular_nova/modules/emotes/sound/voice/scream_skeleton.ogg')

/datum/scream_type/plasmaman
	name = "Plasmaman Scream"
	scream_sounds = list(
		'sound/mobs/humanoids/plasmaman/plasmeme_scream_1.ogg',
		'sound/mobs/humanoids/plasmaman/plasmeme_scream_2.ogg',
		'sound/mobs/humanoids/plasmaman/plasmeme_scream_3.ogg')
