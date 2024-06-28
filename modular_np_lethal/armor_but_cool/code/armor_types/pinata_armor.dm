/datum/armor/armor_lethal_pinata
	melee = ARMOR_LEVEL_MID + 25
	bullet = BULLET_ARMOR_II
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID + 25
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/head/helmet/lethal_pinata_helmet
	name = "'Banda-Completa' neural interface"
	desc = "A high-tech neural interface that is implanted directly to the user's head. \
		Once implanted, it cannot be taken off. Provides a full suite of sensing and HUD elements."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "pinata"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_pinata
	flags_inv = HIDEEARS|HIDEEYES
	flags_cover = HEADCOVERSEYES|PEPPERPROOF
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	max_integrity = 800
	limb_integrity = 0
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	flash_protect = FLASH_PROTECTION_FLASH
	clothing_traits = list(
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_REAGENT_SCANNER,
		TRAIT_MEDICAL_HUD,
	)

/obj/item/clothing/head/helmet/lethal_pinata_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_HEAD))
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/head/helmet/lethal_pinata_helmet/equipped(mob/living/carbon/human/user, slot)
	..()
	if(!(slot & ITEM_SLOT_HEAD))
		return
	for(var/hudtype in list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED))
		var/datum/atom_hud/atom_hud = GLOB.huds[hudtype]
		atom_hud.show_to(user)

/obj/item/clothing/head/helmet/lethal_pinata_helmet/dropped(mob/living/carbon/human/user)
	..()
	if(!istype(user) || user.head != src)
		return
	for(var/hudtype in list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED))
		var/datum/atom_hud/atom_hud = GLOB.huds[hudtype]
		atom_hud.hide_from(user)

/obj/item/clothing/head/helmet/lethal_pinata_helmet/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/head/helmet/lethal_pinata_helmet/examine_more(mob/user)
	. = ..()

	. += "A fully-integrated display piece that is a common sight among piñatas and \
		future piñatas. This is due to the fact that the headset is wired directly to the user's brain, \
		providing unmatched utility and unmatched psychosis risk. \
		This comes with a severe downside, however, as the headset cannot be removed once installed, \
		at least not without a lengthy and highly dangerous procedure that most gakster cannot afford. \
		It covers most of the head, and is armored \
		enough to make up for the fact that the headset is too bulky to wear alongside a regular helmet."

	return .

// CUSTOM LOADOUT PINATA ARMORS

/obj/item/clothing/head/helmet/lethal_pinata_helmet/candle
	name = "'Yamakari-Lain' wetware interface"
	desc = "A high-tech neural interface that is implanted directly to the user's head. \
		Once implanted, it cannot be taken off. Provides a full suite of sensing and HUD elements."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "pinata_candle"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
