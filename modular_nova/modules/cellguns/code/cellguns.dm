// modular_nova/modules/cellguns/code/cellguns.dm:1
/obj/item/gun/energy/cell_loaded
	name = "cell-loaded gun"
	desc = "A energy gun that functions by loading cells for ammo types"

	/// List containing what cells are allowed to be installed by the gun. This includes all subtypes.
	var/list/allowed_cells = list()
	/// The maximum amount of cells that a cell loaded gun can hold at once.
	var/maxcells = 3
	/// A list that contains the currently installed cells.
	var/list/installedcells = list()
	/// Cell types to auto-populate installedcells with on Initialize. Subtypes just override this list.
	var/list/starting_cells = list()
	/// If TRUE, attack_self shows a radial to pick a specific loaded cell instead of cycling linearly.
	var/radial_select_mode = FALSE
	/// Whether cells can be installed into this gun via attackby.
	var/can_install_cells = TRUE
	/// Whether cells can be removed from this gun via click_alt.
	var/can_remove_cells = TRUE

	automatic_charge_overlays = FALSE //This is needed because Cell based guns use their own custom overlay system.

/obj/item/gun/energy/cell_loaded/Initialize(mapload)
	. = ..()
	for(var/cell_type in starting_cells)
		if(installedcells.len >= maxcells)
			break
		var/obj/item/weaponcell/cell = new cell_type(src)
		ammo_type += new cell.ammo_type(src)
		installedcells += cell

/obj/item/gun/energy/cell_loaded/give_gun_safeties()
	return

/obj/item/gun/energy/cell_loaded/examine(mob/user)
	. = ..()
	if(maxcells)
		. += "<b>[installedcells.len]</b> out of <b>[maxcells]</b> cell slots are filled."
		. += span_info("You can use Alt Click with an empty hand to remove the most recently inserted cell from the chamber.")
		. += span_notice("Ctrl-Shift-Click to toggle between cycling cells and picking one via radial. Use in hand to [radial_select_mode ? "pick a cell" : "cycle cells"].")

		for(var/cell in installedcells)
			. += span_notice("There is \a [cell] loaded in the chamber.") //Shows what cells are currently inside of the gun

/// Handles insertion of weapon cells
/obj/item/gun/energy/cell_loaded/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(is_type_in_list(attacking_item, allowed_cells))
		if(!can_install_cells)
			to_chat(user, span_warning("[src] does not accept new cells!"))
			return
		if(installedcells.len >= maxcells)
			to_chat(user, span_warning("[src] is fully chambered. Take a cell out to make room!"))
			return
		var/obj/item/weaponcell/cell = attacking_item
		if(!user.transferItemToLoc(cell, src))
			return
		playsound(loc, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_notice("You install [cell]."))
		ammo_type += new cell.ammo_type(src)
		installedcells += cell
	else
		..()

/obj/item/gun/energy/cell_loaded/update_overlays()
	. = ..()
	var/overlay_icon_state = icon_state
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]

	if(modifystate)
		if(single_shot_type_overlay)
			var/mutable_appearance/full_overlay = mutable_appearance(icon, "[icon_state]_full")
			full_overlay.color = shot.select_color
			. += new /mutable_appearance(full_overlay)
		overlay_icon_state += "_charge"

	var/ratio = get_charge_ratio()
	ratio = get_charge_ratio()

	if(!ratio && display_empty)
		. += "[icon_state]_empty"
		return

	var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)

	if(!shot.select_color)
		return

	charge_overlay.color = shot.select_color

	for(var/i in 0 to ratio)
		charge_overlay.pixel_w = ammo_x_offset * (i - 1)
		charge_overlay.pixel_z = ammo_y_offset * (i - 1)
		. += new /mutable_appearance(charge_overlay)

/obj/item/gun/energy/cell_loaded/click_alt(mob/user, modifiers)
	if(!can_remove_cells)
		to_chat(user, span_warning("The [src]'s cells are fixed in place!"))
		return CLICK_ACTION_BLOCKING
	if(!installedcells.len)
		to_chat(user, span_warning("The [src] has no cells inside!"))
		return CLICK_ACTION_BLOCKING

	to_chat(user, span_notice("You remove a cell."))
	var/obj/item/last_cell = installedcells[installedcells.len]

	if(last_cell)
		last_cell.forceMove(drop_location())
		user.put_in_hands(last_cell)

	installedcells -= last_cell
	ammo_type.len--
	select_fire(user)
	return CLICK_ACTION_SUCCESS

// Quality of life per gun preference
/obj/item/gun/energy/cell_loaded/click_ctrl_shift(mob/user)
	radial_select_mode = !radial_select_mode
	balloon_alert(user, "cell select: [radial_select_mode ? "radial" : "cycle"]")
	return CLICK_ACTION_SUCCESS

//
/obj/item/gun/energy/cell_loaded/attack_self(mob/living/user as mob)
	if(radial_select_mode && installedcells.len > 1)
		select_via_radial(user)
		return
	return ..()

/// Cells are always appended to the tail end of ammo_type in the same order as installedcells (see attackby() and click_alt()), so the last installedcells.len entries of ammo_type map 1:1 to installedcells.
/obj/item/gun/energy/cell_loaded/proc/select_via_radial(mob/living/user)
	var/list/choices = list()
	for(var/obj/item/weaponcell/cell as anything in installedcells)
		choices[cell] = image(icon = cell.icon, icon_state = cell.icon_state)

	var/obj/item/weaponcell/picked = show_radial_menu(user, src, choices, custom_check = CALLBACK(src, PROC_REF(check_radial_menu), user), require_near = TRUE)
	var/index = installedcells.Find(picked)
	if(!index)
		return
//	this version doesn't show the ammo_type option, this might need to get refactored again select = (ammo_type.len - installedcells.len) + index. Could also take the version that shows ammo_type down to mediguns instead.
	select = ammo_type.len + installedcells.len + index
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay
	if(shot.muzzle_flash_color)
		set_light_color(shot.muzzle_flash_color)
	if(shot.select_name)
		balloon_alert(user, "set to [shot.select_name]")
	chambered = null
	recharge_newshot(TRUE)
	update_appearance()
	if(fire_mode_switch_sound)
		playsound(src, fire_mode_switch_sound, 50, TRUE)

/obj/item/gun/energy/cell_loaded/proc/check_radial_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	if(user.get_active_held_item() != src)
		return FALSE
	return TRUE

/// A cellgun used for debug, it is able to use any weaponcell.
/obj/item/gun/energy/cell_loaded/alltypes
	name = "omni gun"
	allowed_cells = list(/obj/item/weaponcell)
