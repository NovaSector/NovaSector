/obj/structure/scrap_pile
	name = "scrap pile"
	desc = "A pile of scrap. Dig through it to find something useful."
	icon = 'modular_nova/master_files/icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	density = TRUE
	anchored = TRUE
	max_integrity = 100
	appearance_flags = TILE_BOUND

	var/storage_capacity = 20
	var/max_item_size = WEIGHT_CLASS_BULKY
	var/loot_generated = FALSE
	var/loot_min = 3
	var/loot_max = 5
	var/list/weighted_loot_list = NONE
	var/list/stored_loot = list()

/obj/structure/scrap_pile/Initialize(mapload)
	..()
	icon_state = pick("pile1", "pile2", "pilechair", "piletable", "pilevending", "brtrashpile", "microwavepile", "rackpile", "boxfort", "trashbag", "brokecomp")

	create_storage(storage_capacity, max_item_size)
	if(atom_storage)
		atom_storage.click_alt_open = TRUE
		atom_storage.set_holdable(list(/obj/item))

	if(weighted_loot_list)
		try_make_loot()

/obj/structure/scrap_pile/Destroy()
	stored_loot.Cut()
	return ..()

/// Определяет размер пачки для найденных материалов
/obj/structure/scrap_pile/proc/amount_in_stack(path)
	if(ispath(path, /obj/item/stack/rods))
		return rand(1, 3)
	if(ispath(path, /obj/item/stack/sheet/plastic))
		return rand(1, 5)
	if(ispath(path, /obj/item/stack/sheet/iron))
		return rand(1, 4)
	if(ispath(path, /obj/item/stack/sheet/glass))
		return rand(1, 3)
	if(ispath(path, /obj/item/stack/sheet/plasteel))
		return rand(1, 2)
	if(ispath(path, /obj/item/stack/sheet/mineral/wood))
		return rand(1, 5)
	return rand(1, 3)

/obj/structure/scrap_pile/shovel_act(mob/living/user, obj/item/I)
	user.visible_message(span_notice("[user] begins to dig through \the [src]."), \
		span_notice("You begin to dig through \the [src]..."))

	if(I.use_tool(src, user, rand(15, 25)))
		do_search(user)
	return ITEM_INTERACT_SUCCESS

/obj/structure/scrap_pile/shovel_act_secondary(mob/living/user, obj/item/tool)
	user.visible_message(span_notice("[user] begins to clear away \the [src]."), \
		span_notice("You begin to clear away the debris..."))

	if(tool.use_tool(src, user, 4 SECONDS))
		to_chat(user, span_notice("You successfully clear away the [src]."))
		qdel(src)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/scrap_pile/attackby(obj/item/I, mob/user)
	if(atom_storage && atom_storage.attempt_insert(I, user))
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/structure/scrap_pile/attack_hand(mob/user)
	if(!ishuman(user))
		return ..()

	if(!stored_loot.len)
		balloon_alert(user, "it's empty!")
		return

	user.visible_message(span_notice("[user] starts rummaging through \the [src]."), \
		span_notice("You start searching through \the [src]..."))

	if(do_after(user, rand(40, 60), target = src))
		do_search(user)

/obj/structure/scrap_pile/proc/try_make_loot()
	if(loot_generated)
		return
	loot_generated = TRUE

	var/amt = rand(loot_min, loot_max)
	for(var/i in 1 to amt)
		var/loot_path = get_loot_path()
		if(!loot_path)
			continue
		stored_loot += loot_path

/obj/structure/scrap_pile/proc/get_loot_path()
	var/lootspawn = pick_weight(weighted_loot_list)
	while(islist(lootspawn))
		lootspawn = pick_weight(lootspawn)
	return lootspawn

/obj/structure/scrap_pile/proc/do_search(mob/user)
	if(!stored_loot.len)
		balloon_alert(user, "nothing left inside!")
		return

	if(prob(50))
		var/loot_path = pick(stored_loot)
		stored_loot -= loot_path

		var/obj/item/found

		if(ispath(loot_path, /obj/effect/spawner))
			var/obj/item/storage/box/temp_box = new(null)
			var/obj/effect/spawner/S = new loot_path(temp_box)
			if(S && !QDELETED(S))
				qdel(S)

			if(temp_box.contents.len)
				found = pick(temp_box.contents)
				found.forceMove(src)
			qdel(temp_box)
		else
			if(ispath(loot_path, /obj/item/stack))
				var/stack_amount = amount_in_stack(loot_path)
				if(stack_amount <= 0)
					balloon_alert(user, "found only dust...")
					return
				found = new loot_path(src, stack_amount)
			else
				found = new loot_path(src)

		if(found)
			balloon_alert(user, "found [found.name]!")
			if(atom_storage)
				atom_storage.open_storage(user)
	else
		balloon_alert(user, "nothing found...")

// --- КУЧИ ---

/obj/structure/scrap_pile/material
	name = "material pile"
	desc = "just a pile of material scrap"
	loot_min = 2
	loot_max = 3

/obj/structure/scrap_pile/material/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_material
	return ..()

/obj/structure/scrap_pile/maintenance
	name = "maintenance pile"
	desc = "just a pile of maintenance scrap"

/obj/structure/scrap_pile/maintenance/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_maintenance
	return ..()

/obj/structure/scrap_pile/trash
	name = "trash pile"
	desc = "A pile of smelly trash."
	loot_min = 3
	loot_max = 6

/obj/structure/scrap_pile/trash/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_trash
	return ..()

/obj/structure/scrap_pile/medical
	name = "medical refuse pile"
	desc = "Pile of medical refuse. They sure don't cut expenses on these"

/obj/structure/scrap_pile/medical/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_medical
	return ..()

/obj/structure/scrap_pile/food
	name = "food trash pile"
	desc = "Pile of thrown away food."

/obj/structure/scrap_pile/food/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_food
	return ..()

/obj/structure/scrap_pile/science
	name = "science scrap"
	desc = "just a pile of maintenance scrap"
	loot_min = 2
	loot_max = 4

/obj/structure/scrap_pile/science/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_science
	return ..()

/obj/structure/scrap_pile/cloth
	name = "cloth pile"
	desc = "Pile of second hand clothing for charity"

/obj/structure/scrap_pile/cloth/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_cloth
	return ..()

/obj/structure/scrap_pile/poor
	name = "mixed rubbish"
	desc = "Pile of mixed rubbish. Useless and rotten, mostly"
	loot_min = 2
	loot_max = 4

/obj/structure/scrap_pile/poor/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_poor
	return ..()

/obj/structure/scrap_pile/industrial
	name = "industrial scrap"
	desc = "Industrial debris and waste."

/obj/structure/scrap_pile/industrial/Initialize(mapload)
	weighted_loot_list = GLOB.scrap_industrial
	return ..()
