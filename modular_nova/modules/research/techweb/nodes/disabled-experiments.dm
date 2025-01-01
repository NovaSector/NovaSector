/datum/techweb_node/gas_compression
  experiments_to_unlock = list()
  discount_experiments = list(
		/datum/experiment/ordnance/gaseous/plasma,
		/datum/experiment/ordnance/gaseous/nitrous_oxide,
		/datum/experiment/ordnance/gaseous/bz,
		/datum/experiment/ordnance/gaseous/noblium,
     = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/selection
  required_experiments = list()

/datum/techweb_node/parts_adv
  required_experiments = list()
  discount_experiments = list(/datum/experiment/scanning/points/machinery_tiered_scan/tier2_any = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/mech_combat
  required_experiments = list()
  discount_experiments = list(/datum/experiment/scanning/random/mecha_equipped_scan = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/medbay_equip_adv
  required_experiments = list()
  discount_experiments = list(/datum/experiment/scanning/reagent/haloperidol = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/explosives
  required_experiments = list()
  discount_experiments = list(/datum/experiment/ordnance/explosive/lowyieldbomb = TECHWEB_TIER_2_POINTS)
                              
