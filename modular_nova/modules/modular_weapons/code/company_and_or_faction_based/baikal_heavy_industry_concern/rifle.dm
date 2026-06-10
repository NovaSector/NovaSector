// Hyperburst firing military grade battle rifle firing .310 Strilka

/obj/item/gun/ballistic/automatic/sokol
	name = "\improper M/BR-7 'Sokol' Battle Rifle"
	desc = "A bullpup hyperburst battle rifle chambered in the .310 Strilka caseless cartridge equipped with a 1-2x variable magnification scope. \
		Due to the high caliber of the weapon and the necessity for quick cycling and follow up shots, an overcomplicated hyperburst mechanism is employed. \
		This mechanism greatly decreases the power of the fired rounds due to re-utilizing the gas produced by ignition to cycle the action extremely quick."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/baikal_heavy_industry_concern/guns_48.dmi'
	icon_state = "miecz"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	inhand_icon_state = "lanca"

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

	accepted_magazine_type = /obj/item/ammo_box/magazine/sokol

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 2
	fire_delay = 1.25 SECONDS
	actions_types = list()
	spread = 5

	projectile_damage_multiplier = 0.65

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

/obj/item/gun/ballistic/automatic/sokol/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/fire_delay)

/obj/item/gun/ballistic/automatic/sokol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BAIKAL)

/obj/item/gun/ballistic/automatic/sokol/no_mag
	spawnwithmagazine = FALSE
