/datum/supply_pack/companies/medical
	group = "★ Medical Supplies"
	express_lock = TRUE
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// Precompiled first aid kits, ready to go if you don't want to bother getting individual items
/datum/supply_pack/companies/medical/first_aid_kit
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/companies/medical/first_aid_kit/comfort
	contains = list(/obj/item/storage/medkit/civil_defense/comfort/stocked)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/first_aid_kit/civil_defense
	contains = list(/obj/item/storage/medkit/civil_defense/stocked)
	cost = CARGO_CRATE_VALUE * 1.25

/datum/supply_pack/companies/medical/first_aid_kit/frontier
	contains = list(/obj/item/storage/medkit/frontier/stocked)
	cost = CARGO_CRATE_VALUE * 1.75

/datum/supply_pack/companies/medical/first_aid_kit/combat_surgeon
	contains = list(/obj/item/storage/medkit/combat_surgeon/stocked)
	cost = CARGO_CRATE_VALUE * 1.75

/datum/supply_pack/companies/medical/first_aid_kit/robo_repair
	contains = list(/obj/item/storage/medkit/robotic_repair/stocked)
	cost = CARGO_CRATE_VALUE * 1.75

/datum/supply_pack/companies/medical/first_aid_kit/robo_repair_super
	contains = list(/obj/item/storage/medkit/robotic_repair/preemo/stocked)
	cost = CARGO_CRATE_VALUE * 4

/datum/supply_pack/companies/medical/first_aid_kit/first_responder
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked)
	cost = CARGO_CRATE_VALUE * 5.25

/datum/supply_pack/companies/medical/first_aid_kit/orange_satchel
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked)
	cost = CARGO_CRATE_VALUE * 4.75

/datum/supply_pack/companies/medical/first_aid_kit/technician_satchel
	contains = list(/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked)
	cost = CARGO_CRATE_VALUE * 8

// Basic first aid supplies like gauze, sutures, mesh, so on
/datum/supply_pack/companies/medical/first_aid

/datum/supply_pack/companies/medical/first_aid/coagulant
	contains = list(/obj/item/stack/medical/suture/coagulant)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/suture
	contains = list(/obj/item/stack/medical/suture)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/medicated_sutures
	contains = list(/obj/item/stack/medical/suture/medicated)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/red_sun
	contains = list(/obj/item/stack/medical/ointment/red_sun)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/ointment
	contains = list(/obj/item/stack/medical/ointment)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/mesh
	contains = list(/obj/item/stack/medical/mesh)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/advanced_mesh
	contains = list(/obj/item/stack/medical/mesh/advanced)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/sterile_gauze
	contains = list(/obj/item/stack/medical/gauze/sterilized)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/first_aid/amollin
	contains = list(/obj/item/storage/pill_bottle/painkiller)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/medical/first_aid/robo_patch
	contains = list(/obj/item/stack/medical/synth_repair)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/medical/first_aid/bandaid
	contains = list(/obj/item/storage/box/bandages)
	cost = CARGO_CRATE_VALUE * 0.375

/datum/supply_pack/companies/medical/first_aid/subdermal_splint
	contains = list(/obj/item/stack/medical/wound_recovery)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/first_aid/rapid_coagulant
	contains = list(/obj/item/stack/medical/wound_recovery/rapid_coagulant)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/first_aid/robofoam
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/first_aid/super_robofoam
	contains = list(/obj/item/stack/medical/wound_recovery/robofoam_super)
	cost = CARGO_CRATE_VALUE * 2

/datum/supply_pack/companies/medical/first_aid/mannitol // Bitrunners and Degenerative players should not be out of a job if med is slow, gone or bad
	contains = list(/obj/item/storage/pill_bottle/mannitol)
	cost = CARGO_CRATE_VALUE * 2 // pricey to not obsolete med if they ARE here

// Autoinjectors for healing
/datum/supply_pack/companies/medical/medpens
	cost = CARGO_CRATE_VALUE * 0.375

/datum/supply_pack/companies/medical/medpens/occuisate
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate)

/datum/supply_pack/companies/medical/medpens/morpital
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/morpital)

/datum/supply_pack/companies/medical/medpens/lipital
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lipital)

/datum/supply_pack/companies/medical/medpens/meridine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/meridine)

/datum/supply_pack/companies/medical/medpens/calopine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/calopine)

/datum/supply_pack/companies/medical/medpens/coagulants
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants)

/datum/supply_pack/companies/medical/medpens/lepoturi
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi)

/datum/supply_pack/companies/medical/medpens/psifinil
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil)

/datum/supply_pack/companies/medical/medpens/halobinin
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin)

/datum/supply_pack/companies/medical/medpens/robo_solder
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder)

/datum/supply_pack/companies/medical/medpens/robo_cleaner
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner)

/datum/supply_pack/companies/medical/medpens/pentibinin
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin)

/datum/supply_pack/companies/medical/neuroware
	cost = CARGO_CRATE_VALUE * 0.375

