/datum/uplink_item/stealthy_weapons/telescopicbaton
	name = "Telescopic Baton"
	desc = "A telescopic baton, exactly like the ones heads are issued. Good for knocking people down briefly."
	item = /obj/item/melee/baton/telescopic
	cost = 2
	surplus = 0
	progression_minimum = 10 MINUTES
	uplink_item_flags = NONE

/datum/uplink_item/stealthy_weapons/CQC
	name = "CQC Manual"
	item = /obj/item/book/granter/martial/cqc
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing. WARNING: Causes the user to think guns 'the basics to CQC' are more important then 'using guns.'"
	progression_minimum = 30 MINUTES
	population_minimum = TRAITOR_POPULATION_LOWPOP
	cost = 17
	surplus = 0
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
