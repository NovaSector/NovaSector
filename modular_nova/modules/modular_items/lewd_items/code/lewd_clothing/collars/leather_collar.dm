/obj/item/clothing/neck/collar/leather
	name = "leather collar"
	desc = "A firm collar made of leather; fit with a locking clasp. There's a little metallic ring on the front."
	icon_state = "leather_collar"
	greyscale_colors = "#2d2d33#9b111e"
	greyscale_config = /datum/greyscale_config/leather_collar
	greyscale_config_worn = /datum/greyscale_config/leather_collar/worn


/obj/item/clothing/neck/collar/leather/bell
	name = "leather bell collar"
	desc = /obj/item/clothing/neck/collar/bell::desc
	icon_state = "leather_bell_collar"
	greyscale_colors = "#2d2d33#9b111e#dead39"
	greyscale_config = /datum/greyscale_config/leather_collar/bell
	greyscale_config_worn = /datum/greyscale_config/leather_collar/bell/worn


/obj/item/clothing/neck/collar/leather/bell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/jingle.ogg'=1), 25, 50, 16)


/obj/item/clothing/neck/collar/leather/cowbell // I'd give this jingling too but it's harder to source a good sample
	name = "leather cowbell collar"
	desc = /obj/item/clothing/neck/collar/thick/cowbell::desc
	icon_state = "leather_cowbell_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/leather/bell::greyscale_colors
	greyscale_config = /datum/greyscale_config/leather_collar/cowbell
	greyscale_config_worn = /datum/greyscale_config/leather_collar/cowbell/worn


/obj/item/clothing/neck/collar/leather/cross
	name = "leather cross collar"
	desc = /obj/item/clothing/neck/collar/cross::desc
	icon_state = "leather_cross_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/leather/bell::greyscale_colors
	greyscale_config = /datum/greyscale_config/leather_collar/cross
	greyscale_config_worn = /datum/greyscale_config/leather_collar/cross/worn


/obj/item/clothing/neck/collar/leather/tagged
	name = "leather tagged collar"
	desc = /obj/item/clothing/neck/collar/tagged::desc
	icon_state = "leather_tagged_collar"
	greyscale_colors = /obj/item/clothing/neck/collar/leather/bell::greyscale_colors
	greyscale_config = /datum/greyscale_config/leather_collar/tagged
	greyscale_config_worn = /datum/greyscale_config/leather_collar/tagged/worn


/obj/item/clothing/neck/collar/leather/holocollar
	name = "leather holocollar"
	desc = /obj/item/clothing/neck/collar/holocollar::desc
	icon_state = "leather_holocollar"
	greyscale_colors = /obj/item/clothing/neck/collar/leather/bell::greyscale_colors
	greyscale_config = /datum/greyscale_config/leather_collar/holo
	greyscale_config_worn = /datum/greyscale_config/leather_collar/holo/worn
