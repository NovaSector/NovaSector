/obj/item/bitrunning_disk/ability/tier0
	name = "bitrunning program: cantrip"
	selectable_actions = list(
		/datum/action/cooldown/spell/shapeshift/minor_illusion,
		/datum/action/cooldown/spell/conjure_item/fire,
		/datum/action/cooldown/spell/conjure_item/water,
	)

/obj/item/bitrunning_disk/item/tier0
	name = "bitrunning gear: trinket"
	selectable_items = list(
		/obj/item/binoculars,
		/obj/item/stack/marker_beacon/thirty,
		/obj/item/storage/belt/military/snack/full,
		/obj/item/dice/d20,
		/obj/item/storage/pouch/medical/firstaid/stabilizer,
		/obj/item/storage/pouch/cin_medkit,
	)

/datum/orderable_item/bitrunning_tech/ability_tier0
	cost_per_order = 500
	item_path = /obj/item/bitrunning_disk/ability/tier0
	desc = "This disk contains a program that lets you cast Minor Illusion, Produce Flame, or Produce Water."

/datum/orderable_item/bitrunning_tech/item_tier0
	cost_per_order = 500
	item_path = /obj/item/bitrunning_disk/item/tier0
	desc = "This disk contains a program that lets you equip thirty marker beacons, a snack rig, a D20, a stabilizer pouch, or an empty colonial first-aid pouch."

/obj/item/bitrunning_disk/item/tier1/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/storage/belt/military,
	)

/obj/item/bitrunning_disk/item/tier2/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/clothing/head/helmet,
		/obj/item/melee/energy/sword/saber/blue,
		/obj/item/storage/medkit/expeditionary/surplus,
	)

/obj/item/bitrunning_disk/item/tier3/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/autosurgeon/syndicate/nodrop,
	)

/obj/item/bitrunning_disk/ability/tier1/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/spell/touch/lay_on_hands,
	/datum/action/cooldown/spell/conjure/flare,
	)

/obj/item/bitrunning_disk/ability/tier2/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/adrenaline,
	/datum/action/cooldown/spell/charge,
	)

/obj/item/bitrunning_disk/ability/tier3/Initialize(mapload)
	. = ..()
	selectable_actions -= list(/datum/action/cooldown/spell/shapeshift/polar_bear)
	selectable_actions += list(
	/datum/action/cooldown/spell/shapeshift/juggernaut,
	/datum/action/cooldown/mob_cooldown/dash,
	/datum/action/cooldown/spell/touch/scream_for_me,
	/datum/action/cooldown/spell/death_loop,
	)

/datum/orderable_item/bitrunning_tech/item_tier1
	desc = "This disk contains a program that lets you equip a medical beamgun, a C4 explosive, a box of infinite pizza, or a military webbing."

/datum/orderable_item/bitrunning_tech/item_tier2
	desc = "This disk contains a program that lets you equip a luxury medipen, a pistol, an armour vest, a helmet, an energy sword, or an expeditionary medkit."

/datum/orderable_item/bitrunning_tech/item_tier3
	desc = "This disk contains a program that lets you equip an advanced energy gun, a dual bladed energy sword, a minibomb, or an anti-drop implanter."

/datum/orderable_item/bitrunning_tech/ability_tier1
	desc = "This disk contains a program that lets you cast Summon Cheese, Summon Light Source, Lesser Heal, or Mending Touch."

/datum/orderable_item/bitrunning_tech/ability_tier2
	desc = "This disk contains a program that lets you cast Fireball, Lightning Bolt, Forcewall, Adrenaline Rush, or Charge Item."

/datum/orderable_item/bitrunning_tech/ability_tier3
	desc = "This disk contains a program that lets you shapeshift into a lesser ashdrake, or a holy juggernaut; or cast Dash, Scream For Me, or Death Loop."
