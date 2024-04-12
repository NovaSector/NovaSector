/obj/effect/spawner/random/epic_loot
	name = "extraction loot spawner"
	desc = "Gods please let there be nobody extract camping."
	icon = 'modular_np_lethal/epic_loot/icons/epic_loot.dmi'
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
		/obj/effect/spawner/random/epic_loot/chainlet = 2,
		/obj/item/epic_loot/press_pass = 2,
		/obj/item/epic_loot/military_flash = 2,
		/obj/item/epic_loot/slim_diary = 2,
		/obj/effect/spawner/random/epic_loot/random_keycard = 1,
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
		// Medigels
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 2,
		/obj/item/reagent_containers/medigel/synthflesh = 1,
		// Pill bottles
		/obj/item/storage/pill_bottle/iron = 2,
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/storage/pill_bottle/probital = 2,
		/obj/item/storage/pill_bottle/happinesspsych = 1,
		/obj/item/storage/pill_bottle/lsdpsych = 1,
		/obj/item/storage/pill_bottle/mannitol = 2,
		/obj/item/storage/pill_bottle/multiver = 2,
		/obj/item/storage/pill_bottle/mutadone = 1,
		/obj/item/storage/pill_bottle/neurine = 1,
		/obj/item/storage/pill_bottle/ondansetron = 1,
		/obj/item/storage/pill_bottle/psicodine = 1,
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
		// Medigels
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 2,
		/obj/item/reagent_containers/medigel/synthflesh = 1,
		// Pill bottles
		/obj/item/storage/pill_bottle/iron = 2,
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/storage/pill_bottle/probital = 2,
		/obj/item/storage/pill_bottle/happinesspsych = 1,
		/obj/item/storage/pill_bottle/lsdpsych = 1,
		/obj/item/storage/pill_bottle/mannitol = 2,
		/obj/item/storage/pill_bottle/multiver = 2,
		/obj/item/storage/pill_bottle/mutadone = 1,
		/obj/item/storage/pill_bottle/neurine = 1,
		/obj/item/storage/pill_bottle/ondansetron = 1,
		/obj/item/storage/pill_bottle/psicodine = 1,
		// Medkits
		/obj/effect/spawner/random/epic_loot/medkit = 1,
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
		/obj/item/hypospray/mkii = 2,
		/obj/item/hypospray/mkii/deluxe = 1,
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
		/obj/item/defibrillator = 1,
		/obj/item/defibrillator/loaded = 1,
		/obj/item/emergency_bed = 2,
		/obj/effect/spawner/random/epic_loot/medkit = 2,
	)

