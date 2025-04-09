// Nova Sector space area defines - Mostly for ruins

///Generic Nova Sector Ruins

/area/ruin/space/has_grav/powered/nova/smugglies
	name = "Suspicious Cargo Installation"

/area/ruin/space/has_grav/powered/nova/clothing_facility
	name = "Abandoned Research Station"

/area/ruin/space/has_grav/powered/nova/luna
	name = "Unexplored Location"

/area/ruin/space/has_grav/nova/blackmarket
	name = "Shady Market"

/area/ruin/space/has_grav/powered/nova/alien_tool_lab
	name = "Alien Tool Lab"

/area/ruin/space/has_grav/powered/nova/scrapheap
	name = "Scrap Heap"

/area/ruin/space/has_grav/shuttle8532engineering
	name = "Shuttle 8532 Engine Room"

/area/ruin/space/has_grav/shuttle8532researchbay
	name = "Shuttle 8532 Research Bay"

/area/ruin/space/has_grav/shuttle8532cargohall
	name = "Shuttle 8532 Cargo Hall"

/area/ruin/space/has_grav/shuttle8532crewquarters
	name = "Shuttle 8532 Crew Quarters"

/area/ruin/space/has_grav/shuttle8532bridge
	name = "Shuttle 8532 Bridge"

/area/ruin/space/has_grav/vaulttango
	name = "ARBORLINK Vault Tango"

/area/ruin/space/has_grav/waypoint
	name = "Abandoned Station"

/area/ruin/space/has_grav/powered/toy_store
	name = "Toy Store"

/area/ruin/space/has_grav/powered/prison_shuttle
	name = "Prison Shuttle"

/area/ruin/space/has_grav/powered/posterpandamonium
	name = "Strange Shuttle"

/area/ruin/space/has_grav/powered/turretfactory //give it vague mechanical sounds
	name = "Turret Factory"
	ambientsounds = list('sound/ambience/maintenance/ambimaint.ogg','sound/ambience/maintenance/ambimaint1.ogg','sound/ambience/maintenance/ambimaint3.ogg', 'sound/ambience/maintenance/ambimaint5.ogg', 'sound/ambience/maintenance/ambimaint6.ogg')

//Port Tarkon

/area/ruin/space/has_grav/outdoors
	outdoors = TRUE

/area/ruin/space/has_grav/port_tarkon
	name = "P-T Cryo-Storage"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "cryo"

/area/ruin/space/has_grav/port_tarkon/afthall
	name = "P-T Aft Hallway"
	icon_state = "afthall"

/area/ruin/space/has_grav/port_tarkon/forehall
	name = "P-T Fore Hallway"
	icon_state = "forehall"

/area/ruin/space/has_grav/port_tarkon/starboardhall
	name = "P-T Starboard Hallway"
	icon_state = "starboardhall"

/area/ruin/space/has_grav/port_tarkon/porthall
	name = "P-T Port Hallway"
	icon_state = "porthall"

/area/ruin/space/has_grav/port_tarkon/trauma
	name = "P-T Trauma Center"
	icon_state = "med_central"

/area/ruin/space/has_grav/port_tarkon/developement
	name = "P-T Developement Center"
	icon_state = "science"
	area_flags = XENOBIOLOGY_COMPATIBLE | UNIQUE_AREA

/area/ruin/space/has_grav/port_tarkon/comms
	name = "P-T Communication Center"
	icon_state = "command"

/area/ruin/space/has_grav/port_tarkon/power1
	name = "P-T Solar Control"
	icon_state = "engine"

/area/ruin/space/has_grav/port_tarkon/centerhall
	name = "P-T Central Hallway"
	icon_state = "centralhall"

/area/ruin/space/has_grav/port_tarkon/secoff
	name = "P-T Security Office"
	icon_state = "security"

/area/ruin/space/has_grav/port_tarkon/atmos
	name = "P-T Atmospheric Center"
	icon_state = "atmos"

/area/ruin/space/has_grav/port_tarkon/kitchen
	name = "P-T Kitchen"
	icon_state = "cafeteria"

/area/ruin/space/has_grav/port_tarkon/garden
	name = "P-T Garden"
	icon_state = "garden"

/area/ruin/space/has_grav/port_tarkon/cargo
	name = "P-T Cargo Center"
	icon_state = "cargo_office"

/area/ruin/space/has_grav/port_tarkon/mining
	name = "P-T Mining Office"
	icon_state = "mining_dock"

/area/ruin/space/has_grav/port_tarkon/storage
	name = "P-T Warehouse"
	icon_state = "cargo_warehouse"

/area/ruin/space/has_grav/port_tarkon/toolstorage
	name = "P-T Tool Storage"
	icon_state = "tool_storage"

/area/ruin/space/has_grav/port_tarkon/observ
	name = "P-T Observatory"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/port_tarkon/dorms
	name = "P-T Dorms"
	icon_state = "dorms"

