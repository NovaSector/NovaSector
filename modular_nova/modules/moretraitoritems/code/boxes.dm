/*
	there probably are boxes set up in one of these files, but i cant bother to search.
	if you have any item boxes to make put them here
*/

/obj/item/storage/box/syndie_kit/radio_cracker_kit
	name = "radio cracker kit"

/obj/item/storage/box/syndie_kit/radio_cracker_kit/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/radio/headset/freerange(src)
	new /obj/item/paper/fluff/jobs/engineering/frequencies(src)
