/obj/structure/scrap
	name = "scrap pile"
	desc = "Pile of industrial debris. It could use a shovel and pair of hands in gloves."
	icon = 'modular_nova/master_files/icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	appearance_flags = TILE_BOUND
	anchored = TRUE
	density = TRUE
	var/loot_generated = FALSE
	var/loot_min = 3
	var/loot_max = 5
	var/list/weighted_loot_list = NONE

/obj/structure/scrap/Initialize(mapload)
	. = ..()
	icon_state = pick("pile1", "pile2", "pilechair", "piletable", "pilevending", "brtrashpile", "microwavepile", "rackpile", "boxfort", "trashbag", "brokecomp")

	// Инициализируем хранилище через встроенную систему [cite: 1]
	create_storage(loot_max, WEIGHT_CLASS_BULKY)

	if(atom_storage)
		// Отключаем автоматический обработчик Alt-Click хранилища, чтобы он не конфликтовал с нашей логикой
		atom_storage.click_alt_open = FALSE
		// Запрещаем игрокам вкладывать любые предметы (белый список пуст, черный список - все предметы) [cite: 11, 46, 48]
		atom_storage.set_holdable(list(), list(/obj/item))

	if(weighted_loot_list)
		try_make_loot()

// Исправленное открытие интерфейса через Alt-Click
/obj/structure/scrap/click_alt(mob/user)
	if(atom_storage && user.can_perform_action(src, ALLOW_SILICON_REACH))
		// Используем точное название прока из твоего файла для открытия UI
		atom_storage.open_storage(user)
		return CLICK_ACTION_SUCCESS
	return CLICK_ACTION_BLOCKING

// Основное взаимодействие
/obj/structure/scrap/attackby(obj/item/I, mob/user, params)
	// Если используем лопату
	if(I.tool_behaviour == TOOL_SHOVEL)
		// Если в куче пусто — удаляем объект
		if(!contents.len)
			user.visible_message(span_notice("[user] begins to clear away the empty [src]."), \
				span_notice("You begin to clear away the empty [src]..."))
			if(I.use_tool(src, user, 2 SECONDS))
				qdel(src)
			return ITEM_INTERACT_SUCCESS

		// Если есть вещи — выкапываем их по одной
		user.visible_message(span_notice("[user] begins to dig through \the [src] with \the [I]."), \
			span_notice("You begin to dig through \the [src]..."))

		if(I.use_tool(src, user, rand(15, 25)))
			do_search(user, TRUE)
		return ITEM_INTERACT_SUCCESS

	return ..()

// ПКМ лопатой для быстрого удаления всей кучи сразу
/obj/structure/scrap/attackby_secondary(obj/item/I, mob/user, list/modifiers)
	if(I.tool_behaviour != TOOL_SHOVEL)
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	user.visible_message(span_notice("[user] begins to clear away \the [src] with \the [I]."), \
		span_notice("You begin to clear away \the [src]..."))

	if(I.use_tool(src, user, 4 SECONDS, volume=50))
		to_chat(user, span_notice("You successfully clear away the debris."))
		qdel(src)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

// Поиск руками
/obj/structure/scrap/attack_hand(mob/user)
	if(!ishuman(user))
		return ..()

	if(!contents.len)
		balloon_alert(user, "it's empty!")
		return

	user.visible_message("[user] starts rummaging through \the [src].", "You start searching through \the [src]...")

	if(do_after(user, rand(40, 60), target = src))
		do_search(user, FALSE)

// Прок поиска (выдает предметы из инвентаря кучи)
/obj/structure/scrap/proc/do_search(mob/user, using_shovel = FALSE)
	if(contents.len)
		var/obj/item/hidden_item = pick(contents)
		if(hidden_item)
			if(using_shovel)
				hidden_item.forceMove(src.loc)
				balloon_alert(user, "dug out [hidden_item.name]!")
			else
				balloon_alert(user, "found [hidden_item.name]!")
				if(!user.put_in_hands(hidden_item))
					hidden_item.forceMove(src.loc)

			if(!contents.len)
				to_chat(user, "The [src.name] is now empty.")
	else
		balloon_alert(user, "nothing here!")

