/obj/item/stack/pieces_metal
	name = "pieces of metal"
	desc = "They contain a little metal and are otherwise practically useless."
	icon = 'modular_regzt/icons/obj/item/stack.dmi'
	icon_state = "pieces_metal"
	inhand_icon_state = "rods"
	singular_name = "piece of metal"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_TINY
	force = 9
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	demolition_mod = 1
	mats_per_unit = list(/datum/material/iron = 2)
	max_amount = 50
	hitsound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	embed_type = /datum/embedding/rods
	novariants = TRUE
	matter_amount = 1
	cost = 2
	merge_type = /obj/item/stack/pieces_metal
	pickup_sound = 'sound/items/handling/materials/iron_rod_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'
	sound_vary = TRUE
	usable_for_construction = FALSE

GLOBAL_LIST_INIT(pieces_metal_recipes, list(/
	new /datum/stack_recipe("iron sheet", /obj/item/stack/sheet/iron, 50, 1, 3 SECONDS, category = CAT_MISC), /
))

/datum/design/pieces_metal
	name = "pieces_metal"
	id = "pieces_metal"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2)
	build_path = /obj/item/stack/pieces_metal
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS,
	)

/obj/item/stack/pieces_glass
	name = "pieces of glass"
	desc = "They contain a little glass and are otherwise practically useless."
	icon = 'modular_regzt/icons/obj/item/stack.dmi'
	icon_state = "pieces_glass"
	inhand_icon_state = "shard-glass"
	singular_name = "piece of glass"
	w_class = WEIGHT_CLASS_TINY
	force = 8
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	demolition_mod = 1
	mats_per_unit = list(/datum/material/glass = 2)
	max_amount = 50
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	embed_type = /datum/embedding/shard
	novariants = TRUE
	matter_amount = 1
	cost = 2
	merge_type = /obj/item/stack/pieces_glass
	pickup_sound = 'sound/items/handling/materials/glass_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/glass_drop.ogg'
	sound_vary = TRUE
	usable_for_construction = FALSE

GLOBAL_LIST_INIT(pieces_glass_recipes, list(/
	new /datum/stack_recipe("glass sheet", /obj/item/stack/sheet/glass, 50, 1, 3 SECONDS, category = CAT_MISC), /
))

/datum/design/pieces_glass
	name = "pieces of glass"
	id = "pieces of glass"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 2)
	build_path = /obj/item/stack/pieces_glass
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS,
	)
