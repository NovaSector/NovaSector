/obj/effect/abstract/held_tk_effect
	name = "held_tk_effect"
	icon = 'modular_nova/master_files/icons/effects/tele_effects.dmi'
	icon_state = "holder"
	layer = HANDS_LAYER
	vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	/// Which hand the tk effect is on.
	var/is_right = TRUE
	/// The X posistion of the effect.
	var/list/base_x
	/// The Y posistion of the effect.
	var/list/base_y

///Handles the direction change signal for the held effect.
/obj/effect/abstract/held_tk_effect/proc/on_parent_dir_change(datum/source, _old_dir, new_dir)
	SIGNAL_HANDLER
	set_direction_facing(new_dir)

/// Sets the direction facing for the held effect based on the new direction.
/obj/effect/abstract/held_tk_effect/proc/set_direction_facing(new_dir)
	if(base_x && base_y)
		var/current_dir = dir2text(new_dir)
		pixel_x = length(base_x) ? ((current_dir in base_x) ? base_x[current_dir] : base_x["south"]) : 0
		pixel_y = length(base_y) ? ((current_dir in base_y) ? base_y[current_dir] : base_y["south"]) : 0
		switch(new_dir)
			if(NORTH)
				if(is_right)
					pixel_x += 5
					pixel_y += 10
				else
					pixel_x += -5
					pixel_y += 10
			if(SOUTH)
				if(is_right)
					pixel_x += -5
					pixel_y += 10
				else
					pixel_x += 5
					pixel_y += 10
			if(EAST)
				if(is_right)
					pixel_x += 0
					pixel_y += 10
				else
					pixel_x += 0
					pixel_y += 10
			if(WEST)
				if(is_right)
					pixel_x += 0
					pixel_y += 10
				else
					pixel_x += 0
					pixel_y += 10

/obj/effect/abstract/held_tk_effect/right
	is_right = TRUE

/obj/effect/abstract/held_tk_effect/left
	is_right = FALSE
