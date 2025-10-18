/obj/item/gun/energy/update_overlays()
	. = ..()
	if(!automatic_charge_overlays)
		return

	var/overlay_icon_state = "[icon_state]_charge"
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]

	if(modifystate)
		if(single_shot_type_overlay)
			. += "[icon_state]_[initial(shot.select_name)]"
		overlay_icon_state += "_[initial(shot.select_name)]"

	var/ratio = get_charge_ratio()
	if(ratio == 0 && display_empty)
		. += "[icon_state]_empty"
		return

	if(shot_type_fluff_overlay)
		. += "[icon_state]_[initial(shot.select_name)]_extra"

	if(shaded_charge == SHADED_CHARGE_MODE_LABELED)
		. += "[icon_state]_[initial(shot.select_name)]_charge[ratio]"
		return

	if(shaded_charge == TRUE)
		. += "[icon_state]_charge[ratio]"
		return

	var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
	for(var/i = ratio, i >= 1, i--)
		charge_overlay.pixel_w = ammo_x_offset * (i - 1)
		charge_overlay.pixel_z = ammo_y_offset * (i - 1)
		. += new /mutable_appearance(charge_overlay)

/obj/item/gun/energy/ionrifle
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	// also covers the ion carbine

/obj/item/gun/energy/xray
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	shaded_charge = TRUE

/obj/item/gun/energy/e_gun
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	shaded_charge = SHADED_CHARGE_MODE_LABELED
	// also covers the hybrid taser, HoS gun, mini e-gun. necessitates overrides for all other e_gun subtypes

/obj/item/gun/energy/e_gun/turret
	shaded_charge = TRUE

/obj/item/gun/energy/e_gun/stun
	shaded_charge = TRUE

/obj/item/gun/energy/e_gun/mini
	charge_sections = 4

/obj/item/gun/energy/e_gun/mini/add_seclight_point()
	// The mini energy gun's light comes attached but is unremovable.
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		light_overlay_icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi', \
		light_overlay = "mini-light", \
		overlay_x = 0, \
		overlay_y = 0)

/obj/item/gun/energy/e_gun/mini/practice_phaser
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/mini/practice_phaser/add_seclight_point()
	return // practice phaser (from the holodeck) doesn't get a free light

/obj/item/gun/energy/e_gun/stun
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/old
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/dragnet
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/turret
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/advtaser/mounted
	shaded_charge = FALSE

/obj/item/gun/energy/laser
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	// also covers laser carbine (the automatic one). necessitates overrides for all other laser subtypes

/obj/item/gun/energy/disabler
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	shaded_charge = TRUE
	// also covers disabler SMG.

/obj/item/gun/energy/e_gun/nuclear
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	ammo_x_offset = 2
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'
	worn_icon_state = "gun"
	worn_icon = null
	shaded_charge = FALSE

/obj/item/gun/energy/e_gun/nuclear/rainbow
	name = "fantastic energy gun"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell. This one seems quite fancy!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/rainbow, /obj/item/ammo_casing/energy/disabler/rainbow)

/obj/item/ammo_casing/energy/laser/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "kill"
	projectile_type = /obj/projectile/beam/laser/rainbow

/obj/projectile/beam/laser/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/ammo_casing/energy/disabler/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "disable"
	projectile_type = /obj/projectile/beam/disabler/rainbow

/obj/projectile/beam/disabler/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/gun/energy/e_gun/nuclear/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	if(pin)
		to_chat(user, span_warning("You probably want to do this on a new gun!"))
		return FALSE
	to_chat(user, "<font color='#ff2700'>T</font><font color='#ff4e00'>h</font><font color='#ff7500'>e</font> <font color='#ffc400'>g</font><font color='#ffeb00'>u</font><font color='#ebff00'>n</font> <font color='#9cff00'>s</font><font color='#75ff00'>u</font><font color='#4eff00'>d</font><font color='#27ff00'>d</font><font color='#00ff00'>e</font><font color='#00ff27'>n</font><font color='#00ff4e'>l</font><font color='#00ff75'>y</font> <font color='#00ffc4'>f</font><font color='#00ffeb'>e</font><font color='#00ebff'>e</font><font color='#00c4ff'>l</font><font color='#009cff'>s</font> <font color='#004eff'>q</font><font color='#0027ff'>u</font><font color='#0000ff'>i</font><font color='#2700ff'>t</font><font color='#4e00ff'>e</font> <font color='#9c00ff'>f</font><font color='#c400ff'>a</font><font color='#eb00ff'>n</font><font color='#ff00eb'>t</font><font color='#ff00c4'>a</font><font color='#ff009c'>s</font><font color='#ff0075'>t</font><font color='#ff004e'>i</font><font color='#ff0027'>c</font><font color='#ff0000'>!</font>")
	new /obj/item/gun/energy/e_gun/nuclear/rainbow(get_turf(user))
	obj_flags |= EMAGGED
	qdel(src)
	return TRUE

/obj/item/gun/energy/e_gun/nuclear/rainbow/update_overlays()
	. = ..()
	. += "[icon_state]_emagged"

/obj/item/gun/energy/e_gun/nuclear/rainbow/emag_act(mob/user, obj/item/card/emag/E)
	return FALSE
