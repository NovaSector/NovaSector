/obj/structure/window/fulltile/colony_fabricator
	name = "prefabricated window"
	desc = "A conservatively built metal frame with a thick sheet of space-grade glass slotted into it."
	icon = 'modular_nova/modules/colony_fabricator/icons/prefab_window.dmi'
	icon_state = "prefab-0"
	base_icon_state = "prefab"
	fulltile = TRUE
	glass_type = /obj/item/stack/sheet/plastic_wall_panel
	glass_amount = 1
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5)

/obj/structure/grille/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stack/sheet/plastic_wall_panel))
		return ..()

	if(broken)
		return ITEM_INTERACT_BLOCKING
	var/obj/item/stack/stack_in_question = tool
	if(stack_in_question.get_amount() < 1)
		to_chat(user, span_warning("You need at least one plastic panel for that!"))
		return ITEM_INTERACT_BLOCKING
	var/dir_to_set = SOUTHWEST
	if(!anchored)
		to_chat(user, span_warning("[src] needs to be fastened to the floor first!"))
		return ITEM_INTERACT_BLOCKING
	for(var/obj/structure/window/window_on_turf in loc)
		to_chat(user, span_warning("There is already a window there!"))
		return ITEM_INTERACT_BLOCKING
	if(!clear_tile(user))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("You start placing the window..."))
	if(!do_after(user, 1 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING
	if(!src.loc || !anchored) //Grille broken or unanchored while waiting
		return ITEM_INTERACT_BLOCKING
	for(var/obj/structure/window/window_on_turf in loc) //Another window already installed on grille
		return ITEM_INTERACT_BLOCKING
	if(!clear_tile(user))
		return ITEM_INTERACT_BLOCKING
	var/obj/structure/window/new_window = new /obj/structure/window/fulltile/colony_fabricator(drop_location())
	new_window.setDir(dir_to_set)
	new_window.state = 0
	stack_in_question.use(1)
	to_chat(user, span_notice("You place [new_window] on [src]."))
	return ITEM_INTERACT_SUCCESS
