/obj/item/mod/control/pre_equipped/blueshield/bruce
	applied_cell = /obj/item/stock_parts/power_store/cell/high/slime_hypercharged
	applied_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/hat_stabilizer,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/quick_cuff,
	)

/datum/mod_theme/blueshield/bruce
	name = "Bruce's Modsuit"
	desc = "A blueshields blueshield modsuit."
	extended_desc = "A prototype of a prototype made to fit a person who has no right to be wearing a modsuit in the first place. \
		This modsuit has been reinforced many times over and would be a burden to most."

	default_skin = "praetorian"
	armor_type = /datum/armor/mod_theme_apocryphal
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	slowdown_deployed = 0
	allowed_suit_storage = list(
		/obj/item/gun/ballistic/automatic/sniper_rifle/lahti
	)
