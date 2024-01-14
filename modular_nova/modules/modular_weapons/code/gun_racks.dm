/obj/structure/rack/gunrack
	name = "gun rack"
	desc = "A tall rack for storing guns."
	icon = 'modular_nova/modules/modular_weapons/icons/gun_rack.dmi'
	icon_state = "gunrack"

/obj/structure/rack/gunrack/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	if(!mapload)
		return
	for(var/obj/item/found_item in loc.contents)
		if(!isgun(found_item))
			continue
		rotate_weapon(found_item)

/obj/structure/rack/gunrack/attackby(obj/item/attacking_item, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if(attacking_item.tool_behaviour == TOOL_WRENCH && !(obj_flags & NO_DECONSTRUCTION) && LAZYACCESS(modifiers, RIGHT_CLICK))
		attacking_item.play_tool_sound(src)
		deconstruct(TRUE)
		return
	if(user.combat_mode)
		return ..()
	if(user.transferItemToLoc(attacking_item, drop_location()))
		if(istype(attacking_item, /obj/item/gun))
			var/obj/item/gun/our_gun = attacking_item
			rotate_weapon(our_gun)
			our_gun.pixel_x = rand(-10, 10)
		return TRUE

/// Rotates the weapon or resets its transform based on the being_removed variable, adjusts for base pixel shifts because that can look real bad sometimes
/obj/structure/rack/gunrack/proc/rotate_weapon(obj/item/incoming_weapon, being_removed = FALSE)
	var/matrix/new_matrix = matrix()
	if(!being_removed)
		new_matrix.Turn(-90)
	incoming_weapon.transform = new_matrix
	if(!being_removed)
		// This makes sure the weapons don't pixel shift off the rack or look weird on mapload
		incoming_weapon.pixel_x -= incoming_weapon.base_pixel_x

/// Checks when something is leaving our turf, if its a gun then make sure to reset its transform so its not permanently rotated
/obj/structure/rack/gunrack/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(!isgun(leaving))
		return
	var/obj/item/leaving_item = leaving
	rotate_weapon(leaving_item, TRUE)
