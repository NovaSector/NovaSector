/obj/item/construction/rcd/tarkon
	name = "Tarkon Industries RCD"
	desc = "An RCD of an alternative design with a \"Tarkon Industries\" logo on it, capable of working at range. Reload using metal, glass, or plasteel."
	icon = 'modular_nova/modules/tarkon/icons/misc/tools.dmi'
	icon_state = "trcd"
	ranged = TRUE
	canRturf = FALSE
	delay_mod = 2.5 //If you're constructing the whole road, You need to be at the speed of road construction.
	max_matter = 200
	matter = 200
	upgrade = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS
