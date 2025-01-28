#define FAUNA_MULTIPLIER 1
#define MEGAFAUNA_MULTIPLIER 1

/obj/item/forging/reagent_weapon
	icon = 'modular_nova/modules/reagent_forging/icons/obj/forge_items.dmi'
	lefthand_file = 'modular_nova/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_nova/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	worn_icon = 'modular_nova/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	obj_flags = UNIQUE_RENAME | CONDUCTS_ELECTRICITY
	obj_flags_nova = ANVIL_REPAIR
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	toolspeed = 0.9
	throwforce = 5
	throw_speed = 3
	throw_range = 7
	var/static/list/nemesis = MOB_BEAST

/obj/item/forging/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)
	AddElement(/datum/element/bane, mob_biotypes = MOB_BEAST, damage_multiplier = FAUNA_MULTIPLIER, requires_combat_mode = FALSE)
	AddElement(/datum/element/bane, target_type = /mob/living/basic/mining/legion, damage_multiplier = FAUNA_MULTIPLIER, requires_combat_mode = FALSE)
	AddElement(/datum/element/bane, target_type = /mob/living/simple_animal/hostile/megafauna, damage_multiplier = MEGAFAUNA_MULTIPLIER, requires_combat_mode = FALSE)

/obj/item/forging/reagent_weapon/examine(mob/user)
	. = ..()
	. += span_notice("Using a hammer on [src] will repair its damage!")
	. += span_notice("This weapon seems twice as effective when used on beasts and monsters.")

/obj/item/forging/reagent_weapon/sword
	name = "forged sword"
	desc = "A sharp, one-handed sword most adept at blocking opposing melee strikes."
	force = 20
	armour_penetration = 20
	demolition_mod = 1.2
	icon_state = "sword"
	inhand_icon_state = "sword"
	worn_icon_state = "sword_back"
	inside_belt_icon_state = "sword_belt"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_chance = 20
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	max_integrity = 150

/obj/item/forging/reagent_weapon/katana
	name = "forged katana"
	desc = "A katana sharp enough to penetrate body armor, but not quite million-times-folded sharp."
	force = 20
	armour_penetration = 40
	icon_state = "katana"
	inhand_icon_state = "katana"
	worn_icon_state = "katana_back"
	inside_belt_icon_state = "katana_belt"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_chance = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED

/obj/item/forging/reagent_weapon/dagger
	name = "forged dagger"
	desc = "A lightweight dagger that seems ideal for butchering and surviving!"
	force = 13
	icon_state = "dagger"
	inhand_icon_state = "dagger"
	worn_icon_state = "dagger_back"
	inside_belt_icon_state = "dagger_belt"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	embed_type = /datum/embedding/forged_dagger
	throwforce = 17
	throw_speed = 4
	demolition_mod = 0.75
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_KNIFE

/obj/item/forging/reagent_weapon/dagger/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 8 SECONDS, \
	effectiveness = 100, \
	bonus_modifier = force + 7, \
	)

/datum/embedding/forged_dagger
	embed_chance = 50
	fall_chance = 10
	pain_mult = 4
	ignore_throwspeed_threshold = TRUE

/obj/item/forging/reagent_weapon/staff
	name = "forged staff"
	desc = "A staff most notably capable of being imbued with reagents, especially useful alongside its otherwise harmless nature."
	force = 0
	icon_state = "staff"
	inhand_icon_state = "staff"
	worn_icon_state = "staff_back"
	throwforce = 0
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")

/obj/item/forging/reagent_weapon/spear
	name = "forged spear"
	desc = "A long spear that can be wielded in two hands to boost damage at the cost of single-handed versatility."
	force = 13
	armour_penetration = 15
	demolition_mod = 0.75
	icon_state = "spear"
	inhand_icon_state = "spear"
	worn_icon_state = "spear_back"
	throwforce = 24
	throw_speed = 4
	embed_data = /datum/embedding/spear
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("attack", "poke", "jab", "tear", "lacerate", "gore")
	wound_bonus = -15
	bare_wound_bonus = 15
	reach = 2
	sharpness = SHARP_POINTY

/obj/item/forging/reagent_weapon/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 13, force_wielded = 23)

