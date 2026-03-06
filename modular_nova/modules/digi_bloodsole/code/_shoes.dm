/obj/item/clothing/shoes/get_blood_overlay(blood_state, mutant_styles)
	if (!(mutant_styles & CLOTHING_DIGITIGRADE_VARIATION))
		return ..()

	if (!GET_ATOM_BLOOD_DECAL_LENGTH(src))
		return

	var/mutable_appearance/blood_overlay = null
	if(clothing_flags & LARGE_WORN_ICON)
		blood_overlay = mutable_appearance('modular_nova/modules/digi_bloodsole/icons/64x64.dmi', "shoeblood_large_digi")
	else
		blood_overlay = mutable_appearance('modular_nova/modules/digi_bloodsole/icons/blood.dmi', "shoeblood_digi")

	var/emissive_alpha = get_blood_emissive_alpha(is_worn = TRUE)
	if (emissive_alpha)
		var/mutable_appearance/emissive_overlay = emissive_appearance(blood_overlay.icon, blood_overlay.icon_state, src, alpha = emissive_alpha)
		blood_overlay.overlays += emissive_overlay

	return blood_overlay
