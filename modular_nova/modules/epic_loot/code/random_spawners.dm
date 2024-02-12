/obj/effect/spawner/random/epic_loot
	name = "extraction loot spawner"
	desc = "Gods please let there be nobody extract camping."
	icon = 'modular_nova/modules/epic_loot/icons/epic_loot.dmi'
	icon_state = null

/obj/effect/spawner/random/epic_loot/chainlet
	name = "random chainlet spawner"
	desc = "Automagically transforms into a random chainlet made of valuable metals."
	icon_state = "random_chain"
	loot = list(
		/obj/item/epic_loot/silver_chainlet = 2,
		/obj/item/epic_loot/gold_chainlet = 1,
	)

/obj/effect/spawner/random/epic_loot/pocket_sized_valuables
	name = "random pocket sized valuables spawner"
	desc = "Automagically transforms into a random valuable that would reasonably be in someone's coat pocket."
	icon_state = "random_pocket_valuable"
	loot = list(
		/obj/effect/spawner/random/epic_loot/chainlet = 1,
		/obj/item/epic_loot/press_pass = 1,
		/obj/item/epic_loot/military_flash = 1,
		/obj/item/epic_loot/slim_diary = 1,
	)

/obj/effect/spawner/random/epic_loot/medical_stack_item
	name = "random medical item spawner"
	desc = "Automagically transforms into a random medical stack item."
	icon_state = "random_med_stack"
	loot = list(
		/obj/item/stack/medical/bruise_pack = 3,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/stack/medical/gauze/sterilized = 1,
		/obj/item/stack/medical/suture/emergency = 3,
		/obj/item/stack/medical/suture/coagulant = 2,
		/obj/item/stack/medical/suture/bloody = 1,
		/obj/item/stack/medical/ointment = 3,
		/obj/item/stack/medical/ointment/red_sun = 2,
		/obj/item/stack/medical/mesh = 1,
		/obj/item/stack/medical/aloe = 2,
		/obj/item/stack/medical/bone_gel/one = 2,
		/obj/item/stack/medical/bandage/makeshift = 2,
		/obj/item/stack/medical/bandage = 1,
		/obj/item/stack/sticky_tape/surgical = 2,
		/obj/item/reagent_containers/blood/random = 1,
		// Chemjaks
		/obj/item/reagent_containers/cup/bottle/epinephrine = 2,
		/obj/item/reagent_containers/cup/bottle/morphine = 1,
		/obj/item/reagent_containers/cup/bottle/mannitol = 1,
		/obj/item/reagent_containers/cup/bottle/multiver = 2,
		/obj/item/reagent_containers/cup/bottle/ammoniated_mercury = 2,
		/obj/item/reagent_containers/cup/bottle/syriniver = 1,
		/obj/item/reagent_containers/cup/bottle/synaptizine = 1,
		/obj/item/reagent_containers/cup/bottle/fentanyl = 1,
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 2,
		/obj/item/reagent_containers/cup/bottle/diphenhydramine = 1,
		/obj/item/reagent_containers/cup/bottle/potass_iodide = 2,
		/obj/item/reagent_containers/cup/bottle/salglu_solution = 2,
		/obj/item/reagent_containers/cup/bottle/atropine = 1,
		/obj/item/reagent_containers/syringe = 2,
	)

