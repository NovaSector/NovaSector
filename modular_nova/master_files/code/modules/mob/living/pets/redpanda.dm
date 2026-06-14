/mob/living/basic/pet/fox/redpanda
	name = "red panda"
	desc = "Wah't a dork."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "red_panda"
	icon_living = "red_panda"
	icon_dead = "dead_panda"
	speak_emote = list("chirps", "huff-quacks")
	butcher_results = list(/obj/item/food/meat/slab = 3)
	gold_core_spawnable = FRIENDLY_SPAWN
	can_be_held = TRUE
	held_state = "fox"
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	ai_controller = /datum/ai_controller/basic_controller/fox/docile //he's a nice boy
