/datum/map_template/shuttle/random_ship/valhalla
	suffix = "valhalla"
	name = "random ship (HC Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5

/area/shuttle/valhalla
	name = "HC Starship"
	forced_ambience = TRUE
	requires_power = TRUE
	ambient_buzz = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_radio.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_small_09.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_loop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_start.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_stop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/intercom_loop.ogg')