/obj/effect/spawner/random/epic_loot/medkit
	name = "random medkit spawner"
	desc = "Automagically transforms into a random medkit of some sort."
	icon_state = "random_medkit"
	loot = list(
		/obj/item/storage/medkit/civil_defense/stocked = 3,
		/obj/item/storage/medkit/civil_defense/comfort/stocked = 3,
		/obj/item/storage/medkit/frontier/stocked = 2,
		/obj/item/storage/medkit/combat_surgeon/stocked = 2,
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked = 1,
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked = 1,
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

/obj/effect/spawner/random/epic_loot/random_computer_parts
	name = "random computer parts spawner"
	desc = "Automagically transforms into a part from a computer of some sort."
	icon_state = "random_electronic_part"
	loot = list(
		/obj/item/epic_loot/signal_amp = 2,
		/obj/item/epic_loot/device_fan = 2,
		/obj/item/epic_loot/graphics = 1,
		/obj/item/epic_loot/military_circuit = 1,
		/obj/item/epic_loot/civilian_circuit = 2,
		/obj/item/epic_loot/processor = 2,
		/obj/item/epic_loot/power_supply = 2,
		/obj/item/epic_loot/disk_drive = 2,
		/obj/item/epic_loot/ssd = 1,
		/obj/item/epic_loot/hdd = 1,
		/obj/item/epic_loot/military_flash = 1,
	)

/obj/effect/spawner/random/epic_loot/random_documents
	name = "random documents spawner"
	desc = "Automagically transforms into some form of documents, valuable or not."
	icon_state = "random_documents"
	loot = list(
		/obj/item/folder/white = 2,
		/obj/item/folder/blue = 2,
		/obj/item/folder/ancient_paperwork = 2,
		/obj/item/paper_bin = 2,
		/obj/item/paper_bin/bundlenatural = 2,
		/obj/item/paper_bin/carbon = 2,
		/obj/item/epic_loot/intel_folder = 1,
		/obj/item/epic_loot/corpo_folder = 1,
		/obj/item/epic_loot/slim_diary = 1,
		/obj/item/epic_loot/diary = 1,
		/obj/item/computer_disk/maintenance = 2,
	)

/obj/effect/spawner/random/epic_loot/random_strongbox_loot
	name = "random strongbox loot spawner"
	desc = "Automagically transforms into some kind of item that would be kept in a safe."
	icon_state = "random_strongbox_loot"
	loot = list(
		/obj/item/folder/ancient_paperwork = 3,
		/obj/item/epic_loot/intel_folder = 2,
		/obj/item/epic_loot/corpo_folder = 2,
		/obj/item/epic_loot/slim_diary = 3,
		/obj/item/epic_loot/diary = 2,
		/obj/item/epic_loot/ssd = 1,
		/obj/item/epic_loot/hdd = 1,
		/obj/item/epic_loot/military_flash = 1,
		/obj/effect/spawner/random/epic_loot/chainlet = 2,
		/obj/item/computer_disk/maintenance = 2,
		/obj/effect/spawner/random/epic_loot/random_keycard = 1,
	)


/obj/effect/spawner/random/epic_loot/random_grenade_or_explosive
	name = "random grenade or explosive spawner"
	desc = "Automagically transforms into some kind of explosive or grenade."
	icon_state = "random_bomb"
	loot = list(
		/obj/item/grenade/antigravity = 1,
		/obj/item/grenade/barrier = 3,
		/obj/item/grenade/c4 = 1,
		/obj/item/grenade/firecracker = 2,
		/obj/item/grenade/flashbang = 3,
		/obj/item/grenade/frag = 2,
		/obj/item/grenade/mirage = 3,
		/obj/item/grenade/smokebomb = 3,
		/obj/item/grenade/stingbang = 2,
		/obj/item/grenade/iedcasing/spawned = 2,
		/obj/item/grenade/syndieminibomb/concussion = 1,
		/obj/item/grenade/clusterbuster/smoke = 1,
		/obj/item/grenade/chem_grenade/teargas = 2,
		/obj/item/epic_loot/plasma_explosive = 2,
		/obj/item/epic_loot/grenade_fuze = 3,
	)

/obj/effect/spawner/random/epic_loot/random_ammunition
	name = "random ammunition spawner"
	desc = "Automagically transforms into some kind of ammo for a weapon."
	icon_state = "random_ammo"
	loot = list(
		// Ammo boxes
		// .38
		/obj/item/ammo_box/c38 = 2,
		/obj/item/ammo_box/c38/dumdum = 2,
		/obj/item/ammo_box/c38/match = 1,
		// .35
		/obj/item/ammo_box/c35sol = 2,
		/obj/item/ammo_box/c35sol/ripper = 2,
		/obj/item/ammo_box/c35sol/incapacitator = 2,
		// .40
		/obj/item/ammo_box/c40sol = 1,
		/obj/item/ammo_box/c40sol/pierce = 1,
		/obj/item/ammo_box/c40sol/incendiary = 2,
		/obj/item/ammo_box/c40sol/fragmentation = 2,
		// .585
		/obj/item/ammo_box/c585trappiste = 1,
		/obj/item/ammo_box/c585trappiste/hollowpoint = 1,
		/obj/item/ammo_box/c585trappiste/incapacitator = 2,
		// .980
		/obj/item/ammo_box/c980grenade = 2,
		/obj/item/ammo_box/c980grenade/riot = 2,
		/obj/item/ammo_box/c980grenade/smoke = 2,
		/obj/item/ammo_box/c980grenade/shrapnel = 1,
		/obj/item/ammo_box/c980grenade/shrapnel/phosphor = 1,
		// .310
		/obj/item/ammo_box/strilka310 = 2,
		/obj/item/ammo_box/strilka310/surplus = 2,
		/obj/item/ammo_box/c310_cargo_box = 1,
		/obj/item/ammo_box/c310_cargo_box/rubber = 2,
		/obj/item/ammo_box/c310_cargo_box/piercing = 1,
		// .27-54
		/obj/item/ammo_box/c27_54cesarzowa = 2,
		/obj/item/ammo_box/c27_54cesarzowa/rubber = 2,
		// .60
		/obj/item/ammo_casing/p60strela = 2,
		// Magazines
		/obj/item/ammo_box/magazine/c35sol_pistol = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle = 2,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 1,
		/obj/item/ammo_box/magazine/c585trappiste_pistol = 2,
		/obj/item/ammo_box/magazine/c980_grenade = 1,
		/obj/item/ammo_box/magazine/c980_grenade/drum = 1,
		/obj/item/ammo_box/magazine/lanca = 2,
		/obj/item/ammo_box/magazine/miecz = 2,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 2,
		/obj/item/ammo_box/magazine/wylom = 1,
		// Shotgun shells
		/obj/item/ammo_box/advanced/s12gauge/antitide = 2,
		/obj/item/ammo_box/advanced/s12gauge/bean = 2,
		/obj/item/ammo_box/advanced/s12gauge/beehive = 2,
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 1,
		/obj/item/ammo_box/advanced/s12gauge/express = 1,
		/obj/item/ammo_box/advanced/s12gauge/flechette = 1,
		/obj/item/ammo_box/advanced/s12gauge/incendiary = 1,
		/obj/item/ammo_box/advanced/s12gauge/magnum = 1,
		/obj/item/ammo_box/advanced/s12gauge/rubber = 2,
	)

/obj/effect/spawner/random/epic_loot/random_silly_arms
	name = "random silly arms spawner"
	desc = "Automagically transforms into a not-so-serious firearm."
	icon_state = "random_common_gun"
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/sol = 2,
		/obj/item/gun/ballistic/automatic/pistol/sol/evil = 1,
		/obj/item/gun/ballistic/automatic/pistol/trappiste = 1,
		/obj/item/gun/ballistic/revolver/c38 = 2,
		/obj/item/gun/ballistic/revolver/sol = 2,
		/obj/item/gun/ballistic/revolver/takbok = 1,
		/obj/item/gun/ballistic/automatic/sol_smg = 1,
		/obj/item/gun/ballistic/automatic/sol_smg/evil = 1,
		/obj/item/gun/ballistic/automatic/m6pdw = 1,
		/obj/item/gun/energy/e_gun/mini = 2,
		/obj/item/gun/energy/modular_laser_rifle/carbine = 1,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower = 2,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 2,
		/obj/item/gun/ballistic/revolver/shotgun_revolver = 2,
		/obj/item/gun/ballistic/automatic/miecz = 1,
	)

