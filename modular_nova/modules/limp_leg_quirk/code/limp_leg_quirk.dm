/datum/quirk/item_quirk/limp_leg
	name = "Limp Leg"
	desc = "Your leg is limp, for one reason or another. A crutch helps you keep up with everyone else."
	icon = FA_ICON_WALKING
	value = -4
	gain_text = span_notice("You feel your leg give out beneath you.")
	lose_text = span_notice("Walking feels natural again.")
	medical_record_text = "The patient presents with a limp leg, limiting unaided movement."
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk_constant_data/limp_leg
	associated_typepath = /datum/quirk/item_quirk/limp_leg
	customization_options = list(/datum/preference/choiced/limp_leg)

/datum/quirk/item_quirk/limp_leg/add_unique(client/client_source)
	. = ..()

	give_item_to_holder(
		/obj/item/cane/crutch,
		list(
			LOCATION_HANDS,
		),
		flavour_text = "Your crutch is essential for moving at full speed. Don't lose it.",
		notify_player = TRUE,
	)

/datum/quirk/item_quirk/limp_leg/add(client/client_source)
	ADD_TRAIT(quirk_holder, TRAIT_PARALYSIS_L_LEG, QUIRK_TRAIT)

/datum/quirk/item_quirk/limp_leg/remove()
	REMOVE_TRAIT(quirk_holder, TRAIT_PARALYSIS_L_LEG, QUIRK_TRAIT)
