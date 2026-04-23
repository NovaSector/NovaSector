/datum/species/robot_nova
	name = "Robot (BETA REDESIGN)"
	id = SPECIES_ROBOT_NOVA
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_NOHUNGER // Has to be here for the UI to render right, species traits are handled by the brain organ
	)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	exotic_bloodtype = BLOOD_TYPE_OIL
	meat = null
	mutantbrain = /obj/item/organ/brain/robot_nova
	mutanttongue = /obj/item/organ/tongue/speaker
	mutantstomach = /obj/item/organ/stomach/fuel_generator
	mutantappendix = /obj/item/organ/appendix/random_number_database
	mutantheart = /obj/item/organ/heart/oil_pump
	mutantliver = /obj/item/organ/liver/cleaning_filter
	mutantlungs = /obj/item/organ/lungs/cooling_fans
	mutanteyes = /obj/item/organ/eyes/camera
	mutantears = /obj/item/organ/ears/microphone
	species_language_holder = /datum/language_holder/synthetic
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/android,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/android,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/android,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/android,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/android,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/android,
	)

	// NOVA EDIT ADDITION START - Robots
	used_outfit_for_preview = /datum/outfit/job/security/preview

/datum/outfit/job/security/preview
	head = /obj/item/clothing/head/soft/sec
	ears = null
	// NOVA EDIT ADDITION END

/datum/species/robot_nova/get_physical_attributes()
	return "Robots are a fully robotic species that doesn't feel pity, or remorse, or fear. It can't go into crit, and has a reworked health \
	system involving power and oil instead of caring about limb damage. They are radically different from the other species; be warned when using this \
	as a Wizard." // We only use this for the wizard mirror species changer, so we can be wizard-specific here.

/datum/species/robot_nova/get_species_description()
	return "Beta test of the new Robotic species design. Give this a test and reach out in #dev-code if you have feedback! \
		Features from other robotic species may be missing or different. If you find something missing or acting inconsistently, please reach out."

/datum/species/robot_nova/get_species_lore()
	return list(
		"Beta test of the new Robotic species design. Give this a test and reach out in #dev-code if you have feedback! \
		Features from other robotic species may be missing or different. If you find something missing or acting inconsistently, please reach out."
	)

/datum/species/robot_nova/check_roundstart_eligible()
	return TRUE

/datum/species/robot_nova/create_pref_traits_perks()
	var/list/perks = list()
	return perks

/datum/species/robot_nova/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_ROBOT,
		SPECIES_PERK_NAME = "Snap-on Limbs",
		SPECIES_PERK_DESC = "If you've lost a limb, it's no problem at all; you can simply snap on the limb to the body.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SCREWDRIVER,
		SPECIES_PERK_NAME = "Easy Organ Repairs",
		SPECIES_PERK_DESC = "Your limbs can be opened up with a screwdriver and crowbar to easily access the contained organs, making \
		organ replacement a breeze if a part gets damaged!",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_BEER_MUG_EMPTY,
		SPECIES_PERK_NAME = "Consume Resources to Recharge",
		SPECIES_PERK_DESC = "With the default engine, ingesting any alcohol will immediately start burning it in your engine for power. This is able to revive you from being \
		completely powered off! The stronger the booze, the better the power burn. Other flammable liquids are usable too. Alternative engines will \
		change how you get power, so choose an engine carefully.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SATELLITE_DISH,
		SPECIES_PERK_NAME = "Distress Beacon",
		SPECIES_PERK_DESC = "If you run out of power or run out of oil, a distress beacon will automatically activate, flagging you up on the \
		Distress Beacon console in Robotics. You'll show up even if your sensors were off when you ran out of power or oil! An EMP will shut off the \
		beacon, however.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_OIL_CAN,
		SPECIES_PERK_NAME = "High-Speed Lubricants",
		SPECIES_PERK_DESC = "When you're topped off on oil, you'll be able to interact with everything around you much faster!",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_BATTERY_FULL,
		SPECIES_PERK_NAME = "Power is Health",
		SPECIES_PERK_DESC = "Robots do not operate off of limb damage like normal spacemen. Damage goes directly to your power, and if you \
		start running out of power, your organs start shutting off and you will eventually power down, activating your distress beacon.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_OIL_CAN,
		SPECIES_PERK_NAME = "Oil for Blood",
		SPECIES_PERK_DESC = "Robots keep themselves moving smoothly via oil as a lubricant, and will bleed it like blood. Replace it by splashing \
		yourself with oil or another type of lubricant, or by getting it injected via IV drip.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_OIL_CAN,
		SPECIES_PERK_NAME = "Oil Consumption",
		SPECIES_PERK_DESC = "All item interactions and all movement will burn through your oil; if it runs low, you'll interact slower, \
		and if it runs out, you'll be locked in place!",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_BOLT_LIGHTNING,
		SPECIES_PERK_NAME = "Stamina Damages Power",
		SPECIES_PERK_DESC = "Stamina damage(ie. tasers, disablers, stun batons) directly sap your power, and as a result, while you can't go into \
		stamina crit, you will power down from enough stamina damage same as if you're attacked with conventional weapons.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_THERMOMETER_HALF,
		SPECIES_PERK_NAME = "Temperature Sensitive",
		SPECIES_PERK_DESC = "Your brain will overheat if not kept adequately cold, and if you're experiencing temperature extremes, you'll \
		burn power significantly faster!",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_WINDOW_RESTORE,
		SPECIES_PERK_NAME = "EMP-Vulnerable",
		SPECIES_PERK_DESC = "Getting hit with an EMP will deactivate your anti-virus and firewall on your email server briefly. \
		Don't click the ads!",
	))
	return perks
