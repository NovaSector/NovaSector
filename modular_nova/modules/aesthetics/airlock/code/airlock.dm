/obj/machinery/door/airlock
	doorOpen = 'modular_nova/modules/aesthetics/airlock/sound/open.ogg'
	doorClose = 'modular_nova/modules/aesthetics/airlock/sound/close.ogg'
	boltUp = 'modular_nova/modules/aesthetics/airlock/sound/bolts_up.ogg'
	boltDown = 'modular_nova/modules/aesthetics/airlock/sound/bolts_down.ogg'
	/// sound to play when forced open
	var/forced_open_sound = 'modular_nova/modules/aesthetics/airlock/sound/open_force.ogg' //Come on guys, why aren't all the sound files like this.

	/// For those airlocks you might want to have varying "fillings" for, without having to
	/// have an icon file per door with a different filling.
	var/fill_state_suffix = null
	/// For the airlocks that use a greyscale accent door color, set this color to the accent color you want it to be.
	var/greyscale_accent_color = null
	/// Does this airlock emit a light?
	var/has_environment_lights = TRUE
	/// Is this door external? E.g. does it lead to space? Shuttle docking systems bolt doors with this flag.
	var/external = FALSE

/obj/machinery/door/airlock/external
	external = TRUE

/obj/machinery/door/airlock/shuttle
	external = TRUE

/obj/machinery/door/airlock/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	validate_as_external(port)

/// Checks validity of var external and automatically sets it appropriately based on if it is surrounded by space on at least one side. Used for autobolting shuttle airlocks. Accepts /obj/docking_port/mobile as arg, but it's optional
/obj/machinery/door/airlock/proc/validate_as_external(obj/docking_port/mobile/port)
	if (port)
		// Heey... This is not your shuttle
		if (!port.shuttle_areas[get_area(src)])
			return

		// Door on the border is external always
		var/list/bounds = port.return_coords()
		if (x == bounds[1] || y == bounds[2] || x == bounds[3] || y == bounds[4])
			external = TRUE
			return

	// If door connected to space or turf mapped without atmos - it is external too
	for(var/turf/turf_nearby in get_adjacent_open_turfs(src))
		if(is_space_or_openspace(turf_nearby) || turf_nearby.initial_gas_mix == AIRLESS_ATMOS)
			external = TRUE
			return

	external = FALSE

/obj/machinery/door/airlock/power_change()
	. = ..()
	update_icon()

//STATION AIRLOCKS
/obj/machinery/door/airlock
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/public.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/overlays.dmi'

/obj/machinery/door/airlock/command
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/command.dmi'

/obj/machinery/door/airlock/security
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/security.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_sec

/obj/machinery/door/airlock/security/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/security/blue
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/securityblue.dmi'

/obj/machinery/door/airlock/engineering
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/engineering.dmi'

/obj/machinery/door/airlock/medical
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/medical.dmi'

/obj/machinery/door/airlock/maintenance
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/maintenance.dmi'

/obj/machinery/door/airlock/maintenance/external
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/maintenanceexternal.dmi'

/obj/machinery/door/airlock/mining
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/mining.dmi'

/obj/machinery/door/airlock/atmos
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/atmos.dmi'

/obj/machinery/door/airlock/research
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/research.dmi'

/obj/machinery/door/airlock/freezer
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/freezer.dmi'

/obj/machinery/door/airlock/science
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/science.dmi'

/obj/machinery/door/airlock/virology
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/virology.dmi'

//STATION CUSTOM ARILOCKS
/obj/machinery/door/airlock/corporate
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/corporate.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_corporate
	normal_integrity = 450

/obj/machinery/door/airlock/corporate/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/service
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/service.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_service

/obj/machinery/door/airlock/service/glass
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/captain
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/cap.dmi'

/obj/machinery/door/airlock/hop
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hop.dmi'

/obj/machinery/door/airlock/hos
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hos.dmi'

/obj/machinery/door/airlock/hos/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/ce
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/ce.dmi'

/obj/machinery/door/airlock/ce/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/rd
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/rd.dmi'

/obj/machinery/door/airlock/rd/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/qm
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/qm.dmi'

/obj/machinery/door/airlock/qm/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/cmo
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/cmo.dmi'

/obj/machinery/door/airlock/cmo/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/psych
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/psych.dmi'

