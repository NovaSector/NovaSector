/// Object for holding stacks of loose ammo as a handful of shells
/obj/item/ammo_box/magazine/ammo_stack
	name = "ammo stack"
	desc = "A stack of ammo."
	icon = 'modular_nova/modules/ammo_stacks/icons/ammo_stacks.dmi'
	icon_state = "stack_regular"
	base_icon_state = "ammo_stack"
	w_class = WEIGHT_CLASS_SMALL
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	multiload = FALSE
	start_empty = TRUE
	max_ammo = 12
	/// Every x position we use for casings, change based on the size of the casing being put into the stack
	var/list/casing_x_positions = list(
		-2,
		-1,
		0,
		1,
		2,
	)
	/// How much space vertically should we leave for casings in random casing y pixel shifts
	var/casing_y_padding = 3

/obj/item/ammo_box/magazine/ammo_stack/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0, shattering_sound = 'sound/weapons/gun/general/mag_bullet_remove.ogg', shatters_as_weapon = TRUE)

/obj/item/ammo_box/magazine/ammo_stack/attack_self(mob/user)
	. = ..()
	check_empty()

/obj/item/ammo_box/magazine/ammo_stack/attackby(obj/item/A, mob/user, params, silent = FALSE, replace_spent = 0)
	. = ..()
	check_empty()

/obj/item/ammo_box/magazine/ammo_stack/empty_magazine()
	. = ..()
	check_empty()

/obj/item/ammo_box/magazine/ammo_stack/Exited(atom/movable/gone, direction)
	. = ..()
	check_empty()

/// Checks the shells in the ammo stack to make sure it isn't empty, if it is, the stack is deleted
/obj/item/ammo_box/magazine/ammo_stack/proc/check_empty()
	if(!ammo_count(TRUE) && !QDELING(src))
		qdel(src)

/obj/item/ammo_box/magazine/ammo_stack/update_appearance()
	. = ..()
	cut_overlays()
	if(!ammo_count(TRUE))
		return

	icon_state = base_icon_state

	for(var/obj/item/ammo_casing/iterated_casing in stored_ammo)
		var/image/overlayed_item = image(icon = iterated_casing.icon, icon_state = iterated_casing.icon_state, pixel_x = pick(casing_x_positions), pixel_y = rand((-16 + casing_y_padding), (16 - casing_y_padding)))
		add_overlay(overlayed_item)

// Allows ammo casings to be attacked together to make a new stack
/obj/item/ammo_casing
	/// What this casing can be stacked into
	var/obj/item/ammo_box/magazine/ammo_stack_type

/obj/item/ammo_casing/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()

	if(!istype(attacking_item, /obj/item/ammo_casing))
		return

	var/obj/item/ammo_casing/ammo_casing = attacking_item
	if(!ammo_casing.ammo_stack_type)
		balloon_alert(user, "[ammo_casing] can't stack")
		return
	if(!ammo_stack_type)
		balloon_alert(user, "[src] can't stack")
		return
	if(caliber != ammo_casing.caliber)
		balloon_alert(user, "can't stack different calibers")
		return
	if(ammo_stack_type != ammo_casing.ammo_stack_type)
		balloon_alert(user, "can't stack [src] with [ammo_casing]")
		return
	if(!loaded_projectile || !ammo_casing.loaded_projectile)
		balloon_alert(user, "can't stack empty casings")
		return

	var/obj/item/ammo_box/magazine/ammo_stack = new ammo_stack_type(drop_location())
	user.transferItemToLoc(src, ammo_stack, silent = TRUE)
	ammo_stack.give_round(src)
	user.transferItemToLoc(ammo_casing, ammo_stack, silent = TRUE)
	ammo_stack.give_round(ammo_casing)
	user.put_in_hands(ammo_stack)
	ammo_stack.update_appearance()
