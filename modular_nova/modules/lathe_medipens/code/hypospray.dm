/obj/item/reagent_containers/hypospray/medipen/universal
	name = "universal medipen"
	desc = "It's an auto-injecting syringe with a universal refill port on the side."
	icon = 'modular_nova/modules/lathe_medipens/icons/syringe.dmi'
	worn_icon_state = "dnainjector0"
	inhand_icon_state = "dnainjector0"
	list_reagents = null
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/universal/update_overlays()
	. = ..()
	var/list/reagent_overlays = update_reagent_overlay()
	if(reagent_overlays)
		. += reagent_overlays

/// Returns a list of overlays to add that relate to the reagents inside the syringe
/obj/item/reagent_containers/hypospray/medipen/universal/proc/update_reagent_overlay()
	if(reagents?.total_volume)
		var/mutable_appearance/filling_overlay = mutable_appearance('modular_nova/modules/lathe_medipens/icons/reagent_fillings.dmi', "medipen")
		filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling_overlay
