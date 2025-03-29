/datum/opposing_force_equipment/clothing_syndicate
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_SYNDICATE

/datum/opposing_force_equipment/clothing_syndicate/operative
	name = "Syndicate Operative"
	description = "A tried classic outfit, sporting versatile defensive gear, tactical webbing, a comfortable turtleneck, and even an emergency space-suit box."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/operative

/obj/item/storage/backpack/duffelbag/syndie/operative/PopulateContents() //basically old insurgent bundle -nukie mod
	return list(
		/obj/item/clothing/under/syndicate/nova/tactical,
		/obj/item/clothing/under/syndicate/nova/tactical/skirt,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/gloves/tackler/combat,
		/obj/item/clothing/mask/gas/syndicate,
		/obj/item/storage/belt/military,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/storage/box/syndie_kit/space_suit,
	)

/datum/opposing_force_equipment/clothing_syndicate/engineer
	name = "Syndicate Engineer"
	description = "A spin on the classic outfit, for those whose hands are never clean. Trades defensive choices for utility. Comes with an emergency space-suit box."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/engineer

/obj/item/storage/backpack/duffelbag/syndie/engineer/PopulateContents()
	return list(
		/obj/item/clothing/under/syndicate/nova/overalls,
		/obj/item/clothing/under/syndicate/nova/overalls/skirt,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/gloves/combat,
		/obj/item/clothing/mask/gas/syndicate,
		/obj/item/storage/belt/utility/syndicate,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/clothing/glasses/meson/night,
		/obj/item/storage/box/syndie_kit/space_suit,
	)

/datum/opposing_force_equipment/clothing_syndicate/spy
	name = "Syndicate Spy"
	description = "They don't have to know who you are, and they won't. Comes with emergency space-suit box."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/spy

/obj/item/storage/backpack/duffelbag/syndie/spy/PopulateContents()
	return list(
		/obj/item/clothing/under/suit/black/armoured,
		/obj/item/clothing/under/suit/black/skirt/armoured,
		/obj/item/clothing/suit/jacket/det_suit/noir/armoured,
		/obj/item/storage/belt/holster/detective/dark,
		/obj/item/clothing/head/frenchberet/armoured,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/neck/tie/red/hitman,
		/obj/item/clothing/mask/gas/syndicate/ds, //a red spy is in the base
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/hhmirror/syndie,
		/obj/item/storage/box/syndie_kit/space_suit,
	)

/datum/opposing_force_equipment/clothing_syndicate/maid
	name = "Syndicate Maid"
	description = "..."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/maid

