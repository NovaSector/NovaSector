/datum/unit_test/digi_underclothes_sanity

/datum/unit_test/digi_underclothes_sanity/Run()
	// The icon files where digi underwear resides
	var/list/digi_underclothes_icon_files = list(
		'modular_nova/master_files/icons/mob/clothing/underwear.dmi' = TRUE,
	)

	// Checks whether we have a digi icon_state (denoted by "_d")
	for (var/datum/sprite_accessory/clothing/clothing_accessory as anything in valid_subtypesof(/datum/sprite_accessory/clothing))
		var/has_digi_sprite = FALSE
		if (digi_underclothes_icon_files[clothing_accessory::icon] && clothing_accessory::icon_state)
			var/digi_icon_state = "[clothing_accessory::icon_state]_d"
			has_digi_sprite = icon_exists(clothing_accessory::icon, digi_icon_state)

		if (has_digi_sprite && !clothing_accessory::has_custom_digi_sprite)
			TEST_FAIL("[clothing_accessory] ([clothing_accessory::icon_state]) has a '_d' version of the sprite but has_custom_digi_sprite = FALSE (should be TRUE)")

		else if (!has_digi_sprite && clothing_accessory::has_custom_digi_sprite)
			TEST_FAIL("[clothing_accessory] ([clothing_accessory::icon_state]) has_custom_digi_sprite = TRUE but no '_d' version of the sprite exists (should be FALSE)")
