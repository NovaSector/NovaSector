/datum/market_item/tool/ai_detector
	name = "Artificial Intelligence Detector"
	desc = "A functional multitool that turns red when it detects an artificial intelligence watching it, you're not certain if the vendor knows about the existence of this function."
	item = /obj/item/multitool/ai_detect
	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 1.5
	stock_max = 2
	availability_prob = 65

/datum/market_item/tool/doorforcer
	name = "Akhter Company Prybar"
	desc = "The infamous colonial crowbar, despite attempts at blacklisting by the Nanotrasen board of safety, still humbly available on the black market. "
	item = /obj/item/crowbar/large/doorforcer
	stock = 4
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	availability_prob = 100
