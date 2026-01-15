//This file and folder is only for donation modsuits.
//Follow the same methods below and make sure that 'icon_state' lable as [YOUR_SUIT_NAME_HERE]-plating.
//The game will load it but will not load the icon as it will lable it as [YOUR_SUIT_NAME_HERE]-plating. Unsure why, have a feeling is due to modsuit coding.
//DO: Coolsuit-plating.
//DONT: Coolsuit-box / coolsuit-box-plating / coolsuit.
//Make sure that your .dmi icon is also labled the same way.
//Remember to add your MODsuit variables in ~donator\modsuit\mod_theme.dm.
// -- Rilomatic - 15th January 2026

/obj/item/mod/construction/plating/paragon
	name = "\improper Paragon Plating"
	desc = "A sturdy black storage container wrapped with yellow tape label 'VOID IF TEMPERED, DO NOT PAINT OVER LABEL.” Barcodes, manufacturing details, and safety warnings are stenciled along its sides. \
		Within the box contains several conversion parts packed neatly within shape foam, a distinctive glass like helmet visor made out of synthetic crystal laminate with electrical polarized lens matrix, and a manual with detailed instruction \
		necessary to create the Paragon MODsuit."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "paragon-plating"
	theme = /datum/mod_theme/paragon

/obj/item/mod/construction/plating/jumper
	name = "\improper PA-4 MK-7 J.S supply crate"
	desc = "A crate made mostly of titanium with handles on the side to carry. It seems to be pressure sealed and the lid seems to be hydraulically assisted. \
		The inside of the crate opens up and folds out to display an entire toolkit with all the essentials to convert most armor \
		into a Mark 7 PA-7 Variant Jump suit. This crate seems to have the emblem relating to a certain Commando... \
		Perhaps you should return it to the owner where you found it, if you can even lift it."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "jumper-plating"
	theme = /datum/mod_theme/jumper
