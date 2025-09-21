/mob/living/basic/trooper/nanotrasen/ranged/smg/display
	ai_controller = null

/mob/living/basic/trooper/nanotrasen/ranged/assault/dispaly
	ai_controller = null

/mob/living/basic/trooper/syndicate/melee/space/stormtrooper/display
	ai_controller = null

/mob/living/basic/trooper/syndicate/ranged/shotgun/space/stormtrooper/anthro/fox/display
	ai_controller = null

/turf/open/floor/iron/solarpanel/terrible_pun
	name = "SOLarpanel"
	desc = "Wow."

/mob/living/basic/trooper/cin_soldier/ranged/display
	ai_controller = null

/obj/structure/showcase/mecha/gygax
	name = "Gygax"
	desc = "A great replica of a gygax that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "gygax"

/obj/structure/showcase/mecha/gygax/dark_gygax
	name = "Dark gygax"
	desc = "A great replica of a syndicate gygax that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "darkgygax"

/obj/structure/showcase/mecha/durand
	name = "Durand"
	desc = "A great replica of a durand that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "durand"

/obj/structure/showcase/mecha/mauler
	name = "Mauler"
	desc = "A great replica of a Mauler that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "mauler"

/mob/living/basic/trooper/syndicate/melee/ninja //Long before time had a name, Ninjago was created by the first Spinjitzu master by using the four weapons of Spinjitzu.
	name = "Space Ninja"
	desc = "A ninja- in space."
	melee_damage_lower = 40
	melee_damage_upper = 40
	corpse = /obj/effect/mob_spawn/corpse/human/nanotrasensoldier/ninja
	mob_spawner = /obj/effect/mob_spawn/corpse/human/nanotrasensoldier/ninja
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	r_hand = /obj/item/katana/ninja_blade
	projectile_deflect_chance = 50

/mob/living/basic/trooper/syndicate/melee/ninja/display

	ai_controller = null

/datum/outfit/nanotrasensoldiercorpse/ninja
	name = "Ninja corpse"
	uniform = /obj/item/clothing/under/syndicate/ninja
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset/syndicate/alt
	mask = /obj/item/clothing/mask/gas/ninja
	back = /obj/item/mod/control/pre_equipped/ninja
	id = /obj/item/card/id/advanced/black/syndicate_command

/obj/effect/mob_spawn/corpse/human/nanotrasensoldier/ninja
	name = "Ninja corpse"
	outfit = /datum/outfit/nanotrasensoldiercorpse/ninja

/mob/living/basic/revolutionary/deranged_assistant
	name = "Deranged Assistant"
	desc = "Your average grey shirt assistant"
	loot = list(
		/obj/item/gun/ballistic/revolver/golden/boingos_blicky,
	)
