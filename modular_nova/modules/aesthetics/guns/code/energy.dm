/obj/item/gun/energy/ionrifle
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	// also covers the ion carbine

/obj/item/gun/energy/laser/xray
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	shaded_charge = TRUE

/obj/item/gun/energy/e_gun
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	shaded_charge = SHADED_CHARGE_MODE_LABELED
	// also covers the hybrid taser, HoS gun, mini e-gun. necessitates overrides for all other e_gun subtypes

/obj/item/gun/energy/e_gun/nuclear
	inhand_icon_state = null //so the human update icon also uses the icon_state instead.
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'

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

// TG Sprites - re-overridden back to point to their icon file
// (these subtypes never got custom art, so no need to duplicate the tg sprites in our file)

/obj/item/gun/energy/alien/astrum
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/disabler/smoothbore
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/dueling
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun/dragnet
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun/mini/practice_phaser
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun/old
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun/stun
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun/turret
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/floragun
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/gravity_gun
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/bluetag
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/captain
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/cybersun
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/instakill
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/musket
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/pistol
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/redtag
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/retro
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/soul
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/laser/thermal
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/lasercannon
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/photon
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/plasmacutter
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/pulse/carbine
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/pulse/pistol
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/recharge/ebow
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/recharge/fisher
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/recharge/kinetic_accelerator/minebot
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/shrink_ray
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/taser/debug
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/temperature
	icon = 'icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/wormhole_projector
	icon = 'icons/obj/weapons/guns/energy.dmi'
