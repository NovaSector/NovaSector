//Maid Outfit

/obj/item/clothing/head/costume/maidheadband/syndicate/loadout_headband
	name = "tactical maid headband"
	desc = "Tacticute."
	icon_state = "syndimaid_headband"
	icon = 'modular_nova/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/costume.dmi'

/obj/item/clothing/gloves/tactical_maid
	name = "tactical maid sleeves"
	desc = "These 'tactical' gloves and heavy and warm."
	icon = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "syndimaid_arms"

/obj/item/clothing/under/syndicate/nova/maid/loadout_maid
	name = "tactical maid outfit"
	desc = "A 'tactical' skirtleneck fashioned to the likeness of a maid outfit"
	has_sensor = HAS_SENSORS
	icon_state = "syndimaid"
	armor_type = /datum/armor/clothing_under/none
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/nova/maid/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/maidcorset/syndicate/A = new (src)
	attach_accessory(A)

/obj/item/clothing/accessory/maidcorset/syndicate/loadout_corset
	name = "syndicate maid apron"
	desc = "Practical? No. Tactical? Also no. Cute? Most definitely yes."
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "syndimaid_corset"
	minimize_when_attached = FALSE
	attachment_slot = NONE
