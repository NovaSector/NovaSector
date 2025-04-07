/obj/item/borg/upgrade/rped
	icon = 'modular_nova/modules/aesthetics/storage/storage.dmi'
	icon_state = "borgrped"

/obj/item/storage/part_replacer
	icon = 'modular_nova/modules/aesthetics/storage/storage.dmi'

/obj/item/storage/part_replacer/bluespace
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/part_replacer/cyborg
	icon = 'modular_nova/modules/aesthetics/storage/storage.dmi'



/*
// Boxes
*/
/obj/item/storage/box
	icon = 'modular_nova/modules/aesthetics/storage/storage.dmi'

/obj/item/storage/box/donkpockets
	icon = 'icons/obj/storage/box.dmi'

/obj/item/storage/box/survival/syndie
	icon_state = "syndiebox"

/obj/item/storage/box/clown
	icon_state = "hugbox"

/obj/item/storage/box/cyber_implants
	illustration = null //Included in the sprite

/obj/item/storage/box/mothic_rations
	icon = 'icons/obj/storage/box.dmi'

/obj/item/storage/box/mothic_goods
	icon = 'icons/obj/storage/box.dmi'

/obj/item/storage/box/mothic_cans_sauces
	icon = 'icons/obj/storage/box.dmi'

/obj/item/storage/box/tiziran_meats
	icon = 'icons/obj/storage/box.dmi'

/obj/item/storage/box/tiziran_cans
	icon = 'icons/obj/storage/box.dmi'

/obj/item/storage/box/tiziran_goods
	icon = 'icons/obj/storage/box.dmi'

/*
// Medical
*/
/obj/item/storage/box/swab
	icon_state = "medbox"

/obj/item/storage/box/masks
	icon_state = "medbox"

/obj/item/storage/box/bodybags
	icon_state = "medbox"

/obj/item/storage/box/survival/medical
	icon_state = "medbox"

/obj/item/storage/box/syringes
	icon_state = "medbox"

/obj/item/storage/box/medipens
	icon_state = "medbox"

/obj/item/storage/box/medigels
	icon_state = "medbox"

/obj/item/storage/box/injectors
	icon_state = "medbox"

/obj/item/storage/box/pillbottles
	icon_state = "medbox"

/obj/item/storage/box/silver_sulf
	icon_state = "medbox"

/*
// Engineering
*/
/obj/item/storage/box/metalfoam
	icon_state = "engibox"

/obj/item/storage/box/smart_metal_foam
	icon_state = "engibox"

/obj/item/storage/box/material
	icon_state = "engibox"

/*
// Security
*/
/obj/item/storage/box/rubbershot
	icon_state = "secbox_xl"
	illustration = "rubbershot"

/obj/item/storage/box/lethalshot
	icon_state = "secbox_xl"
	illustration = "buckshot"

/obj/item/storage/box/beanbag
	icon_state = "secbox_xl"
	illustration = "beanbag"

/obj/item/storage/box/breacherslug
	icon_state = "secbox_xl"
	illustration = "breacherslug"

/obj/item/storage/box/slugs
	icon_state = "secbox_xl"
	illustration = "breacherslug"

/obj/item/storage/box/large_dart
	icon_state = "secbox_xl"
	illustration = "shotdart"

/obj/item/storage/box/evidence
	icon_state = "secbox"
	illustration = "evidence"

/obj/item/storage/box/rxglasses/spyglasskit
	icon_state = "secbox"

/obj/item/storage/box/holobadge
	icon_state = "secbox"
	illustration = "holobadge"

/obj/item/storage/box/survival/security
	icon_state = "secbox"

/obj/item/storage/box/emps
	icon_state = "syndiebox"

/obj/item/storage/box/chemimp
	icon_state = "medbox"

/obj/item/storage/box/exileimp
	icon_state = "secbox"

/*
// Paper Bags
*/
/obj/item/storage/box/papersack
	/// The modular icon file for the new designs
	var/modular_additions_icon = 'modular_nova/master_files/icons/obj/storage/paperbag.dmi'

/obj/item/storage/box/papersack/Initialize(mapload)
	. = ..()

	papersack_designs  += list(
		"Grey" = image(icon = modular_additions_icon, icon_state = "paperbag_Grey"),
		"Black" = image(icon = modular_additions_icon, icon_state = "paperbag_Black"),
		"Sec" = image(icon = modular_additions_icon, icon_state = "paperbag_Sec"),
		"Medical" = image(icon = modular_additions_icon, icon_state = "paperbag_Medical"),
		"Fox" = image(icon = modular_additions_icon, icon_state = "paperbag_Fox"),
		"Bunny" = image(icon = modular_additions_icon, icon_state = "paperbag_Bunny"),
	)
	sort_list(papersack_designs)
	update_appearance()

/obj/item/storage/box/papersack/update_desc(updates)
	icon = modular_additions_icon
	switch(design_choice)
		if("Grey")
			desc = "A grey sack neatly crafted out of paper."
		if("Black")
			desc = "A black sack neatly crafted out of paper."
		if("Sec")
			desc = "A sturdy paper sack ideal to carry lunch on those lonely long patrols."
		if("Medical")
			desc = "A Nitrile lined sack useful to carry sanitized snacks for both patients and medical staff alike."
		if("Fox")
			desc = "A paper sack with a prowling fox etched onto the side."
		if("Bunny")
			desc = "A paper sack with a hopping bunny etched onto the side."
		else
			icon = initial(icon)
	return ..()
