/// Areas for Lavaland 2.0

// openspace for the boi
/turf/open/openspace/lavaland
	name = "ice chasm"
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

// Lavaland sec
/area/mine/security/checkpoint
	name = "Lavaland Security checkpoint"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security

// Lavaland Sci

/area/mine/science
	icon_state = "science"
	airlock_wires = /datum/wires/airlock/science
	name = "Mining Station Science Division"

/area/mine/science/common
	name = "Xenoarcheology Common Room"

/area/mine/science/common/tool
	name = "Xenoarcheology Tool Storage"

/area/mine/science/common/dorm
	name = "Xenoarcheology Resting Room"

/area/mine/science/common/storage
	name = "Xenoarcheology Storage Room"

/area/mine/science/maintenance
	name = "Xenoarcheology Maintenance"

/area/mine/science/maintenance/lower
	name = "Xenoarcheology Lower Maintenance"

/area/mine/science/maintenance/upper
	name = "Xenoarcheology Upper Maintenance"

// Lavaland Engineering/atmos
/area/mine/engineering
	name = "Mining Station Utility Main"
	icon_state = "engie"
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering

/area/mine/engineering/atmos
	name = "Utility Room"

/area/mine/engineering/electrical
	name = "Mining Station Electrical Closet"

/area/mine/engineering/storage
	name = "Mining Station tool storage"

// Mining Underground
// Greenturf - we do a lil monster
/area/lavaland/underground/unexplored
	name = "Lavaland Underground Caves"
	icon_state = "unexplored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | UNIQUE_AREA
	map_generator = /datum/map_generator/cave_generator/lavaland/underground
	allow_shuttle_docking = FALSE

// orangeturf - 'safe passage'
/area/lavaland/underground/unexplored/tunnels
	icon_state = "shore"
	area_flags = UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED
	map_generator = /datum/map_generator/cave_generator/lavaland/tunnel

// blueturf - rock and rubble near the lava rivers
/area/lavaland/underground/unexplored/riverside
	icon_state = "norivers"
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	map_generator = /datum/map_generator/cave_generator/lavaland/riverside

// monster infested
/area/lavaland/underground/unexplored/rivers/deep
	icon_state = "danger"
	area_flags = CAVES_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/lavaland
