/obj/item
	var/datum/greyscale_config/greyscale_config_worn_nabber_fallback
	var/icon/worn_icon_nabber

/datum/species/nabber/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_nabber

/datum/species/nabber/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_nabber = icon

/datum/species/nabber/get_custom_worn_config_fallback(item_slot, obj/item/item)
	return item.greyscale_config_worn_nabber_fallback

/datum/species/nabber/generate_custom_worn_icon(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	. = ..()
	if(.)
		return

	. = generate_custom_worn_icon_fallback(item_slot, item, human_owner)
	if(.)
		return

/obj/item/clothing/under
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber
	worn_icon_nabber = 'modular_iris/monke_ports/gas/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/neck
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/scarf

/obj/item/clothing/neck/cloak
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/cloak

/obj/item/clothing/neck/tie
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/tie

/obj/item/clothing/gloves
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/gloves

/obj/item/clothing/belt
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/belt

/*
/obj/item/clothing/mask // I can only forsee this going well
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/mask

/obj/item/clothing/mask/gas //because we have to subtype... every single time.
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/mask

*/

/obj/item/clothing/glasses
	greyscale_config_worn_nabber_fallback = /datum/greyscale_config/nabber/glasses
	worn_icon_nabber = 'modular_iris/monke_ports/gas/icons/mob/clothing/glasses.dmi'

/**
 * Nabber fallbacks.
 * In case what we have another species with specials Json config file. We use this for our case.
 * Check teshari fasllbacks .json config files for more datails.
 */

/datum/greyscale_config/nabber
	name = "Nabber clothing"
	icon_file = 'modular_iris/modules/GAGS/icons/nabbers/nabber_fallbacks.dmi'
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/uniform.json'

/datum/greyscale_config/nabber/under
	name = "Nabber Suit"
	icon_file = 'modular_iris/monke_ports/gas/icons/mob/clothing/uniform.dmi'
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/uniform.json'

/datum/greyscale_config/nabber/cloak
	name = "Nabber Poncho"
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/neck.json'

/datum/greyscale_config/nabber/tie
	name = "Nabber Tie"
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/neck.json'

/datum/greyscale_config/nabber/scarf
	name = "Nabber Scarf"
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/neck.json'

/datum/greyscale_config/nabber/gloves
	name = "Nabber Gloves"
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/gloves.json'

/datum/greyscale_config/nabber/belt
	name = "Nabber Belt"
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/belt.json'

/datum/greyscale_config/nabber/mask //yippie
	name = "Nabber Mask"
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/mask.json'

/datum/greyscale_config/nabber/glasses //yippie
	name = "Nabber Glasses"
	icon_file = 'modular_iris/monke_ports/gas/icons/mob/clothing/glasses.dmi'
	json_config = 'modular_iris/modules/GAGS/json_configs/nabber_fallbacks/glasses.json'
