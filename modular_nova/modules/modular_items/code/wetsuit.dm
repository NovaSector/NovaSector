/obj/item/clothing/under/akula_wetsuit/refit
	name = "\improper Refitted Shoredress wetsuit"
	desc = "The 'Wetworks'-pattern Shoredress is a long-standing template upon which most Azulean 'wetsuits' are made. \
		This atmospheric exploration suit is a single form-fitting garment, designed to keep wearers comfortable in the harsh environment of dry land; \
		even sometimes worn underneath orbital suits such as MODs. \n\n\
		This variation seems to have been refitted to a more standard body shape."
	worn_icon = 'modular_nova/modules/modular_items/icons/akulasuit.dmi'
	female_sprite_flags = FEMALE_UNIFORM_FULL

/obj/item/clothing/under/akula_wetsuit/refit/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this item.")

/obj/item/clothing/under/akula_wetsuit/refit/examine_more(mob/user)
	. = ..()

	. += "Shoredresses apply active thermal channels and motion-powered micropumps to allow for water of the wearer's temperature choice to circulate; \
		ensuring ample flow over not only the gills, but the rest of the wearer's skin, at the cost of occasional movement being needed when the wearer is still. \n\
		These suits are known to come with luminescent panels that take on a bright glow when underwater, meant for signalling as well as higher visibility in deep waters. \
		The system is meant to only be able to process water, fresh or otherwise; but unofficially, \
		a great many chemicals or even drinks have been loaded in by adventurous or careless explorers of the New Principalities-- at fantastic personal risk to their gills."
