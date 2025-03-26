/obj/item/clothing/shoes/worn_overlays(isinhands = FALSE,icon_file,mutant_styles=NONE)
	. = ..()
	if(isinhands)
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedshoe")
	if(GET_ATOM_BLOOD_DNA(src))
		var/mutable_appearance/blood_overlay
		if (mutant_styles & CLOTHING_DIGITIGRADE_VARIATION)
			if(clothing_flags & LARGE_WORN_ICON)
				blood_overlay = mutable_appearance('modular_nova/modules/digi_bloodsole/icons/64x64.dmi', "shoeblood_large_digi", appearance_flags = KEEP_APART|RESET_COLOR)
			else
				blood_overlay = mutable_appearance('modular_nova/modules/digi_bloodsole/icons/blood.dmi', "shoeblood_digi", appearance_flags = KEEP_APART|RESET_COLOR)
		else
			if(clothing_flags & LARGE_WORN_ICON)
				blood_overlay = mutable_appearance('icons/effects/64x64.dmi', "shoeblood_large", appearance_flags = KEEP_APART|RESET_COLOR)
			else
				blood_overlay = mutable_appearance('icons/effects/blood.dmi', "shoeblood", appearance_flags = KEEP_APART|RESET_COLOR)
		blood_overlay.color = "#FF291E" // NOVA EDIT ADDITION
		. += blood_overlay
