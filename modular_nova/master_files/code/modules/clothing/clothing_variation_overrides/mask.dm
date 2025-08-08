/*
 * /obj/item/clothing/mask defaults to:
 * supports_variations_flags = CLOTHING_SNOUTED_VARIATION | CLOTHING_SNOUTED_VOX_VARIATION
 */

/**
 * NO NEW ICON
 * Clothing that do not require a new icon to function correctly.
 * Masks that don't actually cover the snout, or large masks that already cover it by default
 */

/obj/item/clothing/mask/fakemoustache
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_inv = NONE //Moustache no longer marks you as Unknown

/obj/item/clothing/mask/gas/tiki_mask
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/mask/changeling
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/knife
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/food/grown/wheat
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/mask/kitsune
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/**
 * NONE(Squash)
 * Clothing that does not have species or snout variation, and doesn't quite cover the snout either.
 * Instead, it will 'squash' the face, hiding the snout.
 */

/obj/item/clothing/mask/gas/monkeymask
	supports_variations_flags = NONE

/obj/item/clothing/mask/gondola
	supports_variations_flags = NONE

/obj/item/clothing/mask/gas/owl_mask
	supports_variations_flags = NONE

/obj/item/clothing/mask/gas/carp
	supports_variations_flags = NONE

/obj/item/clothing/mask/animal
	supports_variations_flags = NONE

/obj/item/clothing/head/bio_hood/plague
	supports_variations_flags = NONE

/obj/item/clothing/mask/scarecrow
	supports_variations_flags = NONE

/**
 * INVENTORY/VISOR FLAGS
 * While not strictly a variation override, this applies to showing mutant ears or snouts.
 */

/obj/item/clothing/mask/gas
	//All gas masks show ears
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gas/explorer // HIDESNOUT is in visor toggle now
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/luchador // No longer has HIDESNOUT, has SHOWSPRITEEARS
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|SHOWSPRITEEARS

/obj/item/clothing/mask/balaclava // Now has SHOWSPRITEEARS
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|SHOWSPRITEEARS
