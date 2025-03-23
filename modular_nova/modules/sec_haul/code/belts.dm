/obj/item/storage/belt/security/full/PopulateContents()
	. = ..()

	if(!CONFIG_GET(flag/replace_secbelt_flashbangs_with_bola))
		return
	if(!(/obj/item/grenade/flashbang in .))
		return
	. -= /obj/item/grenade/flashbang
	. += /obj/item/restraints/legcuffs/bola/energy
