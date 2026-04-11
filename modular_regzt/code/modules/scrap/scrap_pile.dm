/obj/structure/scrap_pile
	name = "scrap_pile"
	desc = "scrap_pile. Alt-click to look inside."
	icon = 'modular_nova/master_files/icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	density = TRUE
	anchored = TRUE
	max_integrity = 100

	/// Максимальный суммарный объем (w_class) предметов в куче (как maxspace у сейфа)
	var/max_space = 30
	/// Текущий занятый объем
	var/used_space = 0

/obj/structure/scrap_pile/Initialize(mapload)
	. = ..()
	icon_state = pick("pile1", "pile2", "pilechair", "piletable", "pilevending", "brtrashpile", "microwavepile", "rackpile", "boxfort", "trashbag", "brokecomp")

	// По аналогии с сейфом: собираем предметы, которые лежат на этой же клетке при спавне [cite: 5]
	for(var/obj/item/I in loc)
		if(used_space >= max_space)
			break
		if(I.w_class + used_space <= max_space)
			used_space += I.w_class
			I.forceMove(src)

// --- ВЗАИМОДЕЙСТВИЕ ---

/obj/structure/scrap_pile/click_alt(mob/user)
	ui_interact(user)
	return CLICK_ACTION_SUCCESS

/obj/structure/scrap_pile/attackby(obj/item/I, mob/user, list/modifiers)
	// Позволяем заталкивать мусор в кучу вручную [cite: 7]
	if(I.w_class + used_space <= max_space)
		if(!user.transferItemToLoc(I, src))
			return
		used_space += I.w_class
		to_chat(user, span_notice("Вы выбрасываете [I] в [src]."))
	else
		to_chat(user, span_warning("[I] не помещается в эту кучу мусора!"))

// --- ИНТЕРФЕЙС (TGUI) ---

/obj/structure/scrap_pile/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		// Используем тот же ассет "Safe", если нет своего, или создаем новый
		ui = new(user, src, "Safe", name)
		ui.open()

/obj/structure/scrap_pile/ui_data(mob/user)
	var/list/data = list()
	data["open"] = TRUE // Куча всегда "открыта" для просмотра

	var/list/contents_list = list()
	for(var/obj/item/I in contents)
		contents_list += list(list(
			"name" = I.name,
			"sprite" = I.icon_state
		))
		// Регистрируем иконку для отображения в браузере [cite: 11]
		user << browse_rsc(icon(I.icon, I.icon_state), "[I.icon_state].png")

	data["contents"] = contents_list
	return data

/obj/structure/scrap_pile/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/mob/living/user = usr
	if(!user.can_perform_action(src))
		return

	switch(action)
		if("retrieve") // Достаем предмет из кучи [cite: 13]
			var/index = text2num(params["index"])
			if(!index || index > contents.len)
				return
			var/obj/item/I = contents[index]
			if(!I || !in_range(src, user))
				return

			user.put_in_hands(I)
			used_space -= I.w_class
			return TRUE
