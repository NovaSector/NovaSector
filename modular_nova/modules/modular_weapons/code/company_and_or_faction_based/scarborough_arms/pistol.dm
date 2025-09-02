/obj/item/gun/ballistic/automatic/pistol/enforcer
	name = "\improper Enforcer-TEN combat handgun"
	desc = "A robust, full-size combat handgun, chambered in 10mm. Lacks a threaded barrel, leaving it unable to be suppressed, \
		but has enough heft to be used as a decent improvised weapon in a pinch."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/pistol.dmi'
	icon_state = "magnum"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/scarborough_arms/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/scarborough_arms/guns_righthand.dmi'
	inhand_icon_state = "magnum"
	force = 17 // when all you have is a hammer
	throwforce = 20 // every problem is a nail (i really wanna see someone clutch a fight by throwing their gun)
	can_suppress = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/enforcer
	fire_sound_volume = 120
	w_class = WEIGHT_CLASS_NORMAL
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/bay_gunshot_magnum.ogg'
	load_sound = 'modular_nova/modules/modular_weapons/sounds/bay_magnum_in.ogg'
	load_empty_sound = 'modular_nova/modules/modular_weapons/sounds/bay_magnum_in.ogg'
	eject_sound = 'modular_nova/modules/modular_weapons/sounds/bay_magnum_out.ogg'
	eject_empty_sound = 'modular_nova/modules/modular_weapons/sounds/bay_magnum_out.ogg'
	empty_indicator = TRUE
	obj_flags = UNIQUE_RENAME
	lore_blurb = "The Enforcer-TEN is part of Scarborough Arms's Enforcer series of full-frame handguns, \
		designed to be robust, no-frills solutions to interpersonal conflicts.<br><br>\
		A lightweight, reinforced chassis allows for a slimmer profile and reduced weight, making them popular choices \
		in regards to ease of use and (non-concealed) carry, while maintaining Scarborough's high standards in terms of reliability and performance. \
		While not as concealable as other popular (or infamous) options like the Ansem or Makarov, \
		and not quite qualifying as a \"hand cannon\" like other, larger-caliber handguns in the Enforcer series, the 10mm variant is still \
		nothing to be scoffed at, reliably dropping targets and not breaking the bank nor the wrist to do so.<br><br>\
		For better or for worse, other Enforcer variants, such as the original Enforcer in 14mm Kerberos, or the \
		limited-run Enforcer/CB (featuring a magnetic coil-boosted barrel) have not made their way to the frontier."

/obj/item/gun/ballistic/automatic/pistol/enforcer/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_GUN_SAFETY_TOGGLED, PROC_REF(safety_toggled))

/obj/item/gun/ballistic/automatic/pistol/enforcer/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/// this proc exists for the sole purpose of listening for safety toggles and refreshing our overlays
/obj/item/gun/ballistic/automatic/pistol/enforcer/proc/safety_toggled()
	SIGNAL_HANDLER
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/enforcer/update_overlays()
	. = ..()
	// safety indicator
	var/datum/component/gun_safety/our_safety = GetComponent(/datum/component/gun_safety)
	. += "[icon_state]_sf[our_safety.safety_currently_on ? "1" : "0"]"
	// snowflaked indicator
	if(magazine)
		var/capacity_number
		switch(get_ammo() / magazine.max_ammo)
			if(0.6 to INFINITY)
				capacity_number = 100
			if(0.1 to 0.6)
				capacity_number = 50
			if(0 to 0.1)
				capacity_number = 0
		if(capacity_number != 0)
			. += "[icon_state]_mag_[capacity_number]"
		else
			. += "[icon_state]_empty"
	else
		. += "[icon_state]_empty"

/obj/item/storage/toolbox/guncase/traitor/enforcer
	name = "enforcer gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/enforcer
	extra_to_spawn = /obj/item/ammo_box/magazine/enforcer
	ammo_box_to_spawn = /obj/item/ammo_box/c10mm/large

/obj/item/storage/toolbox/guncase/traitor/enforcer/ammunition
	name = "enforcer magazine case"
	weapon_to_spawn = /obj/item/ammo_box/magazine/enforcer