/obj/item/forging/reagent_weapon/axe
	name = "forged axe"
	desc = "An axe especially balanced for throwing. Nonetheless useful as a traditional melee tool."
	force = 15
	armour_penetration = 10
	demolition_mod = 1.2
	icon_state = "axe"
	inhand_icon_state = "axe"
	worn_icon_state = "axe_back"
	throwforce = 20
	throw_speed = 4
	embed_type = /datum/embedding/forged_axe
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("slashes", "bashes")
	attack_verb_simple = list("slash", "bash")
	sharpness = SHARP_EDGED

/datum/embedding/forged_axe
	embed_chance = 40
	fall_chance = 10
	pain_mult = 2

/obj/item/forging/reagent_weapon/hammer
	name = "forged hammer"
	desc = "A heavy, weighted hammer that packs an incredible punch but can prove to be unwieldy. Useful for forging!"
	force = 10
	armour_penetration = 10
	demolition_mod = 2
	icon_state = "crush_hammer"
	inhand_icon_state = "crush_hammer"
	worn_icon_state = "hammer_back"
	throwforce = 10
	throw_speed = 2
	throw_range = 5
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bashes", "whacks")
	attack_verb_simple = list("bash", "whack")
	tool_behaviour = TOOL_HAMMER

/obj/item/forging/reagent_weapon/hammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 25, require_twohands = TRUE)
	AddElement(/datum/element/kneejerk)

/obj/item/forging/reagent_weapon/hammer/attack(mob/living/target, mob/living/user)
	var/relative_direction = get_cardinal_dir(src, target)
	var/atom/throw_target = get_edge_target_turf(target, relative_direction)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) || !HAS_TRAIT(src, TRAIT_WIELDED))
		return
	else if(!QDELETED(target) && !target.anchored)
		var/whack_speed = (2)
		target.throw_at(throw_target, 2, whack_speed, user, gentle = TRUE)

/obj/item/shield/buckler/reagent_weapon
	name = "forged buckler shield"
	desc = "A small, round shield best used in tandem with a melee weapon in close-quarters combat."
	icon = 'modular_nova/modules/reagent_forging/icons/obj/forge_items.dmi'
	worn_icon = 'modular_nova/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	icon_state = "buckler"
	inhand_icon_state = "buckler"
	worn_icon_state = "buckler_back"
	lefthand_file = 'modular_nova/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_nova/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	custom_materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT)
	block_chance = 30
	transparent = FALSE
	max_integrity = 150
	w_class = WEIGHT_CLASS_NORMAL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	obj_flags_nova = ANVIL_REPAIR
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	shield_break_sound = 'sound/effects/bang.ogg'
	shield_break_leftover = /obj/item/forging/complete/plate

/obj/item/shield/buckler/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)
	AddElement(/datum/element/bane, mob_biotypes = MOB_BEAST, damage_multiplier = FAUNA_MULTIPLIER, requires_combat_mode = FALSE)
	AddElement(/datum/element/bane, target_type = /mob/living/basic/mining/legion, damage_multiplier = FAUNA_MULTIPLIER, requires_combat_mode = FALSE)
	AddElement(/datum/element/bane, target_type = /mob/living/simple_animal/hostile/megafauna, damage_multiplier = MEGAFAUNA_MULTIPLIER, requires_combat_mode = FALSE)

/obj/item/shield/buckler/reagent_weapon/examine(mob/user)
	. = ..()
	. += span_notice("Using a hammer on [src] will repair its damage!")
	. += span_notice("This weapon seems twice as effective when used on beasts and monsters.")

/obj/item/shield/buckler/reagent_weapon/attackby(obj/item/attacking_item, mob/user, params)
	if(atom_integrity >= max_integrity)
		return ..()
	if(istype(attacking_item, /obj/item/forging/hammer))
		var/obj/item/forging/hammer/attacking_hammer = attacking_item
		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * attacking_hammer.toolspeed
		while(atom_integrity < max_integrity)
			if(!do_after(user, skill_modifier SECONDS, src))
				return
			var/fixing_amount = min(max_integrity - atom_integrity, 5)
			atom_integrity += fixing_amount
			user.mind.adjust_experience(/datum/skill/smithing, 5)
			balloon_alert(user, "partially repaired!")
		return
	return ..()

/obj/item/shield/buckler/reagent_weapon/pavise
	name = "forged pavise shield"
	desc = "An oblong shield used by ancient crossbowmen as cover while reloading. Probably just as useful with an actual gun. Can be wielded in both hands to cover yourself and clobber others more effectively."
	icon_state = "pavise"
	inhand_icon_state = "pavise"
	worn_icon_state = "pavise_back"
	block_chance = 45
	force = 12
	item_flags = SLOWS_WHILE_IN_HAND
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	max_integrity = 300
	var/wielded = FALSE
	var/unwielded_block_chance = 45
	var/wielded_block_chance = 65

