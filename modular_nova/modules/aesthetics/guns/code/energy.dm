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
