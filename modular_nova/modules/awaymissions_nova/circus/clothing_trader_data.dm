/datum/trader_data/clothing_trader_data

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
		/obj/item/storage/backpack/ert/clown = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/backpack/duffelbag/clown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/storage/backpack/clown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/yellow = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/sexy = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/rainbow = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/purple = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/orange = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/magic = list(PAYCHECK_CREW * 100, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/jesteralt = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/jester = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/green = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/britches = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown/blue = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/rank/civilian/clown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/plasmaman/clown/magic = list(PAYCHECK_CREW * 100, INFINITY),
		/obj/item/clothing/under/plasmaman/clown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/under/bubbly_clown_skirt = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/suit/chaplainsuit/clownpriest = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/shoes/clown_shoes/pink = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/shoes/clown_shoes/jester = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/shoes/clown_shoes/combat = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/clothing/shoes/clown_shoes/britches = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/shoes/clown_shoes = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/mask/gas/sexyclown = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/mask/gas/clownbald = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/mask/gas/clown_hat = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/mask/gas/clown_colourable = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/clothing/head/chaplain/clownmitre = list(PAYCHECK_CREW * 1, INFINITY),

	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/stack/sheet/animalhide = list(PAYCHECK_CREW * 0.1, INFINITY),
		/obj/item/stack/sheet/animalhide/ashdrake = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/stack/sheet/animalhide/bear = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/stack/sheet/animalhide/bileworm = list(PAYCHECK_CREW * 0.5, INFINITY),
		/obj/item/stack/sheet/animalhide/carp = list(PAYCHECK_CREW * 0.5, INFINITY),
		/obj/item/stack/sheet/animalhide/goliath_hide = list(PAYCHECK_CREW * 0.5, INFINITY),
		/obj/item/stack/sheet/animalhide/xeno = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/stack/sheet/cloth = list(PAYCHECK_CREW * 0.1, INFINITY),
		/obj/item/stack/sheet/hairlesshide = list(PAYCHECK_CREW * 0.2, INFINITY),
		/obj/item/stack/sheet/durathread = list(PAYCHECK_CREW * 2, INFINITY),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"I don't want any of that stuff you're showing me. Come back when you have some cloth for me.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"I'll be here",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Thanks, hope it fits",
		),
		INTERESTED_PHRASE = list(
			"Hey, you got some cloth? Ill give you some credits for those! or if you can find some stuff i lost- thats good too.",
		),
		BUY_PHRASE = list(
			"Hope it fits!",
		),
		NO_CASH_PHRASE = list(
			"Sorry but this isnt a goodwills.",
		),
		NO_STOCK_PHRASE = list(
			"Im out of that clothing, sorry.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I dont want to buy that.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"That thing is worth nothing!",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"Are you guys trying to flood the market and cause inflation? I cant buy anymore of that right now.",
		),
		TRADER_LORE_PHRASE = list(
			"Hiya welcome to the clothing store!",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"I'm not buying any more cloth today come back some other day.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"Youve bought all of my stuff! come back another day.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"RUDE. ",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"Well at least thats dealt with. ",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome to the circus! Enjoy your stay!",
		),
	)
