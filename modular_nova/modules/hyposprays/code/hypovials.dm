/obj/item/reagent_containers/cup/vial
	name = "broken hypovial"
	desc = "You probably shouldn't be seeing this. Shout at a coder."
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	greyscale_config = /datum/greyscale_config/hypovial
	fill_icon_state = "hypovial_fill"
	spillable = FALSE
	volume = 10
	possible_transfer_amounts = list(1,2,5,10)
	fill_icon_thresholds = list(10, 25, 50, 75, 100)
	var/chem_color = "#FFFFFF" //Used for hypospray overlay
	var/type_suffix = "-s"
	fill_icon = 'modular_nova/modules/hyposprays/icons/hypospray_fillings.dmi'
	current_skin = "hypovial"

	unique_reskin = list(
		"Sterile" = "hypovial",
		"Generic" = "hypovial-generic",
		"Brute" = "hypovial-brute",
		"Burn" = "hypovial-burn",
		"Toxin" = "hypovial-tox",
		"Oxyloss" = "hypovial-oxy",
		"Crit" = "hypovial-crit",
		"Buff" = "hypovial-buff",
		"Custom" = "hypovial-custom",
	)

/obj/item/reagent_containers/cup/vial/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/obj/item/reagent_containers/cup/vial/Destroy(force)
	. = ..()
	UnregisterSignal(src, COMSIG_OBJ_RESKIN)

/obj/item/reagent_containers/cup/vial/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Shift-Click to reskin or set a custom color.")

/obj/item/reagent_containers/cup/vial/click_ctrl_shift(mob/user)
	current_skin = null
	icon_state = initial(icon_state)
	icon = initial(icon)
	greyscale_colors = null
	reskin_obj(user)

/obj/item/reagent_containers/cup/vial/proc/on_reskin()
	if(current_skin == "Custom")
		icon_state = unique_reskin["Sterile"]
		current_skin = unique_reskin["Sterile"]
		var/atom/fake_atom = src
		var/list/allowed_configs = list()
		var/config = initial(fake_atom.greyscale_config)
		allowed_configs += "[config]"
		if(greyscale_colors == null)
			greyscale_colors = "#FFFF00"
		var/datum/greyscale_modify_menu/menu = new(src, usr, allowed_configs)
		menu.ui_interact(usr)
	else
		icon_state = unique_reskin[current_skin]

/obj/item/reagent_containers/cup/vial/update_overlays()
	. = ..()
	// Search the overlays for the fill overlay from reagent_containers, and nudge its layer down to have it look correct.
	chem_color = "#FFFFFF"
	var/list/generated_overlays = .
	for(var/added_overlay in generated_overlays)
		if(istype(added_overlay, /mutable_appearance))
			var/mutable_appearance/overlay_image = added_overlay
			if(findtext(overlay_image.icon_state, fill_icon_state) != 0)
				overlay_image.layer = layer - 0.01
				chem_color = overlay_image.color

/obj/item/reagent_containers/cup/vial/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/cup/vial/on_reagent_change()
	update_icon()

//Fit in all hypos
/obj/item/reagent_containers/cup/vial/small
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "hypovial"
	desc = "A small, 50u capacity vial compatible with most hyposprays."
	volume = 50
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/cup/vial/small/style
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"

//Styles
/obj/item/reagent_containers/cup/vial/small/style/generic
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/small/style/brute
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/small/style/burn
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/small/style/toxin
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/small/style/oxy
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/small/style/crit
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/small/style/buff
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"

//Fit in CMO hypo only
/obj/item/reagent_containers/cup/vial/large
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "large hypovial"
	fill_icon_state = "hypoviallarge_fill"
	current_skin = "hypoviallarge"
	desc = "A large, 100u capacity vial that fits only in the most deluxe hyposprays."
	volume = 100
	possible_transfer_amounts = list(1,2,5,10,20,30,40,50,100)
	type_suffix = "-l"

	unique_reskin = list(
		"Sterile" = "hypoviallarge",
		"Generic" = "hypoviallarge-generic",
		"Brute" = "hypoviallarge-brute",
		"Burn" = "hypoviallarge-burn",
		"Toxin" = "hypoviallarge-tox",
		"Oxyloss" = "hypoviallarge-oxy",
		"Crit" = "hypoviallarge-crit",
		"Buff" = "hypoviallarge-buff",
		"Custom" = "hypoviallarge-custom",
	)

/obj/item/reagent_containers/cup/vial/large/style/
	icon_state = "hypoviallarge"

//Styles
/obj/item/reagent_containers/cup/vial/large/style/generic
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/large/style/brute
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/large/style/burn
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/large/style/toxin
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/large/style/oxy
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/large/style/crit
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
/obj/item/reagent_containers/cup/vial/large/style/buff
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"

//Hypos that are in the CMO's kit round start
/obj/item/reagent_containers/cup/vial/large/deluxe
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "deluxe hypovial"
	list_reagents = list(/datum/reagent/medicine/omnizine = 15, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/cup/vial/large/salglu
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "large green hypovial (salglu)"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 50)

/obj/item/reagent_containers/cup/vial/large/synthflesh
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "large orange hypovial (synthflesh)"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 50)

/obj/item/reagent_containers/cup/vial/large/multiver
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "large black hypovial (multiver)"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 50)

//Some bespoke helper types for preloaded combat medkits.
/obj/item/reagent_containers/cup/vial/large/advbrute
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "Brute Heal"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 50, /datum/reagent/medicine/sal_acid = 50)

/obj/item/reagent_containers/cup/vial/large/advburn
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "Burn Heal"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 50, /datum/reagent/medicine/oxandrolone = 50)

/obj/item/reagent_containers/cup/vial/large/advtox
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "Toxin Heal"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 100)

/obj/item/reagent_containers/cup/vial/large/advoxy
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "Oxy Heal"
	list_reagents = list(/datum/reagent/medicine/c2/tirimol = 50, /datum/reagent/medicine/salbutamol = 50)

/obj/item/reagent_containers/cup/vial/large/advcrit
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "Crit Heal"
	list_reagents = list(/datum/reagent/medicine/atropine = 100)

/obj/item/reagent_containers/cup/vial/large/advomni
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "All-Heal"
	list_reagents = list(/datum/reagent/medicine/regen_jelly = 100)

/obj/item/reagent_containers/cup/vial/large/numbing
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "Numbing"
	list_reagents = list(/datum/reagent/medicine/mine_salve = 50, /datum/reagent/medicine/morphine = 50)

//Some bespoke helper types for preloaded paramedic kits.
/obj/item/reagent_containers/cup/vial/small/libital
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "brute hypovial (libital)"

/obj/item/reagent_containers/cup/vial/small/libital/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/libital, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/lenturi
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "burn hypovial (lenturi)"

/obj/item/reagent_containers/cup/vial/small/lenturi/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/lenturi, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/seiver
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "tox hypovial (seiver)"

/obj/item/reagent_containers/cup/vial/small/seiver/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/seiver, amount = 50, reagtemp = 975, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/convermol
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "tox hypovial (convermol)"

/obj/item/reagent_containers/cup/vial/small/convermol/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/convermol, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/atropine
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/item/reagent_containers/cup/vial"
	post_init_icon_state = "hypovial"
	name = "crit hypovial (atropine)"

/obj/item/reagent_containers/cup/vial/small/atropine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/atropine, amount = 50, added_purity = 1)
