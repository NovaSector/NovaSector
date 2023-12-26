// Lavaland Ruins
// NOTICE: /unpowered means you never get power. Thanks Fikou!

// Interdyne planetary base

/area/ruin/interdyne_planetary_base
	name = "Interdyne Pharmaceutics Spinward Sector Base"
	icon_state = "syndicate"
	ambience_index = AMBIENCE_DANGER
	ambient_buzz = 'sound/ambience/magma.ogg'
	area_flags = UNIQUE_AREA | BLOBS_ALLOWED

/area/ruin/interdyne_planetary_base/cargo
	name = "Interdyne Cargo Bay"
	icon_state = "mining"

/area/ruin/interdyne_planetary_base/cargo/deck
	name = "Interdyne Deck Officer's Office"
	icon_state = "quart"

/area/ruin/interdyne_planetary_base/cargo/det
	name = "Interdyne Detention Center"
	icon_state = "holding_cell"

/area/ruin/interdyne_planetary_base/cargo/obs
	name = "Interdyne Observation Center"
	icon_state = "holding_cell"

/area/ruin/interdyne_planetary_base/main
	name = "Interdyne Main Hall"
	icon_state = "secondaryhall"

/area/ruin/interdyne_planetary_base/main/vault
	name = "Interdyne Vault"

/area/ruin/interdyne_planetary_base/main/dorms
	name = "Interdyne Dormitories"
	icon_state = "dorms"

/area/ruin/interdyne_planetary_base/main/dorms/lib
	name = "Interdyne Library"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "I love being in the base's library!"
	mood_trait = TRAIT_INTROVERT
	sound_environment = SOUND_AREA_WOODFLOOR

/area/ruin/interdyne_planetary_base/med
	name = "Interdyne Medical Wing"
	icon_state = "medbay"

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
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/interdyne_planetary_base/science
	name = "Interdyne Science Wing"
	icon_state = "science"

/area/ruin/interdyne_planetary_base/science/xeno
	name = "Interdyne Xenobiological Lab"
	icon_state = "xenobio"

/area/ruin/interdyne_planetary_base/serv
	name = "Interdyne Service Wing"
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
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ruin/interdyne_planetary_base/serv/kitchen
	name = "Interdyne Kitchen"
	icon_state = "kitchen"

/area/ruin/interdyne_planetary_base/serv/hydr
	name = "Interdyne Hydroponics"
	icon_state = "hydro"

/area/ruin/interdyne_planetary_base/eng
	name = "Interdyne Engineering"
	icon_state = "radstorm_shelter" // given interdyne's powerplant is 5 rtg's, thought this looked good on the frontend

/area/ruin/interdyne_planetary_base/eng/disp
	name = "Interdyne Disposals"
	icon_state = "disposal"