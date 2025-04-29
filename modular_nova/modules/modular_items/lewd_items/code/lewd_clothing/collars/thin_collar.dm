/obj/item/clothing/neck/collar/bell
	name = "bell collar"
	desc = "A collar, fit with a locking buckle - affixed with a tiny, ringing bell on the front."
	icon_state = "bell_collar"
	greyscale_colors = "#2d2d33#dead39"
	greyscale_config = /datum/greyscale_config/thin_collar/bell
	greyscale_config_worn = /datum/greyscale_config/thin_collar/bell/worn


/obj/item/clothing/neck/collar/bell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/jingle.ogg'=1), 25, 50, 16)


/obj/item/clothing/neck/collar/cowbell // I'd give this jingling too but it's harder to source a good sample
	name = "cowbell collar"
	desc = "A collar, fit with a locking buckle - practically a dwarf compared to the cowbell attached to it's front!"
	icon_state = "cowbell_collar"
	greyscale_colors = "#2d2d33#dead39"
	greyscale_config = /datum/greyscale_config/thin_collar/cowbell
	greyscale_config_worn = /datum/greyscale_config/thin_collar/cowbell/worn


/obj/item/clothing/neck/collar/cross
	name = "cross collar"
	desc = "A collar, fit with a locking buckle. This one's tag is a little cross."
	icon_state = "cross_collar"
	greyscale_colors = "#2d2d33#dead39"
	greyscale_config = /datum/greyscale_config/thin_collar/cross
	greyscale_config_worn = /datum/greyscale_config/thin_collar/cross/worn


/obj/item/clothing/neck/collar/tagged
	name = "tagged collar"
	desc = "A collar, fit with a locking buckle. This one's got a blank tag on the front, ready for engraving."
	icon_state = "tagged_collar"
	greyscale_colors = "#2d2d33#dead39"
	greyscale_config = /datum/greyscale_config/thin_collar/tagged
	greyscale_config_worn = /datum/greyscale_config/thin_collar/tagged/worn


/obj/item/clothing/neck/collar/holocollar
	name = "holocollar"
	desc = "A collar, fit with a locking buckle. This one's got a fancy holographic tag on the front."
	icon_state = "holocollar"
	greyscale_colors = "#2d2d33#dead39"
	greyscale_config = /datum/greyscale_config/thin_collar/holo
	greyscale_config_worn = /datum/greyscale_config/thin_collar/holo/worn
