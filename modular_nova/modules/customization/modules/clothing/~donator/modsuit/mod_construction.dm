//This file and folder is only for donation modsuits.
//Follow the same methods below and make sure that 'icon_state' lable as [YOUR_SUIT_NAME_HERE]-plating.
//The game will load it but will not load the icon as it will lable it as [YOUR_SUIT_NAME_HERE]-plating. Unsure why, best guess is due to TG modsuit code
//It will take the name variable from mod_theme.dm and merge it with a static "plating" thus the icon_state naming.
//DO: Coolsuit-plating.
//DONT: Coolsuit-box / coolsuit-box-plating / coolsuit.
//Make sure that your .dmi icon is also labled the same way.
//Remember to add your MODsuit variables in ~donator\modsuit\mod_theme.dm.
// -- Rilomatic - 15th January 2026

//Limitations - Entombed MODsuits - Logic wise we can't take off the suit, nor we can craft a new entomed suit / crafting recipe might kill the player
//									Best choice is to use skin_applier - View Akari Modsuit (Entombed) for code in:
//									modular_nova\modules\customization\modules\clothing\~donator\donator_items.dm
// -- Rilomatic - 16th January 2026

//Kaynite Donor Item

//Adding paragon as a object - Needed for crafting recipe
/obj/item/mod/control/paragon
	theme = /datum/mod_theme/paragon

/obj/item/mod/construction/plating/paragon
	name = "\improper Paragon Plating"
	desc = "A sturdy black storage container wrapped with yellow tape label 'VOID IF TEMPERED, DO NOT PAINT OVER LABEL.” Barcodes, manufacturing details, and safety warnings are stenciled along its sides. \
		Within the box contains several conversion parts packed neatly within shape foam, a distinctive glass like helmet visor made out of synthetic crystal laminate with electrical polarized lens matrix, and a manual with detailed instruction \
		necessary to create the Paragon MODsuit."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "paragon-plating"
	theme = /datum/mod_theme/paragon

//Crafting recipe for paragon
/datum/crafting_recipe/Paragon
	name = "Homo Ludens Modsuit 'Paragon'"
	result = /obj/item/mod/control/paragon
	time = 1 SECONDS
	reqs = list(
		/obj/item/mod/construction/plating/paragon = 1,
		/obj/item/mod/control/pre_equipped/medical = 1,
	)
	category = CAT_CLOTHING

// Bonkai Donor Item

/obj/item/mod/construction/plating/jumper
	name = "\improper PA-4 MK-7 J.S supply crate"
	desc = "A crate made mostly of titanium with handles on the side to carry. It seems to be pressure sealed and the lid seems to be hydraulically assisted. \
		The inside of the crate opens up and folds out to display an entire toolkit with all the essentials to convert most armor \
		into a Mark 7 PA-7 Variant Jump suit. This crate seems to have the emblem relating to a certain Commando... \
		Perhaps you should return it to the owner where you found it, if you can even lift it."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "jumper-plating"
	theme = /datum/mod_theme/jumper
