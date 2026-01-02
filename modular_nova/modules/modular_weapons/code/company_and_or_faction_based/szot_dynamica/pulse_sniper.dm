/obj/item/gun/ballistic/rifle/pulse_sniper
	name = "\improper M/PR-16 'Žaibas-Aštrus' Sniper Rifle"
	desc = "A sniper variant of the Žaibas plasma pulse projector, modified for precision long-range engagements. \
	Uses a specialized chamber-loading system that consumes three charges per shot."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "zaibas_sniper"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "zaibas_sniper"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "zaibas_sniper"

	SET_BASE_PIXEL(-8, 0)
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_LOCKING
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/pulse_sniper
	semi_auto = FALSE
	can_suppress = FALSE
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_shoot.ogg'
	fire_sound_volume = 70
	rack_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_pull.ogg'
	bolt_drop_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_push.ogg'

	fire_delay = 1.2 SECONDS

	spread = 2.5
	recoil = 1
	projectile_damage_multiplier = 1.8
	projectile_speed_multiplier = 1.5

	weapon_weight = WEAPON_HEAVY
	internal_magazine = TRUE
	need_bolt_lock_to_interact = TRUE

	/// Number of charges consumed per shot
	var/shots_per_fire = 3

	lore_blurb = "The PR-16 variant sacrifices the PR-15's high capacity for unparalleled precision at extreme ranges. Where the standard model \
		fires rapid pulses, the \"Aštrus\" variant, -'sharp'-, draws three charges per shot to create a hyper-concentrated beam that can defeat even \
		advanced composite armors at over a kilometer. <br><br> \
		Development as XM/PR-15 revealed the standard pulse cells couldn't maintain the energy density needed for precision shots. The solution was \
		a dedicated single-cell mechanism that eliminates the magazine system entirely. Each shot consumes three standard charges' worth of energy, \
		making the weapon incredibly ammunition-inefficient but devastatingly effective. <br><br> \
		The manual bolt action was a controversial addition that almost killed the project. However, Coalition marksmen reported that the \
		cycling process allowed for better shot placement and thermal management during extended engagements. The chambered cell provides immediate \
		feedback on remaining shots - when the charge drops below three projector shots' worth, the bolt automatically locks open. \
		Issued only to elite reconnaissance and anti-materiel teams, the PR-16 has become the weapon of choice for dealing with hardened targets at \
		distances where conventional rifles would be useless."

/obj/item/gun/ballistic/rifle/pulse_sniper/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/rifle/pulse_sniper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2.5)
	// Prevent newshot() from decrementing uses for this weapon
	// We handle ammunition consumption in shoot_live_shot()
	// Set a special flag on any pulse casings that might be loaded
	var/obj/item/ammo_box/magazine/internal/pulse_sniper/mag = magazine
	if(mag && istype(mag))
		for(var/obj/item/ammo_casing/pulse/casing in mag.stored_ammo)
			casing.suppress_use_consumption = TRUE

/obj/item/gun/ballistic/rifle/pulse_sniper/add_notes_ballistic()
	// Only show information about the chambered cell
	if(chambered && istype(chambered, /obj/item/ammo_casing/pulse))
		var/obj/item/ammo_casing/pulse/casing = chambered
		// Set the loc to the gun temporarily so the add_notes_ammo method can access the projectile_damage_multiplier
		var/obj/item/original_loc = casing.loc
		casing.loc = src
		var/notes = casing.add_notes_ammo()
		casing.loc = original_loc
		return notes
	else
		return "No pulse cell is chambered."

/obj/item/gun/ballistic/rifle/pulse_sniper/examine(mob/user)
	. = ..()
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		var/shots_left = floor(casing.remaining_uses / shots_per_fire)
		. += span_notice("The chambered cell has [casing.remaining_uses] out of [casing.max_uses] charges remaining (enough for [shots_left] shot[shots_left != 1 ? "s" : ""]).")
		if(casing.remaining_uses < shots_per_fire)
			. += span_warning("Not enough charge for another shot!")

