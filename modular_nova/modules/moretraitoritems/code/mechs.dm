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

// Warden
/obj/vehicle/sealed/mecha/warden/marauder
	name = "\improper Theseus"
	desc = "A frontier-optimized combat exosuit designed as a mobile firing platform and boarding-assault anchor. \
		This one looks a little too fresh off the nanoforge."
	icon_state = "warden-generic"
	base_icon_state = "warden-generic"
	wreckage = /obj/structure/mecha_wreckage/warden/marauder
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/zaibas_lmg,
	)

/obj/vehicle/sealed/mecha/warden/marauder/Initialize(mapload, built_manually)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/warden/marauder/lore_jumpscare()
	AddElement(/datum/element/examine_lore, \
		lore = "The \"Theseus\" is a frontier-optimized combat exosuit, utilizing an export-ready (and, thus, downgraded) M/TACS-1-LF \"Warden\" design \
		that was subsequently rebuilt and upgraded to standard \"Warden\" standards through various means, some of which may be of questionable legality.<br>\
		<br>\
		Much like its parent design, KMIF's unshakable chassis provides Durand-level resilience, while SŻD's responsive myomer systems grant it Gygax-like agility. \
		Typically stripped of complex jump jets and grapples for ease of maintenance, it excels as a mobile firing \
		platform and boarding-assault anchor.<br>\
		<br>\
		Theseus units, again much like their parent design, are typically equipped with a M/FC-8-LF \"Forge\" fabrication cannon, \
		with its ability to select appropriate ammunition for scanned targets, \
		paired with a M/HP-22 \"Strele\" coaxial plasma pulse machinegun, to give it excellent tactical flexibility." \
	)

/obj/vehicle/sealed/mecha/warden/marauder/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/warden/marauder
	name = "\improper Theseus wreckage"
	icon_state = "warden-generic-broken"
