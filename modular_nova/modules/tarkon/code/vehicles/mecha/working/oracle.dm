/obj/vehicle/sealed/mecha/oracle
	desc = "Temporary description"
	name = "\improper Oracle"
	icon = 'modular_nova/modules/tarkon/icons/mob/rideable/mecha.dmi'
	icon_state = "oracle"
	base_icon_state = "oracle"
	movedelay = 2.3
	max_temperature = 30000
	max_integrity = 250
	mecha_flags = CAN_STRAFE | IS_ENCLOSED | HAS_LIGHTS | MMI_COMPATIBLE | BEACON_TRACKABLE | AI_COMPATIBLE | BEACON_CONTROLLABLE
	possible_int_damage = MECHA_INT_FIRE|MECHA_INT_TEMP_CONTROL|MECHA_CABIN_AIR_BREACH|MECHA_INT_CONTROL_LOST|MECHA_INT_SHORT_CIRCUIT
	armor_type = /datum/armor/sealed_mecha
	wreckage = /obj/structure/mecha_wreckage/oracle
	enter_delay = 40
	silicon_icon_state = null

/obj/structure/mecha_wreckage/oracle
    name = "\improper Oracle wreckage"
    icon = 'modular_nova/modules/tarkon/icons/mob/rideable/mecha.dmi'
    icon_state = "oracle-broken"
    desc = "All that remains of the once proud Ball of Building."
