/// Reticence with shit battery and rusted gun/rcd.
/obj/vehicle/sealed/mecha/reticence/artifact
	desc = "A silent, fast, and nigh-invisible miming exosuit. Dust covers it from the bottom to the top. It has seen better days. \
			The legs looks like they were scratched by animals and the cockpit was probably used as a nest."
	name = "\improper Retired reticence"
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/silenced/artifact,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/rcd/artifact,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(),
	)

/obj/vehicle/sealed/mecha/reticence/artifact/Initialize(mapload)
	. = ..()
	take_damage(max_integrity * 0.5, sound_effect=FALSE) // Start half health

/obj/vehicle/sealed/mecha/reticence/artifact/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/artifact_crap(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/item/stock_parts/power_store/cell/artifact_crap
	name = "\improper Dying old Nanotrasen bluespace cell"
	desc = "A rechargeable transdimensional power cell. This one is almost dead, barely keeping any charge. What happened to it?"
	icon_state = "bscell"
	maxcharge = STANDARD_CELL_CHARGE * 0.3

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/silenced/artifact
	name = "\improper Jammed S.H.H. \"Quietus\" Carbine"
	desc = "A weapon for combat exosuits. A mime invention, field tests have shown that targets cannot even scream before going down. \
			This copy is heavily rusted and needs to be reloaded every single shot."
	projectiles = 1

/obj/item/mecha_parts/mecha_equipment/rcd/artifact
	name = "\improper Rusted mounted RCD"
	desc = "An old exosuit-mounted Rapid Construction Device. Hostile environment conditions didn't leave a chance for the range module to survive."
	rcd_range = 1
