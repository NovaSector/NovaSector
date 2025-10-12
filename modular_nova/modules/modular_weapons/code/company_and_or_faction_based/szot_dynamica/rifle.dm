// Rapid firing scary military grade weapon firing .27-54 Cesarzowa

/obj/item/gun/ballistic/automatic/miecz
	name = "\improper Miecz Support Weapon"
	desc = "A short-barrel weapon riding the line between submachine gun and a rifle, chambered for .27-54 Cesarzowa. \
		To disincentivize use outside of the suggested short range, it only has basic, but very readable, glow-sights."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "miecz"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	inhand_icon_state = "miecz"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "miecz"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "miecz"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/ak_shoot.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 1
	fire_delay = 0.35 SECONDS
	actions_types = list()
	spread = 5
	// assuming base ammo,
	// sindano:	0.3s fire delay, 7.5 spread, normal	|	20 damage, 0 AP
	// miecz:	0.35s fire delay, 5 spread, normal	|	20 damage, 30 AP
	// followup pr suggestion: higher firerate for the sindano/miecz to 0.2s/0.25s, respectively
	// and/or damage buffs for the sindano? i think the old "miecz spews less-damaging but innate AP bullets,
	// while the sindano has higher base damage or something" dichotomy could've been explored more.

	lore_blurb = "The Miecz is one of the staple weapons of the frontier; simple, effective, and not terribly uncomfortable to use.<br>\
		<br>\
		The Miecz's unusual shape is, interestingly, due to its storied development history. \
		The original Miecz prototypes were built off an experimental downscaling of a very early, near-experimental \
		iteration of the Lanca battle rifle; while the Lanca was further revised, the Miecz showed enough potential \
		that it warranted a development of a new pistol cartridge in tandem with further development, \
		leading to the creation of the .27-54 Cesarzowa cartridge.<br>\
		<br>\
		While more cumbersome than its SolFed contemporary, the Sindano, the additional weight makes it easier to control and keep on-target, \
		and the hard-tip design of .27-54 Cesarzowa lends itself well towards defeating lighter personal armor."

/obj/item/gun/ballistic/automatic/miecz/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/miecz/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/miecz/no_mag
	spawnwithmagazine = FALSE

// Semi-automatic rifle firing .310 with reduced firerate compared to a Sakhno

/obj/item/gun/ballistic/automatic/lanca
	name = "\improper Lanca Battle Rifle"
	desc = "A relatively compact, long barreled bullpup battle rifle chambered for .310 Strilka. Has an integrated sight with \
		a surprisingly functional amount of magnification, given its place of origin."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "lanca"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "lanca"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "lanca"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/lanca

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 1
	fire_delay = 1.2 SECONDS
	actions_types = list()

	recoil = 0.5
	spread = 2.5
	projectile_wound_bonus = -20

	lore_blurb = "The Lanca is one of Szot Dynamica's earlier efforts in designing an effective, high-impact battle rifle.<br>\
		<br>\
		When the modern, caseless, full-power .310 Strilka cartridge proved to be quite effective in regards to defeating man-sized targets \
		and hardier fauna, the problem became that the only weapons in general circulation using the cartridge were \
		Sakhno-pattern bolt-action rifles; declaring such a platform as standard-issue would have been both political and martial suicide. \
		Thus, calls went out to design a new, modern rifle to utilize the powerful caseless cartridge. \
		Szot Dynamica took the opportunity to redesign and upscale a prototype to meet the \
		proposed requirements, while also opening the door towards the development of the Miecz. \
		The reworked rifle met the specifications and won the contracts it was built for, and the rest is history."

/obj/item/gun/ballistic/automatic/lanca/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/lanca/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/lanca/no_mag
	spawnwithmagazine = FALSE

// The AMR
// This sounds a lot scarier than it actually is, you'll just have to trust me here

/obj/item/gun/ballistic/automatic/wylom
	name = "\improper Wyłom Anti-Materiel Rifle"
	desc = "A massive, outdated beast of an anti materiel rifle supposedly designed for 'fauna control.' Fires the devastating .60 Strela caseless round, \
		the massively overperforming penetration of which being the reason this weapon was eventually restricted from galactic trade."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_64.dmi'
	base_pixel_x = -16 // This baby is 64 pixels wide
	pixel_x = -16
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/inhands_64_left.dmi'
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/inhands_64_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	icon_state = "wylom"
	inhand_icon_state = "wylom"
	worn_icon_state = "wylom"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/wylom
	can_suppress = FALSE

	fire_sound = 'modular_nova/modules/novaya_ert/sound/amr_fire.ogg'
	fire_sound_volume = 100 // BOOM BABY

	recoil = 4

	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	fire_delay = 2 SECONDS
	actions_types = list()

	force = 15 // I mean if you're gonna beat someone with the thing you might as well get damage appropriate for how big the fukken thing is

	lore_blurb = "The Wyłom anti-materiel rifle is a temperamental, cumbersome beast of a gun, not originally made for unaided human hands.<br>\
		<br>\
		The earliest iterations had mounting points for a specialized suit attachment system, \
		but that quickly fell through once initial rollouts were planned, which became a major point of contention for those \
		assigned with the unenviable tasks of lugging it around and bringing it on-target. \
		This spurred on a great deal of smekalka, or improvisation, among the ranks of its carriers, \
		and led to novel ways of carrying it around that typically lasted up until the Wyłom was actually fired, falling apart moments after. \
		Enough complaints occurred about this that a standardized, extra-heavy-duty sling started being issued with it, only \
		slightly mitigating complaints about its bulk. \
		A strong contender for the definition of \"anti-armor\", \
		an equally strong argument exists to consider it closer to \"anti-anything\".<br>\
		<br>\
		A laser-etched warning label warns users of the weapon to be wary of side-blast from the muzzle brake, \
		and to not fire unsupported if one is not of appropriate mass to \"wrestle\" the recoil."

/obj/item/gun/ballistic/automatic/wylom/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 0.5)

/obj/item/gun/ballistic/automatic/wylom/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gun_launches_little_guys, throwing_force = 3, throwing_range = 5)
