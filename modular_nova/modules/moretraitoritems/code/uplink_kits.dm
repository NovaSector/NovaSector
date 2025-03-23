/obj/item/storage/box/syndie_kit/cultkisr
	name = "cult construct kit"
	desc = "A sleek, sturdy box with an ominous, dark energy inside. Yikes."

/obj/item/storage/box/syndie_kit/cultkitsr/PopulateContents()
	return list(
		/obj/item/storage/belt/soulstone/full/purified,
		/obj/item/sbeacondrop/constructshell,
		/obj/item/sbeacondrop/constructshell,
	)

/obj/item/sbeacondrop/constructshell
	desc = "A label on it reads: <i>Warning: Activating this device will send a Nar'sian construct shell to your location</i>."
	droptype = /obj/structure/constructshell

/obj/item/storage/belt/soulstone/full/purified/PopulateContents()
	. = list()
	for(var/i in 1 to 6)
		. += /obj/item/soulstone/anybody/purified
