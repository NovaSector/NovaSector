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
	/// one crew paycheck is 50 credits
	initial_products = list(
		/obj/vehicle/sealed/mecha/marauder/mauler/loaded = list(PAYCHECK_CREW * 40000000, INFINITY, "These things are twice the price of a main battle tank- kind of worse than a tank but- they are actually sold on the open market!"),
		/obj/item/gun/ballistic/automatic/ar/modular/m44a = list(PAYCHECK_CREW * 4000, INFINITY),
		/obj/item/ammo_box/magazine/m44a = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/gun/ballistic/automatic/l6_saw/unrestricted = list(PAYCHECK_CREW * 12000, INFINITY),
		/obj/item/ammo_box/magazine/m7mm = list(PAYCHECK_CREW * 600, INFINITY),
		/obj/item/gun/ballistic/automatic/lanca = list(PAYCHECK_CREW * 500, INFINITY),
		/obj/item/ammo_box/magazine/lanca = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/automatic/m90/unrestricted = list(PAYCHECK_CREW * 1000, INFINITY),
		/obj/item/ammo_box/magazine/m223 = list(PAYCHECK_CREW * 12, INFINITY),
		/obj/item/gun/ballistic/automatic/napad = list(PAYCHECK_CREW * 400, INFINITY),
		/obj/item/ammo_box/magazine/napad = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/gun/ballistic/automatic/pistol/zashch = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/ammo_box/magazine/zashch = list(PAYCHECK_CREW * 50, INFINITY),
		/obj/item/gun/ballistic/automatic/pistol/deagle/gold = list(PAYCHECK_CREW * 400, INFINITY),
		/obj/item/ammo_box/magazine/m50 = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/automatic/sol_smg = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/rifle/sniper_rifle = list(PAYCHECK_CREW * 3000, INFINITY),
		/obj/item/ammo_box/magazine/sniper_rounds = list(PAYCHECK_CREW * 150, INFINITY),
		/obj/item/gun/ballistic/rocketlauncher/unrestricted = list(PAYCHECK_CREW * 16000, INFINITY),
		/obj/item/ammo_box/rocket = list(PAYCHECK_CREW * 10000, INFINITY),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/gun/energy/laser = list(PAYCHECK_CREW * 5, INFINITY, ""),
		/obj/item/gun/energy/laser/carbine = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/laser/hellgun = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/gun/energy/laser/musket/prime = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/gun/energy/laser/thermal/inferno = list(PAYCHECK_CREW * 4, INFINITY, ""),
		/obj/item/gun/energy/laser/thermal/cryo = list(PAYCHECK_CREW * 6, INFINITY, ""),
		/obj/item/gun/energy/lasercannon = list(PAYCHECK_CREW * 40, INFINITY, ""),
		/obj/item/gun/energy/modular_laser_rifle = list(PAYCHECK_CREW * 25, INFINITY, ""),
		/obj/item/gun/energy/modular_laser_rifle/carbine = list(PAYCHECK_CREW * 30, INFINITY, ""),
		/obj/item/gun/energy/laser/captain = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/laser/musket = list(PAYCHECK_CREW * 1, INFINITY, ""),
		/obj/item/gun/energy/cell_loaded/medigun/cmo = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/alien = list(PAYCHECK_CREW * 7500, INFINITY, ""),
		/obj/item/gun/energy/disabler = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/disabler/smg = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/disabler/smoothbore/prime = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/dueling = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun/dragnet = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun/hos = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/e_gun/nuclear = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun/stun = list(PAYCHECK_CREW * 500, INFINITY, ""),
		/obj/item/gun/energy/event_horizon = list(PAYCHECK_CREW * 5000, INFINITY, ""),
		/obj/item/gun/energy/gravity_gun = list(PAYCHECK_CREW * 25, INFINITY, ""),
		/obj/item/gun/energy/ionrifle = list(PAYCHECK_CREW * 5, INFINITY, ""),
		/obj/item/gun/energy/ionrifle/carbine = list(PAYCHECK_CREW * 1, INFINITY, ""),
		/obj/item/gun/energy/pulse = list(PAYCHECK_CREW * 5000, INFINITY, ""),
		/obj/item/gun/energy/pulse/prize = list(PAYCHECK_CREW * 5000, INFINITY, ""),
		/obj/item/gun/energy/pulse/carbine = list(PAYCHECK_CREW * 2500, INFINITY, ""),
		/obj/item/gun/energy/pulse/pistol = list(PAYCHECK_CREW * 1000, INFINITY, ""),
		/obj/item/gun/energy/pulse/pistol/m1911 = list(PAYCHECK_CREW * 2500, INFINITY, ""),
		/obj/item/gun/energy/recharge/ebow/large = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/recharge/kinetic_accelerator = list(PAYCHECK_CREW * 50, INFINITY, ""),
		/obj/item/gun/energy/shrink_ray = list(PAYCHECK_CREW * 7500, INFINITY, ""),
		/obj/item/gun/energy/temperature/security = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/tesla_cannon = list(PAYCHECK_CREW * 25, INFINITY, ""),
		/obj/item/gun/energy/wormhole_projector/core_inserted = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/xray = list(PAYCHECK_CREW * 20, INFINITY, ""),
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
			"Look man- i know these prices are really fucking high but the conversion rate of credits to any real money is a hundred to one, these are just the prices i got to charge to stay profitable.",
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
			"Welcome to my tool store, i sell tools for any situation- but you seem to be from the stations and uh- your going to be, paying, a lot of credits heh... sorry but the conversion rate of credits to dollars is a hundred to one.",
		),
	)

/**
 * Depending on the passed parameter/override, returns a randomly picked string out of a list
 *
 * Do note when overriding this argument, you will need to ensure pick(the list) doesn't get supplied with a list of zero length
 * Arguments:
 * * say_text - (String) a define that matches the key of a entry in say_phrases
 */
