/obj/item/gun/ballistic/automatic/pulse_rifle
	name = "\improper Žaibas plasma pulse projector"
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
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_shoot.ogg'
	fire_sound_volume = 50
	lock_back_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_pull.ogg'
	bolt_drop_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_push.ogg'

	burst_size = 3
	fire_delay = 2

	spread = 1
	recoil = 0.5

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	lore_blurb = "Žaibas represents the Heliostatic Coalition's pinnacle of plasma weapon miniaturization - at a cost.<br><br>\
		Where conventional plasma weapons use bulky rechargeable cells, Žaibas employs revolutionary crystalline compression \"plugs\" that store plasma \
		in a metastable state. When discharged, these plugs unleash their energy content in controlled pulses before shattering, providing unmatched \
		armor penetration at the expense of sustainability. Each military-grade magazine contains enough for approximately one hundred discharges.<br>\
		Early prototypes lacked simulated recoil, causing seasoned marksmen to overcompensate and miss shots. The solution? \
		A kinetic feedback system that mimics the kick of a .27-54 rifle, ensuring soldiers used to ballistic weapons could transition seamlessly. \
		This 'illusion of recoil' remains a signature feature.<br><br>\
		Developed during the Coalition's formative years, the weapon's origins are reflected in both its name and its operating principle - \
		delivering overwhelming force in brief, devastating strikes. While standard plasma weapons remain more practical for \
		most users, the Žaibas has found particular favor among Coalition shock troops and anti-materiel teams who value its ability to punch through \
		fortifications and powered armor with equal ease.<br><br>\
		A warning etched near the ejection port reminds users: 'NEPONOVLJATI NAPAJANJE - Kristalna matrika može srušiti se'."

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
