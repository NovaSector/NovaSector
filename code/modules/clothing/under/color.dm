/obj/item/clothing/under/color
	name = "jumpsuit"
	desc = "A standard issue colored jumpsuit. Variety is the spice of life!"
	dying_key = DYE_REGISTRY_UNDER
	greyscale_colors = "#3f3f3f"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	greyscale_config = /datum/greyscale_config/jumpsuit
	greyscale_config_worn = /datum/greyscale_config/jumpsuit/worn
	greyscale_config_inhand_left = /datum/greyscale_config/jumpsuit/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/jumpsuit/inhand_right
	greyscale_config_worn_digi = /datum/greyscale_config/jumpsuit/worn/digi //NOVA EDIT ADDITION - DigiGreyscale
	inhand_icon_state = "jumpsuit"
	worn_icon_state = "jumpsuit"
	worn_icon = 'icons/mob/clothing/under/color.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/color/jumpskirt
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config_worn_digi = null //NOVA EDIT ADDITION - DigiGreyscale

/// Returns a random, acceptable jumpsuit typepath
/proc/get_random_jumpsuit()
	return pick(
		subtypesof(/obj/item/clothing/under/color) \
			- typesof(/obj/item/clothing/under/color/jumpskirt) \
			- /obj/item/clothing/under/color/random \
			- /obj/item/clothing/under/color/grey/ancient \
			- /obj/item/clothing/under/color/black/ghost \
			- /obj/item/clothing/under/rank/prisoner \
	)

/obj/item/clothing/under/color/random
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"

/obj/item/clothing/under/color/random/Initialize(mapload)
	..()
	var/obj/item/clothing/under/color/C = get_random_variant() // NOVA EDIT CHANGE - use local proc that handles prefs
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.equip_to_slot_or_del(new C(H), ITEM_SLOT_ICLOTHING, initial=TRUE) //or else you end up with naked assistants running around everywhere...
	else
		new C(loc)
	return INITIALIZE_HINT_QDEL

/// Returns a random, acceptable jumpskirt typepath
/proc/get_random_jumpskirt()
	return pick(
		subtypesof(/obj/item/clothing/under/color/jumpskirt) \
			- /obj/item/clothing/under/color/jumpskirt/random \
			- /obj/item/clothing/under/rank/prisoner/skirt \
	)

/obj/item/clothing/under/color/jumpskirt/random
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color" //Skirt variant needed
	post_init_icon_state = "jumpsuit"

