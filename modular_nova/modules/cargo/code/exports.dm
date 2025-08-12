#define MATERIAL_EXPORT_MODIFIER 0.25
#define PREMIUM_MATERIAL_EXPORT_MODIFIER 0.5
#define SATURATED_MATERIAL_EXPORT_MODIFIER 0.1
#define SATURATED_ALLOY_EXPORT_MODIFIER 0.13

/datum/export/material/market
	k_recovery_elasticity = 1/45 //roughly 30 minutes of recovery

/datum/export/stack
	k_recovery_elasticity = 1/45 //roughly 30 minutes of recovery

/datum/export/stack/plasteel
	cost = CARGO_CRATE_VALUE * 0.41 * MATERIAL_EXPORT_MODIFIER // CCV*0.41 is tg original

/datum/export/stack/plastitanium
	cost = CARGO_CRATE_VALUE * 0.65 * MATERIAL_EXPORT_MODIFIER // CCV*0.65 is tg original

/datum/export/stack/abductor
	cost = CARGO_CRATE_VALUE * 2 * MATERIAL_EXPORT_MODIFIER // CCV*2 is tg original

/datum/export/material/plasma
	cost = CARGO_CRATE_VALUE * 0.4 * MATERIAL_EXPORT_MODIFIER // CCV*0.4 is tg original
	k_elasticity = 1/30 //default elasticity value for stuff.

/datum/export/material/market/diamond
	cost = SATURATED_MATERIAL_EXPORT_MODIFIER

/datum/export/material/market/uranium
	cost = MATERIAL_EXPORT_MODIFIER

/datum/export/material/market/gold
	cost = PREMIUM_MATERIAL_EXPORT_MODIFIER

/datum/export/material/market/silver
	cost = PREMIUM_MATERIAL_EXPORT_MODIFIER

/datum/export/material/market/titanium
	cost = MATERIAL_EXPORT_MODIFIER

/datum/export/material/market/bscrystal
	cost = SATURATED_ALLOY_EXPORT_MODIFIER

#undef MATERIAL_EXPORT_MODIFIER
#undef PREMIUM_MATERIAL_EXPORT_MODIFIER
#undef SATURATED_MATERIAL_EXPORT_MODIFIER
#undef SATURATED_ALLOY_EXPORT_MODIFIER