/obj/item/gun/ballistic/rifle/pulse_sniper/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		// Ensure suppress_use_consumption flag is set for this weapon
		casing.suppress_use_consumption = TRUE

		// Check if we have enough charges for another shot
		if(casing.remaining_uses >= shots_per_fire)
			// Create new projectile if we have enough charges
			casing.newshot()
			// Update HUD after processing pulse casing
			SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
			return

		// Not enough charges - warn and eject if needed
		visible_message(span_warning("[src] emits a low power warning!"))
		playsound(src, 'sound/items/weapons/gun/general/empty_alarm.ogg', 40, TRUE)
		if(casing_ejector || !from_firing)
			casing.forceMove(drop_location())
			if(!QDELETED(casing))
				SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
				casing.bounce_away(TRUE)

	// Only call parent if we have a valid chambered casing
	if(chambered)
		..() // Handle normal ballistic casing behavior

/obj/item/gun/ballistic/rifle/pulse_sniper/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(from_firing)
		return

	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		// Ensure suppress_use_consumption flag is set for this weapon
		casing.suppress_use_consumption = TRUE
		// Only eject pulse casings when depleted beyond usability
		if(casing.remaining_uses < shots_per_fire && (casing_ejector || !from_firing))
			casing.forceMove(drop_location())
			if(!QDELETED(casing))
				SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
				casing.bounce_away(TRUE)

		if(empty_chamber)
			clear_chambered()

	if(chamber_next_round && magazine?.max_ammo >= 1)
		chamber_round()
	// Update HUD after all chamber operations are complete
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/rifle/pulse_sniper/can_shoot()
	if(bolt_locked)
		return FALSE
	if(!chambered)
		return FALSE
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		// Ensure suppress_use_consumption flag is set for this weapon
		casing.suppress_use_consumption = TRUE
		return casing.remaining_uses > 0 && casing.loaded_projectile
	return ..() // Fall back to normal behavior for non-pulse casings

/obj/item/gun/ballistic/rifle/pulse_sniper/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	// Consume multiple charges per shot AFTER calling parent
	. = ..() // Call parent first
	// Consume charges after firing
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		casing.remaining_uses = max(0, casing.remaining_uses - shots_per_fire)
	// Update HUD after firing to show accurate ammo count
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/rifle/pulse_sniper/postfire_empty_checks(last_shot_succeeded)
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing) && casing.remaining_uses < shots_per_fire)
		visible_message(span_warning("[src] emits a low power warning!"))
		playsound(src, 'sound/items/weapons/gun/general/empty_alarm.ogg', 40, TRUE)
		return
	..()

// Custom rack function to ensure HUD updates
/obj/item/gun/ballistic/rifle/pulse_sniper/rack(mob/user = null)
	..() // Call parent function
	// Update HUD after racking
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

// Custom drop_bolt function to ensure HUD updates
/obj/item/gun/ballistic/rifle/pulse_sniper/drop_bolt(mob/user = null)
	..() // Call parent function
	// Update HUD after dropping bolt
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

// Custom load_gun function to ensure HUD updates when loading ammo
/obj/item/gun/ballistic/rifle/pulse_sniper/load_gun(obj/item/ammo, mob/living/user)
	. = ..()
	// Set suppress_use_consumption flag on any pulse casings
	var/obj/item/ammo_box/magazine/internal/pulse_sniper/mag = magazine
	if(mag && istype(mag))
		for(var/obj/item/ammo_casing/pulse/casing in mag.stored_ammo)
			casing.suppress_use_consumption = TRUE
	// Update HUD after loading ammo
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/rifle/pulse_sniper/before_firing(atom/target, mob/user)
	. = ..()
	if(chambered?.loaded_projectile)
		var/obj/projectile/beam/laser/plasma_glob/pulse/plasma_pulse = chambered.loaded_projectile
		if(chambered.loaded_projectile && istype(plasma_pulse))
			plasma_pulse.armour_penetration = 10
			plasma_pulse.secondary_armour_penetration = 10

/obj/item/ammo_box/magazine/internal/pulse_sniper
	name = "pulse sniper pseudochamber"
	ammo_type = /obj/item/ammo_casing/pulse
	caliber = "pulse"
	max_ammo = 1
