//Armor Datums

/datum/armor/armor_forging_hard
	melee = 40
	bullet = 30
	energy = 10
	bomb = 40
	fire = 50
	acid = 20
	wound = 20

/datum/armor/armor_forging_medium
	melee = 30
	bullet = 20
	laser = 10
	energy = 20
	bomb = 70
	fire = 50
	acid = 40
	wound = 20

/datum/armor/armor_forging_light
	melee = 25
	bullet = 15
	laser = 15
	energy = 15
	bomb = 35
	bio = 20
	acid = 20
	wound = 15

/datum/armor/armor_forging_upgrade
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	wound = 5
	bomb = 5

// Vests
/obj/item/clothing/suit/armor/forging_plate_armor
	name = "plate vest"
	desc = "An armor vest made of hammered, interlocking plates."
	icon = 'modular_nova/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_vest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	obj_flags_nova = ANVIL_REPAIR
	body_parts_covered = GROIN|CHEST
	armor_type = /datum/armor/armor_forging_hard
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/clothing/suit/armor/forging_plate_armor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, armor_mod = /datum/armor/armor_forging_upgrade)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_OCLOTHING)
	AddElement(/datum/element/adjust_fishing_difficulty, 4)

	allowed += /obj/item/forging/reagent_weapon
	allowed += /obj/item/kinetic_crusher

/obj/item/clothing/suit/armor/forging_chain_shirt
	name = "chain mail"
	desc = "An armor made by weaved chain links, allowing blows to be evenly distributed."
	icon_state = "chained_leather_armor"
	icon = 'modular_nova/modules/primitive_catgirls/icons/objects.dmi'
	worn_icon = 'modular_nova/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	obj_flags_nova = ANVIL_REPAIR
	body_parts_covered = GROIN|CHEST
	armor_type = /datum/armor/armor_forging_medium
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/clothing/suit/armor/forging_chain_shirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, armor_mod = /datum/armor/armor_forging_upgrade)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_OCLOTHING)

	allowed += /obj/item/forging/reagent_weapon
	allowed += /obj/item/kinetic_crusher

// Gloves
/obj/item/clothing/gloves/forging_plate_gloves
	name = "plate gloves"
	desc = "A set of leather gloves with protective armor plates connected to the wrists."
	icon = 'modular_nova/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_gloves"
	resistance_flags = FIRE_PROOF
	obj_flags_nova = ANVIL_REPAIR
	armor_type = /datum/armor/armor_forging_light
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	body_parts_covered = HANDS|ARMS

/obj/item/clothing/gloves/forging_plate_gloves/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 1, armor_mod = /datum/armor/armor_forging_upgrade)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_GLOVES)
	AddElement(/datum/element/adjust_fishing_difficulty, 4)

// Helmets
/obj/item/clothing/head/helmet/forging_plate_helmet
	name = "plate helmet"
	desc = "A helmet out of hammered plates with a leather neck guard and chin strap."
	icon = 'modular_nova/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_helmet"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	flags_inv = null
	obj_flags_nova = ANVIL_REPAIR
	armor_type = /datum/armor/armor_forging_medium
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/clothing/head/helmet/forging_plate_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, armor_mod = /datum/armor/armor_forging_upgrade)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_HEAD)

// Boots
/obj/item/clothing/shoes/forging_plate_boots
	name = "plate boots"
	desc = "A pair of leather boots with protective armor plates over the shins and toes."
	icon = 'modular_nova/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_digi = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_digi.dmi'
	worn_icon_better_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_nova/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_boots"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	armor_type = /datum/armor/armor_forging_light
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	obj_flags_nova = ANVIL_REPAIR
	fastening_type = SHOES_SLIPON
	body_parts_covered = FEET|LEGS

/obj/item/clothing/shoes/forging_plate_boots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 1, armor_mod = /datum/armor/armor_forging_upgrade)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_FEET)
	AddElement(/datum/element/adjust_fishing_difficulty, 2)

// Misc
/obj/item/clothing/gloves/ring/reagent_clothing
	name = "ring"
	desc = "A tiny ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	worn_icon_state = "sring"
	inhand_icon_state = "ringsilver"
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	obj_flags_nova = ANVIL_REPAIR

/obj/item/clothing/gloves/ring/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_GLOVES)
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/neck/collar/reagent_clothing
	name = "collar"
	desc = "A collar that is ready to be worn for certain individuals."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "thick_strip"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	post_init_icon_state = null
	inhand_icon_state = null
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	obj_flags_nova = ANVIL_REPAIR

/obj/item/clothing/neck/collar/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_NECK)

/obj/item/restraints/handcuffs/reagent_clothing
	name = "handcuffs"
	desc = "A pair of handcuffs that are ready to keep someone captive."
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	obj_flags_nova = ANVIL_REPAIR

/obj/item/restraints/handcuffs/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_HANDCUFFED)
