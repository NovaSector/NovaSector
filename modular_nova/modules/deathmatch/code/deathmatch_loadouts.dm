/// In order to turn it into a proper Quake-like shooter, we gotta remove effectively everything related to /tg/ combat.
#define ARENA_TRAITS list(TRAIT_NOHUNGER, \
TRAIT_NOBLOOD, \
TRAIT_NEVER_WOUNDED, \
TRAIT_SHOVE_KNOCKDOWN_BLOCKED, \
TRAIT_NO_STAGGER, \
TRAIT_NO_SLIP_ALL, \
TRAIT_NOSOFTCRIT, \
TRAIT_NOFLASH, \
TRAIT_IGNOREDAMAGESLOWDOWN, \
)

/datum/outfit/deathmatch_loadout/boomer_arena/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	user.add_traits(ARENA_TRAITS, INNATE_TRAIT)
	user.set_species(/datum/species/human)
	user.underwear = "Hearts Boxers"
	user.undershirt = "Nude"
	user.socks = "Nude"
	user.bra = "Nude"

/datum/outfit/deathmatch_loadout/boomer_arena/doomed_dave
	name = "Deathmatch: Doomed Dave"
	display_name = "Doomed Dave"
	desc = "Slow speed, high armor. Armed with a pump shotgun."

	uniform = /obj/item/clothing/under/pants/slacks
	suit = /obj/item/clothing/suit/hooded/hostile_environment/boomer_shooter
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/combat
	l_hand = /obj/item/gun/ballistic/shotgun/lethal
	r_pocket = /obj/item/knife/combat
	back = /obj/item/storage/backpack/satchel

/datum/outfit/deathmatch_loadout/boomer_arena/solemn_steve
	name = "Deathmatch: Solemn Steve"
	display_name = "Solemn Steve"
	desc = "High speed, no armor, ability to hop around. Armed with a tommy gun."

	glasses = /obj/item/clothing/glasses/orange
	uniform = /obj/item/clothing/under/pants/jeans
	gloves = /obj/item/clothing/gloves/tackler/offbrand
	shoes = /obj/item/clothing/shoes/bhop/boomer_shooter
	l_hand = /obj/item/gun/ballistic/automatic/tommygun
	r_pocket = /obj/item/knife/combat
	back = /obj/item/storage/backpack/satchel

/datum/outfit/deathmatch_loadout/boomer_arena/solemn_steve/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	. = ..()
	user.undershirt = "Shirt (White)"

/datum/outfit/deathmatch_loadout/boomer_arena/atomic_abe
	name = "Deathmatch: Atomic Abe"
	display_name = "Atomic Abe"
	desc = "Average speed, low armor, ability to go atomic. Armed with massive fists; can't use guns."

	glasses = /obj/item/clothing/glasses/sunglasses/big/boomer_shooter
	uniform = /obj/item/clothing/under/pants/jeans
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/jacket
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/swagshoes
	r_pocket = /obj/item/knife/combat
	belt = /obj/item/storage/belt/mining/alt
	back = /obj/item/storage/backpack/satchel

/datum/outfit/deathmatch_loadout/boomer_arena/atomic_abe/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	. = ..()
	user.undershirt = "Tank Top (Red)"
	for(var/obj/item/bodypart/arm/puncher as anything in user.bodyparts)
		if(istype(puncher, /obj/item/bodypart/arm))
			var/obj/item/bodypart/arm/bigger_fist = puncher
			bigger_fist.unarmed_damage_low = initial(bigger_fist.unarmed_damage_low) + 10
			bigger_fist.unarmed_damage_high = initial(bigger_fist.unarmed_damage_high) + 10
	user.add_traits(list(TRAIT_NOGUNS), INNATE_TRAIT)
