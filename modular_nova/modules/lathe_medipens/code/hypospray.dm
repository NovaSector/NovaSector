/// Create subtype path for hypospray
#define HYPOSPRAY_PATH_HELPER(typename) /obj/item/reagent_containers/hypospray/##typename

/// Create empty subtype of medipen
#define EMPTY_MEDIPEN_HELPER(typename) HYPOSPRAY_PATH_HELPER(medipen/##typename/empty) {\
	init_empty = TRUE; \
	used_up = TRUE; \
} \

/obj/item/reagent_containers/hypospray/medipen
	/// If TRUE, the medipen will initialize without reagents
	var/init_empty = FALSE

// Allows medipens to initialize without reagents if init_empty is TRUE
/obj/item/reagent_containers/hypospray/medipen/Initialize(mapload)
	if(init_empty != TRUE)
		return ..()

	// Temporarily sets list_reagents to null to avoid filling the medipen
	var/initial_reagents = list_reagents
	list_reagents = null
	. = ..()
	list_reagents = initial_reagents

	if(label_examine)
		// Set label text via list_reagents, due to actual reagents being empty
		label_text = span_notice("There is a sticker pasted onto the side which reads, 'WARNING: This medipen contains [pretty_string_from_reagent_list(list_reagents, names_only = TRUE, join_text = ", ", final_and = TRUE, capitalize_names = TRUE)], do not use if allergic to any listed chemicals.")

/obj/item/reagent_containers/hypospray/medipen/empty
	init_empty = TRUE
	used_up = TRUE

// Creates /obj/item/reagent_containers/hypospray/medipen/atropine/empty
EMPTY_MEDIPEN_HELPER(atropine)

// Creates /obj/item/reagent_containers/hypospray/medipen/salbutamol/empty
EMPTY_MEDIPEN_HELPER(salbutamol)

// Creates /obj/item/reagent_containers/hypospray/medipen/oxandrolone/empty
EMPTY_MEDIPEN_HELPER(oxandrolone)

// Creates /obj/item/reagent_containers/hypospray/medipen/salacid/empty
EMPTY_MEDIPEN_HELPER(salacid)

// Creates /obj/item/reagent_containers/hypospray/medipen/penacid/empty
EMPTY_MEDIPEN_HELPER(penacid)

#undef HYPOSPRAY_PATH_HELPER
#undef EMPTY_MEDIPEN_HELPER

/obj/item/reagent_containers/hypospray/medipen/universal
	name = "\improper universal medipen"
	desc = "It's an auto-injecting syringe with a universal refill port on the side."
	icon = 'modular_nova/modules/lathe_medipens/icons/syringe.dmi'
	icon_state = "medipen_blue_unused"
	base_icon_state = "medipen_blue"
	worn_icon_state = "dnainjector0"
	inhand_icon_state = "dnainjector0"
	list_reagents = null
	label_examine = FALSE
	used_up = TRUE

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
	name = "\improper universal low-pressure medipen"
	desc = "It's a low-pressure auto-injecting syringe with a universal refill port on the side. WARNING: This device is designed to be operated in low-pressure environments only."
	icon_state = "medipen_red_unused"
	base_icon_state = "medipen_red"
	volume = 30
	amount_per_transfer_from_this = 30

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/update_icon_state()
	. = ..()
	if(reagents.total_volume == 0)
		icon_state = "[base_icon_state]0"
	else if(reagents.total_volume > (volume * 0.5))
		icon_state = base_icon_state
	else
		icon_state = "[base_icon_state]15"

/// Returns a list of overlays to add that relate to the reagents inside the syringe
/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/update_reagent_overlay()
	if(!reagents?.total_volume)
		return
	var/overlay_icon = "medipen"
	if(reagents.total_volume > (volume * 0.5))
		icon_state = base_icon_state
	else
		overlay_icon = "medipen_half"
	var/mutable_appearance/filling_overlay = mutable_appearance('modular_nova/modules/lathe_medipens/icons/reagent_fillings.dmi', overlay_icon)
	filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling_overlay

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/inject(mob/living/affected_mob, mob/user)
	// Calculate quantity to inject, depending on if the user is on lavaland.
	if(lavaland_equipment_pressure_check(get_turf(user)))
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
	else
		if(DOING_INTERACTION(user, DOAFTER_SOURCE_SURVIVALPEN))
			to_chat(user,span_notice("You are too busy to use \the [src]!"))
			return

		to_chat(user,span_notice("You start manually releasing the low-pressure gauge..."))
		if(!do_after(user, 10 SECONDS, affected_mob, interaction_key = DOAFTER_SOURCE_SURVIVALPEN))
			return

		amount_per_transfer_from_this = initial(amount_per_transfer_from_this) * 0.5

	// Attempt the injection
	. = ..()
	// Workaround to update icon and overlay after partial injection
	if(. && !used_up)
		update_appearance()
