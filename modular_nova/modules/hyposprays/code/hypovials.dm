/datum/atom_skin/hypovial
	abstract_type = /datum/atom_skin/hypovial
	/// Should we open a greyscale menu when the user reskins this?
	var/update_greyscale
	/// The icon state to switch to when applying a custom greyscale
	var/base_icon_state = /datum/atom_skin/hypovial/sterile::new_icon_state

/datum/atom_skin/hypovial/apply(atom/apply_to, mob/user)
	. = ..()
	if(isnull(user))
		return
	var/name_temp = tgui_input_text(user, "Input a vial label!", "Rename", apply_to.name)
	if(name_temp)
		var/obj/item/applying_to = apply_to
		applying_to.name = name_temp
		applying_to.update_name()
	if(update_greyscale)
		update_greyscale(apply_to, user)

/// Updates the greyscale colors of the item
/datum/atom_skin/hypovial/proc/update_greyscale(atom/apply_to, mob/user)
	apply_to.icon_state = base_icon_state
	if(isnull(apply_to.greyscale_colors))
		apply_to.greyscale_colors = "#FFFF00"
	var/datum/greyscale_modify_menu/menu = new(apply_to, user, allowed_configs = list("[apply_to.greyscale_config]"), starting_config = apply_to.greyscale_config)
	menu.ui_interact(usr)

/datum/atom_skin/hypovial/sterile
	preview_name = "Sterile"
	new_icon_state = "hypovial"

/datum/atom_skin/hypovial/generic
	preview_name = "Generic"
	new_icon_state = "hypovial-generic"

/datum/atom_skin/hypovial/brute
	preview_name = "Brute"
	new_icon_state = "hypovial-brute"

/datum/atom_skin/hypovial/burn
	preview_name = "Burn"
	new_icon_state = "hypovial-burn"

/datum/atom_skin/hypovial/tox
	preview_name = "Toxin"
	new_icon_state = "hypovial-tox"

/datum/atom_skin/hypovial/oxy
	preview_name = "Oxyloss"
	new_icon_state = "hypovial-oxy"

/datum/atom_skin/hypovial/crit
	preview_name = "Crit"
	new_icon_state = "hypovial-crit"

/datum/atom_skin/hypovial/buff
	preview_name = "Buff"
	new_icon_state = "hypovial-buff"

/datum/atom_skin/hypovial/custom
	preview_name = "Custom"
	new_icon_state = "hypovial-custom"
	update_greyscale = TRUE

/obj/item/reagent_containers/cup/vial
	name = "broken hypovial"
	desc = "You probably shouldn't be seeing this. Shout at a coder."
	icon = 'modular_nova/modules/hyposprays/icons/vials.dmi'
	icon_state = "hypovial"
	greyscale_config = /datum/greyscale_config/hypovial
	fill_icon_state = "hypovial_fill"
	volume = 10
	possible_transfer_amounts = list(1,2,5,10)
	fill_icon_thresholds = list(10, 25, 50, 75, 100)
	var/chem_color = "#FFFFFF" //Used for hypospray overlay
	var/type_suffix = "-s"
	fill_icon = 'modular_nova/modules/hyposprays/icons/hypospray_fillings.dmi'

/obj/item/reagent_containers/cup/vial/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hypovial, blacklisted_subtypes = subtypesof(/datum/atom_skin/hypovial/large) + subtypesof(/datum/atom_skin/hypovial/interdyne_medium))

/obj/item/reagent_containers/cup/vial/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Click to reskin or set a custom color.")

/obj/item/reagent_containers/cup/vial/click_ctrl_shift(mob/user)
	greyscale_colors = null

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
	name = "hypovial"
	desc = "A small, 60u capacity vial compatible with most hyposprays."
	volume = 60
	possible_transfer_amounts = list(5,10,15,20,30,60)

/obj/item/reagent_containers/cup/vial/small/style
	icon_state = "hypovial"

//Styles
/obj/item/reagent_containers/cup/vial/small/style/generic
	icon_state = "hypovial-generic"
/obj/item/reagent_containers/cup/vial/small/style/brute
	icon_state = "hypovial-brute"
/obj/item/reagent_containers/cup/vial/small/style/burn
	icon_state = "hypovial-burn"
/obj/item/reagent_containers/cup/vial/small/style/toxin
	icon_state = "hypovial-tox"
/obj/item/reagent_containers/cup/vial/small/style/oxy
	icon_state = "hypovial-oxy"
/obj/item/reagent_containers/cup/vial/small/style/crit
	icon_state = "hypovial-crit"
/obj/item/reagent_containers/cup/vial/small/style/buff
	icon_state = "hypovial-buff"

//Fit in CMO hypo only

