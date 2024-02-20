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

/datum/outfit/deathmatch_loadout/wizard/electro
	name = "Deathmatch: Electromancer"
	display_name = "Electromancer"
	desc = "Batons are so last century."

	suit = /obj/item/clothing/suit/wizrobe/magusred
	head = /obj/item/clothing/head/wizard/magus
	granted_spells = list(
		/datum/action/cooldown/spell/pointed/projectile/lightningbolt,
		/datum/action/cooldown/spell/charged/beam/tesla,
	)

/datum/outfit/deathmatch_loadout/wizard/necromancer
	name = "Deathmatch: Necromancer"
	display_name = "Necromancer"
	desc = "I've got a BONE to pick- Yeah, sorry."
	species_override = /datum/species/skeleton

	suit = /obj/item/clothing/suit/wizrobe/black
	head = /obj/item/clothing/head/wizard/black
	granted_spells = list(
		/datum/action/cooldown/spell/touch/scream_for_me,
		/datum/action/cooldown/spell/teleport/radius_turf/blink,
	)

/datum/outfit/deathmatch_loadout/wizard/larp
	name = "Deathmatch: LARPer"
	display_name = "LARPer"
	desc = "Lightning bolt! Lightning bolt! Lightning bolt!"

	l_hand = /obj/item/staff/stick
	suit = /obj/item/clothing/suit/wizrobe/fake
	head = /obj/item/clothing/head/wizard/fake
	shoes = /obj/item/clothing/shoes/sandal
	granted_spells = list(
		/datum/action/cooldown/spell/conjure_item/spellpacket,
		/datum/action/cooldown/spell/aoe/repulse/wizard,
	)

/datum/outfit/deathmatch_loadout/wizard/chuuni
	name = "Deathmatch: Chuuni"
	display_name = "Chuunibyou"
	desc = "Darkness blacker than black and darker than dark, I beseech thee..."

	l_hand = /obj/item/staff/broom
	suit = /obj/item/clothing/suit/wizrobe/marisa
	head = /obj/item/clothing/head/wizard/marisa
	shoes = /obj/item/clothing/shoes/sneakers/marisa
	granted_spells = list(
		/datum/action/cooldown/spell/chuuni_invocations/deathmatch,
		/datum/action/cooldown/spell/pointed/projectile/spell_cards,
	)

/datum/outfit/deathmatch_loadout/wizard/battle
	name = "Deathmatch: Battlemage"
	display_name = "Battlemage"
	desc = "Have you heard of the High Elves?"

	l_hand = /obj/item/mjollnir
	suit = /obj/item/clothing/suit/wizrobe/magusblue
	head = /obj/item/clothing/head/wizard/magus
	granted_spells = list(
		/datum/action/cooldown/spell/summonitem,
	)

/datum/outfit/deathmatch_loadout/wizard/apprentice
	name = "Deathmatch: Apprentice"
	display_name = "Apprentice"
	desc = "You feel severely under-leveled for this encounter..."

	l_hand = null
	granted_spells = list(
		/datum/action/cooldown/spell/stimpack,
		/datum/action/cooldown/spell/charge,
	)

/datum/outfit/deathmatch_loadout/wizard/gunmancer
	name = "Deathmatch: Gunmancer"
	display_name = "Gunmancer"
	desc = "Magic is lame."

	l_hand = /obj/item/gun/ballistic/automatic/pistol/m1911
	suit = /obj/item/clothing/suit/wizrobe/tape
	head = /obj/item/clothing/head/wizard/tape
	shoes = /obj/item/clothing/shoes/jackboots
	granted_spells = list(
		/datum/action/cooldown/spell/conjure_item/infinite_guns/gun,
		/datum/action/cooldown/spell/aoe/knock,
	)

/datum/outfit/deathmatch_loadout/wizard/monkey
	name = "Deathmatch: Monkey"
	display_name = "Monkeymancer"
	desc = "Ook eek aaa ooo eee!"
	species_override = /datum/species/monkey

	l_hand = /obj/item/food/grown/banana
	uniform = /obj/item/clothing/under/color/lightpurple
	suit = /obj/item/clothing/suit/wizrobe
	head = /obj/item/clothing/head/wizard
	granted_spells = list(
		/datum/action/cooldown/spell/conjure/simian,
	)

/datum/outfit/deathmatch_loadout/wizard/chaos
	name = "Deathmatch: Chaos"
	display_name = "Chaosmancer"
	desc = "Hardcore Random Body ONLY!"

	l_hand = /obj/item/gun/magic/staff/chaos
	uniform = /obj/item/clothing/under/color/rainbow
	head = /obj/item/clothing/head/wizard/red
	shoes = /obj/item/clothing/shoes/sneakers/marisa
	granted_spells = list(
		/datum/action/cooldown/spell/rod_form/deathmatch,
		/datum/action/cooldown/spell/conjure/the_traps,
	)

/datum/outfit/deathmatch_loadout/wizard/clown
	name = "Deathmatch: Clown"
	display_name = "Funnymancer"
	desc = "Honk NATH!"

	l_hand = /obj/item/gun/magic/staff/honk
	uniform = /obj/item/clothing/under/rank/civilian/clown/magic
	suit = /obj/item/clothing/suit/chaplainsuit/clownpriest
	head = /obj/item/clothing/head/chaplain/clownmitre
	mask = /obj/item/clothing/mask/gas/clown_hat
	back = /obj/item/storage/backpack/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	granted_spells = list(
		null,
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
