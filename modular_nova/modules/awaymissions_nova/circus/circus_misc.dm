/area/awaymission/beach/circus_day
	name = "The Circus"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE

/area/awaymission/circus/no_light
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	name = "The Circus, but dark"
	icon_state = "away3"

/area/awaymission/circus/no_light/bad_area
	name = "The circus, but dangerous"

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
	new /obj/structure/trap/cult/honkmother(loc)
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

//end of laser tag stuff beginning of spawners

/obj/effect/spawner/random/clown_loot
	name = "random funny spawn"
	desc = "Spawns a random clown or item intended for the secret clown gambling."
	loot = list(
		/obj/effect/spawner/random/rare_clown_loot = 1,//spawns the really rare clown stuff
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
		/obj/effect/spawner/random/clothing/funny_hats = 5,
		/obj/item/melee/energy/sword/bananium = 5,
		/obj/item/shield/energy/bananium = 5,
		/obj/item/reagent_containers/spray/cyborg_lube = 5,
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

/obj/effect/spawner/random/rare_clown_loot//im 99% sure that theres an upper limit on how many things can spawn from one spawner so here is this work around
	name = "random funny rare spawn"
	desc = "Spawns a random rare item from the clown loot pool, DO. NOT. PUT. ON. STATION. MAPS."
	loot = list(
		/mob/living/basic/mining/legion/houndoftindalos = 0.099,//if you roll this, you better act fast.
		/obj/item/uplink/clownop =  0.001,//these are the same odds as getting a pulse rifle from an arcade machine it will be FINE, especially considering how doing this is actually SIGNIFICANTLY SLOWER than doing an arcade machine
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

//keycards and the keycard doors

/obj/item/keycard/circus
	name = "pink keycard"
	desc = "A pink keycard. How terrific. Looks like it belongs to a circus door."
	color = "#db3bc0"
	puzzle_id = "circus_codz"

/obj/machinery/door/puzzle/keycard/circus
	name = "circus airlock"
	desc = "It looks like it requires a pink keycard."
	puzzle_id = "circus_codz"

/obj/item/keycard/circus_laser_tag
	name = "LASER keycard"
	desc = "A LASER keycard. How strange? Looks like it belongs to a circus door."
	color = "#a9d5ff"
	puzzle_id = "circus_laser_tag"

/obj/machinery/door/puzzle/keycard/circus_laser_tag
	name = "circus airlock"
	desc = "It looks like it requires a LASER keycard."
	puzzle_id = "circus_laser_tag"

/obj/item/keycard/circus_pool
	name = "pool keycard"
	desc = "A pool keycard. How, moist? Looks like it belongs to a circus door, why is it orange?"
	color = "#e26015"
	puzzle_id = "circus_pool"

/obj/machinery/door/puzzle/keycard/circus_pool
	name = "circus airlock"
	desc = "It looks like it requires a pool keycard."
	puzzle_id = "circus_pool"

/obj/item/keycard/circus_museum
	name = "museum keycard"
	desc = "A museum keycard. Hope the exhibits dont get up."
	color = "#e26015"
	puzzle_id = "circus_museum"

/obj/machinery/door/puzzle/keycard/circus_museum
	name = "circus airlock"
	desc = "It looks like it requires a museum keycard."
	puzzle_id = "circus_museum"

/obj/item/keycard/circus_minigun // its done like this because if i incoporate the minigun on mob loot it will cause runtimes
	name = "minigun keycard"
	desc = "A MINIGUN KEYCARD?!? LETS GOOOOO."
	color = "#8b0000"
	puzzle_id = "circus_minigun"

/obj/machinery/door/puzzle/keycard/circus_minigun
	name = "circus airlock"
	desc = "It looks like it requires a museum keycard."
	puzzle_id = "circus_minigun"


//Firing pins and guns for Codz

/obj/item/firing_pin/explorer/un_removable
	pin_removable = FALSE

/obj/item/firing_pin/explorer/un_removable/circus
	name = "Circus Firing Pin"

	var/list/circus = list(
			/area/awaymission/beach/circus_day,
			/area/awaymission/circus,
			/area/awaymission/circus/no_light,
	)

/obj/item/firing_pin/explorer/un_removable/circus/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	if (is_type_in_list(get_area(user), circus))
		return TRUE
	var/turf/station_check = get_turf(user)
	if(!station_check || is_station_level(station_check.z))
		return FALSE
	return TRUE

//tier 4
/obj/item/gun/ballistic/automatic/smart_machine_gun/unrestricted/circus //heavy support
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/ar/modular/circus //soldier
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/tommygun/circus //smg-er
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/rifle/sniper_rifle/circus //sniper
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/energy/pulse/carbine/circus //energy weapons
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/rocketlauncher/nobackblast/circus //explosive specialist
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/energy/pulse/pistol/circus //secondary
	pin = /obj/item/firing_pin/explorer/un_removable/circus

//tier 3 guns for the circus

/obj/item/gun/ballistic/automatic/l6_saw/circus //Heavy support
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/m90/circus //Soldier
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/c20r/reclaimed/circus //smg-er
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/wylom/circus //sniper
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/pulse_rifle/circus //energy weapons
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/pump_launcher/circus //explosive specialist
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/pistol/deagle/gold/circus //secondary
	pin = /obj/item/firing_pin/explorer/un_removable/circus

//tier 2 guns for the circus

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun/circus //Heavy support
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/battle_rifle/circus  //Soldier
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/napad/circus //smg-er
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/rifle/lionhunter/circus //sniper
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/energy/laser/hellgun/circus //energy weapons
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/revolver/grenadelauncher/circus //explosive specialist
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/pistol/m1911/circus  //secondary
	pin = /obj/item/firing_pin/explorer/un_removable/circus

//tier 1 guns for the circus

/obj/item/gun/ballistic/automatic/smartgun/circus //"heavy" support
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/rifle/boltaction/circus //soldier
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/wt550/circus //smg-er
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/rifle/boltaction/donkrifle/circus //sniper
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/energy/laser/carbine/circus //energy weapons
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/circus //explosive specialist
	pin = /obj/item/firing_pin/explorer/un_removable/circus

/obj/item/gun/ballistic/automatic/pistol/sol/circus //secondary
	pin = /obj/item/firing_pin/explorer/un_removable/circus

//begining of wave mob spawners, fuck my life and determination to make a silly gateway
/obj/effect/spawner/random/cult_wave_3
	name = "cult_wave_3-4 spawn"
	desc = "Spawns a random cultist, used in the circus gateway."
	loot = list(
		/mob/living/basic/cult/CodZ = 40,
		/mob/living/basic/cult/assassin/CodZ = 30,
		/mob/living/basic/cult/mannequin/CodZ = 30,
	)

/obj/effect/spawner/random/cult_wave_5
	name = "cult_wave_5-10 spawn"
	desc = "Spawns a random cultist, used in the circus gateway."
	loot = list(
		/mob/living/basic/cult/mannequin/CodZ = 90,
		/mob/living/basic/cult/engorge/CodZ = 8,
		/mob/living/basic/cult/engorge/devourdem/CodZ = 2,
	)

/obj/effect/spawner/random/cult_wave_6
	name = "cult_wave_6-9 spawn"
	desc = "Spawns a random cultist, used in the circus gateway."
	loot = list(
		/mob/living/basic/cult/CodZ = 20,
		/mob/living/basic/cult/assassin/CodZ = 30,
		/mob/living/basic/cult/mannequin/CodZ = 20,
		/mob/living/basic/cult/horror/CodZ = 10,
		/mob/living/basic/cult/magic/CodZ = 20,
	)

/obj/effect/spawner/random/cult_wave_11
	name = "cult_wave_11-14 spawn"
	desc = "Spawns a random cultist, used in the circus gateway."
	loot = list(
		/mob/living/basic/cult/assassin/CodZ = 20,
		/mob/living/basic/cult/ghost/CodZ = 20,
		/mob/living/basic/cult/horror/CodZ = 10,
		/mob/living/basic/cult/magic/CodZ = 20,
		/mob/living/basic/cult/spear/CodZ = 10,
		/mob/living/basic/cult/warrior/CodZ = 10,
		/mob/living/basic/cult/engorge/devourdem/CodZ = 5,
		/mob/living/basic/cult/magic/elite/CodZ = 5,
	)

/obj/effect/spawner/random/cult_wave_15
	name = "cult_wave_15 spawn"
	desc = "Spawns a random cultist, used in the circus gateway, this one spawns a boss."
	loot = list(
		/mob/living/basic/cult/magic/elite/CodZ/Final_Boss = 99.9,
		/mob/living/basic/cult/magic/elite/fireball/CodZ/Rare_shiny_final_boss = 0.1, //hehehehehe
	)
