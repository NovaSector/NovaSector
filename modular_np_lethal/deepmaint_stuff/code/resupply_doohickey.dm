/obj/machinery/vending/wallmed/epic_loot
	name = "\improper SuperSupply ™"
	desc = "Wall-mounted dispenser filled with bullets and basic medical supplies."
	flags_1 = NO_DEBRIS_AFTER_DECONSTRUCTION
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	product_categories = list(
		list(
			"name" = "Medical",
			"icon" = "suitcase-medical",
			"products" = list(
				/obj/item/healthanalyzer/simple = INFINITY,
				/obj/item/stack/medical/bandage/makeshift = INFINITY,
				/obj/item/stack/medical/gauze/improvised = INFINITY,
				/obj/item/stack/medical/gauze/sterilized = INFINITY,
				/obj/item/stack/medical/bruise_pack = INFINITY,
				/obj/item/stack/medical/suture/coagulant = INFINITY,
				/obj/item/stack/medical/ointment = INFINITY,
				/obj/item/stack/medical/bone_gel = INFINITY,
				/obj/item/stack/sticky_tape/surgical = INFINITY,
				/obj/item/storage/pill_bottle/iron = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/ekit = INFINITY,
				/obj/item/reagent_containers/hypospray/medipen/glucose/synth_charger = INFINITY,
				/obj/item/stack/medical/wound_recovery/robofoam = INFINITY,
				/obj/item/storage/medkit/combat_surgeon/organ/stocked = INFINITY,
				/obj/item/storage/organbox/preloaded = INFINITY,
				/obj/item/tank/internals/plasmaman/belt/full = INFINITY,
				/obj/item/tank/internals/nitrogen/belt/full = INFINITY,
			),
		),
		list(
			"name" = "Ammunition",
			"icon" = "person-rifle",
			"products" = list(
				/obj/item/flashlight/flare = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c980/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/buckshot = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c35_sol/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c27_54cesarzowa/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c585_trappiste/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c40_sol/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c60_strela/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c12chinmoku/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/c8marsian/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/s6gauge/prefilled = INFINITY,
				/obj/item/ammo_box/magazine/ammo_stack/s6gauge/prefilled/slug = INFINITY,
			),
		),
	)
	contraband = list()
	default_price = 0
	extra_price = 0
	onstation = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/vending/wallmed/epic_loot, 32)

/obj/machinery/vending/wallmed/epic_loot/Initialize(mapload)
	. = ..()
	onstation = FALSE

/obj/machinery/vending/wallmed/epic_loot/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/vending/wallmed/epic_loot/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/vending/wallmed/epic_loot/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/vending/evil_clothing
	name = "Evil ClothesMate"
	desc = "A vending machine for clothing, and also weapons and tools to kill your fellow scavenger with!"
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
				/obj/item/clothing/head/soft/black = INFINITY,
				/obj/item/clothing/head/standalone_hood = INFINITY,
				/obj/item/clothing/mask/bandana/black = INFINITY,
				/obj/item/clothing/mask/gas/sechailer/half_mask = INFINITY,
				/obj/item/clothing/mask/gas/alt = INFINITY,
				/obj/item/clothing/mask/paper = INFINITY,
				/obj/item/clothing/mask/gas/syndicate/ds = INFINITY,
				/obj/item/clothing/mask/gas/respirator = INFINITY,
				/obj/item/clothing/gloves/frontier_colonist = INFINITY,
				/obj/item/clothing/gloves/tackler/combat = INFINITY,
				/obj/item/clothing/gloves/latex/nitrile = INFINITY,
				/obj/item/clothing/shoes/jackboots/frontier_colonist = INFINITY,
				/obj/item/clothing/glasses/heat = INFINITY,
				/obj/item/clothing/glasses/nightmare_vision = INFINITY,
				/obj/item/clothing/under/frontier_colonist = INFINITY,
				/obj/item/clothing/under/sol_peacekeeper = INFINITY,
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
				/obj/item/storage/pouch/cin_medkit = INFINITY,
				/obj/item/storage/pouch/cin_medipens = INFINITY,
				/obj/item/storage/belt/military/nri/captain/lethalstation = INFINITY,
				/obj/item/storage/backpack/industrial/frontier_colonist = INFINITY,
				/obj/item/storage/backpack/industrial/frontier_colonist/messenger = INFINITY,
				/obj/item/storage/backpack/industrial/frontier_colonist/satchel = INFINITY,
				/obj/item/storage/organbox/preloaded = INFINITY,
				/obj/item/storage/medkit/combat_surgeon/organ/stocked = INFINITY,
			),
		),
		list(
			"name" = "Weapons",
			"icon" = "hammer",
			"products" = list(
				/obj/item/flashlight/flare = INFINITY,
				/obj/item/lead_pipe = INFINITY,
				/obj/item/knife/combat/survival = INFINITY,
				/obj/item/crowbar/red = INFINITY,
				/obj/item/trench_tool = INFINITY,
				/obj/item/gun/ballistic/automatic/m6pdw = INFINITY,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/clothing
	default_price = PAYCHECK_CREW * 0.7 //Default of
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
	light_mask = "wardrobe-light-mask"
	light_color = LIGHT_COLOR_ELECTRIC_GREEN

/obj/machinery/vending/evil_clothing/Initialize(mapload)
	. = ..()
	onstation = FALSE

/obj/machinery/vending/evil_clothing/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/vending/evil_clothing/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/vending/evil_clothing/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE
