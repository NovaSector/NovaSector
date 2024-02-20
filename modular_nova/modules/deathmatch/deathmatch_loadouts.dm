/datum/outfit/deathmatch_loadout/wizard
	name = "Deathmatch: Wizard"
	display_name = "Wizard"
	desc = "It's wizard time, motherfucker! FIREBALL!!"

	l_hand = /obj/item/staff
	uniform = /obj/item/clothing/under/color/lightpurple
	suit = /obj/item/clothing/suit/wizrobe
	head = /obj/item/clothing/head/wizard
	shoes = /obj/item/clothing/shoes/sandal/magic
	granted_spells = list(
		/datum/action/cooldown/spell/aoe/magic_missile,
		/datum/action/cooldown/spell/forcewall,
		/datum/action/cooldown/spell/jaunt/ethereal_jaunt,
	)

/datum/outfit/deathmatch_loadout/wizard/pyro
	name = "Deathmatch: Pyromancer"
	display_name = "Pyromancer"
	desc = "Burninating the station-side! Burninating all the wizards!"

	suit = /obj/item/clothing/suit/wizrobe/red
	head = /obj/item/clothing/head/wizard/red
	mask = /obj/item/clothing/mask/cigarette
	granted_spells = list(
		/datum/action/cooldown/spell/pointed/projectile/fireball,
		/datum/action/cooldown/spell/smoke,
	)

/*
uniform = /datum/outfit/job/security::uniform
suit = /datum/outfit/job/security::suit
suit_store = /datum/outfit/job/security::suit_store
belt = /datum/outfit/job/security::belt
ears = /datum/outfit/job/security::ears //cant communicate with station i think?
gloves = /datum/outfit/job/security::gloves
head = /datum/outfit/job/security::head
shoes = /datum/outfit/job/security::shoes
l_pocket = /obj/item/flashlight/seclite
l_hand = /obj/item/gun/energy/disabler
r_pocket = /obj/item/knife/combat/survival
back = /datum/outfit/job/security::backpack
*/
