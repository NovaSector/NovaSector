// Lavaland Ruins
// NOTICE: /unpowered means you never get power. Thanks Fikou!

// Interdyne planetary base

/area/ruin/interdyne_planetary_base // used as parent type and for turret control
	name = "Interdyne Pharmaceuticals Spinward Sector Base"
	icon = 'icons/area/areas_centcom.dmi'
	icon_state = "syndie-control"
	ambience_index = AMBIENCE_DANGER
	ambient_buzz = 'sound/ambience/magma.ogg'
	area_flags = UNIQUE_AREA | BLOBS_ALLOWED

/area/ruin/interdyne_planetary_base/cargo
	name = "Interdyne Cargo Bay"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"

/area/ruin/interdyne_planetary_base/cargo/deck
	name = "Interdyne Deck Officer's Office"
	icon_state = "qm_office"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ruin/interdyne_planetary_base/cargo/ware
	name = "Interdyne Warehouse"
	icon_state = "cargo_warehouse"

/area/ruin/interdyne_planetary_base/cargo/obs
	name = "Interdyne Observation Center"
	icon = 'icons/area/areas_centcom.dmi'
	icon_state = "observatory"
	ambience_index = AMBIENCE_DANGER

/area/ruin/interdyne_planetary_base/cargo/obs/Initialize(mapload)
	if(!ambientsounds)
		var/list/temp_ambientsounds = GLOB.ambience_assoc[ambience_index]
		ambientsounds = temp_ambientsounds.Copy()
		ambientsounds += list(
			'modular_nova/modules/encounters/sounds/morse.ogg',
			'sound/ambience/ambitech.ogg',
			'sound/ambience/signal.ogg',
			'modular_nova/modules/encounters/sounds/morse.ogg',
		)
	return ..()

/area/ruin/interdyne_planetary_base/main
	name = "Interdyne Main Hall"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "hall"

/area/ruin/interdyne_planetary_base/main/vault
	name = "Interdyne Vault"
	icon = 'icons/area/areas_centcom.dmi'
	icon_state = "syndie-control"

/area/ruin/interdyne_planetary_base/main/dorms
	name = "Interdyne Dormitories"
	icon_state = "crew_quarters"

/area/ruin/interdyne_planetary_base/main/dorms/lib
	name = "Interdyne Library"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "I love being in the base's library!"
	mood_trait = TRAIT_INTROVERT
	sound_environment = SOUND_AREA_WOODFLOOR

/area/ruin/interdyne_planetary_base/med
	name = "Interdyne Medical Wing"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "medbay"
	ambience_index = AMBIENCE_MEDICAL

/area/ruin/interdyne_planetary_base/med/pharm
	name = "Interdyne Pharmacy"
	icon_state = "pharmacy"

/area/ruin/interdyne_planetary_base/med/viro
	name = "Interdyne Virological Lab"
	icon_state = "virology"
	ambience_index = AMBIENCE_VIROLOGY

/area/ruin/interdyne_planetary_base/med/morgue
	name = "Interdyne Morgue"
	icon_state = "morgue"
	ambience_index = AMBIENCE_SPOOKY
	ambientsounds = list('sound/ambience/ambiicemelody4.ogg') // creepy, but a bit wistful
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/interdyne_planetary_base/science
	name = "Interdyne Science Wing"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "science"

/area/ruin/interdyne_planetary_base/science/xeno
	name = "Interdyne Xenobiological Lab"
	icon_state = "xenobio"

/area/ruin/interdyne_planetary_base/serv
	name = "Interdyne Service Wing"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "hall_service"

/area/ruin/interdyne_planetary_base/serv/rstrm
	name = "Interdyne Unisex Restrooms"
	icon_state = "toilet"

/area/ruin/interdyne_planetary_base/serv/bar
	name = "Interdyne Bar"
	icon_state = "bar"
	mood_bonus = 5
	mood_message = "I love being in the base's bar!"
	mood_trait = TRAIT_EXTROVERT

/area/ruin/interdyne_planetary_base/serv/kitchen
	name = "Interdyne Kitchen"
	icon_state = "kitchen"

/area/ruin/interdyne_planetary_base/serv/hydr
	name = "Interdyne Hydroponics"
	icon_state = "hydro"

/area/ruin/interdyne_planetary_base/eng
	name = "Interdyne Engineering"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "maint_electrical" // given interdyne's powerplant is rtg's, thought this looked good on the frontend for mappers
	ambient_buzz = 'modular_nova/modules/encounters/sounds/gear_loop.ogg'

/area/ruin/interdyne_planetary_base/eng/Initialize(mapload)
	if(!ambientsounds)
		var/list/temp_ambientsounds = GLOB.ambience_assoc[ambience_index]
		ambientsounds = temp_ambientsounds.Copy()
		ambientsounds += list(
			'sound/items/geiger/low1.ogg',
			'sound/items/geiger/low2.ogg',
		)
	return ..()

/area/ruin/interdyne_planetary_base/eng/disp
	name = "Interdyne Disposals"
	icon_state = "disposal"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

//The prefab colonist homestead. Dependent on the colony_fabricator module.
/area/ruin/colonist_homestead
	name = "Colonist Homestead"
