/datum/trader_data/clown_trader_data

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
		/obj/item/storage/backpack/duffelbag/clown/cream_pie = list(PAYCHECK_CREW * 12, INFINITY),
		/obj/item/stack/sheet/mineral/bananium/five = list(PAYCHECK_CREW * 100, INFINITY),
		/obj/item/food/grown/banana/bunch = list(PAYCHECK_CREW * 100, INFINITY),
		/obj/item/clothing/shoes/clown_shoes = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/storage/medkit = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/modular_computer/pda/clown = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/tank/internals/emergency_oxygen/engi/clown/helium = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/box/clown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/nullrod/clown = list(PAYCHECK_CREW * 1000, INFINITY),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/food/pie/cream = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/stack/sheet/mineral/bananium = list(PAYCHECK_CREW * 15, INFINITY),
		/obj/item/toy/figure/clown/boingos_action_figure = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/gun/ballistic/revolver/golden/boingos_blicky = list(PAYCHECK_CREW * 60, INFINITY),
		/obj/item/access_key/boingos_car_key = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/bikehorn/golden/boingos_lost_horn = list(PAYCHECK_CREW * 20, INFINITY),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"I don't want any of that stuff you're showing me. Come back when you have some pies for me HONK.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"I'll be here- im stuck here HONK.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Thanks, put em to good use HONK.",
		),
		INTERESTED_PHRASE = list(
			"Hey, you got some pies? Ill give you some credits for those! or if you can find some stuff i lost- thats good too.",
		),
		BUY_PHRASE = list(
			"Honk em all!",
		),
		NO_CASH_PHRASE = list(
			"Maybe come back whe nyour a bit hmmmmm richer HONK.",
		),
		NO_STOCK_PHRASE = list(
			"Im out of shit NTcel come back when the honkmother has provided more, HONK",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I dont want to buy that.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"That thing is worth nothing! HONK",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"Are you guys trying to flood the market and cause fucking inflation? I cant buy anymore of that right now.",
		),
		TRADER_LORE_PHRASE = list(
			"Hiya welcome to the circus slash amusement park, HONK, enjoy your stay NTstan!",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"I'm not buying any more pies today come back some other day HONK.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"Youve bought all of my stuff! come back another day, HONK",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. ",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. HONK. ",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome to the circus! Enjoy your stay!",
		),
	)
