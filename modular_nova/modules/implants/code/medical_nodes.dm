/datum/techweb_node/cyber/cyber_implants/New()
	unlocked_designs += list(
		/datum/design/cyberimp_scanner,
		/datum/design/cyberimp_botany,
		/datum/design/cyberimp_janitor,
		/datum/design/cyberimp_lighter,
		/datum/design/cyberimp_claws,
		/datum/design/cyberimp_drill,
		/datum/design/cyberimp_sandy,
		/datum/design/cyberimp_razorwire,
		/datum/design/cyberimp_shell_launcher,
	)
	// thrusters in combat_implants
	unlocked_designs -= list(
		/datum/design/cyberimp_thrusters,
	)
	return ..()

/datum/techweb_node/cyber/combat_implants/New()
	unlocked_designs += list(
		/datum/design/cyberimp_mantis,
		/datum/design/cyberimp_flash,
		/datum/design/cyberimp_thrusters,
		/datum/design/cyberimp_antisleep,
	)
	return ..()

/datum/techweb_node/cyber/night_vision_implants
	display_name = "Night Vision Implants"
	description = "Now you can work all night, even if you lost your glasses!"
	prerequisite_nodes = list(/datum/techweb_node/night_vision, /datum/techweb_node/cyber/cyber_implants)
	unlocked_designs = list(
		/datum/design/cyberimp_nv,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/implants_nova
	display_name = "Illegal Cybernetics Implants"
	description = "So, hypothetically, if we didn't care about the formalities of ethics..."
	prerequisite_nodes = list(/datum/techweb_node/cyber/combat_implants)
	unlocked_designs = list(
		/datum/design/cyberimp_hackerman,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/mining_adv/New() //Here for the integrated drill augments.
	unlocked_designs += list(
		/datum/design/cyberimp_diamond_drill,
	)
	return ..()
