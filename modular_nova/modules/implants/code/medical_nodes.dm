/datum/techweb_node/cyber/cyber_implants/New()
	design_ids += list(
		"ci-scanner",
		"ci-gloweyes",
		"ci-welding",
		"ci-medhud",
		"ci-sechud",
		"ci-diaghud",
		"ci-botany",
		"ci-janitor",
		"ci-lighter",
		"ci-razor",
		"ci-drill",
		"combat_implant_sandy",
		"combat_implant_hackerman",
		"combat_implant_razorwire",
		"combat_implant_shell_launcher",
	)
	// thrusters in combat_implants
	design_ids -= list(
		"ci-thrusters",
	)

/datum/techweb_node/cyber/combat_implants/New()
	design_ids += list(
		"ci-mantis",
		"ci-flash",
		"ci-thrusters",
		"ci-antisleep",
	)
	return ..()

/datum/techweb_node/adv_mining //Here for the integrated drill augments.
	design_ids = list(
		"drill_diamond",
		"hypermod",
		"jackhammer",
		"plasmacutter_adv",
		"ci-drill-diamond"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
