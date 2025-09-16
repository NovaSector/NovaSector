

/obj/vehicle/sealed/mecha/oracle
	desc = "Temporary description"
	name = "\improper Oracle"
	icon = 'modular_nova/modules/tarkon/icons/mob/rideable/mecha.dmi'
	icon_state = "oracle"
	base_icon_state = "oracle"
	movedelay = 2.3
	max_temperature = 30000
	max_integrity = 250
	mech_type = EXOSUIT_MODULE_RIPLEY
	mecha_flags = CAN_STRAFE | IS_ENCLOSED | HAS_LIGHTS | MMI_COMPATIBLE | BEACON_TRACKABLE | AI_COMPATIBLE | BEACON_CONTROLLABLE | OMNIDIRECTIONAL_ATTACKS
	possible_int_damage = MECHA_INT_FIRE|MECHA_INT_TEMP_CONTROL|MECHA_CABIN_AIR_BREACH|MECHA_INT_CONTROL_LOST|MECHA_INT_SHORT_CIRCUIT
	armor_type = /datum/armor/oracle
	wreckage = /obj/structure/mecha_wreckage/oracle
	enter_delay = 40
	silicon_icon_state = null

	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/rcd/oracle,
		MECHA_R_ARM = null,
		MECHA_UTILITY = list(),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)



/obj/structure/mecha_wreckage/oracle
    name = "\improper Oracle wreckage"
    icon = 'modular_nova/modules/tarkon/icons/mob/rideable/mecha.dmi'
    icon_state = "oracle-broken"
    desc = "All that remains of the once proud Ball of Building."


/datum/armor/oracle
	melee = 40
	bullet = 10
	laser = 20
	energy = 10
	bomb = 80
	fire = 60
	acid = 100


/obj/item/mecha_parts/mecha_equipment/rcd/oracle

	range = 7
	// Inherit from the base RCD module (adjust the parent path if needed)
	// This override allows omnidirectional do_after for Oracle mechs
	do_after_checks(atom/target, flags = MECH_DO_AFTER_DIR_CHANGE_FLAG)
		if(chassis && istype(chassis, /obj/vehicle/sealed/mecha/oracle))
			// Ignore facing check for Oracle mechs
			flags &= ~MECH_DO_AFTER_DIR_CHANGE_FLAG
		return ..(target, flags)
