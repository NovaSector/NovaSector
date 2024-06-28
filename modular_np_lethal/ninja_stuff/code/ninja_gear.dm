//weapons
//a combat knife with a kunai sprite to encourage people to use them as throwing knives. Similar force as wespe bullets, but with embeds and bleeds.
/obj/item/knife/combat/kunai
	name = "kunai"
	desc = "A long, dual-edged utility knife that serves a dual-function as tool and as weapon. \
	Historically forged from raw iron, they are often improvised in the frontier by stealing the \
	spikes out of industrial rail lines."
	icon ='modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	icon_state = "kunai"
	bayonet = FALSE


//deprecated when i realized the meat hook has this covered, preserved for revisiting in the future when i think of a better mechanic for it
/*/obj/item/kusarigama
	name = "kusari-gama"
	desc = "A distant cousin of the agricultural scythe. The medieval historicity of this weapon is up for \
	dispute in scholarly circles, but any confusion over their potential as real weapons was settled by \
	Marsian enforcers quite a long time ago. This one is crafted of exotic polymers and has an integrated \
	lanyard that allows it to be thrown and retrieved by the wielder."
	icon = ''
	icon_state = ""
	inhand_icon_state = ""
	worn_icon_state = ""
	lefthand_file = ''
	righthand_file = ''
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	force = 25
	throwforce = 25
	armour_penetration = 30
	throw_range = 6
	throw_speed = 2
	hitsound = ''*/

//an oversized shuriken specialized for throwing like a boomerang. good block chance, but you have to throw it for good damage.
/obj/item/fuuma_shuriken
	name = "fuuma shuriken"
	desc = "An unusual weapon that descends from media and fiction rather than the practical considerations \
	of a killing tool, and subsequently brutally forced into compliance with reality by way of countless passionate \
	hours by the artisans of material sciences, by computer assisted design and modeling, and by a shared passion in \
	anime."
	icon ='modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	icon_state = "fuuma_shuriken"
	inhand_icon_state = ""
	worn_icon_state = ""
	lefthand_file = 'modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	righthand_file = 'modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	force = 15
	throwforce = 30
	armour_penetration = 30
	block_chance = 40
	throw_range = 6
	throw_speed = 2
	hitsound = 'sound/weapons/bladeslice.ogg'
	pickup_sound = 'sound/items/unsheath.ogg'
	drop_sound = 'sound/items/sheath.ogg'
	block_sound = 'sound/weapons/block_blade.ogg'

/obj/item/fuuma_shuriken/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range+2, TRUE)

//ninjato but cyberpunk
/obj/item/polymer_tachi
	name = "polymer tachi"
	desc = "A 50cm blade made of laminated layers of polymer, carbon, and oriented glass strands. The result \
	is a strong, weatherproof weapon that maintains a sharp edge, though it requires specialist tools to hone."
	icon = 'modular_np_lethal/ninja_stuff/icons/weapons.dmi'
	//icon_state = "poly_tachi"
	//inhand_icon_state = ""
	//worn_icon_state = ""
	//lefthand_file = ''
	//righthand_file = ''
	greyscale_config = /datum/greyscale_config/poly_tachi
	greyscale_config_worn = /datum/greyscale_config/poly_tachi_worn
	greyscale_colors = "#666633#333300"
	flags_1 = IS_PLAYER_COLORABLE_1
	force = 30
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
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	max_integrity = 400
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF



//misc
/obj/item/storage/belt/kunai_bandolier
	name = "tactical sling bag"
	desc = "Members of the Tsukomogami are known to modify designer sling bags to better facilitate carrying gear and small weapons. \
	Don't call it a fanny pack around the serious ones."
	icon =
	icon_state =
	inhand_icon_state =
	worn_icon_state =

/obj/item/storage/belt/kunai_bandolier/Initialize(mapload)
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

/obj/item/storage/belt/kunai_bandolier/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat/kunai = 20,
		/obj/item/grenade/smokebomb = 5,
		/obj/item/grenade/mirage = 2,
		/obj/item/grenade/spawnergrenade/cat = 1,
	),src)