/obj/effect/spawner/random/epic_loot/medical_stack_item_advanced
	name = "random advanced medical item spawner"
	desc = "Automagically transforms into a random advanced medical stack item."
	icon_state = "random_med_stack_adv"
	loot = list(
		/obj/item/stack/medical/bruise_pack = 3,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/stack/medical/gauze/sterilized = 2,
		/obj/item/stack/medical/suture = 3,
		/obj/item/stack/medical/suture/coagulant = 3,
		/obj/item/stack/medical/suture/bloody = 2,
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/ointment = 2,
		/obj/item/stack/medical/ointment/red_sun = 3,
		/obj/item/stack/medical/mesh = 3,
		/obj/item/stack/medical/mesh/bloody = 2,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/stack/medical/aloe = 2,
		/obj/item/stack/medical/bone_gel = 2,
		/obj/item/stack/medical/bandage = 2,
		/obj/item/stack/sticky_tape/surgical = 2,
		/obj/item/stack/medical/poultice = 1,
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		/obj/item/reagent_containers/blood/random = 2,
		// Chemjaks
		/obj/item/reagent_containers/cup/bottle/epinephrine = 1,
		/obj/item/reagent_containers/cup/bottle/morphine = 2,
		/obj/item/reagent_containers/cup/bottle/mannitol = 1,
		/obj/item/reagent_containers/cup/bottle/multiver = 2,
		/obj/item/reagent_containers/cup/bottle/ammoniated_mercury = 2,
		/obj/item/reagent_containers/cup/bottle/syriniver = 2,
		/obj/item/reagent_containers/cup/bottle/synaptizine = 2,
		/obj/item/reagent_containers/cup/bottle/fentanyl = 2,
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 1,
		/obj/item/reagent_containers/cup/bottle/diphenhydramine = 1,
		/obj/item/reagent_containers/cup/bottle/potass_iodide = 2,
		/obj/item/reagent_containers/cup/bottle/salglu_solution = 3,
		/obj/item/reagent_containers/cup/bottle/atropine = 2,
		/obj/item/reagent_containers/syringe = 3,
	)

/obj/effect/spawner/random/epic_loot/medical_tools
	name = "random medical tools spawner"
	desc = "Automagically transforms into a random medical tools of various sorts."
	icon_state = "random_med_tools"
	loot = list(
		/obj/item/bonesetter = 2,
		/obj/item/cautery = 2,
		/obj/item/cautery/cruel = 1,
		/obj/item/clothing/neck/stethoscope = 2,
		/obj/item/flashlight/pen = 2,
		/obj/item/flashlight/pen/paramedic = 2,
		/obj/item/healthanalyzer = 1,
		/obj/item/healthanalyzer/simple = 2,
		/obj/item/healthanalyzer/simple/disease = 2,
		/obj/item/hemostat = 2,
		/obj/item/hypospray = 2,
		/obj/item/hypospray/mkii = 1,
		/obj/item/storage/box/bandages = 1,
		/obj/item/bodybag = 2,
		/obj/item/bodybag/stasis = 1,
		/obj/item/blood_filter = 2,
		/obj/item/circular_saw = 2,
		/obj/item/clothing/gloves/latex/nitrile = 2,
		/obj/item/clothing/mask/surgical = 2,
		/obj/item/retractor = 2,
		/obj/item/scalpel = 2,
		/obj/item/shears = 1,
		/obj/item/surgical_drapes = 2,
		/obj/item/surgicaldrill = 2,
		/obj/item/handheld_soulcatcher = 1,
		/obj/item/epic_loot/vein_finder = 1,
		/obj/item/epic_loot/eye_scope = 1,
		/obj/item/reagent_containers/dropper = 2,
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/reagent_containers/cup/beaker/large = 1,
		/obj/item/reagent_containers/cup/bottle = 2,
		/obj/item/reagent_containers/cup/vial/small = 2,
		/obj/item/reagent_containers/cup/vial/large = 1,
		/obj/item/reagent_containers/cup/tube = 2,
		/obj/item/reagent_containers/syringe = 2,
		/obj/item/defibrillator = 2,
		/obj/item/defibrillator/loaded = 1,
		/obj/item/emergency_bed = 2,
	)

/obj/effect/spawner/random/epic_loot/medpens
	name = "random autoinjectors spawner"
	desc = "Automagically transforms into random autoinjectors of various types."
	icon_state = "random_medpen_spawner"
	loot = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = 2,
	)

/obj/effect/spawner/random/epic_loot/medpens_combat_based_redpilled
	name = "random combat autoinjectors spawner"
	desc = "Automagically transforms into a random combat focused autoinjector."
	icon_state = "random_medpen_advanced"
	loot = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/twitch = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol = 2,
	)

