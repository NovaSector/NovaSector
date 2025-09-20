// Nova Sector mining-related areas

// Xeno arch
/area/mine/xenoarch
	icon = 'modular_nova/modules/xenoarch/icons/xenoarch_area.dmi'

/area/mine/xenoarch/engineering
	name = "Xenoarch Engineering"
	icon_state = "xa_engine"

/area/mine/xenoarch/engineering/hfr
	name = "Xenoarch HFR Engine"
	icon_state = "xa_hfr"

/area/mine/xenoarch/science
	name = "Xenoarch Science"
	icon_state = "xa_science"

/area/mine/xenoarch/science/xenoarch
	name = "Xenoarch Lab"
	icon_state = "xa_lab"

/area/mine/xenoarch/science/cytology
	name = "Xenoarch Cytology Lab"
	icon_state = "xa_cyto"

/area/mine/xenoarch/living
	name = "Xenoarch Living Quarters"
	icon_state = "xa_living"

/area/mine/xenoarch/maintenance/west
	name = "Xenoarch West Maintenance"
	icon_state = "xa_w_maint"

/area/mine/xenoarch/maintenance/east
	name = "Xenoarch East Maintenance"
	icon_state = "xa_e_maint"

// Mining Underground
// Greenturf - we do a lil monster
/area/lavaland/underground/unexplored
	name = "Lavaland Underground Caves"
	icon_state = "unexplored"
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/lavaland/underground

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
