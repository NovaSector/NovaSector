/obj/machinery/cell_charger/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/cell_charger/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Remove cell"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/cell_charger/click_alt(mob/user, list/modifiers)
	if(. || !charging)
		return CLICK_ACTION_BLOCKING
	to_chat(user, span_notice("You activate the quick release as the cell pops out!"))
	removecell(charging.forceMove(drop_location()))
	return CLICK_ACTION_SUCCESS

/obj/machinery/cell_charger/examine(mob/user)
	. = ..()
	. += span_notice("Alt click it to engage the ejection lever!")
