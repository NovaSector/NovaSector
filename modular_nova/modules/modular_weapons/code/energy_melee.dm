
/obj/item/melee/energy/sword/saber/covenant
	name = "elite energy sword"
	desc = "A blade like this requires great skill and bravery to use, and inspires fear in those who face its elegant energy blade."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
	icon_state = "covenant"
	inhand_icon_state = "covenant"
	base_icon_state = "covenant"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/64x_melee_left.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/64x_melee_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	alt_force_mod = 0
	light_color = LIGHT_COLOR_LIGHT_CYAN

/obj/item/melee/energy/sword/saber/covenant/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "Wort wort wort. \
		Despite having two cutting planes, this still only fights as well as a regular energy sword. \
		It's good at stabbing people, though.", \
	)
	AddComponent(/datum/component/jousting, damage_boost_per_tile = 1, knockdown_chance_per_tile = 10)

/obj/item/melee/energy/sword/saber/multitool_act(mob/living/user, obj/item/tool)
	// todo radial
	update_appearance(UPDATE_ICON_STATE)
