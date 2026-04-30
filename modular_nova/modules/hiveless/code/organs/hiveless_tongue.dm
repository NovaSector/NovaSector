/// Obligate-carnivore tongue: meat/gore liked, plants toxic.
/obj/item/organ/tongue/hiveless
	name = "hiveless tongue"
	desc = "A rasping, serrated tongue that clearly evolved to strip meat from bone."
	liked_foodtypes = MEAT | GORE | SEAFOOD | RAW
	disliked_foodtypes = GRAIN | DAIRY | CLOTH | FRIED | SUGAR
	toxic_foodtypes = VEGETABLES | FRUIT