// Генерация лута при создании
/obj/structure/scrap/proc/try_make_loot()
	if(loot_generated)
		return
	loot_generated = TRUE

	var/amt = rand(loot_min, loot_max)
	for(var/i in 1 to amt)
		var/loot_path = get_loot_path()
		if(loot_path)
			create_loot_item(loot_path)

/obj/structure/scrap/proc/get_loot_path()
	var/lootspawn = pick_weight(weighted_loot_list)
	while(islist(lootspawn))
		lootspawn = pick_weight(lootspawn)
	return lootspawn

// Создание предмета напрямую внутри инвентаря кучи
/obj/structure/scrap/proc/create_loot_item(loot_path)
	if(!ispath(loot_path))
		return

	if(ispath(loot_path, /obj/effect/spawner))
		var/obj/item/storage/box/temp_box = new(null)
		var/obj/effect/spawner/S = new loot_path(temp_box)
		if(S && !QDELETED(S))
			qdel(S)
		// Переносим всё из спавнера в кучу [cite: 59]
		for(var/obj/item/spawned in temp_box.contents)
			spawned.forceMove(src)
			if(istype(spawned, /obj/item/stack))
				var/obj/item/stack/ST = spawned
				ST.amount = amount_in_stack(ST.type)
		qdel(temp_box)
	else
		var/obj/item/I
		if(ispath(loot_path, /obj/item/stack))
			var/stack_amount = amount_in_stack(loot_path)
			I = new loot_path(src, stack_amount)
		else
			I = new loot_path(src)
		if(!I)
			return

/obj/structure/scrap/proc/amount_in_stack(path)
	if(ispath(path, /obj/item/stack/rods)) return rand(1, 3)
	if(ispath(path, /obj/item/stack/sheet/plastic)) return rand(1, 5)
	if(ispath(path, /obj/item/stack/sheet/iron)) return rand(1, 4)
	if(ispath(path, /obj/item/stack/sheet/glass)) return rand(1, 3)
	if(ispath(path, /obj/item/stack/sheet/plasteel)) return rand(0, 1)
	if(ispath(path, /obj/item/stack/sheet/mineral/wood)) return rand(1, 5)
	return rand(1, 3)

// --- Типы кучек ---

/obj/structure/scrap/material
	name = "material pile"
	desc = "just a pile of material scrap"
	loot_min = 2
	loot_max = 3

/obj/structure/scrap/material/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_material
	return ..()

/obj/structure/scrap/maintenance
	name = "maintenance pile"
	desc = "just a pile of maintenance scrap"

/obj/structure/scrap/maintenance/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_maintenance
	return ..()

/obj/structure/scrap/trash
	name = "trash pile"
	desc = "A pile of smelly trash."
	loot_min = 3
	loot_max = 6

/obj/structure/scrap/trash/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_trash
	return ..()

/obj/structure/scrap/medical
	name = "medical refuse pile"
	desc = "Pile of medical refuse. They sure don't cut expenses on these"

/obj/structure/scrap/medical/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_medical
	return ..()

/obj/structure/scrap/food
	name = "food trash pile"
	desc = "Pile of thrown away food. Someone sure have lots of spare food while children on Mars are starving"

/obj/structure/scrap/food/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_food
	return ..()

/obj/structure/scrap/science
	name = "science scrap"
	desc = "just a pile of maintenance scrap"
	loot_min = 0
	loot_max = 2

/obj/structure/scrap/science/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_science
	return ..()

/obj/structure/scrap/cloth
	name = "cloth pile"
	desc = "Pile of second hand clothing for charity"

/obj/structure/scrap/cloth/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_cloth
	return ..()

/obj/structure/scrap/poor
	name = "mixed rubbish"
	desc = "Pile of mixed rubbish. Useless and rotten, mostly"
	loot_min = 2
	loot_max = 4

/obj/structure/scrap/poor/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_poor
	return ..()

/obj/structure/scrap/industrial
	name = "industrial scrap"
	desc = "Pile of mixed rubbish. Useless and rotten, mostly"

/obj/structure/scrap/industrial/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_industrial
	return ..()
