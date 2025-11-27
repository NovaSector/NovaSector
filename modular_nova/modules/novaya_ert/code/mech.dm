/obj/vehicle/sealed/mecha/warden
	name = "\improper M/TACS-1-LF \"Warden\""
	desc = "A frontier-optimized combat exosuit and the product of a rare collaboration between Kemppainen-Morozov Industrial Fabrication and Szot Dynamica. \
	KMIF's unshakable chassis provides Durand-level resilience, while SŻD's responsive myomer systems grant it Gygax-like agility. \
	Stripped of complex jump jets and grapples for ease of maintenance, it excels as a mobile firing platform and boarding-assault anchor."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "warden"
	base_icon_state = "warden"
	movedelay = 3.5
	max_integrity = 325
	armor_type = /datum/armor/warden
	force = 35
	exit_delay = 4 SECONDS
	wreckage = /obj/structure/mecha_wreckage/warden
	mech_type = EXOSUIT_MODULE_COMBAT
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 2,
		MECHA_POWER = 2,
		MECHA_ARMOR = 1,
	)

/datum/armor/warden
	melee = 30
	bullet = 30
	laser = 25
	energy = 15
	bomb = 15
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/warden/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_smoke)
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)

/obj/structure/mecha_wreckage/warden
	name = "\improper Warden wreckage"
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "warden-broken"
	welder_salvage = list(/obj/item/stack/sheet/mineral/titanium, /obj/item/stack/sheet/iron, /obj/item/stack/rods)
