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

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch, 28)

/obj/structure/wall_torch/Initialize(mapload)
	. = ..()
	if(spawns_lit)
		light_it_up()
	find_and_hang_on_wall()


/obj/structure/wall_torch/update_icon_state()
	icon_state = "[base_icon_state][contains_torch ? (burning ? "_on" : "") : "_mount"]"
	return ..()


/obj/structure/wall_torch/attackby(obj/item/used_item, mob/living/user, params)
	if(!contains_torch)
		if(!istype(used_item, /obj/item/flashlight/flare/torch))
			return ..()

		torch = used_item
		contains_torch = TRUE

		if(torch.light_on)
			light_it_up()
		else
			extinguish()

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
	else
		torch.extinguish()

	torch.attempt_pickup(user)

	torch = null
	burning = FALSE
	contains_torch = FALSE
	set_light(0)
	update_icon_state()
	update_appearance(UPDATE_ICON)


/obj/structure/wall_torch/spawns_lit
	spawns_lit = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/wall_torch/spawns_lit, 28)
