/datum/supply_pack/companies/apparel
	group = "★ Apparel & Storage"
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// Blacksteel
/datum/supply_pack/companies/apparel/blacksteel
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/apparel/blacksteel/belt
	contains = list(/obj/item/storage/belt/crusader)

// Kahraman

/datum/supply_pack/companies/apparel/kahraman
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/apparel/kahraman/backpack
	contains = list(/obj/item/storage/backpack/industrial/frontier_colonist)

/datum/supply_pack/companies/apparel/kahraman/satchel
	contains = list(/obj/item/storage/backpack/industrial/frontier_colonist/satchel)

/datum/supply_pack/companies/apparel/kahraman/messenger
	contains = list(/obj/item/storage/backpack/industrial/frontier_colonist/messenger)

/datum/supply_pack/companies/apparel/kahraman/belt
	contains = list(/obj/item/storage/belt/utility/frontier_colonist)

/datum/supply_pack/companies/apparel/kahraman/vest
	contains = list(/obj/item/clothing/accessory/webbing/colonial)

/datum/supply_pack/companies/apparel/kahraman/medipen
	contains = list(/obj/item/storage/pouch/cin_medipens)

/datum/supply_pack/companies/apparel/kahraman/medikit
	contains = list(/obj/item/storage/pouch/cin_medkit)

/datum/supply_pack/companies/apparel/kahraman/general
	contains = list(/obj/item/storage/pouch/cin_general)

/datum/supply_pack/companies/apparel/kahraman/gas_mask
	contains = list(/obj/item/clothing/mask/gas/atmos/frontier_colonist)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/apparel/kahraman/headset
	contains = list(/obj/item/radio/headset/headset_frontier_colonist)
	cost = CARGO_CRATE_VALUE * 0.75

// Sol Fed

/datum/supply_pack/companies/apparel/sol_fed
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/apparel/sol_fed/hecu_mask
	contains = list(/obj/item/clothing/mask/gas/hecu)

/datum/supply_pack/companies/apparel/sol_fed/small_case
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/apparel/sol_fed/large_case
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/apparel/sol_fed/small_case/trappiste
	contains = list(/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case)

/datum/supply_pack/companies/apparel/sol_fed/large_case/carwo
	contains = list(/obj/item/storage/toolbox/guncase/nova/carwo_large_case)

/datum/supply_pack/companies/apparel/sol_fed/small_case/nanotrasen_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/ntcase/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/nanotrasen
	contains = list(/obj/item/storage/toolbox/guncase/nova/ntcase)

/datum/supply_pack/companies/apparel/sol_fed/small_case/solfed_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/solfed/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/solfed
	contains = list(/obj/item/storage/toolbox/guncase/nova/solfed)

/datum/supply_pack/companies/apparel/sol_fed/small_case/redcase_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/red/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/redcase
	contains = list(/obj/item/storage/toolbox/guncase/nova/red)

/datum/supply_pack/companies/apparel/sol_fed/small_case/bluecase_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/blue/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/bluecase
	contains = list(/obj/item/storage/toolbox/guncase/nova/blue)

/datum/supply_pack/companies/apparel/sol_fed/small_case/purplecase_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/purple/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/purplecase
	contains = list(/obj/item/storage/toolbox/guncase/nova/purple)

/datum/supply_pack/companies/apparel/sol_fed/small_case/orangecase_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/orange/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/orangecase
	contains = list(/obj/item/storage/toolbox/guncase/nova/orange)

/datum/supply_pack/companies/apparel/sol_fed/small_case/greencase_pistol
	contains = list(/obj/item/storage/toolbox/guncase/nova/green/pistol)

/datum/supply_pack/companies/apparel/sol_fed/large_case/greencase
	contains = list(/obj/item/storage/toolbox/guncase/nova/green)

// Vitezstvi

/datum/supply_pack/companies/apparel/vitezstvi
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/apparel/vitezstvi/small_case
	contains = list(/obj/item/storage/toolbox/guncase/nova/pistol)

/datum/supply_pack/companies/apparel/vitezstvi/large_case
	contains = list(/obj/item/storage/toolbox/guncase/nova)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/apparel/vitezstvi/bandolier
	contains = list(/obj/item/storage/belt/bandolier)

/datum/supply_pack/companies/apparel/vitezstvi/holster
	contains = list(/obj/item/storage/belt/holster)

/datum/supply_pack/companies/apparel/vitezstvi/pouch
	contains = list(/obj/item/storage/pouch/ammo)
	cost = CARGO_CRATE_VALUE

// HC

/datum/supply_pack/companies/apparel/hc_surplus
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/apparel/hc_surplus/belt
	contains = list(/obj/item/storage/belt/military/cin_surplus/random_color)

/datum/supply_pack/companies/apparel/hc_surplus/backpack
	contains = list(/obj/item/storage/backpack/industrial/cin_surplus/random_color)

// Donk

/datum/supply_pack/companies/apparel/donk
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/apparel/donk/snack_rig
	contains = list(/obj/item/storage/belt/military/snack)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/apparel/donk/valid_bloon
	contains = list(/obj/item/toy/balloon/arrest)
