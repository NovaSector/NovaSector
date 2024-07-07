/obj/item/reagent_containers/hypospray/medipen/universal
	name = "universal medipen"
	desc = "It's an auto-injecting syringe with a universal refill port on the side."
	icon = 'modular_nova/modules/lathe_medipens/icons/syringe.dmi'
	icon_state = "medipen_blue"
	base_icon_state = "medipen_blue"
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
	if(!reagents?.total_volume)
		return
	var/mutable_appearance/filling_overlay = mutable_appearance('modular_nova/modules/lathe_medipens/icons/reagent_fillings.dmi', "medipen")
	filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling_overlay

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure
	name = "universal low-pressure medipen"
	desc = "It's a low-pressure auto-injecting syringe with a universal refill port on the side."
	icon_state = "medipen_red"
	base_icon_state = "medipen_red"
	volume = 30
	amount_per_transfer_from_this = 30

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume * 0.5)
		icon_state = base_icon_state
	else if(reagents.total_volume == 0)
		icon_state = "[base_icon_state]0"
	else
		icon_state = "[base_icon_state]15"

/// Returns a list of overlays to add that relate to the reagents inside the syringe
/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/update_reagent_overlay()
	if(!reagents?.total_volume)
		return
	var/overlay_icon = "medipen_half"
	if(reagents.total_volume >= volume * 0.5)
		overlay_icon = "medipen"
	var/mutable_appearance/filling_overlay = mutable_appearance('modular_nova/modules/lathe_medipens/icons/reagent_fillings.dmi', overlay_icon)
	filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling_overlay

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/inject(mob/living/affected_mob, mob/user)
	if(lavaland_equipment_pressure_check(get_turf(user)))
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
		return ..()

	if(DOING_INTERACTION(user, DOAFTER_SOURCE_SURVIVALPEN))
		to_chat(user,span_notice("You are too busy to use \the [src]!"))
		return

	to_chat(user,span_notice("You start manually releasing the low-pressure gauge..."))
	if(!do_after(user, 10 SECONDS, affected_mob, interaction_key = DOAFTER_SOURCE_SURVIVALPEN))
		return

	amount_per_transfer_from_this = initial(amount_per_transfer_from_this) * 0.5
	. = ..()
	amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
