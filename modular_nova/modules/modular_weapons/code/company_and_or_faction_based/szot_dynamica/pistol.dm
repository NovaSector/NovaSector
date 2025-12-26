// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	name = "\improper M/PP-7 'Słońce' Plasma Projector"
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

	lore_blurb = "The M/PP-7 began as as a prototype - a proof-of-concept weaponization of industrial plasma cutters by Dr. Anya Volkova, \
		a materials scientist who noticed that mining-grade plasma emitters could maintain coherent streams at ranges far beyond their \
		intended use. Her breakthrough was the reconfigurable magnetic bottle that could both contain plasma for storage and shape it into \
		a projectile upon firing. <br><br>\
		Early prototypes used disposable gas canisters, but Volkova's team developed the rechargeable crystalline matrix cell that could \
		be \"refilled\" with raw plasma by being re-energized with conventional electricity. This made the weapon logistically superior to \
		ballistic sidearms - troops could recharge cells from vehicle power or field generators rather than carrying heavy ammunition. \
		The \"Słońce\" designation came from the weapon's tendency to spray plasma in an wide, intimidating arc rather than precise beams. \
		Initial field tests showed poor performance against armor as the plasma would splash and adhere rather than penetrate. The final \
		production model added a rapid-pulse magnetic agitator that makes the plasma \"drill\" through surfaces, solving the armor problem \
		at the cost of making the spread even less predictable. <br><br>\
		Standard issue for vehicle crews and support personnel who need volume of fire over precision. The distinctive roaring report and \
		visible plasma trails make it excellent for crowd control - few things are more intimidating than a wall of searing star-stuff coming your way."

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, autofire_shot_delay = fire_delay)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

// Plasma sharpshooter pistol
// Shoots single, strong plasma blasts at a slow rate

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	name = "\improper M/PP-8 'Gwiazda' Plasma Sharpshooter"
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

	lore_blurb = "Where the PP-7 sprayed plasma, the PP-8 precision-pours it. Developed as a field prototype to get dubbed as XM/PP-7A \
		after frontline commanders requested a plasma sidearm for reconnaissance and special operations teams who needed to engage at longer ranges. <br><br>\
		The \"Gwiazda\" uses the same rechargeable cells as its sibling but completely reworks the magnetic emitter. \
		Instead of a wide dispersal chamber, it features a long, progressively-tightening magnetic coil that squeezes the plasma into \
		a dense, stable sphere. The result is a projectile that maintains cohesion over hundreds of meters rather than dissipating into harmless glitter \
		after fifty. <br><br>\
		Early testers complained the weapon felt \"dead\" in hand - the lack of recoil from the massless projectiles made traditional marksmanship \
		techniques useless. The solution was a clever haptic feedback system that simulates the kick of a .27-54 cartridge, allowing experienced \
		shooters to use their existing muscle memory. This \"ghost recoil\" remains controversial but effective. <br><br>\
		Adopted by military police, shipboard security, and designated marksmen who need the logistical benefits of plasma weapons \
		but can't sacrifice accuracy. The improved magnetic bottle also reduces plasma waste, giving each charge 20% more efficiency than the PP-7 \
		at the cost of a much slower cycle rate."

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/shotgun_revolver
	name = "\improper PM/RS-1 'Bóbr' 12g Shotgun Revolver"
	desc = "A dated attempt at upsizing a revolver to a 'servicable' caliber for frontier and/or otherwise distant planets. \
	Evidently, the conclusion of those efforts was a four-shell cylinder made for twelve gauge shells."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	recoil = SAWN_OFF_RECOIL
	weapon_weight = WEAPON_MEDIUM
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "bobr"
	fire_sound = 'modular_nova/modules/sec_haul/sound/revolver_fire.ogg'
	spread = 15

	lore_blurb = "The \"Bóbr\" is less a formal military design and more an artifact of frontier desperation that somehow found \
		its way into serial production. Classified as a Prototype Model (PM) despite its widespread availability, the RS-1 represents \
		the absolute limit of how far a century-old revolver mechanism can be scaled up. <br><br>\
		The concept was born on the roughest frontier outposts, where gunsmiths, faced with a dire lack of specialized ammunition, \
		began boring out old, heavy-framed pistols to accept readily available 12-gauge shotgun shells. Szot Dynamica's engineers, in a \
		rare moment of pragmatic (or cynical) design, took this jury-rigged concept and refined it into a production weapon. \
		The result is a four-shot cylinder of pure, unadulterated brute force, chambered for a cartridge that was obsolete for \
		military use two centuries prior. <br><br>\
		Its place in the modern era is one of pure utility. While a soldier might be issued a plasma pistol; a freighter pilot, \
		a prospector, or a colonist on a shoestring budget can own a Bóbr. Its ammunition is universally available, \
		easily reloaded with primitive tools, and effective for everything from hunting game to deterring megafauna to close-quarters \
		defense. The trade-offs are severe: punishing recoil that makes accurate follow-up shots a myth, a comically large and \
		cumbersome frame, and a cylinder gap that blasts superheated gas and unburnt powder onto anything nearby. <br><br>\
		It is the antithesis of the Coalition's sleek, logistically streamlined future. It is heavy, loud, inefficient, and brutally simple. \
		But in the vast, lonely stretches of space where cells can't be recharged and supply lines are a dream, the ability to stuff whatever \
		you can find, -rock salt, flechettes, or a solid slug-, into a massive cartridge and have it go \"boom\" every single time has a certain \
		timeless appeal. It's not a weapon of war; it's a tool of survival."

/obj/item/gun/ballistic/revolver/shotgun_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

// A 10mm pistol that shoots slow as all get out, but has that deep dish magazine going on

/obj/item/gun/ballistic/automatic/pistol/zashch
	name = "\improper 'Zashch' Heavy Pistol"
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

	lore_blurb = "If a weapon could be described as \"aggressively adequate,\" it would be the Zashchitnik. It has no formal military designation because it \
		was never submitted for one; it exists in a bureaucratic gray area between a civilian sidearm and an industrial tool, dreamed up by a team of junior \
		engineers whose names were lost to interdepartmental paperwork (though their profit-sharing bonuses remain quite healthy).<br><br> \
		The design philosophy is one of brutalist minimalism: take the cheapest, most abundant material (sheet steel), and the most common, \
		public domain, easiest-to-manufacture pistol cartridge (10mm Auto), and assemble them with the tolerance of a cargo container. \
		The result is a pistol that is less a precision instrument and more a shaped weight that occasionally expels projectiles. \
		It is famously, almost pathologically, durable. Dropping it from a shuttle bay door might dent the deck plating, but the \
		Zashch will be fine. Its primary selling point, aside from a price tag that borders on charitable, is that it will almost \
		certainly outlive its owner.<br><br> \
		The trade-off for this indestructibility is a shooting experience compared to \"wrestling a malfunctioning industrial press.\" \
		The trigger pull is long, gritty, and measured in kilograms. The sheer mass of the reciprocating slide gives it a fire delay that feels geological. \
		It is the handgun for the user who values the 'idea' of having a gun, -a tangible, heavy, indisputable object to signify \"I am armed\"-, \
		over the practicalities of actually aiming and firing it with any semblance of speed or grace. It is the cheapskate's cannon, a monument to \"good enough.\""

/obj/item/gun/ballistic/automatic/pistol/zashch/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/zashch/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
	)

