/area/awaymission/beach/circus_day
	name = "The Circus"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE

/area/awaymission/beach/circus_day/no_light
	name = "The Circus, but dark"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = FALSE

/obj/item/paper/fluff/cyborg_circus
	name = "Cyborg charger"
	default_raw_text = "Dont worry for any of or silicon friends out there, here is a recharger."

/turf/open/floor/iron/solarpanel/terrible_pun
	name = "SOLarpanel"
	desc = "Wow."

//walls n floor and structures and stuff.

/turf/open/floor/carpet/cyan/cold_atmos
	initial_gas_mix = COLD_ATMOS

/turf/open/chasm/cold_atmos
	initial_gas_mix = COLD_ATMOS

/turf/open/lava/incinerator
	name = "Incineration lava"
	desc = "So this is how this circus gets rid of their trash and keep things so clean"

/turf/closed/indestructible/bananium
	name = "silly wall"
	desc = "Effectively impervious to conventional methods of honking."
	icon = 'icons/turf/walls/bananium_wall.dmi'
	icon_state = "bananium_wall-0"
	base_icon_state = "bananium_wall"
	explosive_resistance = 50
	rust_resistance = RUST_RESISTANCE_ABSOLUTE

/obj/structure/trap/cult/honkmother
	name = "funny rune"
	desc = "A rune that looks like it would belong in a clown convention- its yellow, and made out of banana paste"
	icon = 'icons/effects/96x96.dmi'
	color = "#Ffff00"
	icon_state = "rune_large"
	pixel_x = -32
	pixel_y = 16
	pixel_z = -48
	faction = "clown"
	alpha = 100 //initially quite hidden when not "recharging"

/obj/structure/trap/cult/honkmother/trap_effect(mob/living/victim)
	to_chat(victim, span_bolddanger("With a crack, a clown and something else emerge from a small yellow portal with lightning shooting off of the portals,shocking you!"))
	victim.electrocute_act(10, src, flags = SHOCK_NOGLOVES) // electrocute act does a message.
	victim.Paralyze(2 SECONDS)
	new /obj/effect/spawner/random/clown_loot(loc)
	new /mob/living/basic/clown(loc)
	QDEL_IN(src, 3 SECONDS)

//end of structures beginning of boingos lost stuff

/obj/item/bikehorn/golden/boingos_lost_horn
	name = "boingos lost bike horn"
	desc = "it seems to be made out of bananium"

/obj/item/access_key/boingos_car_key
	name = "Boingos car key"
	desc = "this has way more than just one car key on it"

/obj/item/gun/ballistic/revolver/golden/boingos_blicky
	name = "Boingos gun"
	desc = "A gun- made out of bananium- which is a very, soft material"
	projectile_damage_multiplier = 0.5

/obj/item/toy/figure/clown/boingos_action_figure
	name = "Boingos action figure"
	desc = "An old figurine of a clown"

//end of boingos lost items, beginning of the red/blue laser tag miniguns and the shields

/obj/item/gun/energy/minigun/red
	name = "Red team laser minigun"
	desc = "Not a real laser minigun- but one meant for laser tag"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	cell_type = /obj/item/stock_parts/power_store/cell/minigun
	can_charge = TRUE
	gun_flags = NOT_A_REAL_GUN
	selfcharge = TRUE

/obj/item/gun/energy/minigun/blue
	name = "Blue team laser minigun"
	desc = "Not a real laser minigun- but one meant for laser tag"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	cell_type = /obj/item/stock_parts/power_store/cell/minigun
	can_charge = TRUE
	gun_flags = NOT_A_REAL_GUN
	selfcharge = TRUE

/obj/item/shield/roman/blue
	name = "Blue team shield"
	desc = "A blue painted shield"
	uses_integrity = 0
	color = "#0000FF"

/obj/item/shield/roman/red
	name = "Red team shield"
	desc = "A red painted shield"
	uses_integrity = 0
	color = "#ff0000"

//weaker subtype of the normal minigun as a result for killing the victor

/obj/item/minigunpack/weaker
	name = "backpack power source"
	desc = "The massive external power source for the laser gatling gun."

	/obj/item/gun/energy/minigun/weaker/gun

/obj/item/gun/energy/minigun/weaker
	projectile_damage_multiplier = 0.5

//end of laser tag stuff beginning of spawners

/obj/effect/spawner/random/clown_loot
	name = "random funny spawn"
	desc = "Spawns a random clown or item intended for the secret clown gambling."
	loot = list(
		/obj/effect/spawner/random/clown_loot/rare_stuff = 1,//spawns the really rare clown stuff
		/obj/effect/spawner/random/clown_loot_medium = 60,//spawns the more mediocre clown stuff- still some good stuff though
		/obj/effect/spawner/random/clown_food_loot = 20,//mostly food and consumables
		/obj/effect/spawner/random/clown_loot_hostile = 19,//odds of you getting a monster spawned on you
	)

