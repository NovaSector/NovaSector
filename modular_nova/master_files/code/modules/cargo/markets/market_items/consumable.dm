/datum/market_item/consumable/syndie_smokes
	name = "Syndicate Smokes"
	desc = "Strong flavor, dense smoke, infused with omnizine."
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate
	stock_min = 2
	stock_max = 5
	price_min = CARGO_CRATE_VALUE * 0.25
	price_max = CARGO_CRATE_VALUE * 0.5
	availability_prob = 85

/datum/market_item/consumable/stimpack
	name = "Stimulant Medipen"
	desc = "Someoneone's unfortunate agent gear getting fenced"
	item = /obj/item/reagent_containers/hypospray/medipen/stimulants
	stock_min = 1
	stock_max = 2
	price_min = CARGO_CRATE_VALUE * 5
	price_max = CARGO_CRATE_VALUE * 7
	availability_prob = 25

/datum/market_item/consumable/twitch
	name = "TWitch Sensory Stimulant Injector"
	desc = "highly illegal sensory stimulant that migh or might not be expired"
	item = /obj/item/reagent_containers/hypospray/medipen/deforest/twitch
	stock_max = 1
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3
	availability_prob = 25
