/datum/trader_data/deathsquadtrader

	///The item that marks the shopkeeper will sit on
	shop_spot_type =  /obj/structure/chair/office/tactical
	///The sign that will greet the customers
	sign_type = /obj/structure/trader_sign
	///Sound used when item sold/bought
	sell_sound = 'sound/effects/cashregister.ogg'
	///The currency name
	currency_name = "credits"
	///The initial products that the trader offers
	/// one crew paycheck is 50 credits
	initial_products = list(
		/obj/item/assembly/signaler/anomaly/bioscrambler = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/bluespace = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/dimensional = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/ectoplasm = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/flux = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/grav = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/hallucination = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/pyro = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/assembly/signaler/anomaly/vortex = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/survival/luxury = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/stimulants = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/salacid = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked = list(PAYCHECK_CREW * 40, INFINITY),
		/obj/item/storage/medkit = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/medkit/ancient = list(PAYCHECK_CREW * 15, INFINITY),
		/obj/item/storage/medkit/robotic_repair/preemo/stocked = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/medkit/frontier/stocked = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/medkit/brute = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/storage/medkit/combat_surgeon/stocked = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/anomaly_neutralizer = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/gun/ballistic/automatic/wt550 = list(PAYCHECK_CREW * 80, INFINITY, "Wait- what do you mean nanotrasen doesnt sell these anymore?"),
		/obj/item/storage/toolbox/ammobox/wt550m9 = list(PAYCHECK_CREW * 5, INFINITY, "Just some standard ammo- it hits harder against un-armored targets SO USE THIS AMMO AGAINST HOUNDS OF TINDALOS AND SHAGGOTHS."),
		/obj/item/storage/toolbox/ammobox/wt550m9ap = list(PAYCHECK_CREW * 10, INFINITY, "Some AP ammo for some of the tougher enemies"),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/raw_anomaly_core/bioscrambler = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/bluespace = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/dimensional = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/ectoplasm = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/flux = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/grav = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/hallucination = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/pyro = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/random = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/vortex = list(PAYCHECK_CREW * 20, INFINITY, ""),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"I dont want any of that crap your showing me, come back when you have some raw anomalies for me.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"I'll be here- im stuck here.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Thanks, put em to good use.",
		),
		INTERESTED_PHRASE = list(
			"Hey, you got some raw anomalies hand over those useless things to me I'll give you some credits for it, deal?",
		),
		BUY_PHRASE = list(
			"Use my stuff well!",
		),
		NO_CASH_PHRASE = list(
			"Look bro, these prices for the anomalies is high- sure, but it needs to be so i can profit refining them takes some time.",
		),
		NO_STOCK_PHRASE = list(
			"Somebody else came through and bought all my refined anomalies- come through next cycle for more.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I don't want to buy anymore of those anomalies this cycle the amount ive been sold will take me so long to refine anyway.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"This gun is dogshit, take that fucking dooky elsewhere, I dont use anomalies much myself but- i set the prices.",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"Are you guys trying to flood the market and cause fucking inflation? I cant buy anymore of that right now.",
		),
		TRADER_LORE_PHRASE = list(
			"Heya buddy welcome to my bar- feel free to take some food do some surgery get some healing and all of that good stuff, make sure to at least give us some commerce in turn.",
			"How did i get here? Well I came in with other people from my squad and we got split up and i got lost- now i seem, bound? to this bar, the food restocks and i dont seem to age so im not complaining, its about as good as any retirement i could ask for from NT- but if you see any members of my squad like pristine let them know i say hi- if anybody is still alive from my squad its them.",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"I'm not buying any more anomalies today i already got enough for this cycle.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"Youve bought all of my anomalies ive had- come back next cycle.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"come here fuckwad.",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"A real shame.",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome to my anomaly shop its uh- one of the only things around so yea...",
		),
	)

/**
 * Depending on the passed parameter/override, returns a randomly picked string out of a list
 *
 * Do note when overriding this argument, you will need to ensure pick(the list) doesn't get supplied with a list of zero length
 * Arguments:
 * * say_text - (String) a define that matches the key of a entry in say_phrases
 */
