/datum/sprite_accessory/xenodorsal
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	key = FEATURE_XENODORSAL
	color_src = USE_ONE_COLOR
	organ_type = /obj/item/organ/xenodorsal
	flags_custom_mod_icon = MOD_ACCESSORY_CHESTPLATE

/datum/sprite_accessory/xenodorsal/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	natural_spawn = FALSE

/datum/sprite_accessory/xenodorsal/standard
	name = "Standard"
	icon_state = "standard"

/datum/sprite_accessory/xenodorsal/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/xenodorsal/down
	name = "Dorsal Down"
	icon_state = "down"

//TAILS
/datum/sprite_accessory/tails/mammal/wagging/xeno_tail
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	name = "Xenomorph Tail"
	icon_state = "xeno"
	recommended_species = list(SPECIES_XENO = 1)

//HEADS
/datum/sprite_accessory/xenohead
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	key = FEATURE_XENOHEAD
	organ_type = /obj/item/organ/xenohead

/datum/sprite_accessory/xenohead/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	natural_spawn = FALSE

/datum/sprite_accessory/xenohead/standard
	name = "Standard"
	icon_state = "standard"

/datum/sprite_accessory/xenohead/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/xenohead/net
	name = "Nethead"
	icon_state = "net"

/datum/sprite_accessory/xenohead/warrior
	name = "Warrior"
	icon_state = "warrior"