/obj/effect/spawner/random/epic_loot/random_serious_arms
	name = "random serious arms spawner"
	desc = "Automagically transforms into a super serious firearm."
	icon_state = "random_rare_gun"
	loot = list(
		/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 2,
		/obj/item/gun/ballistic/automatic/sol_rifle = 1,
		/obj/item/gun/ballistic/automatic/sol_rifle/evil = 1,
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun = 1,
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher = 1,
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil = 1,
		/obj/item/gun/ballistic/automatic/xhihao_smg = 2,
		/obj/effect/spawner/random/sakhno = 2,
		/obj/item/gun/ballistic/shotgun/riot/sol = 2,
		/obj/item/gun/ballistic/shotgun/riot/sol/evil = 1,
		/obj/item/gun/ballistic/rifle/boltaction/prime = 1,
		/obj/item/gun/energy/laser = 2,
		/obj/item/gun/energy/laser/hellgun = 1,
		/obj/item/gun/energy/tesla_cannon = 1,
		/obj/item/gun/energy/e_gun = 1,
		/obj/item/gun/energy/modular_laser_rifle = 1,
		/obj/item/gun/ballistic/automatic/lanca = 1,
		/obj/item/gun/ballistic/automatic/wylom = 1,
	)

/obj/effect/spawner/random/epic_loot/random_other_military_loot
	name = "random military loot spawner"
	desc = "Automagically transforms into some kind of misc. military loot item."
	icon_state = "random_loot_military"
	loot = list(
		/obj/item/clothing/mask/gas/sechailer = 1,
		/obj/item/clothing/mask/gas = 2,
		/obj/item/clothing/mask/gas/atmos/frontier_colonist = 1,
		/obj/item/clothing/head/helmet/sf_peacekeeper = 2,
		/obj/item/clothing/head/helmet/sf_peacekeeper/debranded = 1,
		/obj/item/clothing/suit/armor/sf_peacekeeper = 2,
		/obj/item/clothing/suit/armor/sf_peacekeeper/debranded = 1,
		/obj/item/folder/ancient_paperwork = 3,
		/obj/item/epic_loot/intel_folder = 2,
		/obj/item/epic_loot/slim_diary = 3,
		/obj/item/epic_loot/ssd = 1,
		/obj/item/epic_loot/hdd = 1,
		/obj/item/epic_loot/military_flash = 1,
		/obj/item/computer_disk/maintenance = 2,
		/obj/item/computer_disk/black_market = 1,
		/obj/item/epic_loot/plasma_explosive = 1,
		/obj/item/epic_loot/grenade_fuze = 2,
		/obj/item/epic_loot/signal_amp = 2,
		/obj/item/epic_loot/thermal_camera = 1,
		/obj/item/epic_loot/shuttle_gyro = 1,
		/obj/item/epic_loot/phased_array = 1,
		/obj/item/epic_loot/shuttle_battery = 1,
		/obj/item/epic_loot/aramid = 1,
		/obj/item/epic_loot/cordura = 1,
		/obj/item/epic_loot/ripstop = 1,
		/obj/item/epic_loot/military_circuit = 2,
		/obj/effect/spawner/random/epic_loot/medkit = 1,
		/obj/effect/spawner/random/epic_loot/random_keycard = 1,
	)

