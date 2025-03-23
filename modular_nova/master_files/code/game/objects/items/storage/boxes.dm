// Most of these are just additions to allow certain cargo packs to exist. More will be on the way on additional PR's

/obj/item/storage/box/techshell
	name = "box of unloaded techshell"
	desc = "A box of technological shells. These come unloaded and ready for custom shot loads."

/obj/item/storage/box/techshell/PopulateContents()
	. = list()
	for(var/i in 1 to 7)
		. += /obj/item/ammo_casing/shotgun/techshell

/obj/item/storage/box/lewd_toys
	name = "lewd toys box"
	desc = "Contains lewd impliments for spending time alone, or together with someone! Try to hide it better next time."

/obj/item/storage/box/lewd_toys/PopulateContents()
	return list(
		/obj/item/clothing/sextoy/dildo,
		/obj/item/clothing/sextoy/buttplug,
		/obj/item/stack/shibari_rope/full,
		/obj/item/spanking_pad,
		/obj/item/clothing/mask/ballgag,
		/obj/item/clothing/suit/straight_jacket/shackles,
		/obj/item/clothing/glasses/blindfold/dorms,
	)
