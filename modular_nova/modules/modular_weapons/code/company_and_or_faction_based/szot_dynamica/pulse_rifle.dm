/obj/item/gun/ballistic/automatic/pulse_rifle
	name = "\improper Pulse Rifle"
	desc = "An advanced energy weapon that uses rechargeable pulse cells. Fires in 3-round bursts."
	icon_state = "pulse-rifle"
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_LOCKING
	accepted_magazine_type = /obj/item/ammo_box/magazine/pulse
	semi_auto = FALSE
	fire_sound = 'sound/items/weapons/gun/l6/shot.ogg'
	burst_size = 3
	fire_delay = 2
	spread = 5
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/ballistic/automatic/pulse_rifle/examine(mob/user)
	. = ..()
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		. += span_notice("The chambered cell has [casing.remaining_uses] out of [casing.max_uses] shots remaining.")

/obj/item/gun/ballistic/automatic/pulse_rifle/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		if(casing.remaining_uses <= 0)
			casing.forceMove(drop_location())
			chambered = null
		else if(!casing.loaded_projectile && !casing.newshot())
			casing.forceMove(drop_location())
			chambered = null
		return

	..() // Handle normal ballistic casing behavior

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

    if(chamber_next_round && magazine?.max_ammo > 1)
        chamber_round()

/obj/item/gun/ballistic/automatic/pulse_rifle/can_shoot()
	if(!chambered)
		return FALSE
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing))
		return casing.remaining_uses > 0 && casing.loaded_projectile
	return ..() // Fall back to normal behavior for non-pulse casings

/obj/item/gun/ballistic/automatic/pulse_rifle/postfire_empty_checks(last_shot_succeeded)
	var/obj/item/ammo_casing/pulse/casing = chambered
	if(istype(casing) && casing.remaining_uses <= 0)
		visible_message(span_warning("[src] emits a low power warning!"))
		playsound(src, 'sound/items/weapons/gun/general/empty_alarm.ogg', 40, TRUE)
		return
	..()
