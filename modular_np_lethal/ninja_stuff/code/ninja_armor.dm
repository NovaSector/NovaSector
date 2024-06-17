//genin are on a similar power band as gaksters, but they trade a few values around.
//the kudagitsune are support fighters that get weak (tier ii-ish) but feature rich armor that allows them to move quicker than similarly armored gaksters.
/datum/armor/armor_lethal_kudagitsune
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_II
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

//the baku are frontline combatants that get mid tier gakster armor (tier iii-ish). they also get slightly less slowdown than similarly armored gaksters in return for using melee
/datum/armor/armor_lethal_baku
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_III
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/head/helmet/lethal_filtre_helmet/kitsune
	name = "'Ninko' helmet system"
	desc = "A complex helmet system that sacrifices some armor plating for a suite of sensors and signal amplifiers \
	that serve to augment the wearer's situational awareness, sensory capacity, and situational effectiveness."
	icon = 'modular_np_lethal/ninja_stuff/icons/armor.dmi'
	icon_state = "genin_helmet_ninko"
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_kudagitsune
	max_integrity = 400
	limb_integrity = 400
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF
	clothing_traits = list(
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_REAGENT_SCANNER,
		TRAIT_MEDICAL_HUD,
	)

/*/obj/item/clothing/head/helmet/lethal_filtre_helmet/oni
	name = "'Baku' helmet system"
	desc = "A complex helmet system that sacrifices some armor plating for a suite of sensors and signal amplifiers \
	that serve to augment the wearer's situational awareness, sensory capacity, and situational effectiveness."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "filtre_helmet_meowers"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_kudagitsune
	max_integrity = 400
	limb_integrity = 400
	flags_inv = HIDEEARS|HIDEEYES
	flags_cover = HEADCOVERSEYES|PEPPERPROOF

/obj/item/clothing/head/helmet/lethal_kudagitsune_helmet/equipped(mob/living/user, slot, current_mode)
	. = ..()
	if(slot & ITEM_SLOT_HEAD)
		START_PROCESSING(SSobj, src)
		RegisterSignal(user, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

	if(!slot == ITEM_SLOT_HEAD)
		mode = MODE_LISTENOFF

/obj/item/clothing/head/helmet/lethal_kudagitsune_helmet/proc/toggle_mode(mob/user, voluntary)
	if(!istype(user) || user.incapacitated())
		return FALSE

	switch(mode)
		if(MODE_LISTENOFF)
			change_mode(MODE_LISTENON)

		if(MODE_LISTENON)
			change_mode(MODE_LISTENOFF)

	playsound(src, modeswitch_sound, 50, TRUE)

/obj/item/gravity_harness/proc/change_mode(target_mode)
	if(!target_mode)
		return FALSE
	user.RemoveElement(/datum/element/forced_gravity, 0)
	REMOVE_TRAIT(user, TRAIT_XRAY_HEARING, CLOTHING_TRAIT)

//stuff that goes on your torso

//stuff that goes on your hands

/obj/item/clothing/gloves/frontier_colonist
	name = "kote sleeves"
	desc = "A pair of armwarmers has been reinforced with printed chain and and high strength resin plates in \
	imitation of medieval underarmor. The result is less resilient then dedicated armored gauntlets, but these \
	are able to protect your extremities without hampering your manual dexterity."
	icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "gloves"
	worn_icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gloves"
	//greyscale_colors = "#3a373e"
	clothing_traits = list(TRAIT_QUICK_CARRY)

//stuff that goes on your feet
*/
