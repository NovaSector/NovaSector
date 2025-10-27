/// Crew sensor module for proteans - works just like regular suit sensors
/obj/item/mod/module/crew_sensor/protean
	name = "MOD crew sensor module"
	desc = "An integrated crew monitoring system that broadcasts your vitals and location to crew monitoring consoles. \
		Compatible with standard station crew monitoring networks."
	icon_state = "scanner"
	complexity = 0 // Built into protean suits by default
	incompatible_modules = list()
	required_slots = list()

	/// Current sensor mode (SENSOR_OFF, SENSOR_LIVING, SENSOR_VITALS, SENSOR_COORDS)
	var/sensor_mode = SENSOR_COORDS
	/// Whether the sensors are working at all
	var/has_sensor = HAS_SENSORS
	/// Who we're currently tracking
	var/mob/living/carbon/human/tracked_owner

/obj/item/mod/module/crew_sensor/protean/Initialize(mapload)
	. = ..()
	// Start broadcasting full tracking by default
	sensor_mode = SENSOR_COORDS

/obj/item/mod/module/crew_sensor/protean/on_install()
	. = ..()
	tracked_owner = mod.wearer
	// Turn it on automatically when installed
	if(!active && mod?.wearer)
		active = TRUE
		on_activation(mod.wearer)
	update_sensor_status()

/obj/item/mod/module/crew_sensor/protean/on_uninstall(deleting)
	if(tracked_owner)
		GLOB.suit_sensors_list -= tracked_owner
		tracked_owner = null
	return ..()

/obj/item/mod/module/crew_sensor/protean/on_activation(mob/activator)
	update_sensor_status()

/obj/item/mod/module/crew_sensor/protean/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	if(!deleting && tracked_owner)
		GLOB.suit_sensors_list -= tracked_owner

/obj/item/mod/module/crew_sensor/protean/on_equip()
	tracked_owner = mod.wearer
	update_sensor_status()

/obj/item/mod/module/crew_sensor/protean/on_unequip()
	if(tracked_owner)
		GLOB.suit_sensors_list -= tracked_owner
		tracked_owner = null

/// Update whether we're showing up on crew monitors
/obj/item/mod/module/crew_sensor/protean/proc/update_sensor_status()
	if(!mod?.wearer)
		return

	tracked_owner = mod.wearer

	// Add to crew monitoring if we're turned on and broadcasting
	if(has_sensor > NO_SENSORS && sensor_mode > SENSOR_OFF && mod.active)
		GLOB.suit_sensors_list |= tracked_owner
	else
		GLOB.suit_sensors_list -= tracked_owner

/// Cycle through sensor modes (off -> binary -> vitals -> tracking -> off)
/obj/item/mod/module/crew_sensor/protean/proc/toggle_sensors()
	if(has_sensor <= NO_SENSORS)
		return

	switch(sensor_mode)
		if(SENSOR_OFF)
			set_sensor_mode(SENSOR_LIVING)
		if(SENSOR_LIVING)
			set_sensor_mode(SENSOR_VITALS)
		if(SENSOR_VITALS)
			set_sensor_mode(SENSOR_COORDS)
		if(SENSOR_COORDS)
			set_sensor_mode(SENSOR_OFF)

/// Change what info we're broadcasting
/obj/item/mod/module/crew_sensor/protean/proc/set_sensor_mode(new_mode)
	if(new_mode == sensor_mode)
		return

	if(new_mode < SENSOR_OFF || new_mode > SENSOR_COORDS)
		return

	sensor_mode = new_mode
	update_sensor_status()

	if(!tracked_owner)
		return

	switch(sensor_mode)
		if(SENSOR_OFF)
			to_chat(tracked_owner, span_notice("You disable your suit's remote sensing equipment."))
		if(SENSOR_LIVING)
			to_chat(tracked_owner, span_notice("Your suit will now only report whether you are alive or dead."))
		if(SENSOR_VITALS)
			to_chat(tracked_owner, span_notice("Your suit will now only report your exact vital lifesigns."))
		if(SENSOR_COORDS)
			to_chat(tracked_owner, span_notice("Your suit will now report your exact vital lifesigns as well as your coordinate position."))

/obj/item/mod/module/crew_sensor/protean/get_configuration()
	. = ..()
	var/list/modes = list("Off", "Binary vitals", "Exact vitals", "Tracking beacon")
	.["sensor_mode"] = add_ui_configuration("Sensor Mode", "list", modes[sensor_mode + 1], modes)

/obj/item/mod/module/crew_sensor/protean/configure_edit(key, value)
	switch(key)
		if("sensor_mode")
			var/list/modes = list("Off", "Binary vitals", "Exact vitals", "Tracking beacon")
			var/new_mode = modes.Find(value) - 1
			set_sensor_mode(new_mode)

/// Component that lets crew monitors read data from protean sensors
/datum/component/protean_crew_sensor
	/// The sensor module we're reading from
	var/obj/item/mod/module/crew_sensor/protean/sensor_module
	/// The protean this component is attached to
	var/mob/living/carbon/human/protean_mob

/datum/component/protean_crew_sensor/Initialize(obj/item/mod/module/crew_sensor/protean/module)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	protean_mob = parent
	sensor_module = module

/datum/component/protean_crew_sensor/Destroy(force)
	protean_mob = null
	sensor_module = null
	return ..()

/// Proc to get sensor data - called by crew monitor
/datum/component/protean_crew_sensor/proc/get_sensor_mode()
	return sensor_module?.sensor_mode || SENSOR_OFF

/datum/component/protean_crew_sensor/proc/get_has_sensor()
	return sensor_module?.has_sensor || NO_SENSORS

