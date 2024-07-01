/obj/machinery/vending/wallmed/epic_loot/evil/ninja
	name = "\improper NinjitsuSupply Premium ™"
	desc = "Wall-mounted dispenser filled with bullets and medical supplies."
	flags_1 = NO_DEBRIS_AFTER_DECONSTRUCTION
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	product_categories = list(
		list(
			"name" = "Medical",
			"icon" = "suitcase-medical",
			"products" = list(
				/obj/item/healthanalyzer/simple = INFINITY,
				/obj/item/stack/medical/bandage = INFINITY,
				/obj/item/stack/medical/gauze = INFINITY,
				/obj/item/stack/medical/gauze/sterilized = INFINITY,
				/obj/item/stack/medical/bruise_pack = INFINITY,
				/obj/item/stack/medical/suture/coagulant = INFINITY,
				/obj/item/stack/medical/suture/bloody = INFINITY,
				/obj/item/stack/medical/suture/medicated = INFINITY,
				/obj/item/stack/medical/ointment/red_sun = INFINITY,
				/obj/item/stack/medical/mesh/bloody = INFINITY,
				/obj/item/stack/medical/mesh/advanced = INFINITY,
				/obj/item/reagent_containers/pill/robotic_patch/synth_repair = INFINITY,
				/obj/item/stack/medical/wound_recovery = INFINITY,
				/obj/item/stack/medical/wound_recovery/rapid_coagulant = INFINITY,
				/obj/item/stack/medical/wound_recovery/robofoam = INFINITY,
				/obj/item/stack/medical/wound_recovery/robofoam_super = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/glucose = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/glucose/synth_charger = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner = INFINITY,
				/obj/item/storage/medkit/frontier/stocked = INFINITY,
				/obj/item/storage/medkit/combat_surgeon/stocked = INFINITY,
				/obj/item/storage/medkit/robotic_repair/preemo/stocked = INFINITY,
				/obj/item/tank/internals/plasmaman/belt/full = INFINITY,
				/obj/item/tank/internals/nitrogen/belt/full = INFINITY,
				/obj/item/stack/cable_coil/thirty = INFINITY,
				/obj/item/weldingtool/electric = INFINITY,
			),
		),
		list(
			"name" = "Ammunition",
			"icon" = "person-rifle",
			"products" = list(
				/obj/item/flashlight/flare = INFINITY,
				/obj/item/grenade/smokebomb = INFINITY,
				/obj/item/grenade/clusterbuster/smoke = INFINITY,
				/obj/item/grenade/stingbang = INFINITY,
				/obj/item/grenade/spawnergrenade/cat =  INFINITY,
			),
		),
		list(
			"name" = "Limb Replacement",
			"icon" = "hand",
			"products" = list(
				/obj/item/bodypart/arm/left/robot/advanced = INFINITY,
				/obj/item/bodypart/arm/right/robot/advanced = INFINITY,
				/obj/item/bodypart/leg/left/robot/advanced = INFINITY,
				/obj/item/bodypart/leg/right/robot/advanced = INFINITY,
			),
		),
	)
	contraband = list()
	default_price = 0
	extra_price = 0
	onstation = FALSE