/obj/item/shield/buckler/reagent_weapon/pavise/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed,\
		force_unwielded = 12, \
		force_wielded = 15, \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/obj/item/shield/buckler/reagent_weapon/pavise/proc/on_wield()
	wielded = TRUE
	block_chance = wielded_block_chance

/obj/item/shield/buckler/reagent_weapon/pavise/proc/on_unwield()
	wielded = FALSE
	block_chance = unwielded_block_chance

/obj/item/pickaxe/reagent_weapon
	name = "forged pickaxe"
	toolspeed = 0.75

/obj/item/pickaxe/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)
	AddElement(/datum/element/bane, mob_biotypes = MOB_BEAST, damage_multiplier = FAUNA_MULTIPLIER, requires_combat_mode = FALSE)
	AddElement(/datum/element/bane, target_type = /mob/living/simple_animal/hostile/megafauna, damage_multiplier = MEGAFAUNA_MULTIPLIER, requires_combat_mode = FALSE)

/obj/item/shovel/reagent_weapon
	name = "forged shovel"
	toolspeed = 0.60

/obj/item/shovel/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)
	AddElement(/datum/element/bane, mob_biotypes = MOB_BEAST, damage_multiplier = FAUNA_MULTIPLIER, requires_combat_mode = FALSE)
	AddElement(/datum/element/bane, target_type = /mob/living/simple_animal/hostile/megafauna, damage_multiplier = MEGAFAUNA_MULTIPLIER, requires_combat_mode = FALSE)

/obj/item/ammo_casing/arrow/attackby(obj/item/attacking_item, mob/user, params)
	var/spawned_item
	if(istype(attacking_item, /obj/item/stack/sheet/sinew))
		spawned_item = /obj/item/ammo_casing/arrow/ash

	if(istype(attacking_item, /obj/item/stack/sheet/bone))
		spawned_item = /obj/item/ammo_casing/arrow/bone

	if(istype(attacking_item, /obj/item/stack/tile/bronze))
		spawned_item = /obj/item/ammo_casing/arrow/bronze

	if(!spawned_item)
		return ..()

	var/obj/item/stack/stack_item = attacking_item
	if(!stack_item.use(1))
		return

	var/obj/item/ammo_casing/arrow/converted_arrow = new spawned_item(get_turf(src))
	transfer_fingerprints_to(converted_arrow)
	remove_item_from_storage(user)
	user.put_in_hands(converted_arrow)
	qdel(src)

/obj/item/forging/reagent_weapon/bokken
	name = "bokken"
	desc = "A wooden sword that is capable of wielded in two hands. It seems to be made to prevent permanent injuries."
	force = 15
	armour_penetration = 40
	icon_state = "bokken"
	inhand_icon_state = "bokken"
	worn_icon_state = "bokken_back"
	block_chance = 20
	block_sound = 'sound/items/weapons/parry.ogg'
	damtype = STAMINA
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")
	var/wielded = FALSE
	var/unwielded_block_chance = 20
	var/wielded_block_chance = 40

/obj/item/forging/reagent_weapon/bokken/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed,\
		force_unwielded = 15, \
		force_wielded = 25, \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/obj/item/forging/reagent_weapon/bokken/proc/on_wield()
	wielded = TRUE
	block_chance = wielded_block_chance

/obj/item/forging/reagent_weapon/bokken/proc/on_unwield()
	wielded = FALSE
	block_chance = unwielded_block_chance

/obj/item/forging/reagent_weapon/bokken/attack(mob/living/carbon/target_mob, mob/living/user, params)
	. = ..()
	if(!iscarbon(target_mob))
		user.visible_message(span_warning("The [src] seems to be ineffective against the [target_mob]!"))
		playsound(src, 'sound/items/weapons/genhit.ogg', 75, TRUE)
		return
	playsound(src, pick('sound/items/weapons/genhit1.ogg', 'sound/items/weapons/genhit2.ogg', 'sound/items/weapons/genhit3.ogg'), 100, TRUE)

#undef FAUNA_MULTIPLIER
#undef MEGAFAUNA_MULTIPLIER
