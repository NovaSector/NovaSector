/obj/effect/spawner/random/epic_loot
	name = "extraction loot spawner"
	desc = "Gods please let there be nobody extract camping."
	icon = 'modular_nova/modules/epic_loot/icons/epic_loot.dmi'
	icon_state = null

/obj/effect/spawner/random/epic_loot/chainlet
	name = "random chainlet spawner"
	desc = "Automagically transforms into a random chainlet made of valuable metals."
	icon_state = "random_chain"
	loot = list(
		/obj/item/epic_loot/silver_chainlet = 2,
		/obj/item/epic_loot/gold_chainlet = 1,
	)

/obj/effect/spawner/random/epic_loot/pocket_sized_valuables
	name = "random pocket sized valuables spawner"
	desc = "Automagically transforms into a random valuable that would reasonably be in someone's coat pocket."
	icon_state = "random_pocket_valuable"
	loot = list(
		/obj/effect/spawner/random/epic_loot/chainlet = 1,
		/obj/item/epic_loot/press_pass = 1,
		/obj/item/epic_loot/military_flash = 1,
		/obj/item/epic_loot/slim_diary = 1,
	)
