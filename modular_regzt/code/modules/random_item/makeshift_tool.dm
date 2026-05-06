//from sand

/obj/item/crowbar/makeshift
	name = "Makeshift Crowbar"
	desc = "It's just a slightly bent metal rod."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "crowbar"
	toolspeed = 2.5
	force = 2
	throwforce = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/wrench/makeshift
	name = "Makeshift Wrench"
	desc = "It's a metal rod with a metal sheet crudely hammered around the tip."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "wrench"
	toolspeed = 2.5
	force = 2
	throwforce = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/wirecutters/makeshift
	name = "Makeshift Wirecutters"
	desc = "It's two metal rods hammered flat with cables holding them together."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "cutters"
	random_color = FALSE
	toolspeed = 2.5
	force = 3
	throwforce = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	w_class = WEIGHT_CLASS_NORMAL
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/screwdriver/makeshift
	name = "Makeshift Screwdriver"
	desc = "It's a metal rod with a crudely hammered tip."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "screwdriver"
	random_color = FALSE
	toolspeed = 2.5
	force = 1
	throwforce = 1
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	w_class = WEIGHT_CLASS_NORMAL
	random_color = FALSE
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/weldingtool/makeshift
	name = "Makeshift Welding Tool"
	desc = "You begin to think that your hands would do a better job."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "welder"
	max_fuel = 10
	force = 1
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.5)
	change_icons = 0
	toolspeed = 2.5

/obj/item/weldingtool/makeshift/Initialize(mapload)
	. = ..()
	create_reagents(max_fuel)
	reagents.add_reagent(/datum/reagent/fuel, 0)
	update_icon()

/obj/item/analyzer/makeshift
	name = "handmade gas analyzer"
	desc = "A hand-held environmental scanner which reports current gas levels."
	cooldown_time = 60 SECONDS
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "analyzer"

/obj/item/multitool/makeshift
	name = "handmade multitool"
	desc = "Used for pulsing wires to test which to cut. Not recommended by doctors. You can activate it in-hand to locate the nearest APC."
	toolspeed = 2.5
	apc_scanner = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "multitool"

//чистый REGZT

/obj/item/shovel/makeshift
	name = "handmade shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "shovel"
	toolspeed = 1.25
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3)

/obj/item/weldingtool/electric/arc_welder/makeshift
	name = "makeshift arc welder"
	desc = "A specialized welding tool utilizing high powered arcs of electricity to weld things together. \
		Compared to other electrically-powered welders, this model is slow and highly power inefficient, \
		but it still gets the job done and chances are you printed this bad boy off for free."
	icon = 'modular_regzt/icons/obj/item/tools.dmi'
	icon_state = "arc_welder"
	usesound = 'modular_nova/modules/colony_fabricator/sound/arc_welder/arc_welder.ogg'
	light_range = 2
	light_power = 1
	toolspeed = 2.5
	power_use_amount = POWER_CELL_USE_INSANE
