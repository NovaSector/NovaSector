/obj/item/clothing/neck/collar/thick
	name = "thick choker"
	icon_state = "thick_choker"
	greyscale_config = /datum/greyscale_config/thick_collar
	greyscale_config_worn = /datum/greyscale_config/thick_collar/worn


/obj/item/clothing/neck/collar/thick/bell
	name = "thick bell collar"
	desc = /obj/item/clothing/neck/collar/bell::desc
	icon_state = "thick_bell_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/bell::greyscale_colors
	greyscale_config = /datum/greyscale_config/thick_collar/bell
	greyscale_config_worn = /datum/greyscale_config/thick_collar/bell/worn


/obj/item/clothing/neck/collar/thick/bell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/jingle.ogg'=1), 25, 50, 16)


/obj/item/clothing/neck/collar/thick/cowbell // I'd give this jingling too but it's harder to source a good sample
	name = "thick cowbell collar"
	desc = "A collar, fit with a locking buckle - only slight smaller compared to the cowbell attached to it's front!"
	icon_state = "thick_cowbell_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/cowbell::greyscale_colors
	greyscale_config = /datum/greyscale_config/thick_collar/cowbell
	greyscale_config_worn = /datum/greyscale_config/thick_collar/cowbell/worn


/obj/item/clothing/neck/collar/thick/cross
	name = "thick cross collar"
	desc = /obj/item/clothing/neck/collar/cross::desc
	icon_state = "thick_cross_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/cross::greyscale_colors
	greyscale_config = /datum/greyscale_config/thick_collar/cross
	greyscale_config_worn = /datum/greyscale_config/thick_collar/cross/worn


/obj/item/clothing/neck/collar/thick/tagged
	name = "thick tagged collar"
	desc = /obj/item/clothing/neck/collar/tagged::desc
	icon_state = "thick_tagged_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/tagged::greyscale_colors
	greyscale_config = /datum/greyscale_config/thick_collar/tagged
	greyscale_config_worn = /datum/greyscale_config/thick_collar/tagged/worn


/obj/item/clothing/neck/collar/thick/holocollar
	name = "thick holocollar"
	desc = /obj/item/clothing/neck/collar/holocollar::desc
	icon_state = "thick_holocollar"
	greyscale_colors = /obj/item/clothing/neck/collar/holocollar::greyscale_colors
	greyscale_config = /datum/greyscale_config/thick_collar/holo
	greyscale_config_worn = /datum/greyscale_config/thick_collar/holo/worn
