
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
		lore = "The Pattern III/C \"Covenant\" charged plasma blade, colloquially known as the \"elite\" energy sword, is a variant of the \
			energy sword infamously used by Syndicate operatives, noteworthy for its unusual twin-bladed design.<br>\
			<br>\
			A very large deviation from conventional energy-based melee weapon designs, designed less for concealment and more for visual distinction, \
			the Pattern III/C \"Covenant\" has a horizontally-oriented hilt with two blade emitters and a central protrusion that provides an orientation \
			point for the fingers wrapping around the hilt. \
			Despite the twin energy blades, the forward-protruding orientation of both blades means that it does not provide the protective qualities \
			of the infamous dual-bladed energy sword, but also means that it does not require both hands to be wielded. Users are advised that it \
			performs more like a standard energy sword, albeit slightly better for impaling people than its single-bladed sibling. \
			A multitool can be used to recalibrate the blade modulator to adjust the color of the energy blade, which does not affect performance.", \
	)

/obj/item/melee/energy/sword/saber/covenant/multitool_act(mob/living/user, obj/item/tool)
	var/list/color_menu = list(
		"Blue" = image(icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi', icon_state = "covenant_on_blue"),
		"Green" = image(icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi', icon_state = "covenant_on_green"),
		"Red" = image(icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi', icon_state = "covenant_on_red"),
		"Purple" = image(icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi', icon_state = "covenant_on_purple"),
	)
	var/pick_result = show_radial_menu(user, src, color_menu, require_near = TRUE, tooltips = TRUE)
	if(!pick_result || !user.can_perform_action(src))
		return ITEM_INTERACT_BLOCKING
	sword_color_icon = LOWER_TEXT(pick_result)
	set_light_color(possible_sword_colors[sword_color_icon])
	to_chat(user, span_info("You modify [src]'s blade modulator to be [sword_color_icon]."))
	update_appearance(UPDATE_ICON_STATE)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/energy/sword/saber/covenant/red
	sword_color_icon = "red"

/obj/item/melee/energy/sword/saber/covenant/blue
	sword_color_icon = "blue"

/obj/item/melee/energy/sword/saber/covenant/green
	sword_color_icon = "green"

/obj/item/melee/energy/sword/saber/covenant/purple
	sword_color_icon = "purple"