/obj/machinery/door/airlock/asylum
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/asylum.dmi'

/obj/machinery/door/airlock/bathroom
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/bathroom.dmi'

//STATION MINERAL AIRLOCKS
/obj/machinery/door/airlock/gold
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/gold.dmi'

/obj/machinery/door/airlock/silver
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/silver.dmi'

/obj/machinery/door/airlock/diamond
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/diamond.dmi'

/obj/machinery/door/airlock/uranium
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/uranium.dmi'

/obj/machinery/door/airlock/plasma
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/plasma.dmi'

/obj/machinery/door/airlock/bananium
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/bananium.dmi'

/obj/machinery/door/airlock/sandstone
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/sandstone.dmi'

/obj/machinery/door/airlock/wood
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/wood.dmi'

//STATION 2 AIRLOCKS

/obj/machinery/door/airlock/public
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station2/glass.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station2/overlays.dmi'

//EXTERNAL AIRLOCKS
/obj/machinery/door/airlock/external
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/external/external.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/external/overlays.dmi'

//CENTCOM
/obj/machinery/door/airlock/centcom
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

/obj/machinery/door/airlock/grunge
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

//VAULT
/obj/machinery/door/airlock/vault
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/vault/vault.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/vault/overlays.dmi'

//HATCH
/obj/machinery/door/airlock/hatch
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/centcom.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

/obj/machinery/door/airlock/maintenance_hatch
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/maintenance.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

//HIGH SEC
/obj/machinery/door/airlock/highsecurity
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/highsec/highsec.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/highsec/overlays.dmi'

//TITANIUM / SHUTTLE
/obj/machinery/door/airlock/titanium
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/shuttle/overlays.dmi'

/obj/machinery/door/airlock/shuttle
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/shuttle/overlays.dmi'

//SHUTTLE2
/obj/machinery/door/airlock/shuttle/ferry
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/shuttle2/erokez.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/shuttle2/overlays.dmi'

/obj/machinery/door/airlock/external/wagon
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/shuttle2/wagon.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/shuttle2/overlays.dmi'

//SURVIVAL
/obj/machinery/door/airlock/survival_pod
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/survival/overlays.dmi'

//ABDUCTOR
/obj/machinery/door/airlock/abductor
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/abductor/overlays.dmi'

//CULT
/obj/machinery/door/airlock/cult
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/cult/runed/overlays.dmi'

/obj/machinery/door/airlock/cult/unruned
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/cult/unruned/overlays.dmi'

//CLOCKWORK
/obj/machinery/door/airlock/bronze
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/clockwork/overlays.dmi'

//MULTI-TILE

/obj/machinery/door/airlock/multi_tile
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass_overlays.dmi'

/obj/machinery/door/airlock/multi_tile/glass
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass_overlays.dmi'

/obj/machinery/door/airlock/multi_tile/metal
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/multi_tile/metal.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/multi_tile/metal_overlays.dmi'

//TRAM

/obj/machinery/door/airlock/tram
	name = "tram door"
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/tram/tram_overlays.dmi'
	doorOpen = 'sound/machines/tram/tramopen.ogg'
	doorClose = 'sound/machines/tram/tramclose.ogg'

/obj/machinery/door/airlock/tram/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, l_angle, l_dir, l_height, l_on)
	return

//ASSEMBLYS
/obj/structure/door_assembly
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/public.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/overlays.dmi'

/obj/structure/door_assembly/door_assembly_public
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station2/glass.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station2/overlays.dmi'

/obj/structure/door_assembly/door_assembly_com
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/command.dmi'

/obj/structure/door_assembly/door_assembly_sec
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/security.dmi'

/obj/structure/door_assembly/door_assembly_sec/blue
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/securityblue.dmi'

/obj/structure/door_assembly/door_assembly_eng
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/engineering.dmi'

/obj/structure/door_assembly/door_assembly_min
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/mining.dmi'

/obj/structure/door_assembly/door_assembly_atmo
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/atmos.dmi'

/obj/structure/door_assembly/door_assembly_research
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/research.dmi'

/obj/structure/door_assembly/door_assembly_science
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/science.dmi'

/obj/structure/door_assembly/door_assembly_viro
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/virology.dmi'

/obj/structure/door_assembly/door_assembly_med
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/medical.dmi'

