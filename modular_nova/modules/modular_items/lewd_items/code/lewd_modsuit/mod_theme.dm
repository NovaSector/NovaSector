#define LUSTWISH_HELMET_SEAL "slides closed"
#define LUSTWISH_HELMET_UNSEAL "slides open"
#define LUSTWISH_CHESTPLATE_SEAL "squeezes snugly around your body"
#define LUSTWISH_CHESTPLATE_UNSEAL "spontaneously loosens"
#define LUSTWISH_GAUNTLET_SEAL "clenches between each finger"
#define LUSTWISH_GAUNTLET_UNSEAL "relaxes from your hand"
#define LUSTWISH_BOOT_SEAL "squeezes tightly around your ankles"
#define LUSTWISH_BOOT_UNSEAL "gives room to your feet"

/// Hardlight color for lustwish modsuit
#define ROYAL_PURPLE "royal_purple"

//// Sprites done by Toriate - Commissioned by The Sharkenning
/datum/mod_theme/lustwish
	name = "lustwish"
	desc = "A specialty designed lustwish themed modsuit which is based entirely off of earlier civilian modsuits."
	default_skin = "lustwish"
	hardlight_theme = ROYAL_PURPLE
	ui_theme = "ntos_darkmode"
	variants = list(
		"lustwish" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_modsuit/mod_lustwish.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_modsuit/mod_lustwish.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = LUSTWISH_HELMET_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_HELMET_SEAL,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = LUSTWISH_CHESTPLATE_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_CHESTPLATE_SEAL,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = LUSTWISH_GAUNTLET_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_GAUNTLET_SEAL,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = LUSTWISH_BOOT_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_BOOT_SEAL,
			),
		),
	)

#undef LUSTWISH_HELMET_SEAL
#undef LUSTWISH_HELMET_UNSEAL
#undef LUSTWISH_CHESTPLATE_SEAL
#undef LUSTWISH_CHESTPLATE_UNSEAL
#undef LUSTWISH_GAUNTLET_SEAL
#undef LUSTWISH_GAUNTLET_UNSEAL
#undef LUSTWISH_BOOT_SEAL
#undef LUSTWISH_BOOT_UNSEAL
#undef ROYAL_PURPLE

