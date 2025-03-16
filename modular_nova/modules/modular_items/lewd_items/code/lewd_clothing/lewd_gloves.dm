/obj/item/clothing/gloves/ball_mittens
	name = "ball mittens"
	desc = "A pair of spherical mitts; made to suppress the wearer's hands and prevent fine motor control."
	icon_state = "ball_mittens"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	greyscale_colors = "#383840"
	greyscale_config = /datum/greyscale_config/ball_mittens
	greyscale_config_worn = /datum/greyscale_config/ball_mittens/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	breakouttime = 1 SECONDS
	resist_cooldown = CLICK_CD_SLOW

/// Reinforce the breakout time on this, if that's your thing
/obj/item/clothing/gloves/ball_mittens/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(attacking_item, /obj/item/restraints/handcuffs) || !initial(breakouttime))
		return
	to_chat(user, span_notice("You reinforce the belts on [src] with [attacking_item]."))
	name = "reinforced [initial(name)]"
	clothing_flags = DANGEROUS_OBJECT
	breakouttime = 100 SECONDS
	qdel(attacking_item)
	return TRUE

/obj/item/clothing/gloves/ball_mittens/examine(mob/user)
	. = ..()
	if(breakouttime == initial(breakouttime))
		. += span_notice("You could probably reinforce it with a pair of [span_bold("handcuffs")]...")

/// Paw mittens; which vary only in looks from ball mittens
/obj/item/clothing/gloves/ball_mittens/paw_mittens
	name = "paw mittens"
	desc = "Mittens that compress the hand into a tight space, and restrict fine motor control."
	icon_state = "paw_mittens"
	greyscale_colors = "#383840#dc7ef4"
	greyscale_config = /datum/greyscale_config/paw_mittens
	greyscale_config_worn = /datum/greyscale_config/paw_mittens/worn


/// Long (Formerly Latex) Gloves
/obj/item/clothing/gloves/long_gloves
	name = "long gloves"
	desc = "Sleek gloves that go up towards the shoulder."
	icon_state = "long_gloves"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	greyscale_colors = "#383840"
	greyscale_config = /datum/greyscale_config/long_gloves
	greyscale_config_worn = /datum/greyscale_config/long_gloves/worn
	flags_1 = IS_PLAYER_COLORABLE_1