/datum/supply_pack/companies/medical/neuroware/reset
	contains = list(/obj/item/disk/neuroware/reset)

/datum/supply_pack/companies/medical/neuroware/brain
	contains = list(/obj/item/disk/neuroware/brain)

/datum/supply_pack/companies/medical/neuroware/morphine
	contains = list(/obj/item/disk/neuroware/morphine)

/datum/supply_pack/companies/medical/neuroware/lidocaine
	contains = list(/obj/item/disk/neuroware/lidocaine)

/datum/supply_pack/companies/medical/neuroware/neuroware/happiness
	contains = list(/obj/item/disk/neuroware/happiness)

/datum/supply_pack/companies/medical/neuroware/synaptizine
	contains = list(/obj/item/disk/neuroware/synaptizine)

/datum/supply_pack/companies/medical/neuroware/psicodine
	contains = list(/obj/item/disk/neuroware/psicodine)

// Autoinjectors for fighting

/datum/supply_pack/companies/medical/medpens_stim
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/medpens_stim/adrenaline
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline)

/datum/supply_pack/companies/medical/medpens_stim/synephrine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine)

/datum/supply_pack/companies/medical/medpens_stim/krotozine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine)

/datum/supply_pack/companies/medical/medpens_stim/aranepaine
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine)

/datum/supply_pack/companies/medical/medpens_stim/synalvipitol
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol)

/datum/supply_pack/companies/medical/medpens_stim/twitch
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/twitch)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/medpens_stim/demoneye
	contains = list(/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye)
	cost = CARGO_CRATE_VALUE * 1.5

// Equipment, from defibs to scanners to surgical tools
/datum/supply_pack/companies/medical/equipment

/datum/supply_pack/companies/medical/equipment/treatment_zone_projector
	contains = list(/obj/item/holosign_creator/medical/treatment_zone)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/equipment/health_analyzer
	contains = list(/obj/item/healthanalyzer)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/medical/equipment/loaded_defib
	contains = list(/obj/item/defibrillator/loaded)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/medical/equipment/surgical_tools
	contains = list(/obj/item/surgery_tray/full)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/medical/equipment/advanced_health_analyer
	contains = list(/obj/item/healthanalyzer/advanced)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/equipment/penlite_defib_mount
	contains = list(/obj/item/wallframe/defib_mount/charging)
	cost = CARGO_CRATE_VALUE * 0.75

/datum/supply_pack/companies/medical/equipment/advanced_scalpel
	contains = list(/obj/item/scalpel/advanced)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/equipment/advanced_retractor
	contains = list(/obj/item/retractor/advanced)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/equipment/advanced_cautery
	contains = list(/obj/item/cautery/advanced)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/equipment/advanced_blood_filter
	contains = list(/obj/item/blood_filter/advanced)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/equipment/medigun_upgrade
	contains = list(/obj/item/device/custom_kit/medigun_fastcharge)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/equipment/hypospray_upgrade
	contains = list(/obj/item/device/custom_kit/deluxe_hypo2)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/medical/equipment/afad
	contains = list(/obj/item/gun/medbeam/afad)
	cost = CARGO_CRATE_VALUE * 2.5

/datum/supply_pack/companies/medical/equipment/medstation
	contains = list(/obj/item/wallframe/frontier_medstation)
	cost = CARGO_CRATE_VALUE * 2.5

/datum/supply_pack/companies/medical/equipment/cyber_repair_paste
	contains = list(/obj/item/cybernetic_repair_paste)
	cost = CARGO_CRATE_VALUE

// Advanced implants, some of these can be printed but this is a way to get them before tech if you REALLY wanted
/datum/supply_pack/companies/medical/cyber_implants
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/cyber_implants/razorwire
	name = "Razorwire Spool Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/razorwire)

/datum/supply_pack/companies/medical/cyber_implants/shell_launcher
	name = "Shell Launch System Implant"
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/shell_launcher)

/datum/supply_pack/companies/medical/cyber_implants/sandy
	name = "Qani-Laaca Sensory Computer Implant"
	contains = list(/obj/item/organ/cyberimp/sensory_enhancer)
	cost = CARGO_CRATE_VALUE * 2.5

// Donk
/datum/supply_pack/companies/medical/donk

/datum/supply_pack/companies/medical/donk/neuroware
	cost = CARGO_CRATE_VALUE * 0.375

/datum/supply_pack/companies/medical/donk/neuroware/blastoff
	contains = list(/obj/item/disk/neuroware/blastoff)

/datum/supply_pack/companies/medical/donk/neuroware/mindbreaker
	contains = list(/obj/item/disk/neuroware/mindbreaker)

/datum/supply_pack/companies/medical/donk/neuroware/mushroomhallucinogen
	contains = list(/obj/item/disk/neuroware/mushroomhallucinogen)

/datum/supply_pack/companies/medical/donk/neuroware/space_drugs
	contains = list(/obj/item/disk/neuroware/space_drugs)

/datum/supply_pack/companies/medical/donk/neuroware/thc
	contains = list(/obj/item/disk/neuroware/thc)