/datum/atom_skin/hypovial/large
	abstract_type = /datum/atom_skin/hypovial/large
	base_icon_state = /datum/atom_skin/hypovial/large/sterile::new_icon_state

/datum/atom_skin/hypovial/large/sterile
	preview_name = "Sterile"
	new_icon_state = "hypoviallarge"

/datum/atom_skin/hypovial/large/generic
	preview_name = "Generic"
	new_icon_state = "hypoviallarge-generic"

/datum/atom_skin/hypovial/large/brute
	preview_name = "Brute"
	new_icon_state = "hypoviallarge-brute"

/datum/atom_skin/hypovial/large/burn
	preview_name = "Burn"
	new_icon_state = "hypoviallarge-burn"

/datum/atom_skin/hypovial/large/tox
	preview_name = "Toxin"
	new_icon_state = "hypoviallarge-tox"

/datum/atom_skin/hypovial/large/oxy
	preview_name = "Oxyloss"
	new_icon_state = "hypoviallarge-oxy"

/datum/atom_skin/hypovial/large/crit
	preview_name = "Crit"
	new_icon_state = "hypoviallarge-crit"

/datum/atom_skin/hypovial/large/buff
	preview_name = "Buff"
	new_icon_state = "hypoviallarge-buff"

/datum/atom_skin/hypovial/large/custom
	preview_name = "Custom"
	new_icon_state = "hypoviallarge-custom"
	update_greyscale = TRUE

/obj/item/reagent_containers/cup/vial/large
	name = "large hypovial"
	icon_state = "hypoviallarge"
	fill_icon_state = "hypoviallarge_fill"
	desc = "A large, 120u capacity vial that fits only in the most deluxe hyposprays."
	volume = 120
	possible_transfer_amounts = list(5,10,15,20,30,40,60,120)
	type_suffix = "-l"
	greyscale_config = /datum/greyscale_config/hypovial/large

/obj/item/reagent_containers/cup/vial/large/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hypovial/large, blacklisted_subtypes = subtypesof(/datum/atom_skin/hypovial/interdyne_medium))

/obj/item/reagent_containers/cup/vial/large/style
	icon_state = "hypoviallarge"

//Styles
/obj/item/reagent_containers/cup/vial/large/style/generic
	icon_state = "hypoviallarge-generic"
/obj/item/reagent_containers/cup/vial/large/style/brute
	icon_state = "hypoviallarge-brute"
/obj/item/reagent_containers/cup/vial/large/style/burn
	icon_state = "hypoviallarge-burn"
/obj/item/reagent_containers/cup/vial/large/style/toxin
	icon_state = "hypoviallarge-tox"
/obj/item/reagent_containers/cup/vial/large/style/oxy
	icon_state = "hypoviallarge-oxy"
/obj/item/reagent_containers/cup/vial/large/style/crit
	icon_state = "hypoviallarge-crit"
/obj/item/reagent_containers/cup/vial/large/style/buff
	icon_state = "hypoviallarge-buff"

//Interdyne exclusive

/datum/atom_skin/hypovial/interdyne_medium
	abstract_type = /datum/atom_skin/hypovial/interdyne_medium
	base_icon_state = /datum/atom_skin/hypovial/interdyne_medium/sterile::new_icon_state

/datum/atom_skin/hypovial/interdyne_medium/sterile
	preview_name = "Sterile"
	new_icon_state = "hypovial-interdyne"

/datum/atom_skin/hypovial/interdyne_medium/generic
	preview_name = "Generic"
	new_icon_state = "hypovial-interdyne-generic"

/datum/atom_skin/hypovial/interdyne_medium/brute
	preview_name = "Brute"
	new_icon_state = "hypovial-interdyne-brute"

/datum/atom_skin/hypovial/interdyne_medium/burn
	preview_name = "Burn"
	new_icon_state = "hypovial-interdyne-burn"

/datum/atom_skin/hypovial/interdyne_medium/tox
	preview_name = "Toxin"
	new_icon_state = "hypovial-interdyne-tox"

/datum/atom_skin/hypovial/interdyne_medium/oxy
	preview_name = "Oxyloss"
	new_icon_state = "hypovial-interdyne-oxy"

/datum/atom_skin/hypovial/interdyne_medium/crit
	preview_name = "Crit"
	new_icon_state = "hypovial-interdyne-crit"

/datum/atom_skin/hypovial/interdyne_medium/buff
	preview_name = "Buff"
	new_icon_state = "hypovial-interdyne-buff"

/datum/atom_skin/hypovial/interdyne_medium/custom
	preview_name = "Custom"
	new_icon_state = "hypovial-interdyne-custom"
	update_greyscale = TRUE