/obj/effect/spawner/random/epic_loot/random_provisions
	name = "random provisions spawner"
	desc = "Automagically transforms into some kind of potentially edible meal."
	icon_state = "random_food"
	loot = list(
		/obj/item/food/sustenance_bar = 3,
		/obj/item/food/sustenance_bar/cheese = 2,
		/obj/item/food/sustenance_bar/mint = 2,
		/obj/item/food/sustenance_bar/neapolitan = 2,
		/obj/item/food/vendor_snacks/mothmallow = 1,
		/obj/item/food/vendor_snacks/moth_bag = 3,
		/obj/item/food/vendor_snacks/moth_bag/cheesecake = 2,
		/obj/item/food/vendor_snacks/moth_bag/cheesecake/honey = 2,
		/obj/item/food/vendor_snacks/moth_bag/fuel_jack = 3,
		/obj/item/food/vendor_tray_meal/side/cornbread = 2,
		/obj/item/food/vendor_tray_meal/side/moffin = 2,
		/obj/item/food/vendor_tray_meal/side/roasted_seeds = 2,
		/obj/item/food/bluefeather_crisp = 3,
		/obj/item/food/brain_pate = 2,
		/obj/item/food/branrequests = 3,
		/obj/item/food/breadslice/corn = 2,
		/obj/item/food/breadslice/reispan = 2,
		/obj/item/food/breadslice/plain = 2,
		/obj/item/food/breadslice/root = 2,
		/obj/item/food/butter = 3,
		/obj/item/food/candy = 3,
		/obj/item/food/canned/beans = 3,
		/obj/item/food/canned/peaches = 3,
		/obj/item/food/canned/tomatoes = 3,
		/obj/item/food/canned/tuna = 3,
		/obj/item/food/cheese/firm_cheese_slice = 2,
		/obj/item/food/cheese/firm_cheese = 1,
		/obj/item/food/chocolatebar = 2,
		/obj/item/food/cnds/random = 3,
		/obj/item/food/colonial_course/pljeskavica = 1,
		/obj/item/food/colonial_course/nachos = 1,
		/obj/item/food/colonial_course/blins = 1,
		/obj/item/food/cornchips/random = 2,
		/obj/item/food/peanuts/random = 2,
		/obj/item/food/ready_donk = 1,
		/obj/item/food/ready_donk/donkhiladas = 1,
		/obj/item/food/ready_donk/donkrange_chicken = 1,
		/obj/item/food/ready_donk/mac_n_cheese = 1,
		/obj/item/food/ready_donk/nachos_grandes = 1,
		/obj/item/food/semki = 3,
		/obj/item/food/spacers_sidekick = 2,
		/obj/item/food/sticko/random = 3,
		// Ingredients
		/obj/item/reagent_containers/cup/glass/bottle/juice/limejuice = 2,
		/obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice = 2,
		/obj/item/reagent_containers/cup/glass/bottle/juice/pineapplejuice = 2,
		/obj/item/reagent_containers/condiment/milk = 1,
		/obj/item/reagent_containers/condiment/sugar/small_ration = 2,
		/obj/item/reagent_containers/condiment/flour/small_ration = 2,
		/obj/item/reagent_containers/condiment/small_ration_korta_flour = 2,
		/obj/item/reagent_containers/condiment/cherryjelly = 1,
		/obj/item/reagent_containers/condiment/rice/small_ration = 2,
		/obj/item/reagent_containers/condiment/soymilk/small_ration = 2,
		/obj/item/reagent_containers/condiment/cornmeal = 1,
		/obj/item/storage/box/spaceman_ration/meats = 1,
		/obj/item/storage/box/spaceman_ration/meats/lizard = 1,
		/obj/item/storage/box/spaceman_ration/meats/fish = 1,
		/obj/item/storage/box/spaceman_ration/plants = 2,
		/obj/item/storage/box/spaceman_ration/plants/alternate = 2,
		/obj/item/storage/box/spaceman_ration/plants/lizard = 2,
		/obj/item/storage/box/spaceman_ration/plants/mothic = 2,
		/obj/item/storage/box/papersack/ration_bread_slice = 1,
		/obj/item/storage/box/colonial_rations = 1,
	)

