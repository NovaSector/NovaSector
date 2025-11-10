// Most of these are just additions to allow certain cargo packs to exist. More will be on the way on additional PR's

/obj/item/storage/box/techshell
	name = "box of unloaded techshell"
	desc = "A box of technological shells. These come unloaded and ready for custom shot loads."

/obj/item/storage/box/techshell/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/techshell(src)

/obj/item/storage/box/lewd_toys
	name = "lewd toys box"
	desc = "Contains lewd implements for spending time alone, or together with someone! Try to hide it better next time."

/obj/item/storage/box/lewd_toys/PopulateContents()
	new /obj/item/clothing/sextoy/dildo(src)
	new /obj/item/clothing/sextoy/buttplug(src)
	new /obj/item/stack/shibari_rope/full(src)
	new /obj/item/spanking_pad(src)
	new /obj/item/clothing/mask/muzzle/ballgag(src)
	new /obj/item/clothing/suit/straight_jacket/shackles(src)
	new /obj/item/clothing/glasses/blindfold/dorms(src)
