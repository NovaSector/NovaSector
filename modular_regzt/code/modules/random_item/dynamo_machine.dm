/obj/item/manual_charger
	name = "dynamo machine"
	desc = "A rugged, hand-powered device used to charge standard power cells. It has a small slot for a cell and a heavy folding crank."
	icon = 'modular_regzt/icons/obj/item/charger.dmi'
	icon_state = "base"
	w_class = WEIGHT_CLASS_NORMAL

	var/obj/item/stock_parts/power_store/cell/inserted_cell
	var/crank_speed = 1 SECONDS
	var/crank_amount = STANDARD_CELL_CHARGE * 0.1

/obj/item/manual_charger/examine(mob/user)
	. = ..()
	if(inserted_cell)
		. += span_notice("Inside is [inserted_cell]. It's charged to [round(inserted_cell.percent())]%.")
		. += span_info("Click to start <b>cranking</b>.")
	else
		. += span_notice("It's empty. Insert a power cell to charge it.")

/obj/item/manual_charger/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stock_parts/power_store/cell))
		if(inserted_cell)
			to_chat(user, span_warning("[src] already has a cell inside!"))
			return

		if(!user.transferItemToLoc(I, src))
			return

		inserted_cell = I
		to_chat(user, span_notice("You slot [I] into [src]."))
		playsound(src, 'sound/machines/click.ogg', 20, TRUE)
		update_appearance()
		return

	return ..()

/obj/item/manual_charger/attack_hand(mob/user, list/modifiers)
	if(inserted_cell && loc == user)
		to_chat(user, span_notice("You remove [inserted_cell] from [src]."))
		user.put_in_hands(inserted_cell)
		inserted_cell = null
		update_appearance()
		return
	return ..()

/obj/item/manual_charger/attack_self(mob/user)
	if(!inserted_cell)
		to_chat(user, span_warning("There is no cell in [src] to charge!"))
		return

	if(inserted_cell.charge >= inserted_cell.maxcharge)
		to_chat(user, span_warning("[inserted_cell] is already fully charged!"))
		return

	to_chat(user, span_notice("You start cranking [src]..."))

	while(inserted_cell && inserted_cell.charge < inserted_cell.maxcharge)
		if(!do_after(user, crank_speed, target = src))
			break

		if(!inserted_cell)
			break

		inserted_cell.give(crank_amount)
		playsound(src, 'modular_nova/modules/new_cells/sound/crank.ogg', 25, FALSE)

		update_appearance()

		if(inserted_cell.charge >= inserted_cell.maxcharge)
			to_chat(user, span_nicegreen("The indicator on [src] turns green: [inserted_cell] is fully charged!"))
			break

/obj/item/manual_charger/update_overlays()
	. = ..()
	if(!inserted_cell)
		return

	. += "battery"

	var/percent = inserted_cell.percent()

	if(percent >= 75)
		. += "cell_4"
	else if(percent >= 50)
		. += "cell_3"
	else if(percent >= 25)
		. += "cell_2"
	else if(percent > 0)
		. += "cell_1"

/obj/item/manual_charger/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(AM == inserted_cell)
		inserted_cell = null
		update_appearance()

/obj/item/manual_charger/Destroy()
	inserted_cell = null
	return ..()
