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