/obj/structure/door_assembly/door_assembly_mai
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/maintenance.dmi'

/obj/structure/door_assembly/door_assembly_extmai
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/maintenanceexternal.dmi'

/obj/structure/door_assembly/door_assembly_ext
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/external/external.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/external/overlays.dmi'

/obj/structure/door_assembly/door_assembly_fre
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/freezer.dmi'

/obj/structure/door_assembly/door_assembly_hatch
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/centcom.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

/obj/structure/door_assembly/door_assembly_mhatch
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/maintenance.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

/obj/structure/door_assembly/door_assembly_highsecurity
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/highsec/highsec.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/highsec/overlays.dmi'

/obj/structure/door_assembly/door_assembly_vault
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/vault/vault.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/vault/overlays.dmi'

/obj/structure/door_assembly/door_assembly_centcom
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

/obj/structure/door_assembly/door_assembly_grunge
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

/obj/structure/door_assembly/door_assembly_gold
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/gold.dmi'

/obj/structure/door_assembly/door_assembly_silver
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/silver.dmi'

/obj/structure/door_assembly/door_assembly_diamond
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/diamond.dmi'

/obj/structure/door_assembly/door_assembly_uranium
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/uranium.dmi'

/obj/structure/door_assembly/door_assembly_plasma
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/plasma.dmi'

/obj/structure/door_assembly/door_assembly_bananium
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/bananium.dmi'

/obj/structure/door_assembly/door_assembly_sandstone
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/sandstone.dmi'

/obj/structure/door_assembly/door_assembly_wood
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/wood.dmi'

/obj/structure/door_assembly/door_assembly_corporate
	name = "corporate airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/corporate.dmi'
	glass_type = /obj/machinery/door/airlock/corporate/glass
	airlock_type = /obj/machinery/door/airlock/corporate

/obj/structure/door_assembly/door_assembly_service
	name = "service airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/service.dmi'
	base_name = "service airlock"
	glass_type = /obj/machinery/door/airlock/service/glass
	airlock_type = /obj/machinery/door/airlock/service

/obj/structure/door_assembly/door_assembly_captain
	name = "captain airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/cap.dmi'
	glass_type = /obj/machinery/door/airlock/command/glass
	airlock_type = /obj/machinery/door/airlock/captain

/obj/structure/door_assembly/door_assembly_hop
	name = "head of personnel airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hop.dmi'
	glass_type = /obj/machinery/door/airlock/command/glass
	airlock_type = /obj/machinery/door/airlock/hop

/obj/structure/door_assembly/hos
	name = "head of security airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/hos.dmi'
	glass_type = /obj/machinery/door/airlock/hos/glass
	airlock_type = /obj/machinery/door/airlock/hos

/obj/structure/door_assembly/door_assembly_cmo
	name = "chief medical officer airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/cmo.dmi'
	glass_type = /obj/machinery/door/airlock/cmo/glass
	airlock_type = /obj/machinery/door/airlock/cmo

/obj/structure/door_assembly/door_assembly_ce
	name = "chief engineer airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/ce.dmi'
	glass_type = /obj/machinery/door/airlock/ce/glass
	airlock_type = /obj/machinery/door/airlock/ce

/obj/structure/door_assembly/door_assembly_rd
	name = "research director airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/rd.dmi'
	glass_type = /obj/machinery/door/airlock/rd/glass
	airlock_type = /obj/machinery/door/airlock/rd

/obj/structure/door_assembly/door_assembly_qm
	name = "quartermaster airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/qm.dmi'
	glass_type = /obj/machinery/door/airlock/qm/glass
	airlock_type = /obj/machinery/door/airlock/qm

/obj/structure/door_assembly/door_assembly_psych
	name = "psychologist airlock assembly"
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/psych.dmi'
	glass_type = /obj/machinery/door/airlock/medical/glass
	airlock_type = /obj/machinery/door/airlock/psych

/obj/structure/door_assembly/door_assembly_asylum
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/asylum.dmi'

/obj/structure/door_assembly/door_assembly_bathroom
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/bathroom.dmi'

/obj/machinery/door/airlock/hydroponics
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/botany.dmi'

/obj/structure/door_assembly/door_assembly_hydro
	icon = 'modular_nova/modules/aesthetics/airlock/icons/airlocks/station/botany.dmi'
