/datum/trader_data/gundealer

	///The item that marks the shopkeeper will sit on
	shop_spot_type =  /obj/structure/chair/office/tactical
	///The sign that will greet the customers
	sign_type = /obj/structure/trader_sign
	///Sound used when item sold/bought
	sell_sound = 'sound/effects/cashregister.ogg'
	///The currency name
	currency_name = "credits"
	///The initial products that the trader offers
	initial_products = list(
		/obj/item/food/burger/ghost = list(PAYCHECK_CREW * 4, INFINITY),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/ectoplasm = list(PAYCHECK_CREW * 2, INFINITY, ""),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"Im not a fan of any of the gear your showing, come back when you have something i want.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"I'll be here.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Thanks, ill make a good turn around on this.",
		),
		INTERESTED_PHRASE = list(
			"Hey, you've got a gun that interests me, I'd like to buy it, I'll give you some credits for it, deal?",
		),
		BUY_PHRASE = list(
			"Use those tools well, their serial numbers are scrubbed.",
		),
		NO_CASH_PHRASE = list(
			"Fuck you think i am- a communist? come back when you have the credits for the firepower.",
		),
		NO_STOCK_PHRASE = list(
			"Somebody else came through and bought that gun earlier, come back a different cycle- when everything resets here.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I don't want to buy that gun right now buddy, come back a different cycle.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"This gun is dogshit, take that fucking dooky elsewhere, I dont shoot guns much myself but- i know the prices of guns in the main systems and thats not worth much.",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"Are you guys trying to flood the market and cause fucking inflation? I cant buy anymore of that right now.",
		),
		TRADER_LORE_PHRASE = list(
			"Heya buddy- you made your way here- somehow, from what i know from what ive seen that ladder has many many MANY entrances but youll leave the same way you came in, I come here to do deals every cycle and i make a killing with it- although the low stability gets to me sometimes.",
			"How did i get here? Well- there is this wall in my- area... that never seems right, walking through it brings me here, i tried to climb that ladder a few times and i saw what was on the other side, and decided it was not my time but this place allowed me to quit my deadend job and peddle weapons instead.",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"I'm not buying anythhing else today if i peddle away too many weapons the cops get suspicious- well, the ones who i DONT pay off get suspicious and THATS a real problem.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"I have sold everything i brought with me through the veil today buddy, i can only go through twice every cycle once in once out so come back next cycle when everything resets for mroe guns.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"Time to begin to take directly from the source.",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"now THAT is some free produce!",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome to my tool store, i sell tools for any situation.",
		),
	)

/**
 * Depending on the passed parameter/override, returns a randomly picked string out of a list
 *
 * Do note when overriding this argument, you will need to ensure pick(the list) doesn't get supplied with a list of zero length
 * Arguments:
 * * say_text - (String) a define that matches the key of a entry in say_phrases
 */
/datum/trader_data/proc/return_trader_phrase(say_text)
	if(!length(say_phrases[say_text]))
		return
	return pick(say_phrases[say_text])
