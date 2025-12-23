/datum/trader_data/burger_trader_data

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
		/obj/item/food/burger/baconburger = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/baseball = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/bearger = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/big_blue = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/bigbite = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/black = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/blue = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/catburger = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/chappy = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/cheese = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/chicken = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/clown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/corgi = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/crab = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/crazy = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/empoweredburger = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/empty = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/fish = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/fivealarm = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/ghost = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/green = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/jelly = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/mcguffin = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/mime = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/orange = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/plain = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/plain/korta = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/purple = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/red = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/rib = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/roburger = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/roburger/big = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/rootchicken = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/rootfish = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/rootguffin = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/rootrib = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/sloppy_moe = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/sloppyroot = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/spell = list(PAYCHECK_CREW * 12, INFINITY),
		/obj/item/food/burger/superbite = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/tofu = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/white = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/burger/xeno = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/food/burger/yellow = list(PAYCHECK_CREW * 1, INFINITY),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/food/meat/slab/grassfed = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/meat/slab/chicken = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/meat/slab = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/food/meat/slab/xeno = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/food/bread/plain = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/food/cheese/wheel = list(PAYCHECK_CREW * 2, INFINITY),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"I don't want any of that stuff you're showing me. Come back when you have some produce for me.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"I'll be here",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Thanks, hope it tastes good",
		),
		INTERESTED_PHRASE = list(
			"Hey, you got some produce? Ill give you some credits for those! or if you can find some stuff i lost- thats good too.",
		),
		BUY_PHRASE = list(
			"Hope it fits!",
		),
		NO_CASH_PHRASE = list(
			"Sorry but this isnt a food bank.",
		),
		NO_STOCK_PHRASE = list(
			"Im out of that food, sorry.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I dont want to buy that.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"That thing is worth nothing!",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"Are you guys trying to flood the market and stop global starvation? I cant buy anymore of that right now.",
		),
		TRADER_LORE_PHRASE = list(
			"Hiya welcome to the resturant!",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"I'm not buying any more produce today come back some other day.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"Youve bought all of my food! come back another day.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"MAMA MIA. ",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"Idiot. ",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome to the circus! Enjoy your stay!",
		),
	)
