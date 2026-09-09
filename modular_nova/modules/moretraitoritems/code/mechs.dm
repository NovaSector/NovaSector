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
	name = "\improper M/TACS-1-EX \"Theseus\""
	desc = "A frontier-optimized-and-manufactured combat exosuit designed as a mobile firing platform and boarding-assault anchor."
	icon_state = "warden-generic"
	base_icon_state = "warden-generic"
	wreckage = /obj/structure/mecha_wreckage/warden/marauder
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/zaibas_lmg,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster, /obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine),
	)

/obj/vehicle/sealed/mecha/warden/marauder/Initialize(mapload, built_manually)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/warden/marauder/lore_jumpscare()
	AddElement(/datum/element/examine_lore, \
		lore = "The M/TACS-1-EX \"Theseus\" is the product of compromise between the Heliostatic Coalition's desire to arm rim-world colonies \
			and its absolute refusal to export proprietary technology. The end result is, evidently, an exosuit built from open-source or public-domain \
			parts and manufacturing standards that looks, moves, and fights like a proper \"Warden\" despite its status as something \
			rebuilt piece by piece into a complete replacement.<br>\
			<br>\
			True to its name, the Theseus replaces many proprietary and advanced components for ease of manufacture, repair, and replacement: \
			the armor is made of layered composite ceramics, polymers, and alloys instead of proprietary KMIF nanocomposite matrices, \
			the mobility is provided through reliable, repairable hydropneumatic actuators instead of advanced myomer systems, \
			and the sensor suite uses basic but reliable optical and infrared sensors \
			instead of multi-spectral scanning arrays and proprietary datalink integration.<br>\
			<br>\
			While its more \"advanced\" capabilities may be lacking compared to its smarter, more technical cousin, the nature of its durable armor, \
			serviceable electronics, and reliable mobility mean that it requires much less external support while remaining extremely capable as an exosuit.<br>\
			<br>\
			The ease of its manufacture and the degree of its performance makes the \"Theseus\" relatively popular during barter and trade \
			between rim-world colonies and external entities such as corporations, paramilitaries, and other actors who would have a vested interest in \
			trading goods and services for such a performant exosuit (or, in particularly large exchanges, exosuits)." \
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
