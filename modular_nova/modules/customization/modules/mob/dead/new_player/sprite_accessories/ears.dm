/datum/sprite_accessory/ears
	key = "ears"
	generic = "Ears"
	organ_type = /obj/item/organ/ears_external
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	color_src = USE_MATRIXED_COLORS
	genetic = TRUE

/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.head)
		return FALSE

	// Can hide if wearing hat
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	// Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE

	// Hide accessory if flagged to do so
	if((wearer.head?.flags_inv & HIDEHAIR || wearer.wear_mask?.flags_inv & HIDEHAIR) \
		// This line basically checks if we FORCE accessory-ears to show, for items with earholes like Balaclavas and Luchador masks
		&& ((wearer.head && !(wearer.head.flags_inv & SHOWSPRITEEARS)) || (wearer.wear_mask && !(wearer.wear_mask?.flags_inv & SHOWSPRITEEARS))))
		return TRUE

	return FALSE

/datum/sprite_accessory/ears/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/ears/cat
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_HUMANOID, SPECIES_GHOUL)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	color_src = USE_ONE_COLOR
	has_inner = TRUE

/datum/sprite_accessory/ears/fox
	color_src = USE_ONE_COLOR
	has_inner = TRUE

/datum/sprite_accessory/ears/external
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/ears.dmi'
	organ_type = /obj/item/organ/ears_external
	color_src = USE_MATRIXED_COLORS
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_HUMANOID, SPECIES_GHOUL)
	uses_emissives = TRUE

/datum/sprite_accessory/ears/external/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/ears/external/big
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/ears_big.dmi'

/datum/sprite_accessory/ears/external/vulpkanin
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_VULP, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/ears/external/cat
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_TAJARAN, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/ears/external/akula
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_AQUATIC, SPECIES_AKULA, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/ears/external/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/bat
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/ears/external/bear
	name = "Bear"
	icon_state = "bear"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/bigwolf
	name = "Big Wolf"
	icon_state = "bigwolf"

/datum/sprite_accessory/ears/external/bigwolfinner
	name = "Big Wolf (ALT)"
	icon_state = "bigwolfinner"
	has_inner = TRUE

/datum/sprite_accessory/ears/external/bigwolfdark //alphabetical sort ignored here for ease-of-use
	name = "Dark Big Wolf"
	icon_state = "bigwolfdark"

/datum/sprite_accessory/ears/external/bigwolfinnerdark
	name = "Dark Big Wolf (ALT)"
	icon_state = "bigwolfinnerdark"
	has_inner = TRUE

/datum/sprite_accessory/ears/external/bunny
	name = "Bunny"
	icon_state = "bunny"

/datum/sprite_accessory/ears/external/cow
	name = "Cow"
	icon_state = "cow"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/curled
	name = "Curled Horn"
	icon_state = "horn1"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/ears/external/deer
	name = "Deer (Antler)"
	icon_state = "deer"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/ears/external/eevee
	name = "Eevee"
	icon_state = "eevee"

/datum/sprite_accessory/ears/external/eevee_alt
	name = "Eevee ALT"
	icon_state = "eevee_alt"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/ears/external/elf
	name = "Elf"
	icon_state = "elf"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY

/datum/sprite_accessory/ears/external/elf/wide
	name = "Wide Elf"
	icon_state = "elfwide"

/datum/sprite_accessory/ears/external/elf/broad
	name = "Broad Elf"
	icon_state = "elfbroad"

/datum/sprite_accessory/ears/external/elf/broad/reverse
	name = "Broad Elf, Reversed"
	icon_state = "elfbroadreverse"

/datum/sprite_accessory/ears/external/elf/longer
	name = "Longer Elf"
	icon_state = "elflonger"

/datum/sprite_accessory/ears/external/elephant
	name = "Elephant"
	icon_state = "elephant"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/fennec
	name = "Fennec"
	icon_state = "fennec"

/datum/sprite_accessory/ears/external/fish
	name = "Fish"
	icon_state = "fish"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/floppy
	name = "Floppy"
	icon_state = "floppy"

/datum/sprite_accessory/ears/external/vulpkanin/fox
	name = "Fox"
	icon_state = "fox"

/datum/sprite_accessory/ears/external/akula/hammerhead
	name = "Hammerhead"
	icon_state = "hammerhead"

/datum/sprite_accessory/ears/external/husky
	name = "Husky"
	icon_state = "wolf"

/datum/sprite_accessory/ears/external/jellyfish
	name = "Jellyfish"
	icon_state = "jellyfish"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"

/datum/sprite_accessory/ears/external/lab
	name = "Dog, Long"
	icon_state = "lab"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/murid
	name = "Murid"
	icon_state = "murid"

/datum/sprite_accessory/ears/external/vulpkanin/otie
	name = "Otusian"
	icon_state = "otie"

/datum/sprite_accessory/ears/external/protogen
	name = "Protogen"
	icon_state = "protogen"

