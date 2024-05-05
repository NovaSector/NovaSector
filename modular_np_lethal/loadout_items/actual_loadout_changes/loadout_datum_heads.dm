/datum/loadout_item/head/frontier_helmet
	name = "Frontier Helmet"
	item_path = /obj/item/clothing/head/frontier_colonist_helmet

/datum/loadout_item/head/welding_helmet
	name = "Welding Helmet"
	item_path = /obj/item/clothing/head/utility/welding

/datum/loadout_item/head/combat_maid
	name = "Tactical Maid Headband"
	item_path = /obj/item/clothing/head/costume/maidheadband/syndicate

// Custom filtre helmets
/datum/loadout_item/head/giggler_armor
	name = "'Armageddon' type V ballistic helmet"
	item_path = /obj/item/clothing/head/helmet/lethal_filtre_helmet/giggler
	ckeywhitelist = list("ApplePlastic")
	restricted_roles = list("Filtre")

/datum/loadout_item/head/nineball_armor
	name = "'Novem' type V ballistic helmet"
	item_path = /obj/item/clothing/head/helmet/lethal_filtre_helmet/nineball
	ckeywhitelist = list("DawsonKeyes")
	restricted_roles = list("Filtre")