/obj/effect/spawner/random/clown_loot_hostile
	name = "random funny spawn"
	desc = "Spawns a random clown- probably hostile, intended for the secret clown gambling."
	loot = list(
		/obj/structure/spawner/clown = 1,
		/mob/living/basic/clown/clownhulk/honkmunculus = 1,
		/mob/living/basic/clown/mutant = 2,
		/mob/living/basic/clown/mutant/glutton = 2,
		/mob/living/basic/clown/fleshclown = 2,
		/mob/living/basic/clown/honkling = 3,
		/mob/living/basic/clown/longface = 3,
		/mob/living/basic/clown/clownhulk/chlown = 6,
		/mob/living/basic/clown/clownhulk/destroyer = 10,
		/mob/living/basic/clown/clownhulk = 20,
		/mob/living/basic/clown/banana = 30,
		/mob/living/basic/clown = 10,
		/obj/item/toy/figure/clown = 10,
	)

/obj/effect/spawner/random/clown_loot_medium
	name = "random funny spawn"
	desc = "Spawns a random item intended for the secret clown gambling, this one of the medium variety."
	loot = list(
		/obj/item/clothing/shoes/clown_shoes/banana_shoes = 5,
		/obj/item/clothing/shoes/clown_shoes/combat = 5,
		/obj/item/target/clown = 5,
		/obj/item/vending_refill/donksoft = 5,
		/obj/item/storage/toolbox/guncase/traitor/donksoft = 5,
		/obj/item/storage/toolbox/guncase/traitor/ammunition/donksoft = 5,
		/obj/effect/spawner/random/clothing/funny_hats = 10,
		/obj/item/reagent_containers/spray/cyborg_lube = 10,
		/obj/item/reagent_containers/spray/waterflower/superlube = 10,
		/obj/item/toy/crayon/spraycan/lubecan = 10,
		/obj/item/reagent_containers/spray/waterflower/lube = 10,
		/obj/effect/spawner/costume/sexyclown = 5,
		/obj/item/bedsheet/clown/double = 5,
		/obj/item/card/id/advanced/centcom/ert/clown = 5,
		/obj/item/borg/upgrade/transform/clown = 5,
	)

/obj/effect/spawner/random/clown_food_loot//spawns clown consumables
	name = "random funny food spawn"
	desc = "Spawns a random consumable item intended for the secret clown gambling."
	loot = list(
		/obj/item/food/burger/clown = 10,
		/obj/item/food/cake/clown_cake = 10,
		/obj/item/food/cakeslice/clown_slice = 10,
		/obj/item/food/meatclown = 10,
		/obj/item/food/snowcones/clown = 10,
		/obj/item/fish/clownfish = 10,
		/obj/item/fish/clownfish/lube = 10,
		/obj/item/reagent_containers/applicator/patch/style/clown = 10,
		/obj/item/reagent_containers/cup/bottle/clownstears = 10,
		/obj/item/sticker/clown = 10,
	)

/obj/effect/spawner/random/rare_stuff//im 99% sure that theres an upper limit on how many things can spawn from one spawner so here is this work around
	name = "random funny rare spawn"
	desc = "Spawns a random rare item from the clown loot pool, DO. NOT. PUT. ON. STATION. MAPS."
	loot = list(
		/mob/living/basic/mining/legion/houndoftindalos = 0.09,//if you roll this, you better act fast.
		/obj/item/uplink/clownop =  0.01,//these are the same odds as getting a pulse rifle from an arcade machine it will be FINE, especially considering how doing this is actually SIGNIFICANTLY SLOWER than doing an arcade machine
		/obj/effect/spawner/random/anomaly = 0.9,//so rare because these portals work- most of the time with no downside, but ya know clownmancy isnt perfect.
		/obj/item/stack/sheet/mineral/runite = 3,
		/obj/item/stack/sheet/mineral/gold = 10,
		/obj/item/stack/sheet/hauntium = 10,
		/obj/machinery/syndicatebomb/badmin/clown = 1,
		/obj/item/mod/control/pre_equipped/responsory/clown = 1,
		/obj/item/grenade/spawnergrenade/clown_broken = 1,
		/obj/item/firing_pin/clown/ultra/selfdestruct = 1,
		/obj/vehicle/sealed/car/clowncar = 1,
		/obj/item/gun/magic/staff/honk = 1,
		/obj/item/clothing/shoes/clown_shoes/banana_shoes/combat = 70,
	)

/obj/effect/spawner/random/anomaly//so aparently no actual just random anomaly spawners exist- so this is that
	name = "anomaly spawner"
	icon_state = "big_anomaly"
	loot = list(
		/obj/effect/anomaly/pyro,
		/obj/effect/anomaly/flux,
		/obj/effect/anomaly/bluespace,
		/obj/effect/anomaly/grav,
		/obj/effect/anomaly/hallucination,
		/obj/effect/anomaly/dimensional,
		/obj/effect/anomaly/ectoplasm,
		/obj/effect/anomaly/bioscrambler,
	)