/datum/sprite_accessory/ears/external/cat/cat_alt
	name = "Cat (Colorable Inner)"
	icon_state = "cat_alt"

/datum/sprite_accessory/ears/external/cat/cat_alt_behind_hair
	name = "Cat (Colorable Inner, Behind Hair)"
	icon_state = "cat_alt_underhair"

/datum/sprite_accessory/ears/external/cat/miqo_alt
	name = "Cat, Miqo'te (Colorable Inner)"
	icon_state = "miqo_alt"

/datum/sprite_accessory/ears/external/cat/lynx_alt
	name = "Cat, Lynx (Colorable Inner)"
	icon_state = "lynx_alt"

/datum/sprite_accessory/ears/external/cat/round_alt
	name = "Cat, Round (Colorable Inner)"
	icon_state = "round_alt"

/datum/sprite_accessory/ears/external/cat/fold_alt
	name = "Cat, Fold (Colorable Inner)"
	icon_state = "fold_alt"

/datum/sprite_accessory/ears/external/cat/big_alt
	name = "Cat, Big (Colorable Inner)"
	icon_state = "big_alt"

/datum/sprite_accessory/ears/external/cat/cat_alert
	name = "Cat, Alert"
	icon_state = "cat_alert"

/datum/sprite_accessory/ears/external/rabbit
	name = "Rabbit"
	icon_state = "rabbit"

/datum/sprite_accessory/ears/external/big/hare_large
	name = "Rabbit (Large)"
	icon_state = "bunny_large"

/datum/sprite_accessory/ears/external/big/bunny_large
	name = "Curved Rabbit Ears (Large)"
	icon_state = "rabbit_large"

/datum/sprite_accessory/ears/external/big/sandfox_large
	name = "Sandfox (Large)"
	icon_state = "sandfox_large"

/datum/sprite_accessory/ears/external/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/ears/external/akula/sergal
	name = "Sergal"
	icon_state = "sergal"

/datum/sprite_accessory/ears/external/skunk
	name = "skunk"
	icon_state = "skunk"

/datum/sprite_accessory/ears/external/squirrel
	name = "Squirrel"
	icon_state = "squirrel"

/datum/sprite_accessory/ears/external/vulpkanin/wolf
	name = "Wolf"
	icon_state = "wolf"

/datum/sprite_accessory/ears/external/vulpkanin/perky
	name = "Perky"
	icon_state = "perky"

/datum/sprite_accessory/ears/external/antenna_simple1
	name = "Insect antenna (coloring 2)"
	icon_state = "antenna_simple1"

/datum/sprite_accessory/ears/external/antenna_simple1_v2
	name = "Insect antenna (coloring 3)"
	icon_state = "antenna_simple1v2"

/datum/sprite_accessory/ears/external/antenna_simple2
	name = "Insect antenna 2 (coloring 2)"
	icon_state = "antenna_simple2"

/datum/sprite_accessory/ears/external/antenna_simple2_v2
	name = "Insect antenna 2 (coloring 3)"
	icon_state = "antenna_simple2v2"

/datum/sprite_accessory/ears/external/antenna_fuzzball
	name = "Fuzzball antenna (coloring 2+3)"
	icon_state = "antenna_fuzzball"

/datum/sprite_accessory/ears/external/antenna_fuzzball_v2
	name = "Fuzzball antenna (coloring 3+1)"
	icon_state = "antenna_fuzzballv2"

/datum/sprite_accessory/ears/external/setaceous
	name = "Setaceous Antenna"
	icon_state = "setaceous"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/setaceousm
	name = "Medium Setaceous Antenna"
	icon_state = "setaceousm"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/geniculate
	name = "Geniculate Antenna"
	icon_state = "geniculate"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/big/eyes
	name = "Eye Antenna"
	icon_state = "eyes"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"

/datum/sprite_accessory/ears/external/cobrahoodears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"

/datum/sprite_accessory/ears/external/miqote
	name = "Miqo'te"
	icon_state = "miqote"

/datum/sprite_accessory/ears/external/hare
	name = "Hare"
	icon_state = "rabbitalt"

/datum/sprite_accessory/ears/external/bunnyalt
	name = "Curved Rabbit Ears"
	icon_state = "bunnyalt"

/datum/sprite_accessory/ears/external/deerear
	name = "Deer (ear)"
	icon_state = "deerear"

/datum/sprite_accessory/ears/external/teshari
	recommended_species = list(SPECIES_TESHARI)

/datum/sprite_accessory/ears/external/teshari/regular
	name = "Teshari Regular"
	icon_state = "teshari_regular"

/datum/sprite_accessory/ears/external/teshari/feathers_bushy
	name = "Teshari Feathers Bushy"
	icon_state = "teshari_feathers_bushy"

/datum/sprite_accessory/ears/external/teshari/feathers_mohawk
	name = "Teshari Feathers Mohawk"
	icon_state = "teshari_feathers_mohawk"

/datum/sprite_accessory/ears/external/teshari/feathers_spiky
	name = "Teshari Feathers Spiky"
	icon_state = "teshari_feathers_spiky"

