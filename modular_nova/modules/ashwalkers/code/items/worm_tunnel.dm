GLOBAL_LIST_EMPTY(ashwalker_tunnels)

/obj/item/tunneling_worm
	name = "ashen tunneling worm"
	desc = "A purple glow seems to radiate from the worm. It slowly gnashes at the ground."

	/// the amount of uses left
	var/tunnels_remaining = 2

	/// how long it takes to create a tunnel
	var/tunnel_creation = 10 SECONDS

/obj/item/tunneling_worm/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /turf/open/misc/asteroid/basalt/lava_land_surface)) //eventually we could spread this to more than just lavaland?
		var/turf/interacting_turf = interacting_with
		if(locate(/obj/structure/worm_tunnel) in interacting_turf)
			to_chat(user, span_warning("There is already a tunnel here!"))
			return ITEM_INTERACT_BLOCKING

		var/tunnel_name = tgui_input_text(user, "What would you like to name the tunnel?", "Tunnel Naming (20 Character Max)", max_length = 20)
		if(isnull(tunnel_name))
			to_chat(user, span_warning("You have decided against creating a tunnel!"))
			return ITEM_INTERACT_BLOCKING

		//if we have the primitive skill, perhaps add some functionality to this
		if(!do_after(user, tunnel_creation, target = interacting_turf))
			to_chat(user, span_warning("You have decided against creating a tunnel!"))
			return ITEM_INTERACT_BLOCKING

		var/obj/structure/worm_tunnel/created_tunnel
		created_tunnel = new created_tunnel()
		created_tunnel.name = tunnel_name
		GLOB.ashwalker_tunnels += created_tunnel
		tunnels_remaining -= 1
		if(tunnels_remaining <= 0)
			to_chat(user, span_warning("[src] has been exhausted!"))
			qdel(src)

		return ITEM_INTERACT_BLOCKING

	return ..()

/obj/structure/worm_tunnel
	name = "worm tunnel"
	desc = "A horrid stench rises from the hole, perhaps the visible bile residue is the cause?"

	/// whether the tunnel is covered or not
	var/covered_tunnel = FALSE

/obj/structure/worm_tunnel/examine(mob/user)
	. = ..()
	. += "<br>Using a shovel will destroy the tunnel."
	. += "Using wood will block the tunnel until removed."

/obj/structure/worm_tunnel/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/sheet/mineral/wood))
		if(covered_tunnel)
			to_chat(user, span_warning("There is already wood blocking [src]!"))
			return ITEM_INTERACT_BLOCKING

/obj/structure/worm_tunnel/Destroy(force)
	GLOB.ashwalker_tunnels -= src
	return ..()

/obj/structure/worm_tunnel/
