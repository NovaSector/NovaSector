/datum/supply_pack/companies/armor
	group = "★ Armors and Uniforms"
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// Blacksteel

/datum/supply_pack/companies/armor/blacksteel
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/armor/blacksteel/cuirass
	contains = list(/obj/item/clothing/suit/armor/vest/cuirass)

// Kahraman

/datum/supply_pack/companies/armor/kahraman
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/armor/kahraman/jumpsuit
	contains = list(/obj/item/clothing/under/frontier_colonist)

/datum/supply_pack/companies/armor/kahraman/jacket
	contains = list(/obj/item/clothing/suit/jacket/frontier_colonist)

/datum/supply_pack/companies/armor/kahraman/jacket_short
	contains = list(/obj/item/clothing/suit/jacket/frontier_colonist/short)

/datum/supply_pack/companies/armor/kahraman/med_jacket
	contains = list(/obj/item/clothing/suit/jacket/frontier_colonist/medical)

/datum/supply_pack/companies/armor/kahraman/ballcap
	contains = list(/obj/item/clothing/head/soft/frontier_colonist)

/datum/supply_pack/companies/armor/kahraman/med_ballcap
	contains = list(/obj/item/clothing/head/soft/frontier_colonist/medic)

/datum/supply_pack/companies/armor/kahraman/booties
	contains = list(/obj/item/clothing/shoes/jackboots/frontier_colonist)

/datum/supply_pack/companies/armor/kahraman/gloves
	contains = list(/obj/item/clothing/gloves/frontier_colonist)

/datum/supply_pack/companies/armor/kahraman/flak_vest
	contains = list(/obj/item/clothing/suit/frontier_colonist_flak)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/armor/kahraman/tanker_helmet
	contains = list(/obj/item/clothing/head/frontier_colonist_helmet)
	cost = CARGO_CRATE_VALUE * 0.5

// Sol Fed

/datum/supply_pack/companies/armor/sol_fed
	cost = CARGO_CRATE_VALUE * 0.75

/datum/supply_pack/companies/armor/sol_fed/ballistic_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper/debranded)

/datum/supply_pack/companies/armor/sol_fed/sf_ballistic_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper)

/datum/supply_pack/companies/armor/sol_fed/soft_vest
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper/debranded)

/datum/supply_pack/companies/armor/sol_fed/sf_soft_vest
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper)

/datum/supply_pack/companies/armor/sol_fed/flak_jacket
	contains = list(/obj/item/clothing/suit/armor/vest/sol)

/datum/supply_pack/companies/armor/sol_fed/slim_vest
	contains = list(/obj/item/clothing/suit/armor/vest)

/datum/supply_pack/companies/armor/sol_fed/combat_boots
	cost = CARGO_CRATE_VALUE
	contains = list(/obj/item/clothing/shoes/combat)

/datum/supply_pack/companies/armor/sol_fed/enclosed_helmet
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened)

/datum/supply_pack/companies/armor/sol_fed/emt_enclosed_helmet
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt)

/datum/supply_pack/companies/armor/sol_fed/hardened_vest
	contains = list(/obj/item/clothing/suit/armor/sf_hardened)

/datum/supply_pack/companies/armor/sol_fed/emt_hardened_vest
	contains = list(/obj/item/clothing/suit/armor/sf_hardened/emt)

/datum/supply_pack/companies/armor/sol_fed/sacrificial_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_sacrificial)

/datum/supply_pack/companies/armor/sol_fed/face_shield
	contains = list(/obj/item/sacrificial_face_shield)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/armor/sol_fed/sacrificial_vest
	contains = list(/obj/item/clothing/suit/armor/sf_sacrificial)

/datum/supply_pack/companies/armor/sol_fed/clothing
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/armor/sol_fed/clothing/peacekeeper
	contains = list(/obj/item/clothing/under/sol_peacekeeper)

/datum/supply_pack/companies/armor/sol_fed/clothing/emt
	contains = list(/obj/item/clothing/under/sol_emt)

// HC surplus

/datum/supply_pack/companies/armor/hc_surplus
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/armor/hc_surplus/space_suit
	name = "Voskhod-P depowered combat armor"
	contains = list(/obj/item/clothing/suit/space/voskhod, /obj/item/clothing/head/helmet/space/voskhod)
	desc = "An old combat proto-hardsuit with its powered components removed. Works perfectly for kevlar knighting though! Includes helmet."
	cost = CARGO_CRATE_VALUE * 2
	auto_name = FALSE

/datum/supply_pack/companies/armor/hc_surplus/clothing/helmet
	contains = list(/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color)

/datum/supply_pack/companies/armor/hc_surplus/clothing/vest
	contains = list(/obj/item/clothing/suit/armor/vest/cin_surplus_vest)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_jacket
	contains = list(/obj/item/clothing/suit/armor/vest/hc_police_jacket)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_cap
	contains = list(/obj/item/clothing/head/hats/colonial/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_baseball_cap
	contains = list(/obj/item/clothing/head/soft/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_mask
	contains = list(/obj/item/clothing/mask/gas/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_vest
	contains = list(/obj/item/clothing/head/helmet/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_helmet
	contains = list(/obj/item/clothing/suit/armor/vest/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_uniform
	contains = list(/obj/item/clothing/under/colonial/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_skirt
	contains = list(/obj/item/clothing/under/colonial/hc_police/skirt)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_cloak
	contains = list(/obj/item/clothing/neck/cloak/colonial/hc_police)

/datum/supply_pack/companies/armor/hc_surplus/clothing/police_suit_jacket
	contains = list(/obj/item/clothing/suit/armor/vest/hc_police_jacket/suit)

// Donk
/datum/supply_pack/companies/armor/donk
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/armor/donk/tacticool_turtleneck
	contains = list(/obj/item/clothing/under/syndicate/tacticool)

/datum/supply_pack/companies/armor/donk/tacticool_turtleneck_skirt
	contains = list(/obj/item/clothing/under/syndicate/tacticool/skirt)

/datum/supply_pack/companies/armor/donk/fake_centcom_turtleneck
	contains = list(/obj/item/clothing/under/rank/centcom/officer/replica)

/datum/supply_pack/companies/armor/donk/fake_centcom_turtleneck_skirt
	contains = list(/obj/item/clothing/under/rank/centcom/officer_skirt/replica)

/datum/supply_pack/companies/armor/donk/fake_syndie_suit
	contains = list(/obj/item/storage/box/fakesyndiesuit)

