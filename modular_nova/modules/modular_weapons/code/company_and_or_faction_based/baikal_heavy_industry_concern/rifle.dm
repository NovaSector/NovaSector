// Hyperburst firing military grade battle rifle firing .310 Strilka

/obj/item/gun/ballistic/automatic/sokol
	name = "\improper M/BR-7 'Sokol' Battle Rifle"
	desc = "A bullpup hyperburst battle rifle chambered in the .310 Strilka caseless cartridge equipped with a 1-2x variable magnification scope. \
		Due to the high caliber of the weapon and the necessity for quick cycling and follow up shots, an overcomplicated hyperburst mechanism is employed. \
		This mechanism greatly decreases the power of the fired rounds due to re-utilizing the gas produced by ignition to cycle the action extremely quick."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/baikal_heavy_industry_concern/guns_48.dmi'
	icon_state = "sokol"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	inhand_icon_state = "lanca"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "lanca"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "lanca"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/sokol

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 5
	suppressor_y_offset = 0

	burst_size = 2
	fire_delay = 1 SECONDS
	actions_types = list()
	spread = 3

	projectile_damage_multiplier = 0.67
	// 4.5 shots to kill using standard = 3 bursts to kill = 3s minimum TTK
	// By comparison, the Renpaard is at 4.5 shots to kill with an automatic fire delay of 0.4s which means a 2s minimum TTK, Meanwhile, the similar caliber Lanca has a TTK of 3.6 seconds, requiring 3 shots to kill and a delay of 1.2 seconds between shots. The Lanca is a DMR equipped with a long range scope.

	lore_blurb = "The M/BR-7 was the flashy prototype of the bygone era of the Coalition's \"advanced ballistics\" phase, before the introduction of plasma pulse weaponry. \
		It represented the peak of the Coalition's ballistic arms technology at the time, featuring a revolutionary hyperburst mechanism and much higher capacity and close quarters firepower comapred to it's competitor, the BR-8. <br><br> \
		Chambered in the same .310 Strilka Caseless cartridge, the M/BR-7 was supposed to be the ultimate battle rifle in the Coalition's service, if not for the adoption of the pulse plasma line of weaponry, which relegated it to relative obscurity. \
		Its operating system is a complex, recoil-shifted pulse mechanism that requires especially configured, lower pressure ammunition and frequent, professional maintenance. \
		In spite of it's finicky nature, the BR-7 showed an extremely high performance compared to it's competitor, and while it was never adopted \
		by the main forces of the coalition, it gained popularity and almost cult-like status among special forces, mercenaries and other users with \
		the funds and patience to keep it running reliably. <br><br> \
		The BR-7 is a gun that has no cut corners in it's construction, somewhat of an outlier for the Heliostatic Coalition, especially when it comes to ballistic weaponry; \
		the sighting system consists of a built-in 1-2x variable magnification scope with a quick detatch mount, and a backup iron sight assembly with a glowing front post; \
		it possesses a composite heavy barrel, meant for sustained burst fire at the blistering rates the weapon offered, as well as a built-in muzzle device for flash and recoil control; \
		it's sleek, mostly polymer construction kept the weapon light and manageable, as well as easy to take apart (althogh hard to put back together) by users. \
		In spite of it's use of the .310 Strilka cartridge, the BR-7 required a special line of ammunition utilizing lower pressure propellant to run reliably. \
		While this left the weapon lacking in stopping power compared to the BR-8, it more than made up for it by the ability to allow for two, \
		almost simultaneous impacts on target at distances of up to 600 meters."

/obj/item/gun/ballistic/automatic/sokol/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.2)


/obj/item/gun/ballistic/automatic/sokol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BAIKAL)

/obj/item/gun/ballistic/automatic/sokol/no_mag
	spawnwithmagazine = FALSE


/obj/item/gun/ballistic/automatic/voron
	name = "\improper M/BC-7S 'Voron' Battle Carbine"
	desc = "A bullpup hyperburst battle carbine chambered in the .310 Strilka caseless cartridge equipped with a 1-2x variable magnification scope. \
		Due to the high caliber of the weapon and the necessity for quick cycling and follow up shots, an overcomplicated hyperburst mechanism is employed. \
		This mechanism greatly decreases the power of the fired rounds due to re-utilizing the gas produced by ignition to cycle the action extremely quick. \
		The Voron is an even more obscure offshoot of the more popular M/BR-7 Sokol, sold only to the most covert and unscrupulous clients."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/baikal_heavy_industry_concern/guns_48.dmi'
	icon_state = "voron"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	inhand_icon_state = "infanterie_evil"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie_evil"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie_evil"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/sokol

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	suppressed = SUPPRESSED_QUIET
	can_suppress = FALSE
	can_unsuppress = FALSE

	burst_size = 2
	fire_delay = 1 SECONDS
	actions_types = list()
	spread = 3

	projectile_damage_multiplier = 1
	// 3 shots to kill using standard = 2 bursts to kill = 2s minimum TTK

	lore_blurb = "The M/BC-7S was an offshoot of an already rare and ellusive weapon, the Heliostatic Coalition's Falcon, or Sokol in their native language. \
	But while the falcon flies high and mighty, the raven's way of achieving success is through cunning, subterfuge and stealth. That is exactly the purpose the \
	Voron was designed for. A shoter length, integrally suppressed answer to the Sokol, featuring experimental magnetic technology that until recently, was only known to \
	be present on the weapon by the Coalition's chief military procurement officers. Alas, it was not to be. Pulse plasma had entrenched itself too hard within the HC's \
	Military for ballistic alternatives, even ones as cutting edge and deadly as the Voron to be sought out actively by army-wide procurement. Instead, the Voron fell into \
	less scrupulous hands. Coalition Black Ops teams, state funded terrorists and the cream of the crop of special forces, and, of course... Less legitimate users... \
	Namely, the Syndicate, which through a series of backroom deals, procured a hefty amount of Voron carbines from Baikal Heavy Industry Concern without the knowledge or approval of the Coalition."

/obj/item/gun/ballistic/automatic/voron/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.2)


/obj/item/gun/ballistic/automatic/voron/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BAIKAL)

/obj/item/gun/ballistic/automatic/voron/no_mag
	spawnwithmagazine = FALSE
