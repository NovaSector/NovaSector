/// SolFed Accessories
/obj/item/clothing/accessory/nova/solfedribbon
	name = "\improper SolFed rank ribbon"
	desc = "An average military ribbon."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon"
	post_init_icon_state = "star_arr_ribbon_1"
	greyscale_colors = "#FFD700"
	greyscale_config = /datum/greyscale_config/solfedribbons
	greyscale_config_worn = /datum/greyscale_config/solfedribbons/worn
	minimize_when_attached = TRUE
	unique_reskin = list(
		"Default" = "star_arr_ribbon_1",
		"Alt 1" = "star_arr_ribbon_2",
		"Alt 2" = "star_sw_ribbon_1",
		"Alt 3" = "star_sw_ribbon_2",
		"Alt 4" = "star_ribbon_1",
		"Alt 5" = "star_ribbon_2",
		"Alt 6" = "star_ribbon_3",
		"Alt 7" = "arr_ribbon_1",
		"Alt 8" = "arr_ribbon_2",
		"Alt 9" = "arr_ribbon_3",
		"Alt 10" = "sw_ribbon_1",
		"Alt 11" = "sw_ribbon_2",
		"Alt 12" = "sw_ribbon_3",
	)

/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official
	name = "\improper SolFed Official neckpin"
	desc = "A special golden neckpin to show true loyalty to the Federation."
	greyscale_colors = "#ffff66#0099ff"