/obj/item/reagent_containers/cup/vial/interdyne_medium
	name = "medium mountable hypovial"
	icon_state = "hypovial-interdyne"
	fill_icon_state = "hypovial-interdyne_fill"
	desc = "A medium-size, 90u capacity vial with special mounting clamps and an Interdyne stamp."
	volume = 90
	possible_transfer_amounts = list(1,2,5,10,15,20,30,60,90)
	type_suffix = "-interdyne"
	greyscale_config = /datum/greyscale_config/hypovial/interdyne

/obj/item/reagent_containers/cup/vial/interdyne_medium/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hypovial/interdyne_medium)

/obj/item/reagent_containers/cup/vial/interdyne_medium/style/
	icon_state = "hypovial-interdyne"

//Styles
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/generic
	icon_state = "hypovial-interdyne-generic"
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/brute
	icon_state = "hypovial-interdyne-brute"
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/burn
	icon_state = "hypovial-interdyne-burn"
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/toxin
	icon_state = "hypovial-interdyne-tox"
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/oxy
	icon_state = "hypovial-interdyne-oxy"
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/crit
	icon_state = "hypovial-interdyne-crit"
/obj/item/reagent_containers/cup/vial/interdyne_medium/style/buff
	icon_state = "hypovial-interdyne-buff"

//Hypos that are in the CMO's kit round start
/obj/item/reagent_containers/cup/vial/large/deluxe
	name = "deluxe hypovial"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(/datum/reagent/medicine/omnizine = 15, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/cup/vial/large/salglu
	name = "large green hypovial (salglu)"
	icon_state = "hypoviallarge-oxy"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 50)

/obj/item/reagent_containers/cup/vial/large/synthflesh
	name = "large orange hypovial (synthflesh)"
	icon_state = "hypoviallarge-crit"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 50)

/obj/item/reagent_containers/cup/vial/large/multiver
	name = "large black hypovial (multiver)"
	icon_state = "hypoviallarge-tox"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 50)

//Some bespoke helper types for preloaded combat medkits.
/obj/item/reagent_containers/cup/vial/large/advbrute
	name = "Brute Heal"
	icon_state = "hypoviallarge-brute"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 50, /datum/reagent/medicine/sal_acid = 50)

/obj/item/reagent_containers/cup/vial/large/advburn
	name = "Burn Heal"
	icon_state = "hypoviallarge-burn"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 50, /datum/reagent/medicine/oxandrolone = 50)

/obj/item/reagent_containers/cup/vial/large/advtox
	name = "Toxin Heal"
	icon_state = "hypoviallarge-tox"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 100)

/obj/item/reagent_containers/cup/vial/large/advoxy
	name = "Oxy Heal"
	icon_state = "hypoviallarge-oxy"
	list_reagents = list(/datum/reagent/medicine/c2/tirimol = 50, /datum/reagent/medicine/salbutamol = 50)

/obj/item/reagent_containers/cup/vial/large/advcrit
	name = "Crit Heal"
	icon_state = "hypoviallarge-crit"
	list_reagents = list(/datum/reagent/medicine/atropine = 100)

/obj/item/reagent_containers/cup/vial/large/advomni
	name = "All-Heal"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(/datum/reagent/medicine/regen_jelly = 100)

/obj/item/reagent_containers/cup/vial/large/numbing
	name = "Numbing"
	icon_state = "hypoviallarge-generic"
	list_reagents = list(/datum/reagent/medicine/mine_salve = 50, /datum/reagent/medicine/morphine = 50)

//Some bespoke helper types for preloaded paramedic kits.
/obj/item/reagent_containers/cup/vial/small/libital
	name = "brute hypovial (libital)"
	icon_state = "hypovial-brute"

/obj/item/reagent_containers/cup/vial/small/libital/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/libital, amount = volume, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/lenturi
	name = "burn hypovial (lenturi)"
	icon_state = "hypovial-burn"

/obj/item/reagent_containers/cup/vial/small/lenturi/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/lenturi, amount = volume, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/seiver
	name = "tox hypovial (seiver)"
	icon_state = "hypovial-tox"

/obj/item/reagent_containers/cup/vial/small/seiver/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/seiver, amount = volume, reagtemp = 975, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/convermol
	name = "tox hypovial (convermol)"
	icon_state = "hypovial-oxy"

/obj/item/reagent_containers/cup/vial/small/convermol/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/convermol, amount = volume, added_purity = 1)

/obj/item/reagent_containers/cup/vial/small/atropine
	name = "crit hypovial (atropine)"
	icon_state = "hypovial-crit"

/obj/item/reagent_containers/cup/vial/small/atropine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/atropine, amount = volume, added_purity = 1)
