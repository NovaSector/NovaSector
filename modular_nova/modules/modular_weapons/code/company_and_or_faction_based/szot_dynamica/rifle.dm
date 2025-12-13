// Rapid firing scary military grade weapon firing .27-54 Cesarzowa

/obj/item/gun/ballistic/automatic/miecz
	name = "\improper M/CR-9 'Miecz' Support Weapon"
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

	lore_blurb = "The M/CR-9 is a relic of a bygone era, a time when \"advanced ballistics\" was not a contradiction in terms. \
		Before the widespread adoption of plasma pulse weaponry, the Coalition's answer to close-quarters firepower was the Miecz, a weapon that \
		straddles the line between submachine gun and compact rifle. <br><br> \
		Chambered for the purpose-built .27-54 Cesarzowa caseless cartridge, the Miecz was engineered for reliability above all else. \
		Its operating system is a sealed, short-stroke piston that can cycle everything from high-purity military propellant to re-pressed frontier \
		smokeless powder caked with lubricant and dust. This legendary tolerance for abuse is why, despite being officially replaced by the M/PR-15 \
		in frontline service, it remains ubiquitous on the frontier, in colonial militias, and in the hands of security contractors who can't always \
		guarantee a supply of pristine plasma cells. <br><br> \
		Its design philosophy is brutally simple: basic, high-visibility glow-sights for fast target acquisition in dimly-lit corridors; \
		a heavy barrel that refuses to warp during sustained fire; and a robust polymer construction that feels less like a precision instrument and \
		more like a breaker bar. It lacks the sleek, intimidating lines of modern plasma weapons, a fact its users appreciate — it's a tool, \
		first and foremost. The hard-tip .27-54 round was specifically designed to defeat the early generations of personal armor that were becoming common \
		during its development, a trait that remains effective against modern soft armor."

/obj/item/gun/ballistic/automatic/miecz/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/miecz/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/miecz/no_mag
	spawnwithmagazine = FALSE

// Semi-automatic rifle firing .310 with reduced firerate compared to a Sakhno

/obj/item/gun/ballistic/automatic/lanca
	name = "\improper M/BR-8 'Lanca' Battle Rifle"
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

	lore_blurb = "If the Miecz is a trusted old knife, the Lanca is a weathered spear. It represents the pinnacle of caseless, powder-based rifle technology, \
		a platform so effective it delayed the adoption of plasma rifles for nearly a decade. Chambered for the powerful .310 Strilka cartridge, \
		the Lanca was the Coalition's first attempt at a unified infantry weapon system, developed in tandem with the smaller Miecz. <br><br>\
		The BR-8's bullpup layout was revolutionary for its time, concentrating mass for superior handling and allowing for a long barrel in \
		a relatively compact package. Its integrated magnified optic was a luxury for a standard-issue weapon, turning every soldier into a \
		potential marksman. The .310 Strilka's caseless design eliminated extraction and ejection failures, while its sheer power could defeat \
		cover and body armor that would shrug off smaller rounds. <br><br>\
		The irony is that the Lanca was <b>too</b> successful. Its logistical footprint, -the weight of the dense .310 rounds, the \
		specialized presses needed to manufacture them-, became its greatest weakness in the face of the plasma pulse revolution. \
		Why ship ten kilograms of brass and propellant when you can ship one kilogram of plasma cells with equivalent firepower? <br><br>\
		Now, the Lanca is a weapon of specialists and traditionalists. It's found in the hands of long-range patrol units operating \
		in high-electronic-warfare environments where plasma projectiles can be magnetically dispersed, or among veteran sergeants who \
		trust the tangible 'thump' of a .310 round downrange over the mechanical slam and silent flash of plasma. It's an old, heavy, \
		demanding weapon, but in the right hands, it is utterly decisive."

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
	name = "\improper M/AMR-1 'Wyłom' Anti-Materiel Rifle"
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

	lore_blurb = "Some problems cannot be solved with technology. The Wyłom is the living proof. This colossal anti-materiel rifle, \
		chambered for the devastating .60 Strela, is a holdover from an age of brute-force ballistics, and it remains in service for one \
		simple reason: nothing in the plasma arsenal can replicate the sheer kinetic obliteration of its projectile. <br><br>\
		The AMR-1 was originally designed as a \"fauna control\" weapon for frontier worlds, a euphemism for engaging targets \
		that were effectively living battle tanks. Its .60 Strela caseless round is less a bullet and more a self-contained \
		artillery shell, a monolithic slug of tungsten and high-explosive propellant designed to punch through a meter of \
		reinforced concrete or the frontal glacis of a light armored vehicle. The over-penetration is so extreme that the \
		weapon was eventually restricted from galactic trade, as the rounds would pass through most civilian-grade \
		starship hulls with ease. <br><br>\
		Early models required a dedicated crew or a powered armor frame to transport and fire. The current \"lightweight\" model, \
		a relative term for a 15-kilogram weapon, is issued with a massively reinforced sling and a warning to users of \"appropriate mass\" \
		to handle the recoil. The side-blast from its gargantuan muzzle brake is a lethal hazard in its own right. <br><br>\
		While plasma weapons excel at killing personnel and disabling systems, the Wyłom is for when you need to delete the target \
		and a significant portion of the geometry behind it. It is the Coalition's argument that for pure, unsubtle anti-'anything' \
		work, sometimes you just need to throw a very large piece of metal, very, very fast. It is the one ballistic weapon system \
		the logistics corps has never seriously attempted to replace."

/obj/item/gun/ballistic/automatic/wylom/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 0.5)

/obj/item/gun/ballistic/automatic/wylom/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gun_launches_little_guys, throwing_force = 3, throwing_range = 5)
