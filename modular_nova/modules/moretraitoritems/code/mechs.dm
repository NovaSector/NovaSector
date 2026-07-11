// Gygax
/obj/vehicle/sealed/mecha/gygax/dark/marauder
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/repair_droid, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine),
	)

/obj/vehicle/sealed/mecha/gygax/dark/marauder/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/vehicle/sealed/mecha/gygax/dark/marauder/Initialize(mapload)
	. = ..()
	max_ammo()

// Mauler
/obj/vehicle/sealed/mecha/marauder/mauler/marauder
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/repair_droid, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine),
	)

/obj/vehicle/sealed/mecha/marauder/mauler/marauder/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/vehicle/sealed/mecha/marauder/mauler/marauder/Initialize(mapload)
	. = ..()
	max_ammo()

// Ripley
/obj/vehicle/sealed/mecha/ripley/deathripley/marauder
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp,
		MECHA_R_ARM = null,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/drill/diamonddrill, /obj/item/mecha_parts/mecha_equipment/ejector),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)

/obj/vehicle/sealed/mecha/ripley/deathripley/marauder/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

// Honker
/obj/vehicle/sealed/mecha/honker/dark/marauder
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/repair_droid, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)

/obj/vehicle/sealed/mecha/honker/dark/marauder/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()
