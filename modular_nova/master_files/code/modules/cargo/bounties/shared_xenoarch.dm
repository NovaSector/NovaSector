// XENOARCH GOALS

/datum/bounty/item/sharedxenoarch/strange_rock
	reward = 1000
	required_count = 5
	wanted_types = list(
		/obj/item/xenoarch/strange_rock
	)

/datum/bounty/item/sharedxenoarch/fossil_1
	name = "Relic of the Past"
	description = "Members of corporate want some useless relics of the past to serve as office decoration, mostly in the form of paperweights."
	reward = CARGO_CRATE_VALUE * 2
	required_count = 5
	wanted_types = list(
		/obj/item/xenoarch/useless_relic
	)

/datum/bounty/item/sharedxenoarch/fossil_2
	name = "Object of Redemption"
	description = "Corporate wants some broken items from xeno-archeology, not sure why... but just send anything that's broken."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(
		/obj/item/xenoarch/broken_item
	)

/datum/bounty/item/sharedxenoarch/fossil_tech
	name = "Technology of the Yesteryear"
	description = "Corporate wants some broken ancient technology, not sure why, but it's good to keep the investors happy."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 5
	wanted_types = list(
		/obj/item/xenoarch/broken_item/tech
	)

/datum/bounty/item/sharedxenoarch/fossil_weapon
	name = "Weapons Through Time"
	description = "Corporate wants some broken ancient weaponry, not sure why, but it's good to keep the investors happy."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 5
	wanted_types = list(
		/obj/item/xenoarch/broken_item/weapon
	)

/datum/bounty/item/sharedxenoarch/fossil_unknown
	name = "Oddities of the Past"
	description = "Corporate wants unidentifiable broken ancient objects, for REDACTED."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 5
	wanted_types = list(
		/obj/item/xenoarch/broken_item/illegal,
		/obj/item/xenoarch/broken_item/alien
	)
