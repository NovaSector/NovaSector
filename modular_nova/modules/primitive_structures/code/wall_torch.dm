/obj/structure/wall_torch
	name = "mounted torch"
	desc = "A simple torch mounted to the wall, for lighting and such."
	icon = 'modular_nova/modules/primitive_structures/icons/lighting.dmi'
	icon_state = "walltorch"
	base_icon_state = "walltorch"
	anchored = TRUE
	density = FALSE
	light_color = LIGHT_COLOR_FIRE
	/// Torch contained by the wall torch, if it was mounted manually.
	var/obj/item/flashlight/flare/torch/torch
	/// Does it have a torch?
	var/contains_torch = TRUE
	/// is the bonfire lit?
	var/burning = FALSE
	/// Does this torch spawn pre-lit?
	var/spawns_lit = FALSE
	/// What this item turns back into when wrenched off the wall.
	var/wallmount_item_type = /obj/item/wallframe/torch_mount

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch, 28)

/obj/structure/wall_torch/Initialize(mapload)
	. = ..()
	if(contains_torch && spawns_lit)
		light_it_up()

	update_name()
	update_desc()
	update_icon_state()
	find_and_hang_on_wall()


/obj/structure/wall_torch/update_icon_state()
	icon_state = "[base_icon_state][contains_torch ? (burning ? "_on" : "") : "_mount"]"
	return ..()


/obj/structure/wall_torch/update_name(updates)
	. = ..()
	name = contains_torch ? "mounted torch" : "torch mount"


/obj/structure/wall_torch/update_desc(updates)
	. = ..()
	desc = contains_torch ? "A simple torch mounted to the wall, for lighting and such." : "A simple torch mount, torches go here."


/obj/structure/wall_torch/attackby(obj/item/used_item, mob/living/user, params)
	if(!contains_torch)
		if(!istype(used_item, /obj/item/flashlight/flare/torch))
			return ..()

		torch = used_item
		used_item.forceMove(src)
		contains_torch = TRUE
		update_name()
		update_desc()

		if(torch.light_on)
			light_it_up()
		else
			extinguish()

		torch.turn_off()

		return

	if(!burning && used_item.get_temperature())
		light_it_up()
	else
		return ..()


/obj/structure/wall_torch/fire_act(exposed_temperature, exposed_volume)
	light_it_up()


/// Sets the torch's icon to burning and sets the light up
/obj/structure/wall_torch/proc/light_it_up()
	burning = TRUE
	set_light(4)
	update_icon_state()
	update_appearance(UPDATE_ICON)


/obj/structure/wall_torch/extinguish()
	. = ..()
	if(!burning)
		return

	burning = FALSE
	set_light(0)
	update_icon_state()
	update_appearance(UPDATE_ICON)


/obj/structure/wall_torch/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	remove_torch(user)


/**
 * Helper proc that handles removing the torch and trying to put it in the user's hand.
 */
/obj/structure/wall_torch/proc/remove_torch(mob/living/user)
	if(!contains_torch)
		return

	if(!torch)
		torch = new(src)

	if(burning)
		torch.toggle_light()

	torch.attempt_pickup(user)

	torch = null
	burning = FALSE
	contains_torch = FALSE
	set_light(0)
	update_name()
	update_desc()
	update_icon_state()
	update_appearance(UPDATE_ICON)


/obj/structure/wall_torch/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	to_chat(user, span_notice("You detach [src] from its place."))

	remove_torch(user)

	new /obj/item/wallframe/torch_mount(drop_location())

	qdel(src)
	return TRUE


/obj/structure/wall_torch/mount_only
	name = "torch mount"
	contains_torch = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch/mount_only, 28)


/obj/structure/wall_torch/spawns_lit
	spawns_lit = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch/spawns_lit, 28)


/obj/item/wallframe/torch_mount
	name = "torch mount"
	desc = "Used to attach torches to walls."
	icon = 'modular_nova/modules/primitive_structures/icons/lighting.dmi'
	icon_state = "walltorch_mount"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	result_path = /obj/structure/wall_torch/mount_only
	pixel_shift = 28


/obj/item/wallframe/torch_mount/try_build(turf/on_wall, mob/user)
	if(get_dist(on_wall,user) > 1)
		balloon_alert(user, "you are too far!")
		return

	var/floor_to_wall = get_dir(user, on_wall)
	if(!(floor_to_wall in GLOB.cardinals))
		balloon_alert(user, "stand in line with wall!")
		return

	var/turf/user_turf = get_turf(user)

	if(check_wall_item(user_turf, floor_to_wall, wall_external))
		balloon_alert(user, "already something here!")
		return

	return TRUE