/obj/effect/spawner/random/entertainment/money/one
	spawn_loot_count = 1

/obj/effect/spawner/random/entertainment/money_small/one
	spawn_loot_count = 1

/obj/effect/spawner/random/epic_loot/random_keycard
	name = "random keycard spawner"
	desc = "Automagically transforms into a random colored keycard."
	icon_state = "keycard_random"
	loot = list(
		/obj/item/keycard/epic_loot/green = 1,
		/obj/item/keycard/epic_loot/teal = 1,
		/obj/item/keycard/epic_loot/blue = 1,
		/obj/item/keycard/epic_loot/ourple = 1,
		/obj/item/keycard/epic_loot/red = 1,
		/obj/item/keycard/epic_loot/orange = 1,
		/obj/item/keycard/epic_loot/yellow = 1,
		/obj/item/keycard/epic_loot/black = 1,
	)

/obj/effect/spawner/random/epic_loot/random_maint_loot_structure
	name = "random maintenance loot structure spawner"
	desc = "Automagically transforms into a random loot structure that spawns in maint."
	icon = 'modular_np_lethal/epic_loot/icons/loot_structures.dmi'
	icon_state = "random_maint_structure"
	loot = list(
		/obj/structure/maintenance_loot_structure/ammo_box/random,
		/obj/structure/maintenance_loot_structure/computer_tower/random,
		/obj/structure/maintenance_loot_structure/file_cabinet/random,
		/obj/structure/maintenance_loot_structure/grenade_box/random,
		/obj/structure/maintenance_loot_structure/gun_box/random,
		/obj/effect/spawner/random/epic_loot/random_supply_crate,
		/obj/structure/maintenance_loot_structure/medbox/random,
		/obj/structure/maintenance_loot_structure/medbox/random/advanced_loot,
		/obj/structure/maintenance_loot_structure/military_case/random,
		/obj/structure/maintenance_loot_structure/register/random,
		/obj/structure/maintenance_loot_structure/desk_safe/random,
		/obj/structure/maintenance_loot_structure/toolbox/random,
	)

// Overriding the tg and nova crate spawner to add epic loot to them
/obj/effect/spawner/random/structure/crate
	loot = list(
		/obj/effect/spawner/random/structure/crate_loot = 250,
		/obj/effect/spawner/random/epic_loot/random_maint_loot_structure = 500,
		/obj/structure/closet/crate/trashcart/filled = 75,
		/obj/effect/spawner/random/trash/moisture_trap = 50,
		/obj/effect/spawner/random/trash/hobo_squat = 30,
		/obj/structure/closet/mini_fridge = 35,
		/obj/effect/spawner/random/trash/mess = 30,
		/obj/structure/closet/crate/decorations = 15,
	)

// Trash piles suck a lot
/obj/structure/trash_pile/Initialize(mapload)
	. = ..()
	new /obj/effect/spawner/random/epic_loot/random_maint_loot_structure(get_turf(src))
	qdel(src)
