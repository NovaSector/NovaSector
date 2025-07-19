/datum/outfit/abductor_nova
	name = "Abductor Mob Basic"
	uniform = /obj/item/clothing/under/abductor
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/military/abductor

/datum/outfit/abductor_nova/combat
	name = "Abductor Mob Armored"
	suit = /obj/item/clothing/suit/armor/abductor/vest

/datum/outfit/abductor_nova/heavy
	name = "Abductor Mob Heavy"
	suit = /obj/item/clothing/suit/armor/abductor/astrum
	head = /obj/item/clothing/head/helmet/abductor
	back = /obj/item/storage/backpack

/datum/outfit/abductor_nova/boss
	name = "Abductor Boss"
	suit = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/rd
	belt = null

/obj/effect/mob_spawn/corpse/human/abductor/nova
	outfit = /datum/outfit/abductor_nova

/obj/effect/mob_spawn/corpse/human/abductor/nova/combat
	outfit = /datum/outfit/abductor_nova/combat

/obj/effect/mob_spawn/corpse/human/abductor/nova/heavy
	outfit = /datum/outfit/abductor_nova/heavy

/obj/effect/mob_spawn/corpse/human/abductor/nova/boss
	outfit = /datum/outfit/abductor_nova/boss
