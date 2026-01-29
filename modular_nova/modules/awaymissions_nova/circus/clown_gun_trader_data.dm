/datum/trader_data/clown_gun_trader_data

	///The item that marks the shopkeeper will sit on
	shop_spot_type =  /obj/vehicle/ridden/wheelchair
	///The sign that will greet the customers
	sign_type = /obj/structure/trader_sign
	///Sound used when item sold/bought
	sell_sound = 'sound/effects/cashregister.ogg'
	///The currency name
	currency_name = "credits"
	///The initial products that the trader offers
	/// one crew paycheck is 50 credits
	initial_products = list(
		//tier 1 guns for the circus
		/obj/item/gun/ballistic/automatic/smartgun/circus  = list(PAYCHECK_CREW * 2, INFINITY), //"heavy" support
		/obj/item/gun/ballistic/rifle/boltaction/circus  = list(PAYCHECK_CREW * 8, INFINITY), //soldier
		/obj/item/gun/ballistic/automatic/wt550/circus  = list(PAYCHECK_CREW * 8, INFINITY), //smg-er
		/obj/item/gun/ballistic/rifle/boltaction/donkrifle/circus  = list(PAYCHECK_CREW * 6, INFINITY), //sniper
		/obj/item/gun/energy/laser/carbine/circus  = list(PAYCHECK_CREW * 4, INFINITY), //energy weapons
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/circus  = list(PAYCHECK_CREW * 8, INFINITY), //explosive specialist
		/obj/item/gun/ballistic/automatic/pistol/sol/circus  = list(PAYCHECK_CREW * 2, INFINITY), //secondary
		//tier 2 guns for the circus
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun/circus  = list(PAYCHECK_CREW * 60, 3), //Heavy support
		/obj/item/gun/ballistic/automatic/battle_rifle/circus  = list(PAYCHECK_CREW * 32, 3),  //Soldier
		/obj/item/gun/ballistic/automatic/napad/circus  = list(PAYCHECK_CREW * 28, 3), //smg-er
		/obj/item/gun/ballistic/rifle/lionhunter/circus  = list(PAYCHECK_CREW * 20, 3), //sniper
		/obj/item/gun/energy/laser/hellgun/circus  = list(PAYCHECK_CREW * 30, 3), //energy weapons
		/obj/item/gun/ballistic/revolver/grenadelauncher/circus  = list(PAYCHECK_CREW * 32, 3), //explosive specialist
		/obj/item/gun/ballistic/automatic/pistol/m1911/circus  = list(PAYCHECK_CREW * 16, 4),  //secondary
		//tier 3 guns for the circus
		/obj/item/gun/ballistic/automatic/l6_saw/circus  = list(PAYCHECK_CREW * 120, 2), //Heavy support
		/obj/item/gun/ballistic/automatic/m90/circus  = list(PAYCHECK_CREW * 64, 2), //Soldier
		/obj/item/gun/ballistic/automatic/c20r/reclaimed/circus  = list(PAYCHECK_CREW * 56, 2), //smg-er
		/obj/item/gun/ballistic/automatic/wylom/circus  = list(PAYCHECK_CREW * 60, 2), //sniper
		/obj/item/gun/ballistic/automatic/pulse_rifle/circus  = list(PAYCHECK_CREW * 40, 2), //energy weapons
		/obj/item/gun/ballistic/pump_launcher/circus  = list(PAYCHECK_CREW * 48, 2), //explosive specialist
		/obj/item/gun/ballistic/automatic/pistol/deagle/gold/circus  = list(PAYCHECK_CREW * 40, 4), //secondary
		//tier 4 guns
		/obj/item/gun/ballistic/automatic/smart_machine_gun/unrestricted/circus  = list(PAYCHECK_CREW * 560, 1), //heavy support
		/obj/item/gun/ballistic/automatic/ar/modular/circus  = list(PAYCHECK_CREW * 280, 1), //soldier
		/obj/item/gun/ballistic/automatic/tommygun/circus  = list(PAYCHECK_CREW * 200, 1), //smg-er
		/obj/item/gun/ballistic/rifle/sniper_rifle/circus  = list(PAYCHECK_CREW * 240, 1), //sniper
		/obj/item/gun/energy/pulse/carbine/circus  = list(PAYCHECK_CREW * 320, 1), //energy weapons
		/obj/item/gun/ballistic/rocketlauncher/nobackblast/circus  = list(PAYCHECK_CREW * 192, 1), //explosive specialist
		/obj/item/gun/energy/pulse/pistol/circus  = list(PAYCHECK_CREW * 160, 4), //secondary
		//tier 1 ammo
		/obj/item/ammo_box/magazine/smartgun  = list(PAYCHECK_CREW * 0.1, INFINITY),
		/obj/item/storage/toolbox/ammobox/strilka310  = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/storage/toolbox/ammobox/wt550  = list(PAYCHECK_CREW * 1, INFINITY),
		/obj/item/ammo_box/c980grenade/shrapnel  = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty  = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo  = list(PAYCHECK_CREW * 1, INFINITY),
		//tier 2 ammo
		/obj/item/ammo_box/magazine/c40sol_rifle/standard  = list(PAYCHECK_CREW * 4, INFINITY),
		/obj/item/ammo_box/magazine/m38  = list(PAYCHECK_CREW * 3, INFINITY),
		/obj/item/ammo_box/magazine/napad  = list(PAYCHECK_CREW * 4, INFINITY),
		/obj/item/ammo_box/a40mm  = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/ammo_box/magazine/m45  = list(PAYCHECK_CREW * 4, INFINITY),
		/obj/item/ammo_box/c45/large  = list(PAYCHECK_CREW * 8, INFINITY),
		//tier 3 ammo
		/obj/item/storage/toolbox/ammobox/full/l6_saw  = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/ammo_box/magazine/m223  = list(PAYCHECK_CREW * 12, INFINITY),
		/obj/item/ammo_box/magazine/smgm45  = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/ammo_box/magazine/wylom  = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/ammo_box/magazine/pulse  = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/ammo_box/pulse_cargo_box  = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/ammo_box/magazine/m50  = list(PAYCHECK_CREW * 6, INFINITY),
		//tier 4 ammo
		/obj/item/ammo_box/magazine/smartgun_drum  = list(PAYCHECK_CREW * 18, INFINITY),
		/obj/item/ammo_box/magazine/tommygunm45  = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/ammo_box/magazine/sniper_rounds  = list(PAYCHECK_CREW * 12, INFINITY),
		/obj/item/ammo_casing/rocket  = list(PAYCHECK_CREW * 20, INFINITY),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/stack/sheet/bronze = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/reagent_containers/cup/bottle/thermite = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/grenade/c4 = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/grenade/c4/x4 = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/grenade/frag = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/grenade/frag/mega = list(PAYCHECK_CREW * 20, INFINITY),
		/obj/item/grenade/syndieminibomb/concussion = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/ammo_box/magazine/mmg_box = list(PAYCHECK_CREW * 20, INFINITY),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"I don't want any of that stuff you're showing me. Come back when you have some money for me, oh yea, honk.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"I'll be here, got to pay for my mortage.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Thanks, fill em full of lead.",
		),
		INTERESTED_PHRASE = list(
			"Hey, I can get some gunpowder or brass out of that and reshape it for more ammo.",
		),
		BUY_PHRASE = list(
			"KILL EM ALL! i mean, honk em all, honk...",
		),
		NO_CASH_PHRASE = list(
			"Come back when youve gotten more money buddy.",
		),
		NO_STOCK_PHRASE = list(
			"Im out of guns or ammo you corporate sheep, come back in a while, honk.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"Back in mimun when we were fighting the mimench, the movies never told us how they would shit themselves.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"That thing is worth nothing.",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"I have enough stuff for now, I appriciate the enthusiasm but- I didnt invest in my 401k when i was young, and I didnt get no army bonus, so now im stuck hustling like this, oh yea, honk.",
		),
		TRADER_LORE_PHRASE = list(
			"Welcome to the darkside, chambered in five five six",
			"Sometimes, when i walk past a tree I could swear it was speaking french",
			"'go home GI, yo honkmutha has abandon you, the headclowns get richa and richa while you are sent to die in the swamp, defect gi' Somedays, I wonder what wouldve happened if I did turn in my horn and shoes and became french instead.",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"You got nothing I could want",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"Im not selling anything",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"I KNEW YOU WERE A MIMUN SPY!!!",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"im not gonna get no medal for this, but then agian, i never did get one, and my count was twenty eight, and all i got was this wheelchair. 'they were civilians' they said 'you're a war criminal' they said, those beaucratic fucks denying me my EARNED BANANIUM, well whose laughing now.",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"You need guns, you got cash, i got a solution",
		),
	)
