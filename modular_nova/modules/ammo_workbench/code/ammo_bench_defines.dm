/*
We assume ammo benches are innately capable of printing nonlethals,
and that these categories apply for both the ammunition and the categories
unlocked in the ammo bench.
*/

/// This bitflag is for "basic" lethals, with nothing particularly fancy under the hood.
#define AMMO_CATEGORY_LETHAL 	(1<<0)
/// This bitflag is for "unarmored" ammo, which are assumed to be good against unarmored or simpler targets,
/// e.g. hollow-points, DumDum rounds, hunting ammo.
#define AMMO_CATEGORY_HOLLOW 	(1<<1)
/// This bitflag is for armor-piercing ammo, which are assumed to deal less damage but penetrate through armor.
#define AMMO_CATEGORY_ARMORPEN	(1<<2)
/// This bitflag is for "super" ammo, which are like their standard variant but better, somehow, e.g. mil-spec shells.
/// Welcome back, Metro-style military ammo as currency?
#define AMMO_CATEGORY_SUPER		(1<<3)
/// This bitflag is for niche ammo, which have some gimmick attached to them, e.g. match ammo bouncing to all hell.
#define AMMO_CATEGORY_NICHE		(1<<4)
/// This bitflag is for thermal ammo, which usually relates to adjusting the temperature of their targets, either hot or cold.
/// Usually, it's hot. Generally, you do this through setting targets on fire.
#define AMMO_CATEGORY_THERMAL	(1<<5)
/// This bitflag is for "smart" lethals with some integrated electronic something-or-others, e.g. tracking ammo (.38 TRAC), nanite shock-y ammo (12g Stardust?).
#define AMMO_CATEGORY_SMART		(1<<6)
/// This bitflag is for esoteric ammo, e.g. phasic, homing. Mainly as a supplementary bitflag.
#define AMMO_CATEGORY_ESOTERIC	(1<<7)

/// This ammo is nonlethal, less-lethal, or otherwise unremarkable in regards to turning men into corpses.
#define AMMO_CLASS_NONE			0
/// This ammo is nonlethal, less-lethal, or otherwise unremarkable in regards to turning men into corpses, but has some niche applications.
#define AMMO_CLASS_NICHE_LTL	(AMMO_CATEGORY_NICHE)

/// This ammo is lethal, but otherwise unremarkable in regards to turning men into corpses.
#define AMMO_CLASS_LETHAL		(AMMO_CATEGORY_LETHAL)
/// This ammo is lethal, and meant for use against unarmored or simplemob targets.
#define AMMO_CLASS_HOLLOW		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW)
/// This ammo is lethal, and meant for use against armored targets.
#define AMMO_CLASS_ARMORPEN		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_ARMORPEN)
/// This ammo is lethal, and meant to perform better than conventional ammunition.
#define AMMO_CLASS_SUPER		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_SUPER)
/// This ammo is lethal, and has some weird and/or gimmicky niche.
#define AMMO_CLASS_NICHE		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE)
/// This ammo is lethal, and generally relates to adjusting a target's temperature. By force. At time of writing, it's usually setting them on fire.
#define AMMO_CLASS_THERMAL		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_THERMAL)
/// This ammo is lethal, and has some vaguely electronic bits involved with it, such as tracking implantation.
#define AMMO_CLASS_SMART		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_SMART)
/// This ammo is lethal, and has a weird and/or gimmicky niche, and also has some electronic bits.
#define AMMO_CLASS_NICHE_SMART	(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART)
/// This ammo is lethal, and has something strange going on with it. Probably append extra types to it, 'cause esoteric ammo is capital W Weird.
#define AMMO_CLASS_ESOTERIC		(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_ESOTERIC)

/// Define for *all* ammo categories.
#define AMMO_ALL_TYPES	(AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW | AMMO_CATEGORY_ARMORPEN | AMMO_CATEGORY_SUPER | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART | AMMO_CATEGORY_ESOTERIC)

DEFINE_BITFIELD(ammo_categories, list(
	"LETHAL" = AMMO_CATEGORY_LETHAL,
	"HOLLOW" = AMMO_CATEGORY_HOLLOW,
	"ARMORPEN" = AMMO_CATEGORY_ARMORPEN,
	"SUPER" = AMMO_CATEGORY_SUPER,
	"NICHE" = AMMO_CATEGORY_NICHE,
	"SMART" = AMMO_CATEGORY_SMART,
	"ESOTERIC" = AMMO_CATEGORY_ESOTERIC,
))
