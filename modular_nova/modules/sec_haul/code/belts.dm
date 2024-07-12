/obj/item/storage/belt/security/full/PopulateContents()
	. = ..()

	if (!CONFIG_GET(flag/replace_secbelt_flashbangs_with_bola))
		return

	var/obj/item/grenade/flashbang/bang = locate(/obj/item/grenade/flashbang) in src
	if (!bang)
		return

	qdel(bang)
	new /obj/item/restraints/legcuffs/bola/energy(src)
