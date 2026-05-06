/obj/vehicle/sealed/mecha/warden
	name = "\improper M/TACS-1-LF \"Warden\""
	desc = "A frontier-optimized combat exosuit and the product of a rare collaboration between Kemppainen-Morozov Industrial Fabrication \
		and Szot Dynamica. KMIF's unshakable chassis provides Durand-level resilience, while SŻD's responsive myomer systems \
		grant it Gygax-like agility. Stripped of complex jump jets and grapples for ease of maintenance, it excels as a mobile firing \
		platform and boarding-assault anchor."
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
		MECHA_POWER = 1,
		MECHA_ARMOR = 2,
	)

/datum/armor/warden
	melee = 65
	bullet = 60
	laser = 45
	energy = 35
	bomb = 40
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

/obj/vehicle/sealed/mecha/warden/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/zaibas_lmg,
	)

/obj/vehicle/sealed/mecha/warden/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/super(src)
	scanmod = new /obj/item/stock_parts/scanning_module/phasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/super(src)
	servo = new /obj/item/stock_parts/servo/pico(src)
	update_part_values()

/obj/vehicle/sealed/mecha/warden/wunk
	name = "\improper M/TACS-1A-LF \"Arbiter\" (WUNK)"
	desc = "The Warden Urban Necessity Kit transforms the already formidable frontier combat exosuit into a dedicated urban-breaching \
		asset. Reinforced chassis now incorporates supplemental armor pauldrons, a groin plate, and a rear skirt, while \
		myomer systems are recalibrated to compensate. Its sensor suite provides wall-penetrating radar and 360° awareness. \
		Heavier and slower than its predecessor, but unmatched in shipboard assaults and built-up environments."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "warden_wunk"
	base_icon_state = "warden_wunk"
	movedelay = 3.75
	max_integrity = 375
	armor_type = /datum/armor/warden_wunk
	wreckage = /obj/structure/mecha_wreckage/warden/wunk
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 2,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)

/datum/armor/warden_wunk
	melee = 75
	bullet = 70
	laser = 55
	energy = 45
	bomb = 55
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/warden/wunk/moved_inside(mob/living/carbon/human/human)
	. = ..()
	if(. && !HAS_TRAIT(human, TRAIT_THERMAL_VISION))
		ADD_TRAIT(human, TRAIT_THERMAL_VISION, VEHICLE_TRAIT)
		human.update_sight()

/obj/vehicle/sealed/mecha/warden/wunk/remove_occupant(mob/living/carbon/human/human)
	if(isliving(human) && HAS_TRAIT_FROM(human, TRAIT_THERMAL_VISION, VEHICLE_TRAIT))
		REMOVE_TRAIT(human, TRAIT_THERMAL_VISION, VEHICLE_TRAIT)
		human.update_sight()
	return ..()

/obj/vehicle/sealed/mecha/warden/wunk/mmi_moved_inside(obj/item/mmi/MMI, mob/user)
	. = ..()
	if(. && !isnull(MMI.brainmob) && !HAS_TRAIT(MMI.brainmob, TRAIT_THERMAL_VISION))
		ADD_TRAIT(MMI.brainmob, TRAIT_THERMAL_VISION, VEHICLE_TRAIT)
		MMI.brainmob.update_sight()

/obj/structure/mecha_wreckage/warden/wunk
	name = "\improper Arbiter wreckage"
	icon_state = "warden_wunk-broken"

/obj/vehicle/sealed/mecha/warden/wunk/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/gunpod,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/dagr,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/repair_droid, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster),
	)

/obj/vehicle/sealed/mecha/warden/wunk/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

//Abysmal copy-paste of the Ripley upgrade kit because upstream never envisioned making things easily editable.
/obj/item/mecha_parts/mecha_equipment/wardenupgrade
	name = "\improper Warden Urban Necessity Kit (WUNK) Conversion"
	desc = "A comprehensive modernization package for the M/TACS-1-LF \"Warden\" exosuit. \
		The WUNK (Warden Urban Necessity Kit) conversion adds supplemental armor pauldrons, \
		a groin plate, and rear skirt protection, the Argus-U distributed aperture sensor suite \
		with wall-penetrating radar, and the distributed frontal camera system. \
		The conversion is non-reversible and requires an open maintenance panel and an unoccupied \
		mech with a cell installed. Slightly reduces top speed in exchange for dramatically improved \
		survivability in urban and shipboard environments."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "upgrade_kit"
	mech_flags = EXOSUIT_MODULE_COMBAT
	var/result = /obj/vehicle/sealed/mecha/warden/wunk

