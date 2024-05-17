// MODsuit-related overrides for our digitigrade sprites and such
/obj/item/clothing/head/mod
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION
	worn_icon_muzzled = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi'
	worn_icon_better_vox = 'modular_nova/modules/better_vox/icons/clothing/mod.dmi'

/obj/item/clothing/suit/mod
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi'
	worn_icon_better_vox = 'modular_nova/modules/better_vox/icons/clothing/mod.dmi'

/obj/item/clothing/gloves/mod
	supports_variations_flags = NONE
	worn_icon_better_vox = 'modular_nova/modules/better_vox/icons/clothing/mod.dmi'

/obj/item/clothing/shoes/mod
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi'
	worn_icon_better_vox = 'modular_nova/modules/better_vox/icons/clothing/mod.dmi'

/obj/item/mod/control
	worn_icon_better_vox = 'modular_nova/modules/better_vox/icons/clothing/mod_modules.dmi'

// Proc overwrites to allow modsuits to function despite missing limbs
// Because modsuit clothing parts are always equipped by a modsuit script and not player action
// the proc overwrite can be a little unsafe
/obj/item/clothing/head/mod/mob_can_equip(mob/living/carbon/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!user)
		return FALSE
	if(!(slot_flags & slot))
		return FALSE
	if(!user.get_bodypart(BODY_ZONE_HEAD)) //so no head?
		return TRUE
	return ..()

/obj/item/clothing/gloves/mod/mob_can_equip(mob/living/carbon/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!user)
		return FALSE
	if(!(slot_flags & slot))
		return FALSE
	if(!user.get_bodypart(BODY_ZONE_L_ARM) || !user.get_bodypart(BODY_ZONE_R_ARM))
		return TRUE
	return ..()

/obj/item/clothing/shoes/mod/mob_can_equip(mob/living/carbon/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!user)
		return FALSE
	if(!(slot_flags & slot))
		return FALSE
	if(!user.get_bodypart(BODY_ZONE_L_LEG) || !user.get_bodypart(BODY_ZONE_R_LEG))
		return TRUE
	return ..()