/obj/item/clothing/under/color/jumpskirt/random/Initialize(mapload)
	..()
	var/obj/item/clothing/under/color/jumpskirt/C = get_random_jumpskirt()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.equip_to_slot_or_del(new C(H), ITEM_SLOT_ICLOTHING, initial=TRUE)
	else
		new C(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/clothing/under/color/black
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "black jumpsuit"
	resistance_flags = NONE

/obj/item/clothing/under/color/jumpskirt/black
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "black jumpskirt"

/obj/item/clothing/under/color/black/ghost
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	item_flags = DROPDEL

/obj/item/clothing/under/color/black/ghost/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/clothing/under/color/grey
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "grey jumpsuit"
	desc = "A tasteful grey jumpsuit that reminds you of the good old days."
	greyscale_colors = "#b3b3b3"

/obj/item/clothing/under/color/jumpskirt/grey
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "grey jumpskirt"
	desc = "A tasteful grey jumpskirt that reminds you of the good old days."
	greyscale_colors = "#b3b3b3"

/obj/item/clothing/under/color/grey/ancient
	name = "ancient jumpsuit"
	desc = "A terribly ragged and frayed grey jumpsuit. It looks like it hasn't been washed in over a decade."
	inhand_icon_state = "gy_suit"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	can_adjust = FALSE

/obj/item/clothing/under/color/blue
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "blue jumpsuit"
	greyscale_colors = "#52aecc"

/obj/item/clothing/under/color/jumpskirt/blue
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "blue jumpskirt"
	greyscale_colors = "#52aecc"

/obj/item/clothing/under/color/green
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "green jumpsuit"
	greyscale_colors = "#9ed63a"

/obj/item/clothing/under/color/jumpskirt/green
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "green jumpskirt"
	greyscale_colors = "#9ed63a"

/obj/item/clothing/under/color/orange
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "orange jumpsuit"
	desc = "Don't wear this near paranoid security officers."
	greyscale_colors = "#ff8c19"

/obj/item/clothing/under/color/jumpskirt/orange
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "orange jumpskirt"
	greyscale_colors = "#ff8c19"

/obj/item/clothing/under/color/pink
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "pink jumpsuit"
	desc = "Just looking at this makes you feel <i>fabulous</i>."
	greyscale_colors = "#ffa69b"

/obj/item/clothing/under/color/jumpskirt/pink
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "pink jumpskirt"
	greyscale_colors = "#ffa69b"

/obj/item/clothing/under/color/red
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "red jumpsuit"
	greyscale_colors = "#eb0c07"

/obj/item/clothing/under/color/jumpskirt/red
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "red jumpskirt"
	greyscale_colors = "#eb0c07"

/obj/item/clothing/under/color/white
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "white jumpsuit"
	greyscale_colors = "#ffffff"

/obj/item/clothing/under/color/jumpskirt/white
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "white jumpskirt"
	greyscale_colors = "#ffffff"

/obj/item/clothing/under/color/yellow
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "yellow jumpsuit"
	greyscale_colors = "#ffe14d"

/obj/item/clothing/under/color/jumpskirt/yellow
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "yellow jumpskirt"
	greyscale_colors = "#ffe14d"

/obj/item/clothing/under/color/darkblue
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "dark blue jumpsuit"
	greyscale_colors = "#3285ba"

/obj/item/clothing/under/color/jumpskirt/darkblue
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "dark blue jumpskirt"
	greyscale_colors = "#3285ba"

/obj/item/clothing/under/color/teal
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "teal jumpsuit"
	greyscale_colors = "#77f3b7"

/obj/item/clothing/under/color/jumpskirt/teal
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "teal jumpskirt"
	greyscale_colors = "#77f3b7"

/obj/item/clothing/under/color/lightpurple
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "light purple jumpsuit"
	greyscale_colors = "#9f70cc"

/obj/item/clothing/under/color/jumpskirt/lightpurple
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "light purple jumpskirt"
	greyscale_colors = "#9f70cc"

/obj/item/clothing/under/color/darkgreen
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "dark green jumpsuit"
	greyscale_colors = "#6fbc22"

/obj/item/clothing/under/color/jumpskirt/darkgreen
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "dark green jumpskirt"
	greyscale_colors = "#6fbc22"

/obj/item/clothing/under/color/lightbrown
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "light brown jumpsuit"
	greyscale_colors = "#c59431"

/obj/item/clothing/under/color/jumpskirt/lightbrown
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "light brown jumpskirt"
	greyscale_colors = "#c59431"

/obj/item/clothing/under/color/brown
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "brown jumpsuit"
	greyscale_colors = "#a17229"

/obj/item/clothing/under/color/jumpskirt/brown
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "brown jumpskirt"
	greyscale_colors = "#a17229"

/obj/item/clothing/under/color/maroon
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "maroon jumpsuit"
	greyscale_colors = "#cc295f"

/obj/item/clothing/under/color/jumpskirt/maroon
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	name = "maroon jumpskirt"
	greyscale_colors = "#cc295f"

/obj/item/clothing/under/color/rainbow
	name = "rainbow jumpsuit"
	desc = "A multi-colored jumpsuit!"
	inhand_icon_state = "rainbow"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	digitigrade_greyscale_colors = "#3f3f3f"
	can_adjust = FALSE
	flags_1 = NONE

/obj/item/clothing/under/color/jumpskirt/rainbow
	name = "rainbow jumpskirt"
	desc = "A multi-colored jumpskirt!"
	inhand_icon_state = "rainbow"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/color"
	post_init_icon_state = "jumpsuit"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	can_adjust = FALSE
	flags_1 = NONE