/obj/item/mecha_parts/mecha_equipment/wardenupgrade/can_attach(obj/vehicle/sealed/mecha/warden/mecha, attach_right = FALSE, mob/user)
	if(!istype(mecha, /obj/vehicle/sealed/mecha/warden))
		to_chat(user, span_warning("This conversion kit can only be applied to M/TACS-1-LF \"Warden\" exosuits."))
		return FALSE
	if(istype(mecha, /obj/vehicle/sealed/mecha/warden/wunk))
		to_chat(user, span_warning("[mecha] has already been upgraded with the WUNK package."))
		return FALSE
	if(!(mecha.mecha_flags & PANEL_OPEN))
		to_chat(user, span_warning("[mecha]'s maintenance panel must be open to install the WUNK package."))
		return FALSE
	if(LAZYLEN(mecha.occupants))
		to_chat(user, span_warning("[mecha] must be unoccupied during the WUNK conversion process."))
		return FALSE
	if(!mecha.cell)
		to_chat(user, span_warning("The WUNK conversion requires a functional power cell installed."))
		return FALSE
	// Check if the mech has any equipment that conflicts with WUNK mounting points
	if(mecha.equip_by_category[MECHA_ARMOR] && LAZYLEN(mecha.equip_by_category[MECHA_ARMOR]) > 1)
		to_chat(user, span_warning("[mecha] has too many armor modules installed. Remove one before conversion."))
		return FALSE
	return TRUE

/obj/item/mecha_parts/mecha_equipment/wardenupgrade/attach(obj/vehicle/sealed/mecha/warden/old_mech, attach_right = FALSE)
	var/obj/vehicle/sealed/mecha/warden/wunk/new_mech = new result(get_turf(old_mech), 1)
	if(!new_mech)
		return FALSE

	// Transfer power cell
	if(old_mech.cell)
		new_mech.cell = old_mech.cell
		old_mech.cell.forceMove(new_mech)
		old_mech.cell = null

	// Transfer scanning module
	if(old_mech.scanmod)
		new_mech.scanmod = old_mech.scanmod
		old_mech.scanmod.forceMove(new_mech)
		old_mech.scanmod = null

	// Transfer capacitor
	if(old_mech.capacitor)
		new_mech.capacitor = old_mech.capacitor
		old_mech.capacitor.forceMove(new_mech)
		old_mech.capacitor = null

	// Transfer servo
	if(old_mech.servo)
		new_mech.servo = old_mech.servo
		old_mech.servo.forceMove(new_mech)
		old_mech.servo = null

	new_mech.update_part_values()

	// Transfer all equipment
	for(var/obj/item/mecha_parts/mecha_equipment/equipment in old_mech.flat_equipment)
		if(istype(equipment, /obj/item/mecha_parts/mecha_equipment/ejector))
			continue // The new mech already has one
		var/righthandgun = (old_mech.equip_by_category[MECHA_R_ARM] == equipment)
		equipment.detach(new_mech)
		equipment.attach(new_mech, righthandgun)

	// Transfer DNA lock
	new_mech.dna_lock = old_mech.dna_lock

	// Transfer mech flags (PANEL_OPEN, LIGHTS_ON, etc.)
	new_mech.mecha_flags |= old_mech.mecha_flags & ~initial(old_mech.mecha_flags)
	new_mech.set_light_on(new_mech.mecha_flags & LIGHTS_ON)

	// Transfer strafe mode setting
	new_mech.strafe = old_mech.strafe

	// Preserve custom name if set
	if(old_mech.name != initial(old_mech.name))
		new_mech.name = old_mech.name

	// Transfer integrity proportionally
	new_mech.update_integrity(round((old_mech.get_integrity() / old_mech.max_integrity) * new_mech.max_integrity))

	// Prevent the old mech from spawning wreckage
	old_mech.wreckage = FALSE

	// Preserve spawn trait if present
	if(HAS_TRAIT(old_mech, TRAIT_MECHA_CREATED_NORMALLY))
		ADD_TRAIT(new_mech, TRAIT_MECHA_CREATED_NORMALLY, REF(new_mech))

	// Clean up the old mech
	qdel(old_mech)

	// Play the upgrade sound
	playsound(get_turf(new_mech), 'sound/items/tools/ratchet.ogg', 50, TRUE)
	return TRUE
