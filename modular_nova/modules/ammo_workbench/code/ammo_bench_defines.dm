/*
We assume ammo benches are innately capable of printing nonlethals,
and that these categories apply for both the ammunition and the categories
unlocked in the ammo bench.
*/

/// This bitflag is for "basic" lethals, with nothing particularly fancy under the hood.
#define AMMO_CATEGORY_LETHAL 	(1<<0)
/// This bitflag is for "plus" ammo, which covers both hollow-point and armor-piercing.
#define AMMO_CATEGORY_PLUS		(1<<1)
/// This bitflag is for niche ammo, which have some gimmick attached to them, e.g. match ammo bouncing, incendiaries setting people on fire, etc.
#define AMMO_CATEGORY_NICHE		(1<<2)
/// This bitflag is for "super" ammo, which performs better than more conventional ammo, somehow, e.g. mil-spec shells.
#define AMMO_CATEGORY_SUPER		(1<<3)
/// This bitflag is for esoteric ammo, e.g. phasic, homing. Mainly as a supplementary bitflag.
#define AMMO_CATEGORY_ESOTERIC	(1<<4)

/// This ammo is nonlethal, less-lethal, or otherwise unremarkable in regards to turning men into corpses.
#define AMMO_CLASS_NONE			0
/// This ammo is nonlethal, less-lethal, or otherwise unremarkable in regards to turning men into corpses, but has some niche applications.
#define AMMO_CLASS_NICHE_LTL	(AMMO_CATEGORY_NICHE)

// --- Separator between less lethal classes above and lethal classes below. ---

/// This ammo is lethal, but otherwise unremarkable in regards to turning men into corpses.
#define AMMO_CLASS_LETHAL		(AMMO_CATEGORY_LETHAL)
/// This ammo is lethal, and is either hollow-point (more damage, weak to armor) or armor-piercing (less damage, ignores some armor).
#define AMMO_CLASS_PLUS			(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_PLUS)
/// This ammo is lethal, and has some weird and/or gimmicky niche.
#define AMMO_CLASS_NICHE		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE)
/// This ammo is lethal, and meant to perform better than conventional ammunition.
#define AMMO_CLASS_SUPER		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_SUPER)
/// This ammo is lethal, and is weird in some way, shape, or form. This should probably be combined with another ammo class.
#define AMMO_CLASS_ESOTERIC		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_ESOTERIC)

/// Define for *all* ammo categories.
#define AMMO_ALL_TYPES	(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_PLUS | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SUPER | AMMO_CATEGORY_ESOTERIC)

DEFINE_BITFIELD(ammo_categories, list(
	"LETHAL" = AMMO_CATEGORY_LETHAL,
	"PLUS" = AMMO_CATEGORY_PLUS,
	"NICHE" = AMMO_CATEGORY_NICHE,
	"SUPER" = AMMO_CATEGORY_SUPER,
	"ESOTERIC" = AMMO_CATEGORY_ESOTERIC,
))
