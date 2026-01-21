/*
	there probably are boxes set up in one of these files, but i cant bother to search.
	if you have any item boxes to make put them here
*/

/obj/item/storage/box/syndicate/radio_cracker_kit
	name = "radio cracker kit"
	desc = "It's just an ordinary box."
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/syndicate/radio_cracker_kit/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/radio/headset/freerange(src)
	new /obj/item/paper/fluff/jobs/engineering/frequencies(src)
