// Nova Sector area ruins

/area/ruin/powered/miningfacility
	name = "Abandoned Nanotrasen Mining Facility"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/music/lobby_music/title3.ogg') //Classic vibes

/area/ruin/powered/crashedshuttle
	name = "Crashed Shuttle"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/ambience/misc/ambiodd.ogg')

/area/ruin/powered/cozycabin
	name = "Cozy Cabin"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/ambience/holy/ambicha1.ogg', 'sound/ambience/holy/ambicha2.ogg', 'sound/ambience/holy/ambicha3.ogg')

/area/ruin/powered/biodome
	name = "Jungle Biodome"
	icon_state = "dk_yellow"

/area/ruin/turretbunker
	name = "Geological Research Bunker" //yes, code is "Turret bunker", But this is more for immersion reasons

/area/ruin/unpowered/magic_hotsprings
	name = "Magical Hotsprings"
	icon_state = "ruins"
	ambientsounds = list('sound/ambience/icemoon/ambiicemelody2.ogg')

/area/ruin/unpowered/abandoned_hearth
	name = "Abandoned Hearth"
	icon_state = "ruins"
	ambientsounds = list('sound/ambience/icemoon/ambiicesting4.ogg', 'sound/ambience/icemoon/ambiicemelody1.ogg')

/area/ruin/unpowered/abandoned_sacred_temple
	name = "Abandoned Sacred Temple"
	icon_state = "ruins"
	ambientsounds = list('sound/ambience/holy/ambiholy.ogg')

/area/ruin/unpowered/frozenwake
	name = "Frozenwake"
	icon_state = "ruins"
	ambientsounds = null
	ambience_index = AMBIENCE_SPOOKY
	ambient_buzz = null
	forced_ambience = TRUE
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	mood_bonus = -5
	mood_message = "The weight of loss clings to the air. Every step feels like an echo of mourning."
	var/frozenwake_stasis_target = null
	var/datum/frozenwake_puzzle/frozenwake_puzzle_controller = new

/area/ruin/unpowered/luna
	name = "\improper Unregistered Structure"
	ambientsounds = list(
		'modular_nova/modules/mapping/sounds/ambience/luna.ogg',
		)
	min_ambience_cooldown = 2 MINUTES
	max_ambience_cooldown = 10 MINUTES

/area/ruin/unpowered/bloodzone
	name = "\improper Unknown Structure"

/area/ruin/unpowered/trilogy_research
	name = "\improper Unsanctioned Structure"
