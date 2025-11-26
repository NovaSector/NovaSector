/// Object for holding stacks of loose ammo as a handful of shells
/obj/item/ammo_box/magazine/ammo_stack
	name = "ammo stack"
	desc = "A stack of ammo."
	icon = 'modular_nova/modules/ammo_stacks/icons/ammo_stacks.dmi'
	icon_state = "stack_regular"
	base_icon_state = "ammo_stack"
	appearance_flags = parent_type::appearance_flags | KEEP_TOGETHER
	w_class = WEIGHT_CLASS_SMALL
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	ammo_box_multiload = AMMO_BOX_MULTILOAD_NONE
	start_empty = TRUE
	max_ammo = 12
	/// Spacing between random w offsets of casings. Change based on the size of the casing being put into the stack.
	var/casing_w_spacing = 1
	/// How much space vertically should we leave for casings in random casing z pixel shifts.
	var/casing_z_padding = 3

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

/obj/item/ammo_box/magazine/ammo_stack/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(.) // They caught all the bullets. Powerful.
		return
	scatter(hit_atom, 48)

/obj/item/ammo_box/magazine/ammo_stack/onZImpact(turf/impacted_turf, levels, impact_flags)
	. = ..()
	scatter(impacted_turf, 48)

/obj/item/ammo_box/magazine/ammo_stack/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	scatter(target, 48)

/// Checks the shells in the ammo stack to make sure it isn't empty, if it is, the stack is deleted
/obj/item/ammo_box/magazine/ammo_stack/proc/check_empty()
	if(!ammo_count(TRUE) && !QDELETED(src))
		spawn(0) // We are doing this to yield execution to the rest of the call chain to avoid a race condition. Hacky but avoids nonmodular messes.
			qdel(src)

/// Iterates through every casing in this ammo stack, scattering it and moving it out of the ammo stack, in the event this was thrown.
/obj/item/ammo_box/magazine/ammo_stack/proc/scatter(atom/hit_atom, pixel_distance = 48)
	var/turf/scatter_turf = get_turf(hit_atom)
	if(!hit_atom.CanPass(src, get_dir(src, hit_atom))) //Object is too dense to fall apart on
		scatter_turf = get_turf(src)

	var/generator/scatter_gen = generator(GEN_CIRCLE, 0, pixel_distance, NORMAL_RAND)
	for(var/obj/item/ammo_casing/scattered_casing as anything in ammo_list())
		scattered_casing.forceMove(scatter_turf)
		var/list/scatter_vector = scatter_gen.Rand()
		scatter_individual_casing(scattered_casing, scatter_vector[1], scatter_vector[2])

	playsound(scatter_turf, 'sound/items/weapons/gun/general/mag_bullet_remove.ogg', 60, TRUE)
	check_empty()

/// Scatters an individual casing, bouncing and pixel-moving it about.
/obj/item/ammo_box/magazine/ammo_stack/proc/scatter_individual_casing(obj/item/ammo_casing/scattered_casing, pixel_x_offset = 0, pixel_y_offset = 0)
	if(prob(50)) // Randomize order, avoid bias to one axis if stepping is blocked
		pixelmove_casing(scattered_casing, pixel_y_offset, x_axis = FALSE)
		pixelmove_casing(scattered_casing, pixel_x_offset, x_axis = TRUE)
	else
		pixelmove_casing(scattered_casing, pixel_x_offset, x_axis = TRUE)
		pixelmove_casing(scattered_casing, pixel_y_offset, x_axis = FALSE)
	scattered_casing.bounce_away(FALSE, rand(0, 3))

/// Pixel-moves a casing around based on offsets, in tandem with casing scattering when this ammo stack is thrown.
/obj/item/ammo_box/magazine/ammo_stack/proc/pixelmove_casing(obj/item/ammo_casing/scattered_casing, pixel_offset = 0, x_axis = TRUE)
	var/positive_dir = x_axis ? EAST : NORTH
	var/negative_dir = x_axis ? WEST : SOUTH
	var/per_step = x_axis ? ICON_SIZE_X : ICON_SIZE_Y
	var/half_step = per_step / 2

	if(abs(pixel_offset) > half_step)
		var/positive_offset = (pixel_offset > 0)
		var/offset_correction = positive_offset ? -half_step : half_step
		var/step_dir = positive_offset ? positive_dir : negative_dir
		for(var/i in 1 to floor(abs(pixel_offset) + half_step) / per_step)
			step(scattered_casing, step_dir)
		pixel_offset = (pixel_offset % half_step) + offset_correction

	if(x_axis)
		scattered_casing.pixel_x = pixel_offset
	else
		scattered_casing.pixel_y = pixel_offset

/obj/item/ammo_box/magazine/ammo_stack/update_appearance()
	. = ..()
	if(!ammo_count())
		return
	icon_state = base_icon_state

/obj/item/ammo_box/magazine/ammo_stack/update_overlays()
	. = ..()
	if(!ammo_count())
		return

	for(var/obj/item/ammo_casing/iterated_casing as anything in stored_ammo)
		var/mutable_appearance/overlayed_casing = mutable_appearance(icon = iterated_casing.icon, icon_state = "[initial(iterated_casing.icon_state)]-live")
		overlayed_casing.pixel_w = rand(-2, 2) * casing_w_spacing
		var/z_offset_range = 16 - casing_z_padding
		overlayed_casing.pixel_z = rand(-z_offset_range, z_offset_range)
		. += overlayed_casing

// Allows ammo casings to be attacked together to make a new stack
/obj/item/ammo_casing
	/// What this casing can be stacked into
	var/obj/item/ammo_box/magazine/ammo_stack_type

/obj/item/ammo_casing/examine(mob/user)
	. = ..()
	if(ammo_stack_type)
		. += span_notice("[src] can be stacked with other casings of a similar type.")
	return .

/obj/item/ammo_casing/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/ammo_casing))
		return NONE

	var/obj/item/ammo_casing/used_casing = tool
	if(!used_casing.ammo_stack_type)
		balloon_alert(user, "used casing can't stack")
		return ITEM_INTERACT_BLOCKING
	if(!ammo_stack_type)
		balloon_alert(user, "target can't stack!")
		return ITEM_INTERACT_BLOCKING
	if(ammo_stack_type != used_casing.ammo_stack_type)
		balloon_alert(user, "can't stack together!")
		return ITEM_INTERACT_BLOCKING
	if(!loaded_projectile || !used_casing.loaded_projectile)
		balloon_alert(user, "can't stack empty casings!")
		return ITEM_INTERACT_BLOCKING

	var/obj/item/ammo_box/magazine/ammo_stack = new ammo_stack_type(drop_location())
	ammo_stack.give_round(src)
	ammo_stack.give_round(used_casing)
	user.put_in_hands(ammo_stack)
	ammo_stack.update_appearance()