/obj/machinery/vending/evil_clothing/evil_ninja
	name = "Evil Ninja ClothesMate"
	desc = "A vending machine for clothing, and also weapons and tools to kill intruders with!"
	product_slogans = "Dress to kill!;If you're the last thing they'll ever see, at least dress good!;Look at all these metal pipes!;Why leave warfare up to fate? Use the ClothesMate!"
	vend_reply = "Thank you for using the ClothesMate!"
	icon_state = "clothes"
	icon_deny = "clothes-deny"
	panel_type = "panel15"
	flags_1 = NO_DEBRIS_AFTER_DECONSTRUCTION
	product_categories = list(
		list(
			"name" = "Clothing",
			"icon" = "shirt",
			"products" = list(
				/obj/item/clothing/head/helmet/lethal_filtre_helmet/kitsune = INFINITY,
				/obj/item/clothing/head/helmet/lethal_filtre_helmet/oni = INFINITY,
				/obj/item/clothing/suit/armor/lethal_ninja_armor = INFINITY,
				/obj/item/clothing/suit/armor/lethal_ninja_armor/medium = INFINITY,
				/obj/item/clothing/under/genin_uniform = INFINITY,
				/obj/item/clothing/under/genin_uniform/femme = INFINITY,
				/obj/item/clothing/mask/gas/sechailer/half_mask = INFINITY,
				/obj/item/clothing/mask/gas/alt = INFINITY,
				/obj/item/clothing/mask/paper = INFINITY,
				/obj/item/clothing/mask/gas/syndicate/ds = INFINITY,
				/obj/item/clothing/mask/gas/respirator = INFINITY,
				/obj/item/clothing/gloves/kote = INFINITY,
				/obj/item/clothing/gloves/tackler/combat = INFINITY,
				/obj/item/clothing/gloves/latex/nitrile = INFINITY,
				/obj/item/clothing/shoes/jackboots/jikatabi = INFINITY,
				/obj/item/clothing/shoes/jackboots/long_jikatabi = INFINITY,
				/obj/item/clothing/glasses/meson/night = INFINITY,
				/obj/item/clothing/glasses/sunglasses/big = INFINITY,
				/obj/item/clothing/glasses/nightmare_vision = INFINITY,
				/obj/item/clothing/under/syndicate/combat = INFINITY,
				/obj/item/clothing/neck/ranger_poncho = INFINITY,
				/obj/item/clothing/neck/robe_cape = INFINITY,
				/obj/item/clothing/neck/long_cape = INFINITY,
				/obj/item/clothing/neck/wide_cape = INFINITY,
			),
		),
		list(
			"name" = "Gear",
			"icon" = "gear",
			"products" = list(
				/obj/item/storage/belt/ninja_bandolier = INFINITY,
				/obj/item/storage/pouch/medical/loaded = INFINITY,
				/obj/item/storage/pouch/ammo = INFINITY,
				/obj/item/storage/epic_loot_org_pouch = INFINITY,
				/obj/item/storage/epic_loot_medpen_case = INFINITY,
				/obj/item/storage/epic_loot_tag_case = INFINITY,
				/obj/item/storage/belt/military/nri/captain = INFINITY,
				/obj/item/storage/belt/military/cin_surplus/marine = INFINITY,
				/obj/item/storage/belt/holster/nukie/cowboy = INFINITY,
				/obj/item/storage/backpack/industrial/frontier_colonist = INFINITY,
				/obj/item/storage/backpack/industrial/frontier_colonist/messenger = INFINITY,
				/obj/item/storage/backpack/industrial/frontier_colonist/satchel = INFINITY,
				/obj/item/shield/ballistic = INFINITY,
				/obj/item/shield/riot/tele = INFINITY,
				/obj/item/shield/riot/pointman = INFINITY,
				/obj/item/motiondetector = INFINITY,
			),
		),
		list(
			"name" = "Weapons",
			"icon" = "hammer",
			"products" = list(
				/obj/item/flashlight/flare = INFINITY,
				/obj/item/gun/ballistic/revolver/sol = INFINITY,
				/obj/item/lead_pipe = INFINITY,
				/obj/item/crowbar/red = INFINITY,
				/obj/item/trench_tool = INFINITY,
				/obj/item/grapple_gun/lethal_ninja = INFINITY,
				/obj/item/gun/magic/hook = INFINITY,
				/obj/item/knife/combat/kunai = INFINITY,
				/obj/item/katana = INFINITY,
				/obj/item/fuuma_shuriken = INFINITY,
				/obj/item/polymer_tachi = INFINITY,
				/obj/item/melee/energy/sword = INFINITY,
				/obj/item/grenade/smokebomb = INFINITY,
				/obj/item/grenade/stingbang = INFINITY,
				/obj/item/grenade/spawnergrenade/cat =  INFINITY,
			),
		),
	)