/datum/sprite_accessory/ears/external/teshari/feathers_pointy
	name = "Teshari Feathers Pointy"
	icon_state = "teshari_feathers_pointy"

/datum/sprite_accessory/ears/external/teshari/feathers_upright
	name = "Teshari Feathers Upright"
	icon_state = "teshari_feathers_upright"

/datum/sprite_accessory/ears/external/teshari/feathers_mane
	name = "Teshari Feathers Mane"
	icon_state = "teshari_feathers_mane"

/datum/sprite_accessory/ears/external/teshari/feathers_maneless
	name = "Teshari Feathers Mane Fluffless"
	icon_state = "teshari_feathers_maneless"

/datum/sprite_accessory/ears/external/teshari/feathers_droopy
	name = "Teshari Feathers Droopy"
	icon_state = "teshari_feathers_droopy"

/datum/sprite_accessory/ears/external/teshari/feathers_longway
	name = "Teshari Feathers Longway"
	icon_state = "teshari_feathers_longway"

/datum/sprite_accessory/ears/external/teshari/feathers_tree
	name = "Teshari Feathers Tree"
	icon_state = "teshari_feathers_tree"

/datum/sprite_accessory/ears/external/teshari/feathers_ponytail
	name = "Teshari Feathers Ponytail"
	icon_state = "teshari_feathers_ponytail"

/datum/sprite_accessory/ears/external/teshari/feathers_mushroom
	name = "Teshari Feathers Mushroom"
	icon_state = "teshari_feathers_mushroom"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/teshari/feathers_backstrafe
	name = "Teshari Feathers Backstrafe"
	icon_state = "teshari_feathers_backstrafe"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/teshari/feathers_thinmohawk
	name = "Teshari Feathers Thin Mohawk"
	icon_state = "teshari_feathers_thinmohawk"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/teshari/feathers_thin
	name = "Teshari Feathers Thin"
	icon_state = "teshari_feathers_thin"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/teshari/feathers_thinmane
	name = "Teshari Feathers Thin Mane"
	icon_state = "teshari_feathers_thinmane"

/datum/sprite_accessory/ears/external/teshari/feathers_thinmaneless
	name = "Teshari Feathers Thin Mane Fluffless"
	icon_state = "teshari_feathers_thinmaneless"

/datum/sprite_accessory/ears/external/deer2
	name = "Deer 2"
	icon_state = "deer2"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/external/mouse
	name = "Mouse"
	icon_state = "mouse"

/datum/sprite_accessory/ears/external/mouse_two
	name = "Mouse II"
	icon_state = "mouse_two"

/datum/sprite_accessory/ears/external/big/fourears1
	name = "Four Ears 1"
	icon_state = "four_ears_1"

/datum/sprite_accessory/ears/external/fourears2
	name = "Four Ears 2"
	icon_state = "four_ears_2"

/datum/sprite_accessory/ears/external/big/fourears3
	name = "Four Ears 3"
	icon_state = "four_ears_3"

/datum/sprite_accessory/ears/external/acrador
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/ears_big.dmi'
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/ears/external/acrador/long
	icon_state = "acrador_long"
	name = "Acrador (Long)"

/datum/sprite_accessory/ears/external/acrador/long/alt_1
	name = "Acrador Long (Alt 1)"
	icon_state = "acrador_long_alt_1"

/datum/sprite_accessory/ears/external/acrador/long/alt_2
	name = "Acrador Long (Alt 2)"
	icon_state = "acrador_long_alt_2"

/datum/sprite_accessory/ears/external/acrador/long/alt_3
	name = "Acrador Long (Alt 3)"
	icon_state = "acrador_long_alt_3"

/datum/sprite_accessory/ears/external/acrador/long/alt_4
	name = "Acrador Long (Alt 4)"
	icon_state = "acrador_long_alt_4"

/datum/sprite_accessory/ears/external/acrador/short
	icon_state = "acrador_short"
	name = "Acrador (Short)"

/datum/sprite_accessory/ears/external/acrador/short/alt_1
	name = "Acrador (Short) (Alt 1)"
	icon_state = "acrador_short_alt_1"

/datum/sprite_accessory/ears/external/acrador/short/alt_2
	name = "Acrador (Short) (Alt 2)"
	icon_state = "acrador_short_alt_2"

/datum/sprite_accessory/ears/external/acrador/short/alt_3
	name = "Acrador (Short) (Alt 3)"
	icon_state = "acrador_short_alt_3"

/datum/sprite_accessory/ears/external/acrador/short/alt_4
	name = "Acrador (Short) (Alt 4)"
	icon_state = "acrador_short_alt_4"

/datum/sprite_accessory/ears/external/possum
	name = "Possum"
	icon_state = "possum"

/datum/sprite_accessory/ears/external/lunasune
	name = "Lunasune"
	icon_state = "lunasune"

/datum/sprite_accessory/ears/external/hawk
	name = "Hawk"
	icon_state = "hawk"
