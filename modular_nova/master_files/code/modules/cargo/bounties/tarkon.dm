/datum/bounty/item/tarkon/xenobodies
	name = "Xenomorphic Bodies"
	description = "Another corporation, named weyland something really wants some xenobodies, got any lying around?"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/mob/living/basic/alien = TRUE,
	)

/datum/bounty/item/tarkon/arc
	name = "Advanced Tools"
	description = "We need a few A.R.C.S. Resonators got any of those layin about?"
	reward = CARGO_CRATE_VALUE * 5
	required_count = 3
	wanted_types = list(
		/obj/item/gun/energy/recharge/resonant_system = TRUE,
	)

/datum/bounty/item/tarkon/rcd
	name = "Project Reconstruction"
	description = "We need a few of our proprietary RCDs, we're about to close a deal with corporate?"
	reward = CARGO_CRATE_VALUE * 5
	required_count = 3
	wanted_types = list(
		/obj/item/construction/rcd/tarkon = TRUE,
	)

/datum/bounty/item/tarkon/defense
	name = "Project Shutdown"
	description = "A big spender wants one of our proprietary turrets, get it done as soon as possible."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 1
	wanted_types = list(
		/obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus = TRUE,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite = TRUE,
	)