/obj/item/storage/backpack/duffelbag/syndie/maid/PopulateContents() //by far the weakest bundle
	return list(
		/obj/item/clothing/under/syndicate/nova/maid,
		/obj/item/clothing/gloves/combat/maid,
		/obj/item/clothing/head/costume/maidheadband/syndicate,
		/obj/item/clothing/shoes/laceup,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_syndicate/cybersun_operative
	name = "Cybersun Operative"
	description = "For the most covert of ops. Comes with emergency space-suit box."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/cybersun_operative

/obj/item/storage/backpack/duffelbag/syndie/cybersun_operative/PopulateContents() //drip maxxed
	return list(
		/obj/item/clothing/under/syndicate/combat,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/gloves/combat,
		/obj/item/clothing/mask/neck_gaiter,
		/obj/item/clothing/glasses/meson/night,
		/obj/item/storage/belt/military/assault,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/storage/box/syndie_kit/space_suit,
	)

/datum/opposing_force_equipment/clothing_syndicate/cybersun_hacker
	name = "Cybersun Hacker"
	description = "Some space-farers believe the infamous Space Ninja is no longer around, and they are wrong."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/cybersun_hacker

/obj/item/storage/backpack/duffelbag/syndie/cybersun_hacker/PopulateContents()
	return list(
		/obj/item/clothing/under/syndicate/ninja,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/gloves/combat,
		/obj/item/clothing/mask/gas/ninja,
		/obj/item/clothing/glasses/hud/health/night/meson, //damn it's sexy
		/obj/item/storage/belt/military/assault,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_syndicate/lone_gunman
	name = "Lone Gunman"
	description = "My name is not important."
	admin_note = "Looks unarmoured, yet is very armoured"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/lone_gunman

/obj/item/storage/backpack/duffelbag/syndie/lone_gunman/PopulateContents()
	return list(
		/obj/item/clothing/under/pants/track/robohand,
		/obj/item/clothing/glasses/sunglasses/robohand,
		/obj/item/clothing/suit/jacket/trenchcoat/gunman,
		/obj/item/clothing/shoes/combat,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)


/datum/opposing_force_equipment/clothing_sol
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_SOL

/datum/opposing_force_equipment/clothing_sol/sol_militant
	name = "Sol Militant"
	description = "There is a war being fought, and it's taking place right here."
	item_type = /obj/item/storage/backpack/ert/odst/hecu/sol_militant

/obj/item/storage/backpack/ert/odst/hecu/sol_militant/PopulateContents()
	return list(
		/obj/item/clothing/under/sol_peacekeeper,
		/obj/item/clothing/suit/armor/sf_peacekeeper,
		/obj/item/clothing/head/helmet/sf_peacekeeper,
		/obj/item/storage/belt/military/assault,
		/obj/item/clothing/mask/gas/hecu2,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/gloves/combat,
		/obj/item/clothing/glasses/night,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_sol/dogginos
	name = "Dogginos Courier"
	description = "You're just doing your job."
	item_type = /obj/item/storage/backpack/satchel/leather/dogginos

/obj/item/storage/backpack/satchel/leather/dogginos/PopulateContents()
	return list(
		/obj/item/clothing/under/pizza,
		/obj/item/clothing/suit/pizzaleader,
		/obj/item/clothing/suit/toggle/jacket/hoodie/pizza,
		/obj/item/clothing/head/pizza,
		/obj/item/clothing/head/soft/red,
		/obj/item/clothing/glasses/regular/betterunshit,
		/obj/item/clothing/mask/fakemoustache/italian,
		/obj/item/clothing/shoes/sneakers/red,
		/obj/item/radio/headset/headset_cent/impostorsr,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_sol/impostor
	name = "CentCom Impostor"
	description = "Don't ask us how we got this. Comes with special agent ID pre-equipped with COMMAND access."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/impostor

/obj/item/storage/backpack/duffelbag/syndie/impostor/PopulateContents()
	return list(
		/obj/item/clothing/under/rank/centcom/officer,
		/obj/item/clothing/under/rank/centcom/officer_skirt,
		/obj/item/clothing/head/hats/centcom_cap,
		/obj/item/clothing/suit/armor/centcom_formal,
		/obj/item/clothing/shoes/combat,
		/obj/item/radio/headset/headset_cent/impostorsr,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clipboard,
		/obj/item/card/id/advanced/chameleon/impostorsr, //this thing has bridge access, and no one knows about that
		/obj/item/stamp/centcom,
		/obj/item/clothing/gloves/combat,
	)


/datum/opposing_force_equipment/clothing_pirate
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_PIRATE

/datum/opposing_force_equipment/clothing_pirate/space_pirate
	name = "Space Pirate"
	description = "Did you fall overboard?"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/space_pirate

/obj/item/storage/backpack/duffelbag/syndie/space_pirate/PopulateContents()
	return list(
		/obj/item/clothing/under/costume/pirate,
		/obj/item/clothing/suit/space/pirate,
		/obj/item/clothing/head/helmet/space/pirate,
		/obj/item/clothing/head/costume/pirate/armored,
		/obj/item/clothing/shoes/pirate/armored,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_pirate/akula
	name = "Azulean Boarder"
	description = "Advanced Azulean pirate gear, akin to riot-armour yet space-proofed. Never take on an Azulean boarder in zero-gravity."
	admin_note = "Uniquely spaceproofed."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/akula

/obj/item/storage/backpack/duffelbag/syndie/akula/PopulateContents()
	return list(
		/obj/item/clothing/under/skinsuit,
		/obj/item/clothing/suit/armor/riot/skinsuit_armor,
		/obj/item/clothing/head/helmet/space/skinsuit_helmet,
		/obj/item/clothing/gloves/tackler/combat, //tackles in space
		/obj/item/clothing/shoes/combat,
		/obj/item/storage/belt/military,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_pirate/nri_soldier
	name = "NRI Soldier"
	description = "The station failed the inspection, now they have to deal with you."
	item_type = /obj/item/storage/backpack/industrial/cin_surplus/forest/nri_soldier

/obj/item/storage/backpack/industrial/cin_surplus/forest/nri_soldier/PopulateContents()
	return list(
		/obj/item/clothing/under/syndicate/rus_army,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/gloves/tackler/combat,
		/obj/item/clothing/mask/gas/hecu2,
		/obj/item/clothing/suit/armor/vest/marine,
		/obj/item/clothing/head/beret/sec/nri,
		/obj/item/storage/belt/military/nri/plus_mre,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/clothing/glasses/sunglasses,
	)

/datum/opposing_force_equipment/clothing_pirate/heister
	name = "Professional"
	description = "It's payday."
	admin_note = "Has uniquely strong armour."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/heister

/obj/item/storage/backpack/duffelbag/syndie/heister/PopulateContents()
	var/obj/item/clothing/new_mask = new /obj/item/clothing/mask/gas/clown_hat //-animal mask +clow mask
	new_mask.set_armor(new_mask.get_armor().generate_new_with_specific(list(
		MELEE = 30,
		BULLET = 25,
		LASER = 25,
		ENERGY = 25,
		BOMB = 0,
		BIO = 0,
		FIRE = 100,
		ACID = 100,
	)))
	return list(
		new_mask,
		/obj/item/storage/box/syndie_kit/space_suit,
		/obj/item/clothing/gloves/latex/nitrile/heister,
		/obj/item/clothing/under/suit/black,
		/obj/item/clothing/under/suit/black/skirt,
		/obj/item/clothing/neck/tie/red/hitman,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/suit/jacket/det_suit/noir/heister,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/restraints/handcuffs/cable/zipties,
	)

/datum/opposing_force_equipment/clothing_magic
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_MAGIC

/datum/opposing_force_equipment/clothing_magic/wizard
	name = "Wizard"
	description = "Basic colored wizard attire."
	item_type = /obj/item/storage/backpack/satchel/leather/wizard

/obj/item/storage/backpack/satchel/leather/wizard/PopulateContents()
	. = list()
	switch(pick(list("yellow", "blue", "red", "black")))
		if("yellow")
			. += /obj/item/clothing/head/wizard/yellow
			. += /obj/item/clothing/suit/wizrobe/yellow
		if("blue")
			. += /obj/item/clothing/head/wizard
			. += /obj/item/clothing/suit/wizrobe
		if("red")
			. += /obj/item/clothing/head/wizard/red
			. += /obj/item/clothing/suit/wizrobe/red
		if("black")
			. += /obj/item/clothing/head/wizard/black
			. += /obj/item/clothing/suit/wizrobe/black
	. += /obj/item/staff
	. += /obj/item/clothing/shoes/sandal/magic
	. += /obj/item/radio/headset/syndicate/alt
	. += /obj/item/card/id/advanced/chameleon

/datum/opposing_force_equipment/clothing_magic/wizard_broom
	name = "Broom Wizard"
	description = "A wizard with a broom, technically a witch."
	item_type = /obj/item/storage/backpack/satchel/leather/wizard_broom

/obj/item/storage/backpack/satchel/leather/wizard_broom/PopulateContents()
	return list(
		/obj/item/clothing/suit/wizrobe/marisa,
		/obj/item/clothing/head/wizard/marisa,
		/obj/item/staff/broom,
		/obj/item/clothing/shoes/sneakers/marisa,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_magic/wizard_tape
	name = "Tape Wizard"
	description = "A wizard outfit, but hand-crafted. Very nice."
	item_type = /obj/item/storage/backpack/satchel/leather/wizard_tape

/obj/item/storage/backpack/satchel/leather/wizard_tape/PopulateContents()
	return list(
		/obj/item/clothing/suit/wizrobe/tape,
		/obj/item/clothing/head/wizard/tape,
		/obj/item/staff/tape,
		/obj/item/clothing/shoes/sandal/magic,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_magic/zealot
	name = "Zealot"
	description = "Spell-casting is outlawed, not like that'll stop you though."
	item_type = /obj/item/storage/backpack/satchel/leather/zealot

/obj/item/storage/backpack/satchel/leather/zealot/PopulateContents()
	return list(
		/obj/item/clothing/suit/hooded/cultrobes/eldritch,
		/obj/item/clothing/glasses/hud/health/night/cultblind_unrestricted,
		/obj/item/clothing/shoes/cult,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)

/datum/opposing_force_equipment/clothing_magic/narsian
	name = "Nar'Sien Prophet"
	description = "An overshadowed cult following, whom incidentally thrive best in the dark."
	item_type = /obj/item/storage/backpack/satchel/leather/narsian

/obj/item/storage/backpack/satchel/leather/narsian/PopulateContents()
	return list(
		/obj/item/clothing/suit/hooded/cultrobes/hardened,
		/obj/item/clothing/head/hooded/cult_hoodie/hardened,
		/obj/item/clothing/glasses/hud/health/night/cultblind_unrestricted/narsie,
		/obj/item/clothing/shoes/cult/alt,
		/obj/item/bedsheet/cult,
		/obj/item/radio/headset/syndicate/alt,
		/obj/item/card/id/advanced/chameleon,
	)


