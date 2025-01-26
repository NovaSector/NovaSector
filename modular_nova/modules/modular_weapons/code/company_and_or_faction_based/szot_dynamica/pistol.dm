// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	name = "\improper Słońce Plasma Projector"
	desc = "A full auto plasma-spewer, in the flavor of 'dirt cheap.' \
		Uses plasma power packs. \
		Spews an inaccurate stream of searing plasma out the magnetic barrel so long as it has power and the trigger is pulled."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "slonce"

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/laser_firing/incinerate.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.1 SECONDS
	spread = 15

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, autofire_shot_delay = fire_delay)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine_more(mob/user)
	. = ..()

	. += "Originally started as the best means to deterring large crowds, it quickly found a second life \
		as a frontier all-arounder on account of it's cheap-and-rechargable packs, full auto capabilities, \
		and one hell of an intimidation factor. \
		Earlier claims by competitors passed it off as terrible against armor,  \
		but in reality, it's about as effective as any ballistic you could get your hands on! \
		As long as your sector, and local-command permits automatic weapons, that is... and grevious wounds."

	return .

// Plasma sharpshooter pistol
// Shoots single, strong plasma blasts at a slow rate

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	name = "\improper Gwiazda Plasma Sharpshooter"
	desc = "An accurate, plasma spitting pistol-'prototype,' atleast it shoots straight.\
		Uses plasma power packs. \
		Fires relatively accurate globs of searing plasma."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "gwiazda"

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/laser_firing/burn.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.6 SECONDS
	spread = 2.5

	projectile_damage_multiplier = 3 // 30 damage a shot
	projectile_wound_bonus = 10 // +55 of the base projectile, burn baby burn

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine_more(mob/user)
	. = ..()

	. += "The 'Gwiazda' is a further refinement of the 'Słońce' design. with improved \
		energy cycling, magnetic launchers built to higher precision, and an overall more \
		ergonomic design. Early reports speak highly of it's ability to shoot in a straight line. \
		Why it's ended up here is anyone's guess, but the best one would be: 'Testing market sustainability.'"

	return .

// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/shotgun_revolver
	name = "\improper Bóbr 12 GA revolver"
	desc = "A dated attempt at upsizing a revolver to a 'servicable' caliber for frontier-and-distance planets. \
		A revolver type design with a four shell cylinder. That's right, shell, this one shoots twelve guage."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	recoil = SAWN_OFF_RECOIL
	weapon_weight = WEAPON_MEDIUM
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "bobr"
	fire_sound = 'modular_nova/modules/sec_haul/sound/revolver_fire.ogg'
	spread = 15

/obj/item/gun/ballistic/revolver/shotgun_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/revolver/shotgun_revolver/examine_more(mob/user)
	. = ..()

	. += "The 'Bóbr' started development as a limited run sporting weapon before \
		quickly being eaten up by both militias and the general populace on most frontiers, \
		Especially favored by cargo-runners, and pirates due to the ease of finding more 12G. \
		Unlike the silver and wood sporting variants, this is the pure survival model replacing the grip with a \
		standard rubberized pistol grip and weather resistant finish. While the 'Bóbr' isn't the most appealing \
		weapon to grace someone's hands, it might be the most practical."

	return .

// A 10mm pistol that shoots slow as all get out, but has that deep dish magazine going on

/obj/item/gun/ballistic/automatic/pistol/zashch
	name = "\improper 'Zashch' self-loading pistol"
	desc = "A hulking self-loading handgun designated 'Zashchitnik'. Feeds from large 18 round box magazines. Chambered for 10mm."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "zashch"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "zashch"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/zashch
	can_suppress = FALSE
	fire_delay = 1 SECONDS
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_heavy.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/slide_drop.ogg'
	fire_sound_volume = 80
	custom_premium_price = PAYCHECK_COMMAND * 6

/obj/item/gun/ballistic/automatic/pistol/zashch/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/zashch/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
	)

/obj/item/gun/ballistic/automatic/pistol/zashch/examine_more(mob/user)
	. = ..()

	. += "The Zashchitnik self-loading pistol was designed as a police and security sidearm for ballistic favoring forces. \
		Choosing to chamber the 10mm cartridge for its exceptional stopping power, \
		the hulking pistol is known to be a powerful firearm, albeit maligned by some units for the sheer size. \
		The size was dictated necessary for several reasons during the design, not the least so that it can load expansive \
		magazines flush to the grip that allow for exceptionally large amounts of fire power. \
		It has found niche use with security forces both corporate and state sponsored in more middling economic locations."

	return .
