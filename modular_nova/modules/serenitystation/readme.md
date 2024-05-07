## Title: SerenityStation

MODULE ID: SERENITYSTATION

### Description:

A nova-specific map featuring a station located on a forest planet. The forest planet has underground caves filled with mushrooms, and underground liquid plasma springs bubbling to the surface.

This includes 3 z-levels: the underground, mushroom level; the surface, forest level; and a space level that has a small orbital station and linkage to other space z levels.

This station features a custom shuttle to go between the orbital and planetary shuttle, though the public mining shuttle can also go between them (with 3 docking options now: planetary dock, orbital dock and lavaland).

There are custom mushroom tree, mushroom floor and megadeer sprites for this map. The megadeer is more or less a respawned wolf and drops a reskinned wolf crusher trophy.

There are two main cave generation types: the surface and /deep for the caves. There are some grass underground; this is intentional, it is where there is glass above so sun can get through.

The mushroom sprites were cut using the icon cutter; I included the .png and .toml files needed for the cutter if that sprite gets edited. 

### TG Proc/File Changes:

All tg file & defines changes included within existing NOVA edit tags. 

- _maps/_basemap.dm 
- config/maps.txt
- tgstation.dme 

### Modular File Changes: 

- modular_nova/modules/aesthetics/floors/icons/floors.dmi -> added mushroom turf icon 
- modular_nova/modules/automapper/code/area_spawn_subsystem.dm -> added SerenityStation to the automapper's blacklisted stations 
- modular_nova/modules/mapping/code/areas/shuttles.dm -> added the area for the planetary_ferry 
- modular_nova/modules/mapping/code/areas/station.dm -> added the areas used in the station (as these might be reused in mapping; forest-related areas are in the module's folder)
- modular_nova/modules/mapping/code/vgdecals.dm -> added BZ floor decals 
- modular_nova/modules/mapping/icons/areas/areas_station.dmi -> added icons for new station areas (cargo projects room, orbital areas, cyborg storage)
- modular_nova/modules/mapping/icons/turf/decals/vgstation_decals.dmi -> added BZ floor decals 

### Defines:

- code/__DEFINES/icon_smoothing.dm -> SMOOTH_GROUP_MUSHROOM
- code/__DEFINES/~nova_defines/atmospherics.dm -> FOREST_DEFAULT_ATMOS

### Included files that are not contained in this module:

- _maps/map_files/SerenityStation/SerenityStation.dmm
- _maps/serenitystation.json
- _maps/shuttles/nova/planetary_planetary_ferry.dmm

### Credits:

Credits to SableSteel (sable.steel on Discord, thlumyn on Github)
