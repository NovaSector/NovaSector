/obj/item/gun/ballistic/automatic/pulse_rifle
	name = "\improper M/PR-15 'Žaibas' Plasma Pulse Projector"
	desc = "An advanced energy weapon that uses high-capacity plasma pulse cells. Fires in 3-round bursts."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "zaibas"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "zaibas"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "zaibas"

	SET_BASE_PIXEL(-8, 0)
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_LOCKING
	accepted_magazine_type = /obj/item/ammo_box/magazine/pulse
	semi_auto = FALSE
	can_suppress = FALSE
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_shoot.ogg'
	fire_sound_volume = 50
	lock_back_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_pull.ogg'
	bolt_drop_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_push.ogg'

	burst_size = 3
	burst_delay = 0.3 SECONDS
	fire_delay = 0.9 SECONDS

	spread = 3
	recoil = 0.5

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	lore_blurb = "The M/PR-15 represents the Coalition's solution to the eternal logistical problem: how much ammunition can one soldier carry? \
		While plasma pistols solved the sidearm question, battle rifles still required troops to hump kilograms of brass and propellant. \
		The answer was the plasma pulse cell - a disposable, hyper-dense energy storage unit that shaves microscopic amounts of tungsten \
		into each plasma burst, creating projectiles that behave like .277 caliber HEAT rounds. <br><br> \
		Developed as XM/PR-12 through XM/PR-14 over eight years, the \"Žaibas\" uses crystalline compression \"plugs\" that store plasma \
		in metastable states. When discharged, these plugs unleash their energy in controlled pulses before shattering. \
		Each military-grade magazine contains enough for approximately one hundred discharges. <br><br> \
		The most controversial feature is the non-ejecting casing system. Pulse cells remain chambered until completely \
		depleted, reducing mechanical complexity and preventing lost cells in combat. This does mean reloading requires manually clearing \
		a partially-spent cell, but troops appreciate not having to police their brass under fire. <br><br> \
		Standard testing revealed an unusual problem: veteran marksmen consistently overcompensated for non-existent recoil. \
		The kinetic feedback system from the M/PP-8 was scaled up to mimic the kick of a .277 rifle, ensuring soldiers used to \
		ballistic weapons could transition seamlessly. Coalition shock troops value its ability to punch through fortifications and powered armor with equal ease. <br><br> \
		The weapon's aesthetic was a deliberate departure from Coalition norms. Its sleek, blackened ferritic casing; rounded yet sharp lines; and imposing, \
		oversized magazine were designed for psychological impact as much as function. The strategy worked too well; the PR-15's menacing silhouette \
		became so culturally ubiquitous that it single-handedly replaced the many centuries-old stereotype of \
		the \"villain with a stamped-receiver, wood-stocked assault rifle\" in popular media, becoming the new de-facto \"bad guy's gun\" in films \
		and video games for a generation."

/obj/item/gun/ballistic/automatic/pulse_rifle/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pulse_rifle/examine(mob/user)
	. = ..()
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		. += span_notice("The chambered cell has [casing.remaining_uses] out of [casing.max_uses] shots remaining.")

/obj/item/gun/ballistic/automatic/pulse_rifle/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		if(casing.remaining_uses <= 0)
			// Lock the bolt back when the pulse cell is depleted
			bolt_locked = TRUE
			update_icon()
			casing.forceMove(drop_location())
			chambered = null
		else if(isnull(casing.loaded_projectile) && !casing.newshot())
			// Lock the bolt back when the pulse cell fails to create a new shot
			bolt_locked = TRUE
			update_icon()
			casing.forceMove(drop_location())
			chambered = null
		// Update HUD after processing pulse casing
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		return

	..() // Handle normal ballistic casing behavior
	// Update HUD after processing normal casing
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/automatic/pulse_rifle/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!semi_auto && from_firing)
		return

	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		// Only eject pulse casings when fully depleted
		if(casing.remaining_uses <= 0 && (casing_ejector || !from_firing))
			casing.forceMove(drop_location())
			if(!QDELETED(casing))
				SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
				casing.bounce_away(TRUE)

		if(empty_chamber)
			clear_chambered()

	// Don't automatically chamber a new round if the bolt is locked
	if(bolt_locked)
		return

	if(chamber_next_round && magazine?.max_ammo >= 1)
		chamber_round()
	// Update HUD after all chamber operations are complete
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/automatic/pulse_rifle/can_shoot()
	if(!chambered)
		return FALSE
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		return casing.remaining_uses > 0 && casing.loaded_projectile
	return ..() // Fall back to normal behavior for non-pulse casings

/obj/item/gun/ballistic/automatic/pulse_rifle/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	// Update HUD after firing to show accurate ammo count
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/automatic/pulse_rifle/postfire_empty_checks(last_shot_succeeded)
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing) && casing.remaining_uses <= 0)
		visible_message(span_warning("[src] emits a low power warning!"))
		playsound(src, 'sound/items/weapons/gun/general/empty_alarm.ogg', 40, TRUE)
		return
	..()
