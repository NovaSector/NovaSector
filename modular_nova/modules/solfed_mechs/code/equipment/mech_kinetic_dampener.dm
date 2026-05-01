/obj/item/mecha_parts/mecha_equipment/kinetic_dampener
	name = "Projectile Dampener Module"
	desc = "An advanced electromagnetic field generator adapted from peaceborg technology. It weakens incoming projectiles within a short radius, reducing their kinetic impact."
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "projectile_dampener"
	equipment_slot = MECHA_UTILITY
	detachable = FALSE
	active = FALSE
	can_be_toggled = TRUE
	energy_drain = 5
	/// Radius of the dampening field.
	var/field_radius = 4
	/// Damage multiplier on projectiles.
	var/damage_multiplier = 0.5
	/// Debuff multiplier on projectiles.
	var/debuff_multiplier = 0.5
	/// Speed multiplier on projectiles, higher means slower.
	var/speed_multiplier = 0.65
	/// The dampening field
	var/datum/proximity_monitor/advanced/bubble/projectile_dampener/dampening_field

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/kinetic_dampener, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/detach(atom/moveto)
	if(active)
		active = FALSE
		if(dampening_field)
			QDEL_NULL(dampening_field)
			STOP_PROCESSING(SSobj, src)
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/kinetic_dampener, VEHICLE_CONTROL_EQUIPMENT)
	return ..()

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/Destroy()
	if(active)
		active = FALSE
		if(dampening_field)
			QDEL_NULL(dampening_field)
			STOP_PROCESSING(SSobj, src)
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/kinetic_dampener, VEHICLE_CONTROL_EQUIPMENT)
	return ..()

/datum/action/vehicle/sealed/mecha/kinetic_dampener
	name = "Projectile Dampener Module"
	desc = "An advanced electromagnetic field generator adapted from peaceborg technology. It weakens incoming projectiles within a short radius, reducing their kinetic impact."
	button_icon_state = "mech_defense_mode_off"

/datum/action/vehicle/sealed/mecha/kinetic_dampener/Trigger(mob/clicker, trigger_flags)
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/dampener = locate(/obj/item/mecha_parts/mecha_equipment/kinetic_dampener) in chassis.contents
	if(!dampener)
		to_chat(clicker, span_warning("No dampener module found."))
		return FALSE

	var/desired_state = !dampener.active
	var/success = dampener.set_active(desired_state)

	if(success)
		button_icon_state = dampener.active ? "mech_defense_mode_on" : "mech_defense_mode_off"
		build_all_button_icons()
		to_chat(clicker, span_notice("You toggle the projectile dampener [dampener.active ? "on" : "off"]."))
	else
		// set_active() already printed the “no power” message
		return FALSE

	return TRUE

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/set_active(active)
	. = ..()
	if(!active)
		// Turning off
		if(dampening_field)
			QDEL_NULL(dampening_field)
		STOP_PROCESSING(SSobj, src)
		src.active = FALSE
		return TRUE
	// Check if chassis exists and has enough energy to start
	if(QDELETED(chassis) || !chassis.use_energy(energy_drain))
		for(var/mob/living/pilot in chassis.return_controllers_with_flag(VEHICLE_CONTROL_DRIVE))
			to_chat(pilot, span_warning("The projectile dampener fails to power on — insufficient energy."))
		src.active = FALSE
		return FALSE
	// Clear any old field
	if(dampening_field)
		QDEL_NULL(dampening_field)
	// Create new dampening field
	dampening_field = new(src, field_radius, TRUE, src)
	START_PROCESSING(SSobj, src)
	src.active = TRUE
	return TRUE

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/process(seconds_per_tick)
	if(QDELETED(chassis))
		return PROCESS_KILL  // mech gone, stop processing

	if(!active)
		return PROCESS_KILL  // module turned off, stop processing

	if(!chassis.use_energy(energy_drain))
		// not enough power, shut down
		set_active(FALSE)
		for(var/mob/living/pilot in chassis.return_controllers_with_flag(VEHICLE_CONTROL_DRIVE))
			to_chat(pilot, span_warning("The projectile dampener powers down — insufficient energy."))
		return PROCESS_KILL
