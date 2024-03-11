/obj/item/clothing/under/rank/civilian
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/obj/item/clothing/under/rank/civilian/lawyer // Lawyers' suits are in TG's suits.dmi
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/suits_digi.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit // EXCEPT THIS ONE.
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_slacks/worn/digi

/obj/item/clothing/under/rank/civilian/head_of_personnel/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE //Just gonna set it to default for ease

//TG's files separate this into Civilian, Clown/Mime, and Curator. We wont have as many, so all Service goes into this file.
//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/nova. USE /obj/item/clothing/under/suit/nova FOR MODULAR SUITS (civilian/suits.dm).

/*
*	HEAD OF PERSONNEL
*/

/obj/item/clothing/under/rank/civilian/head_of_personnel/nova/imperial //Rank pins of the Grand Moff
	name = "head of personnel's naval jumpsuit"
	desc = "A pale green naval suit and a rank badge denoting the Personnel Officer. Target, maximum firepower."
	icon_state = "imphop"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/nova/parade
	name = "head of personnel's male formal uniform"
	desc = "A luxurious uniform for the head of personnel, woven in a deep blue. On the lapel is a small pin in the shape of a corgi's head."
	icon_state = "hop_parade_male"

/obj/item/clothing/under/rank/civilian/head_of_personnel/nova/parade/female
	name = "head of personnel's female formal uniform"
	icon_state = "hop_parade_female"

/obj/item/clothing/under/rank/civilian/head_of_personnel/nova/turtleneck
	name = "head of personnel's turtleneck"
	desc = "A soft blue turtleneck and black khakis worn by Executives who prefer a bit more comfort over style."
	icon_state = "hopturtle"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/head_of_personnel/nova/turtleneck/skirt
	name = "head of personnel's turtleneck skirt"
	desc = "A soft blue turtleneck and black skirt worn by Executives who prefer a bit more comfort over style."
	icon_state = "hopturtle_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
