/obj/structure/epic_loot_crafting_bench/magazine
	name = "ammu-nation station"
	desc = "Not a link to a trade network like the other machines, instead being an online \
		netpage that strangely deals in tags and body parts for magazines and ammo."
	icon_state = "magazine_maker"

	allowed_choices = list(
		/datum/crafting_bench_recipe_real/c8mars_magazine,
		/datum/crafting_bench_recipe_real/c8mars_piercing,
		/datum/crafting_bench_recipe_real/c8mars_shockwave,
		/datum/crafting_bench_recipe_real/c12moku_short,
		/datum/crafting_bench_recipe_real/c12moku_regular,
		/datum/crafting_bench_recipe_real/c12moku_tracer,
		/datum/crafting_bench_recipe_real/c12moku_special,
		/datum/crafting_bench_recipe_real/s6longshot,
		/datum/crafting_bench_recipe_real/nomi_drums,
		/datum/crafting_bench_recipe_real/s12magnum,
		/datum/crafting_bench_recipe_real/s12express,
		/datum/crafting_bench_recipe_real/s12flechette,
		/datum/crafting_bench_recipe_real/c40sol_short,
		/datum/crafting_bench_recipe_real/c40sol_regular,
		/datum/crafting_bench_recipe_real/c40sol_match,
		/datum/crafting_bench_recipe_real/c35sol_short,
		/datum/crafting_bench_recipe_real/c35sol_regular,
		/datum/crafting_bench_recipe_real/c35sol_ripper,
		/datum/crafting_bench_recipe_real/c310_lanca,
		/datum/crafting_bench_recipe_real/c310_piercing,
		/datum/crafting_bench_recipe_real/c27_54,
		/datum/crafting_bench_recipe_real/c585_trappiste,
		/datum/crafting_bench_recipe_real/c585_hp,
	)

// 8mm mars

/datum/crafting_bench_recipe_real/c8mars_magazine
	recipe_name = "chokyu sniper magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 2,
	)
	resulting_item = /obj/item/ammo_box/magazine/c8marsian/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c8mars_piercing
	recipe_name = "8mm Marsian piercing casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c8marsian/prefilled/piercing

/datum/crafting_bench_recipe_real/c8mars_shockwave
	recipe_name = "8mm Marsian shockwave casings"
	recipe_requirements = list(
		/obj/item/organ/internal/heart = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c8marsian/prefilled/shockwave

// 12mm chinmoku

/datum/crafting_bench_recipe_real/c12moku_short
	recipe_name = "chinmoku short magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/c12chinmoku/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c12moku_regular
	recipe_name = "chinmoku magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 3,
	)
	resulting_item = /obj/item/ammo_box/magazine/c12chinmoku/standard/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c12moku_tracer
	recipe_name = "12mm Chinmoku tracer casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c12chinmoku/prefilled/tracer
	amount_to_make = 4

/datum/crafting_bench_recipe_real/c12moku_special
	recipe_name = "12mm Chinmoku special casings"
	recipe_requirements = list(
		/obj/item/organ/internal/heart = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c12chinmoku/prefilled/special
	amount_to_make = 4

// 6ga Shotgun

/datum/crafting_bench_recipe_real/s6longshot
	recipe_name = "12mm Chinmoku tracer casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/s6gauge/prefilled/longshot
	amount_to_make = 2

// 12ga Shotgun

/datum/crafting_bench_recipe_real/nomi_drums
	recipe_name = "nomi 12ga drum"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 2,
	)
	resulting_item = /obj/item/ammo_box/magazine/c12nomi/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/s12magnum
	recipe_name = "12ga magnum"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/magnum
	amount_to_make = 3

/datum/crafting_bench_recipe_real/s12express
	recipe_name = "12ga express"
	recipe_requirements = list(
		/obj/item/organ/internal/ears = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/express
	amount_to_make = 3

/datum/crafting_bench_recipe_real/s12flechette
	recipe_name = "12ga flechette"
	recipe_requirements = list(
		/obj/item/organ/internal/heart = 1,
		/obj/item/epic_loot/nail_box = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/flechette
	amount_to_make = 3

// .40 sol stuff

/datum/crafting_bench_recipe_real/c40sol_short
	recipe_name = "sol rifle short magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/c40sol_rifle/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c40sol_regular
	recipe_name = "sol rifle magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 3,
	)
	resulting_item = /obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c40sol_match
	recipe_name = ".40 Sol Long match casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c40_sol/prefilled/match
	amount_to_make = 4

// .35 sol stuff

/datum/crafting_bench_recipe_real/c35sol_short
	recipe_name = "sol pistol magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c35sol_regular
	recipe_name = "sol pistol extended magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 3,
	)
	resulting_item = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c35sol_ripper
	recipe_name = ".35 Sol Short ripper casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c35_sol/prefilled/ripper
	amount_to_make = 4

// .310 stuff

/datum/crafting_bench_recipe_real/c310_lanca
	recipe_name = "lanca rifle magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/lanca/spawns_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c310_piercing
	recipe_name = ".310 Strilka piercing casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled/ap
	amount_to_make = 2

// .27-54 and miecz magazines

/datum/crafting_bench_recipe_real/c27_54
	recipe_name = "miecz submachinegun magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/miecz/spawns_empty
	amount_to_make = 3

// .585

/datum/crafting_bench_recipe_real/c585_trappiste
	recipe_name = "lanca rifle magazine"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/c585trappiste_pistol/spawns_empty
	amount_to_make = 3

/datum/crafting_bench_recipe_real/c585_hp
	recipe_name = ".585 Trappiste hollowhead casings"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/ammo_box/magazine/ammo_stack/c585_trappiste/prefilled/hollowpoint
	amount_to_make = 2
