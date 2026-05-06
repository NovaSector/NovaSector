/mob/living/basic/pet/dog/wolf
	name = "wolf"
	desc = "A white wolf. Typically seen howling at the moon or making supernatural themed roleplaying games."
	icon = 'icons/mob/simple/icemoon/icemoon_monsters.dmi'
	icon_state = "whitewolf"
	icon_living = "whitewolf"
	icon_dead = "whitewolf_dead"
	speak_emote = list("howls")
	friendly_verb_continuous = "howls at"
	friendly_verb_simple = "howl at"
	ai_controller = /datum/ai_controller/basic_controller/dog


butcher_results = list(
		/obj/item/food/meat/slab = 2,
		/obj/item/stack/sheet/sinew/wolf = 2,
		/obj/item/stack/sheet/bone = 2
	)

	maxHealth = 130
	health = 130
	obj_damage = 15
	melee_damage_lower = 7.5
	melee_damage_upper = 7.5
	attack_vis_effect = ATTACK_EFFECT_BITE
	melee_attack_cooldown = 1.2 SECONDS

	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	death_message = "snarls its last and perishes."

	attack_sound = 'sound/items/weapons/bite.ogg'
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK
