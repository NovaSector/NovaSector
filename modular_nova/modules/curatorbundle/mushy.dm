/obj/item/clothing/head/mush_helmet
	name = "mush cap"
	desc = "A mushroom cap, this one also doubles as an umbrella!"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/costume.dmi'
	worn_icon_state = "mush_cap"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/mush_helmet"
	post_init_icon_state = "mush_cap"
	greyscale_config = /datum/greyscale_config/mushcap
	greyscale_config_worn = /datum/greyscale_config/mushcap/worn
	greyscale_colors = "#eb0c07"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_1 = IS_PLAYER_COLORABLE_1


/datum/atom_skin/mushroom_suit
	abstract_type = /datum/atom_skin/mushroom_suit

/datum/atom_skin/mushroom_suit/male
	preview_name = "Male Mush"
	new_icon_state = "mush_male"

/datum/atom_skin/mushroom_suit/female
	preview_name = "Female Mush"
	new_icon_state = "mush_female"

/obj/item/clothing/suit/mush
	name = "mushroom suit"
	desc = "A mushroom suit, these can be sporadically seen being worn by the more fungal personalities."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "mush_male"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	slowdown = 1
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/mush/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/mushroom_suit)

/obj/item/storage/box/hero/mushperson
	name = "Mushy The Mushperson - 2305"
	desc = "Can you remember?"

/obj/item/storage/box/hero/mushperson/PopulateContents()
	new /obj/item/clothing/suit/mush(src)
	new /obj/item/clothing/head/mush_helmet(src)
	new /obj/item/mushpunch(src)
