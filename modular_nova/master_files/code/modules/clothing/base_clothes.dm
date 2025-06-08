// Mutant variants needs to be a property of all items, because all items can be equipped, despite the mob code only expecting clothing items (ugh)
/obj/item
	/// Icon file for mob worn overlays, if the user is digi.
	var/icon/worn_icon_digi
	/// The config type to use for greyscaled worn sprites for digitigrade characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_digi
	/// Icon file for mob worn overlays, for characters with a muzzle sprite accessory.
	var/icon/worn_icon_muzzled
	/// The config type to use for greyscaled worn sprites for characters with a muzzle sprite accessory. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_muzzled

	// Monkey

	/// Icon file for mob worn overlays, if the user is a monkey.
	var/icon/worn_icon_monkey
	/// The config type to use for greyscale worn sprites for monkeys. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_monkey

	// Teshari

	/// Icon file for mob worn overlays, if the user is a teshari.
	var/icon/worn_icon_teshari
	/// The config type to use for greyscaled worn sprites for Teshari characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_teshari

	// Vox

	/// Icon file for mob worn overlays, if the user is a vox.
	var/icon/worn_icon_vox
	/// Icon file for mob worn overlays, if the user is a better vox.
	var/icon/worn_icon_better_vox
	/// The config type to use for greyscaled worn sprites for vox characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_vox
	/// The config type to use for greyscaled worn sprites for vox primalis characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_better_vox

	// Taurs

	/// Icon file for mob worn overlays, for characters with a snake taur sprite accessory.
	var/icon/worn_icon_taur_snake
	/// Icon file for mob worn overlays, for characters with a paw'd taur sprite accessory.
	var/icon/worn_icon_taur_paw
	/// Icon file for mob worn overlays, for characters with a hoof'd taur sprite accessory.
	var/icon/worn_icon_taur_hoof
	///  The config type to use for greyscaled worn sprites for characters using taur snake sprite accessory. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_taur_snake
	///  The config type to use for greyscaled worn sprites for characters using taur paws sprite accessory. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_taur_paw
	///  The config type to use for greyscaled worn sprites for characters using taur hoofs sprite accessory. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_taur_hoof

	/// Used for BODYSHAPE_CUSTOM: Needs to follow this syntax: a list() with the x and y coordinates of the pixel you want to get the color from. Colors are filled in as GAGs values for fallback.
	var/list/species_clothing_color_coords[3]

/obj/item/clothing/head
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/mask
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION | CLOTHING_SNOUTED_VOX_VARIATION

/obj/item/clothing/glasses
	supports_variations_flags = CLOTHING_SNOUTED_VOX_VARIATION

/obj/item/clothing/under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/changeling
	supports_variations_flags = NONE


