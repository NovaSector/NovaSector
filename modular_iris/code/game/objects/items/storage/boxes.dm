/obj/item/storage/box/disks_plantgene
	name = "plant data disks box"
	illustration = "disk_kit"

/obj/item/storage/box/disks_plantgene/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/plantgene(src)

/obj/item/storage/box/stickers
	custom_price = PAYCHECK_CREW * 2

/obj/item/sticker
	custom_price = PAYCHECK_CREW * 0.5

/obj/item/storage/box/stickers/hearts
	name = "heart sticker pack"
	desc = "A pack of heart-shaped stickers, popular among pediatric nurses across the galaxy."
	illustration = "heart"

/obj/item/storage/box/stickers/hearts/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/sticker/heart(src)

/obj/item/storage/box/stickers/stars
	name = "star sticker pack"
	desc = "Sparkle on! Don't forget to be yourself!"
	illustration = "star"

/obj/item/storage/box/stickers/stars/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/sticker/star(src)

/obj/item/storage/box/stickers/plush
	name = "plush sticker pack"
	desc = "Assorted stickers meant to resemble the huggable plushies of the station! These are far less huggable, unfortunately."
	illustration = "smile"

/obj/item/storage/box/stickers/plush/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/sticker/pbee(src)
		new /obj/item/sticker/psnake(src)
		new /obj/item/sticker/pliz(src)
		new /obj/item/sticker/robot(src)
