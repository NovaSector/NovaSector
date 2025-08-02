/obj/structure/rack
	icon = 'modular_nova/modules/aesthetics/rack/icons/rack.dmi'

/obj/structure/rack/shelf
	name = "shelf"
	desc = "A shelf, for storing things on. Convenient!"
	icon = 'modular_nova/modules/aesthetics/rack/icons/rack.dmi'
	icon_state = "shelf"

/obj/structure/rack/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(.)
		return .

	if(isnull(held_item))
		return NONE

	// Add tooltips if the item is not a wrench (wrenches handled by parent)
	if(held_item.tool_behaviour != TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "Precise placement"
		context[SCREENTIP_CONTEXT_RMB] = "Center item"
		. = CONTEXTUAL_SCREENTIP_SET

	return . || NONE

/obj/structure/rack/base_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return .

	if((tool.item_flags & ABSTRACT) || (user.combat_mode && !(tool.item_flags & NOBLUDGEON)))
		return NONE

	// Right-click to center item unless it's a wrench (similar to table code)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(tool.tool_behaviour == TOOL_WRENCH)
			return NONE

		if(user.transfer_item_to_turf(tool, get_turf(src), silent = FALSE))
			return ITEM_INTERACT_SUCCESS

		return ITEM_INTERACT_BLOCKING

	// Left-click for pixel-perfect placement
	var/x_offset = 0
	var/y_offset = 0
	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		x_offset = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(ICON_SIZE_X * 0.5), ICON_SIZE_X * 0.5)
		y_offset = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(ICON_SIZE_Y * 0.5), ICON_SIZE_Y * 0.5)

	if(user.transfer_item_to_turf(tool, get_turf(src), x_offset, y_offset, silent = FALSE))
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_BLOCKING
