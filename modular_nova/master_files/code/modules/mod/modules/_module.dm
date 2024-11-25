/**
 * Proc that handles the mutable_appearances of the module on the MODsuits
 *
 * Arguments:
 * * standing - The mutable_appearance we're taking as a reference for this one, mainly to use its layer.
 * * module_icon_state - The name of the icon_state we'll be using for the module on the MODsuit.
 */
/obj/item/mod/module/proc/handle_module_icon(mutable_appearance/standing, module_icon_state)
	if(!mod.wearer)
		CRASH("Attempted to generate modsuit module icons with no wearer")
	. = list()
	var/obj/item/clothing/suit/mod/chestplate = mod.get_part_from_slot(ITEM_SLOT_OCLOTHING)
	var/obj/item/clothing/head/mod/helmet = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	var/suit_snouted = (helmet?.supports_variations_flags & CLOTHING_SNOUTED_VARIATION) && (mod.wearer.bodyshape & BODYSHAPE_SNOUTED) && (supports_variations_flags & CLOTHING_SNOUTED_VARIATION)
	var/suit_digitigrade = (chestplate.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION) && (mod.wearer.bodyshape & BODYSHAPE_DIGITIGRADE) && (supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION)

	var/icon_to_use = 'icons/mob/clothing/modsuit/mod_modules.dmi'
	var/icon_state_to_use = module_icon_state
	if(isvoxprimalis(mod.wearer))
		icon_to_use = 'modular_nova/modules/better_vox/icons/clothing/mod_modules.dmi'
	else if(isvox(mod.wearer))
		icon_to_use = worn_icon_vox

	else if(suit_snouted && (supports_variations_flags & CLOTHING_SNOUTED_VARIATION))
		icon_to_use = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_modules_mutant.dmi'
		icon_state_to_use = "[module_icon_state]_head_muzzled"
	else if(suit_digitigrade && (supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
		icon_to_use = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_modules_mutant.dmi'
		icon_state_to_use = "[module_icon_state]_digi"

	var/mutable_appearance/module_icon
	if(mask_worn_overlay)
		var/icon/mod_mask = icon(mod.generate_suit_mask())
		mod_mask.Blend(icon(icon_to_use, icon_state_to_use), ICON_MULTIPLY)
		module_icon = mutable_appearance(mod_mask, layer = standing.layer + 0.1)
	else
		module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1)
	module_icon.appearance_flags |= RESET_COLOR

	. += module_icon

/obj/item/mod/control/generate_suit_mask()
	var/list/parts = get_parts(all = TRUE)
	var/icon/slot_mask = icon('icons/blanks/32x32.dmi', "nothing")
	for(var/obj/item/part as anything in parts)
		var/icon_to_use
		if(isvoxprimalis(wearer) && part.worn_icon_better_vox)
			icon_to_use = part.worn_icon_better_vox
		else if(isvox(wearer) && part.worn_icon_vox)
			icon_to_use = part.worn_icon_vox
		else if (isteshari(wearer) && part.worn_icon_teshari)
			icon_to_use = part.worn_icon_teshari
		else if((wearer.bodyshape & BODYSHAPE_SNOUTED) && (part.supports_variations_flags & CLOTHING_SNOUTED_VARIATION))
			icon_to_use = part.worn_icon_muzzled
		else if((wearer.bodyshape & BODYSHAPE_DIGITIGRADE) && (part.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_to_use = part.worn_icon_digi
		else
			icon_to_use = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
		slot_mask.Blend(icon(icon_to_use, part.icon_state), ICON_OVERLAY)
	slot_mask.Blend("#fff", ICON_ADD)
	return slot_mask
