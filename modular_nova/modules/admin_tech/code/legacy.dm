// Legacy Debug items
/obj/item/clothing/shoes/combat/debug // This was made for a reason, I'm not going to question it
	w_class = WEIGHT_CLASS_TINY // tiny ahh feet

/obj/item/gun/energy/taser/debug
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/debug)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_casing/energy/electrode/debug
	e_cost = LASER_SHOTS(1000, STANDARD_CELL_CHARGE)

// Legacy armor, but keeping it for now. Minor touchups
/obj/item/clothing/suit/armor/vest/debug
	name = "\improper subspace vest"
	desc = "A sleek piece of armour designed for Bluespace agents."
	armor_type = /datum/armor/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//Legacy Skinmode Outfit
/datum/outfit/debug/bst
	name = "Bluespace Tech"
	uniform = /obj/item/clothing/under/syndicate/combat
	belt = /obj/item/storage/belt/utility/full/powertools/debug
	shoes = /obj/item/clothing/shoes/combat/debug
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debugtools
	backpack_contents = list(
		/obj/item/melee/energy/axe = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/debug/omnitool = 1,
		/obj/item/storage/box/stabilized = 1,
		/obj/item/storage/hypospraykit/cmo/combat = 1,
		/obj/item/summon_beacon/gas_miner/expanded/debug = 1,
		/obj/item/choice_beacon/job_locker/debug = 1,
	)

