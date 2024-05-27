// The marauder is the middle ground between the Durands heavy defensive role and the Gygax's high speed agression. It has extra mod slots to either make it more tanky, or add new features.
// To achieve this it's armor has been lowerd, and it's health brought up both of these values sit in the middle of the two other mechs. It also moves alot faster.

/obj/vehicle/sealed/mecha/marauder
	desc = "A medium weight modular exosuit, decently fast on its feed and able to take more then a few hits before going down."
	name = "\improper Marauder"
	icon_state = "marauder"
	base_icon_state = "marauder"
	movedelay = 4
	internal_damage_threshold = 25
	internal_damage_probability = 10
	max_integrity = 900
	armor_type = /datum/armor/mecha_marauder
	max_temperature = 60000
	destruction_sleep_duration = 10
	exit_delay = 40
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	accesses = list(ACCESS_CENT_SPECOPS)
	wreckage = /obj/structure/mecha_wreckage/marauder
	mecha_flags = CAN_STRAFE | IS_ENCLOSED | HAS_LIGHTS | MMI_COMPATIBLE
	mech_type = EXOSUIT_MODULE_MARAUDER
	force = 45
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 5,
		MECHA_POWER = 1,
		MECHA_ARMOR = 3,
	)
	bumpsmash = TRUE

/datum/armor/mecha_marauder
	melee = 35
	bullet = 35
	laser = 35
	energy = 30
	bomb = 15
	fire = 100
	acid = 100

//Seraph, evil marauder. better in every way, it's probably the most dangerous of all the big dumb evil mechs. All evil mechs are for admin events/big boss fights.
// It's similar to a durand in it's durability but can walk around the speed of a gygax. Be afraid.

/obj/vehicle/sealed/mecha/marauder/seraph
	desc = "Heavy-duty, command-type exosuit. This is a custom model, utilized only by high-ranking military personnel."
	name = "\improper Seraph"
	icon_state = "seraph"
	base_icon_state = "seraph"
	armor_type = /datum/armor/mecha_seraph
	movedelay = 3
	internal_damage_threshold = 30
	internal_damage_probability = 10
	max_integrity = 1000
	wreckage = /obj/structure/mecha_wreckage/seraph
	force = 55
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 5,
		MECHA_POWER = 1,
		MECHA_ARMOR = 3,
	)
	equip_by_category = list(

		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)
/datum/armor/mecha_seraph
	melee = 40
	bullet = 40
	laser = 40
	energy = 30
	bomb = 15
	fire = 100
	acid = 100
