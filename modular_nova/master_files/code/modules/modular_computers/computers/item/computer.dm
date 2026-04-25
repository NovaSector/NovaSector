/// Optional DMI file to source [program_open_overlay] from. When null the
/// program falls back to the host computer's [overlays_icon], which is the
/// stock TG behaviour. Programs that ship their own splash sprite (Nova
/// additions that don't want to clutter the core PDA overlay sheet) point
/// this at their own DMI.
/datum/computer_file/program
	var/program_open_overlay_icon = null

/obj/item/modular_computer/update_overlays()
	. = ..()
	if(enabled)
		if(active_program)
			var/program_icon = active_program.program_open_overlay_icon || overlays_icon
			. += mutable_appearance(program_icon, active_program.program_open_overlay)
		else
			. += mutable_appearance(overlays_icon, icon_state_menu)
	if(atom_integrity <= integrity_failure * max_integrity)
		. += mutable_appearance(overlays_icon, "bsod")
		. += mutable_appearance(overlays_icon, "broken")