/obj/effect/spawner/random/epic_loot/random_components
	name = "random components spawner"
	desc = "Automagically transforms into components."
	icon_state = "random_component"
	loot = list(
		/obj/item/epic_loot/water_filter = 2,
		/obj/item/epic_loot/thermometer = 2,
		/obj/item/epic_loot/nail_box = 2,
		/obj/item/epic_loot/cold_weld = 2,
		/obj/item/epic_loot/electric_motor = 1,
		/obj/item/epic_loot/current_converter = 1,
		/obj/item/epic_loot/signal_amp = 1,
		/obj/item/epic_loot/thermal_camera = 1,
		/obj/item/epic_loot/shuttle_gyro = 1,
		/obj/item/epic_loot/phased_array = 1,
		/obj/item/epic_loot/shuttle_battery = 1,
		/obj/item/epic_loot/fuel_conditioner = 2,
		/obj/item/epic_loot/aramid = 2,
		/obj/item/epic_loot/cordura = 2,
		/obj/item/epic_loot/ripstop = 2,
		/obj/item/epic_loot/display = 1,
		/obj/item/epic_loot/display_broken = 2,
		/obj/item/epic_loot/civilian_circuit = 2,
	)

/obj/effect/spawner/random/epic_loot/random_tools
	name = "random tools spawner"
	desc = "Automagically transforms into a tool of some sort."
	icon_state = "random_tool"
	loot = list(
		// Wrench
		/obj/item/wrench = 3,
		/obj/item/wrench/bolter = 2,
		/obj/item/wrench/caravan = 1,
		/obj/item/wrench/combat = 1,
		// Screwdriver
		/obj/item/screwdriver = 3,
		/obj/item/screwdriver/omni_drill = 2,
		/obj/item/screwdriver/caravan = 1,
		// Crowbar
		/obj/item/crowbar = 3,
		/obj/item/crowbar/large/doorforcer = 2,
		/obj/item/crowbar/red/caravan = 1,
		// Wirecutters
		/obj/item/wirecutters = 3,
		/obj/item/wirecutters/caravan = 1,
		// Welder
		/obj/item/weldingtool = 3,
		/obj/item/weldingtool/largetank = 3,
		/obj/item/weldingtool/electric/arc_welder = 2,
		/obj/item/weldingtool/experimental = 1,
		// Multitool
		/obj/item/multitool = 2,
		/obj/item/multitool/ai_detect = 1,
		// Rapid whatever tools
		/obj/item/pipe_dispenser = 1,
		/obj/item/construction/rcd = 1,
		/obj/item/construction/rtd = 1,
		// Misc tools and related items
		/obj/item/stack/cable_coil = 3,
		/obj/item/flashlight = 2,
		/obj/item/flashlight/flare = 3,
		/obj/item/grenade/chem_grenade/metalfoam = 2,
		/obj/item/geiger_counter = 2,
		/obj/item/analyzer = 2,
		// Various methods of insulation
		/obj/item/clothing/gloves/color/yellow = 2,
		/obj/item/clothing/gloves/chief_engineer = 1,
		/obj/item/clothing/gloves/atmos = 1,
		// Misc utility clothing
		/obj/item/clothing/gloves/tinkerer = 1,
		/obj/item/clothing/head/utility/welding = 2,
		/obj/item/clothing/head/utility/hardhat/welding = 1,
		/obj/item/clothing/glasses/meson = 3,
		/obj/item/clothing/glasses/meson/engine = 2,
		/obj/item/storage/belt/utility = 2,
		/obj/item/clothing/shoes/magboots = 2,
		// Tapes
		/obj/item/stack/sticky_tape = 2,
		/obj/item/stack/sticky_tape/super = 1,
		// Cells
		/obj/item/stock_parts/cell/upgraded = 2,
		/obj/item/stock_parts/cell/crap = 3,
		// Masks
		/obj/item/clothing/mask/gas/sechailer = 2,
		/obj/item/clothing/mask/gas = 3,
		/obj/item/clothing/mask/gas/atmos/frontier_colonist = 2,
		// Air tanks
		/obj/item/tank/internals/nitrogen/belt = 1,
		/obj/item/tank/internals/emergency_oxygen/engi = 2,
		/obj/item/tank/internals/emergency_oxygen/double = 1,
	)
