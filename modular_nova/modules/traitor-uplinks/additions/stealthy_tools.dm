// LOW COST
/datum/uplink_item/stealthy_tools/thief_gloves
	name = "Thieves Gloves"
	desc = "Gloves which enhance the wearer's ability to strip small items from another, silently unequipping the desired loot and placing it within your grasp."
	item = /obj/item/clothing/gloves/color/black/thief
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/stealthy_tools/knuckleduster
	name = "Reinforced Knuckleduster"
	desc = "A compact, concealable set of reinforced knuckles. Quiet, fast, and hits harder than it looks."
	item = /obj/item/melee/knuckleduster/traitor
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/stealthy_tools/sleepy_neuroware
	name = "Ransomware Neuroware Chip"
	desc = "This Syndicate neuroware chip contains CrypSys, a package of ransomware viruses targeting synthetic humanoids. Designed to temporarily render the target mute, immobile, and unconscious. Note that before the target falls asleep, they will be able to move and act."
	item = /obj/item/disk/neuroware/sleepy
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/stealthy_tools/custom_announcement
	name = "Fake Announcement"
	desc = "A device that allows you to spoof an announcement to the station of your choice."
	item = /obj/item/device/traitor_announcer
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS
	surplus = 0

/datum/uplink_item/stealthy_tools/xl_shotglasses
	name = "Extra Large Syndicate Shotglasses"
	desc = "These modified shot glasses can hold up to 50 units of booze while looking like a regular 15 unit model \
			guaranteed to knock someone on their ass with a hearty dose of bacchus blessing. Look for the Snake underneath \
			to tell these are the real deal. Box of 7."
	item = /obj/item/storage/box/syndieshotglasses
	cost = 1
	purchasable_from = UPLINK_TRAITORS
	restricted_roles = list(JOB_BARTENDER, JOB_BRIDGE_ASSISTANT)


// MEDIUM COST


// HIGH COST