/area/solars/tarkon
	name = "P-T Solar Array"
	icon_state = "space_near"
	default_gravity = STANDARD_GRAVITY
	outdoors = TRUE

/**
 * DS2 Syndie Areas
 */
/area/ruin/space/has_grav/nova/des_two
	name = "DS-2" //If DS-1 is so great...
	icon = 'icons/area/areas_centcom.dmi'
	icon_state = "syndie-ship"

//Cargo
/area/ruin/space/has_grav/nova/des_two/cargo
	name = "DS-2 Warehouse"

/area/ruin/space/has_grav/nova/des_two/cargo/hangar
	name = "DS-2 Hangar"

//Bridge
/area/ruin/space/has_grav/nova/des_two/bridge
	name = "DS-2 Bridge"
	icon_state = "syndie-control"

/area/ruin/space/has_grav/nova/des_two/bridge/cl
	name = "DS-2 Corporate Liaison's Office"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/ruin/space/has_grav/nova/des_two/bridge/admiral
	name = "DS-2 Station Admiral's Office"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/ruin/space/has_grav/nova/des_two/bridge/vault
	name = "DS-2 Vault"

/area/ruin/space/has_grav/nova/des_two/bridge/eva
	name = "DS-2 E.V.A."

//Security
/area/ruin/space/has_grav/nova/des_two/security
	name = "DS-2 Security"
	ambience_index = AMBIENCE_DANGER

/area/ruin/space/has_grav/nova/des_two/security/armory
	name = "DS-2 Armory"

/area/ruin/space/has_grav/nova/des_two/security/lawyer
	name = "DS-2 Interrogation Office"

/area/ruin/space/has_grav/nova/des_two/security/prison
	name = "DS-2 Long-Term Brig"

//Service
/area/ruin/space/has_grav/nova/des_two/service
	name = "DS-2 Service Wing"

/area/ruin/space/has_grav/nova/des_two/service/diner
	name = "DS-2 Diner"

/area/ruin/space/has_grav/nova/des_two/service/dorms
	name = "DS-2 Dormitories"

/area/ruin/space/has_grav/nova/des_two/service/dorms/fitness
	name = "DS-2 Fitness Room"

/area/ruin/space/has_grav/nova/des_two/service/lounge
	name = "DS-2 Lounge"

/area/ruin/space/has_grav/nova/des_two/service/hydroponics
	name = "DS-2 Hydroponics"

//Hallways
/area/ruin/space/has_grav/nova/des_two/halls
	name = "DS-2 Central Halls"

//Engineering
/area/ruin/space/has_grav/nova/des_two/engineering
	name = "DS-2 Engineering"

//Research
/area/ruin/space/has_grav/nova/des_two/research
	name = "DS-2 Research"

/area/ruin/space/has_grav/nova/des_two/research/robotics
	name = "DS-2 Robotics Bay"

//Medbay
/area/ruin/space/has_grav/nova/des_two/medbay
	name = "DS-2 Medical Bay"

/area/ruin/space/has_grav/nova/des_two/medbay/chem
	name = "DS-2 Chemistry"

/**
 * Cargodise Lost Freighter defines
 */

/area/ruin/space/has_grav/cargodise_freighter/primaryhall
	name = "Freighter Primary Hall"

/area/ruin/space/has_grav/cargodise_freighter/trauma
	name = "Freighter Trauma Center"

/area/ruin/space/has_grav/cargodise_freighter/utility
	name = "Freighter Utility Room"

/area/ruin/space/has_grav/cargodise_freighter/kitchen
	name = "Freighter Kitchen"

/area/ruin/space/has_grav/cargodise_freighter/bridge
	name = "Freighter Bridge"

/area/ruin/space/has_grav/cargodise_freighter/cargo
	name = "Freighter Cargo Bay"

/area/ruin/space/has_grav/cargodise_freighter/mining
	name = "Freighter Mining Office"

/area/ruin/space/has_grav/cargodise_freighter/quarters
	name = "Freighter Crew Quarters"

/area/ruin/space/has_grav/cargodise_freighter/hydroponics
	name = "Freighter Hydroponics"

/area/ruin/space/has_grav/cargodise_freighter/vault
	name = "Freighter Vault"

/area/ruin/space/has_grav/cargodise_freighter/exterior
	name = "Freighter Exterior"

// Nova Sector's Space Hotel

/area/ruin/space/has_grav/hotel/sauna
	name = "Hotel Sauna Room"

/area/ruin/space/has_grav/hotel/workroom/quarters
	name = "Hotel Staff Quarters"

/area/ruin/solars/hotel/solars
	name = "\improper Hotel Solar Array"
	requires_power = FALSE
	area_flags = UNIQUE_AREA
	sound_environment = SOUND_AREA_SPACE
	base_lighting_alpha = 255
