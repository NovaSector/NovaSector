/// Interdyne Pharmaceuticals — Tactical Maid Outfit (green variant)

/obj/item/clothing/under/costume/maid/interdyne
	name = "Interdyne tactical maid outfit"
	desc = "A 'tactical' skirtleneck fashioned to the likeness of a maid outfit, in Interdyne Pharmaceuticals' signature green."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing.dmi'
	worn_icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing_worn.dmi'
	icon_state = "interdyne_maid"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	has_sensor = HAS_SENSORS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/maid/interdyne/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/maidcorset/interdyne/apron = new(src)
	attach_accessory(apron)

/obj/item/clothing/head/costume/maid_headband/interdyne
	name = "Interdyne tactical maid headband"
	desc = "Tacticute. Now in Interdyne green."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing.dmi'
	worn_icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing_worn.dmi'
	icon_state = "interdyne_maid_headband"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/gloves/interdyne_maid
	name = "Interdyne tactical maid sleeves"
	desc = "These 'tactical' gloves and sleeves are warm and cozy. In Interdyne green."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing.dmi'
	worn_icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing_worn.dmi'
	icon_state = "interdyne_maid_arms"

/obj/item/clothing/accessory/maidcorset/interdyne
	name = "Interdyne maid apron"
	desc = "Practical? No. Tactical? Also no. Cute? Most definitely yes. Green? Absolutely."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing.dmi'
	worn_icon = 'modular_nova/modules/interdyne/icons/interdyne_clothing_worn.dmi'
	icon_state = "interdyne_maid_corset"
	minimize_when_attached = FALSE
	attachment_slot = NONE
