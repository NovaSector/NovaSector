/obj/item/implantpad//NOVA EDIT - ICON OVERRIDEN BY AESTHETICS - SEE MODULE
	name = "implant pad"
	desc = "Used to modify implants."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "implantpad-0"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/implantcase/case = null

/obj/item/implantpad/update_icon_state()
	icon_state = "implantpad-[!QDELETED(case)]"
	return ..()

/obj/item/implantpad/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		. += "It [case ? "contains \a [case]" : "is currently empty"]."
		if(case)
			. += span_info("Alt-click to remove [case].")
	else
		if(case)
			. += span_warning("There seems to be something inside it, but you can't quite tell what from here...")

/obj/item/implantpad/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == case)
		case = null
		update_appearance()
		updateSelfDialog()

/obj/item/implantpad/AltClick(mob/user)
	..()
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(!case)
		to_chat(user, span_warning("There's no implant to remove from [src]."))
		return

	user.put_in_hands(case)

	add_fingerprint(user)
	case.add_fingerprint(user)

	updateSelfDialog()
	update_appearance()

/obj/item/implantpad/attackby(obj/item/implantcase/C, mob/user, params)
	if(istype(C, /obj/item/implantcase) && !case)
		if(!user.transferItemToLoc(C, src))
			return
		case = C
		updateSelfDialog()
		update_appearance()
	else
		return ..()

/obj/item/implantpad/ui_interact(mob/user)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		user.unset_machine(src)
		user << browse(null, "window=implantpad")
		return

	user.set_machine(src)
	var/dat = "<B>Implant Mini-Computer:</B><HR>"
	if(case)
		if(case.imp)
			if(istype(case.imp, /obj/item/implant))
				dat += case.imp.get_data()
		else
			dat += "The implant casing is empty."
	else
		dat += "Please insert an implant casing!"
	user << browse(dat, "window=implantpad")
	onclose(user, "implantpad")
