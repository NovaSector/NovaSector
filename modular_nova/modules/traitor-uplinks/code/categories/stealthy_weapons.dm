/datum/uplink_item/stealthy_weapons/telescopicbaton
	name = "Telescopic Baton"
	desc = "A telescopic baton, exactly like the ones heads are issued. Good for knocking people down briefly."
	item = /obj/item/melee/baton/telescopic
	cost = 2
	surplus = 0
	progression_minimum = 10 MINUTES
	uplink_item_flags = NONE

//In essence, this following code removes Romerol.
/datum/uplink_item/stealthy_weapons/romerol_kit
	purchasable_from = NONE

/datum/uplink_item/stealthy_weapons/sleepy_neuroware
	name = "Ransomware Neuroware Chip"
	desc = "This Syndicate neuroware chip contains CrypSys, a package of ransomware viruses targeting synthetic humanoids. Designed to temporarily render the target mute, immobile, and unconscious. Note that before the target falls asleep, they will be able to move and act."
	item = /obj/item/disk/neuroware/sleepy
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
