// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	name = "\improper Słońce Plasma Projector"
	desc = "An inaccurate, plasma-spewing pistol, for melting the broad side of a barn. Uses plasma power packs."
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

	lore_blurb = "The Słońce Plasma Projector is an exercise in magnetically-agitated volume of plasmic fire.<br><br>\
		Originally designed as a means to deter larger crowds, it quickly found a second life as a frontier all-rounder, \
		on account of it's cheap and rechargable packs, full-auto capabilities, \
		and the intimidation factor of throwing a wall of searing plasma in the vague direction of what it's pointed at. \
		Earlier iterations had some performance issues against layers of armor, \
		but refinements to the magnetic chamber mitigated previous plasma adherence issues, mitigating that issue."

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, autofire_shot_delay = fire_delay)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

// Plasma sharpshooter pistol
// Shoots single, strong plasma blasts at a slow rate

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	name = "\improper Gwiazda Plasma Sharpshooter"
	desc = "An accurized, plasma-spitting pistol, for melting the narrow side of a barn. Uses plasma power packs."
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
	projectile_wound_bonus = 20 // base projectile has -20 wound bonus, this brings it back up to 0. burns are pretty schnasty though

	lore_blurb = "The 'Gwiazda' is a further refinement of the 'Słońce' design, \
		serving as an exercise in magnetically-agitated precision of plasmic fire.<br><br>\
		Sharing its predecessor's cheap and rechargable power packs, this iteration trades \
		in the intimidation factor of its haphazard automatic mode for much better per-glob performance. \
		With improved energy cycling, a better-tuned \"precision\" magnetic chamber, and an overall more \
		ergonomic design, end-users report that it is actually capable of shooting in a line straighter than other variants."

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/shotgun_revolver
	name = "\improper Bóbr 12 GA revolver"
	desc = "A dated attempt at upsizing a revolver to a 'servicable' caliber for frontier and/or otherwise distant planets. \
	Evidently, the conclusion of those efforts was a four-shell cylinder made for twelve gauge shells."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	recoil = SAWN_OFF_RECOIL
	weapon_weight = WEAPON_MEDIUM
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "bobr"
	fire_sound = 'modular_nova/modules/sec_haul/sound/revolver_fire.ogg'
	spread = 15

	lore_blurb = "The 'Bóbr' is a twelve gauge shotgun in the somewhat comical form-factor of a revolver, \
		which doesn't prove particularly conducive to controlling recoil or lining up a good shot.<br><br>\
		The Bóbr started development as a limited run sporting weapon, \
		before quickly finding a place with both colonial militias and the general populace of rougher frontiers. \
		It's been favored by cargo-runners on both sides of the law, due to the ease of finding or reloading ammunition. \
		Unlike the silver and wood sporting variants, this is the pure survival model, which uses a \
		standard, rubberized pistol grip, and weather-resistant finish. \
		While the 'Bóbr' isn't the most appealing weapon to grace someone's hands, it's at least somewhat practical."

/obj/item/gun/ballistic/revolver/shotgun_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

// A 10mm pistol that shoots slow as all get out, but has that deep dish magazine going on

/obj/item/gun/ballistic/automatic/pistol/zashch
	name = "\improper 'Zashch' heavy pistol"
	desc = "A hulking, self-loading 10mm handgun, designated 'Zashchitnik'. Feeds from large 18 round box magazines."
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

	lore_blurb = "The 'Zashchitnik' self-loading pistol is a hefty handgun with a focus on reliability and magazine size.<br><br>\
		Originally designed as a police and security sidearm for ballistic-favoring forces, \
		Szot Dynamica chose to chamber it for the 10mm cartridge for its exceptional stopping power. \
		The hulking pistol is known to be a powerful firearm with a surprisingly tame recoil, thanks to \
		the sheer bulk of it; a trait that some find satisfying while others find suboptimal for aiming consecutive shots. \
		The size was dictated necessary for several reasons during the design, not the least so that it can load expansive \
		magazines flush to the grip that allow for exceptionally large amounts of firepower. \
		It has found niche use with security forces both corporate and state-sponsored in more middling economic locations."

/obj/item/gun/ballistic/automatic/pistol/zashch/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/zashch/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
	)

