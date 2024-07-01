//weapons
//a combat knife with a kunai sprite to encourage people to use them as throwing knives. Similar force as wespe bullets, but with embeds and bleeds.
/obj/item/knife/combat/kunai
	name = "kunai"
	desc = "A long, dual-edged utility knife that serves a dual-function as tool and as weapon. \
	Historically forged from raw iron, they are often improvised in the frontier by stealing the \
	spikes out of industrial rail lines."
	icon ='modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	icon_state = "kunai"
	lefthand_file = 'modular_np_lethal/ninja_stuff/icons/weapons_lefthand.dmi'
	righthand_file = 'modular_np_lethal/ninja_stuff/icons/weapons_righthand.dmi'
	inhand_icon_state = "kunai"
	bayonet = FALSE

//an oversized shuriken specialized for throwing like a boomerang. good block chance, but you have to throw it for good damage.
/obj/item/fuuma_shuriken
	name = "fuuma shuriken"
	desc = "An unusual weapon that descends from media and fiction rather than the practical considerations \
	of a killing tool. It has been brutally forced into compliance with reality by computer assisted design, \
	exotic materials, and the intense passion."
	icon = 'modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	lefthand_file = 'modular_np_lethal/ninja_stuff/icons/weapons_lefthand_48x.dmi'
	righthand_file = 'modular_np_lethal/ninja_stuff/icons/weapons_righthand_48x.dmi'
	icon_state = "fuuma_shuriken"
	worn_icon_state = "fuuma_shuriken_worn"
	inhand_icon_state = "fuuma_shuriken"
	inhand_x_dimension = 48
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_EDGED
	force = 15
	throwforce = 35
	armour_penetration = 30
	block_chance = 40
	throw_range = 6
	throw_speed = 2
	max_integrity = 400
	hitsound = 'sound/weapons/bladeslice.ogg'
	pickup_sound = 'sound/items/unsheath.ogg'
	drop_sound = 'sound/items/sheath.ogg'
	block_sound = 'sound/weapons/block_blade.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

/obj/item/fuuma_shuriken/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range+2, TRUE)

//ninjato but cyberpunk
/obj/item/polymer_tachi
	name = "polymer tachi"
	desc = "A 50cm blade made of laminated layers of polymer, carbon, and oriented glass strands that can be \
	readily molded to shape. The result is a strong, weatherproof weapon that maintains a sharp edge, though it \
	requires specialist tools to hone."
	icon_state = "poly_tachi"
	inhand_icon_state = "poly_tachi"
	greyscale_config = /datum/greyscale_config/poly_tachi
	greyscale_config_worn = /datum/greyscale_config/poly_tachi_worn
	greyscale_config_inhand_left = /datum/greyscale_config/poly_tachi_lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/poly_tachi_righthand
	greyscale_colors = "#eaeaea#333333#1c1c1c#b2b2b2"
	flags_1 = IS_PLAYER_COLORABLE_1
	force = 40
	throwforce = 20
	block_chance = 10
	armour_penetration = 30
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'
	pickup_sound = 'sound/items/unsheath.ogg'
	drop_sound = 'sound/items/sheath.ogg'
	block_sound = 'sound/weapons/block_blade.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE
	sharpness = SHARP_EDGED
	max_integrity = 400
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF



//misc
/obj/item/storage/belt/ninja_bandolier
	name = "tactical sling bag"
	desc = "Members of the Tsukomogami are known to modify designer sling bags to better facilitate carrying gear and small weapons. \
	Don't call it a fanny pack around the serious ones."
	icon = 'modular_np_lethal/ninja_stuff/icons/clothing_obj.dmi'
	icon_state = "tactical_bag"
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/clothing_worn.dmi'
	worn_icon_state = "tactical_bag"

/obj/item/storage/belt/ninja_bandolier/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 30
	atom_storage.numerical_stacking = TRUE
	atom_storage.max_total_storage = 60
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/throwing_star/stamina/ninja,
		/obj/item/knife/combat/kunai,
		/obj/item/food/grown/cherry_bomb,
		/obj/item/food/grown/firelemon,
		/obj/item/grenade,
		/obj/item/lighter,
		/obj/item/reagent_containers/cup/glass/bottle/molotov,
	))

/obj/item/storage/belt/ninja_bandolier/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat/kunai = 20,
		/obj/item/grenade/smokebomb = 5,
		/obj/item/grenade/mirage = 2,
		/obj/item/grenade/spawnergrenade/cat = 1,
	),src)

/obj/item/grapple_gun/lethal_ninja //we need a child type so we can make it work off lavaland without unnecessary nonmod edits
	desc = "A small specialised airgun capable of launching a climbing hook into a distant surface and pulling the user toward it via motorised zip-line."

/obj/item/grapple_gun/lethal_ninja/ranged_interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(isgroundlessturf(target))
		return NONE
	if(target == user || !hooked)
		return NONE

	if(get_dist(user, target) > 9)
		user.balloon_alert(user, "too far away!")
		return ITEM_INTERACT_BLOCKING

	var/turf/attacked_atom = get_turf(target)
	if(isnull(attacked_atom))
		return ITEM_INTERACT_BLOCKING

	var/list/turf_list = (get_line(user, attacked_atom) - get_turf(src))
	for(var/turf/singular_turf as anything in turf_list)
		if(ischasm(singular_turf))
			continue
		if(!singular_turf.is_blocked_turf())
			continue
		attacked_atom = singular_turf
		break

	if(user.CanReach(attacked_atom))
		return ITEM_INTERACT_BLOCKING

	var/atom/bullet = fire_projectile(/obj/projectile/grapple_hook, attacked_atom, 'sound/weapons/zipline_fire.ogg')
	zipline = user.Beam(bullet, icon_state = "zipline_hook", maxdistance = 9, layer = BELOW_MOB_LAYER)
	hooked = FALSE
	RegisterSignal(bullet, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(on_grapple_hit))
	RegisterSignal(bullet, COMSIG_PREQDELETED, PROC_REF(on_grapple_fail))
	zipliner = WEAKREF(user)
	update_appearance()
	return ITEM_INTERACT_SUCCESS
