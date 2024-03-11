//File for modular wintercoats that aren't bundled with other stuff
//If the coat is part of a module (i.e. the Blueshield coat) then make sure it's subtyped under wintercoat/nova, but don't put it in this file!

//Coat Basetype (The Assistant's Formal Coat)
/obj/item/clothing/suit/hooded/wintercoat/nova
	name = "assistant's formal winter coat"
	desc = "A dark gray winter coat with bronze-gold detailing, and a zipper in the shape of a toolbox."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coataformal"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/nova

//Hood Basetype (The Assistant's Formal Coat Hood)
/obj/item/clothing/head/hooded/winterhood/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "hood_aformal"

//Bartender
/obj/item/clothing/suit/hooded/wintercoat/nova/bartender
	name = "bartender's winter coat"
	desc = "A heavy jacket made from wool originally stolen from the chef's goat. This new design is made to fit the classic suit-and-tie aesthetic, but without the hypothermia."
	icon_state = "coatbar"
	allowed = list(
		/obj/item/reagent_containers/cup/glass/shaker,
		/obj/item/reagent_containers/cup/glass/flask,
		/obj/item/reagent_containers/cup/rag
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/nova/bartender

/obj/item/clothing/head/hooded/winterhood/nova/bartender
	icon_state = "hood_bar"

//Ratvar-themed
/obj/item/clothing/suit/hooded/wintercoat/nova/ratvar
	name = "ratvarian winter coat"
	desc = "A brass-plated button up winter coat. Instead of a zipper tab, it has a brass cog with a tiny red gemstone inset."
	icon_state = "coatratvar"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/nova/ratvar

/obj/item/clothing/head/hooded/winterhood/nova/ratvar
	icon_state = "hood_ratvar"

//Nar'sie-themed
/obj/item/clothing/suit/hooded/wintercoat/nova/narsie
	name = "narsian winter coat"
	desc = "A somber button-up in dark tones of grey entropy and a wicked crimson zipper. It's covered in intricate runes and symbols, and the zipper tab looks like a single drop of blood."
	icon_state = "coatnarsie"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/nova/narsie

/obj/item/clothing/head/hooded/winterhood/nova/narsie
	desc = "A black winter hood full of whispering secrets that only she shall ever know."
	icon_state = "hood_narsie"

//Christmas
/obj/item/clothing/suit/hooded/wintercoat/nova/christmas
	name = "christmas winter coat"
	desc = "A festive Christmas coat, warm and lined with white, soft fabric. The zipper tab is a small Candy Cane!"
	icon_state = "coatchristmas"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/nova/christmas

/obj/item/clothing/head/hooded/winterhood/nova/christmas
	icon_state = "hood_christmas"

/obj/item/clothing/suit/hooded/wintercoat/nova/christmas/green
	icon_state = "coatchristmas_green"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/nova/christmas/green

/obj/item/clothing/head/hooded/winterhood/nova/christmas/green
	icon_state = "hood_christmas_green"
