/obj/item/clothing/suit
	/// Does this object get cropped when worn by a taur on their suit or uniform slot?
	var/gets_cropped_on_taurs = TRUE

//Define worn_icon_digi below here for suits so we don't have to make whole new .dm files for each
/obj/item/clothing/suit/armor
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/armor_digi.dmi'

/obj/item/clothing/suit/bio_suit
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/bio_digi.dmi'

/obj/item/clothing/suit/wizrobe
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/wizard_digi.dmi'
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/labcoat_digi.dmi'

/obj/item/clothing/suit/space
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'

/obj/item/clothing/suit/chaplainsuit
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/chaplain_digi.dmi'

/obj/item/clothing/suit/hooded/chaplainsuit
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suits/chaplain_digi.dmi'

/obj/item/clothing/suit/chaplainsuit/habit
	greyscale_config = /datum/greyscale_config/chappy_habit
	greyscale_config_worn = /datum/greyscale_config/chappy_habit/worn
	greyscale_colors = "#373548#FFFFFF#D29722"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/hooded/chaplainsuit/monkhabit
	greyscale_config = /datum/greyscale_config/monk_habit
	greyscale_config_worn = /datum/greyscale_config/monk_habit/worn
	greyscale_colors = "#8C531A#9C7132"
	flags_1 = IS_PLAYER_COLORABLE_1

// Monk habit hood needs to match; code pulled from wintercoats.
/obj/item/clothing/suit/hooded/chaplainsuit/monkhabit/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.
	hood.update_slot_icon()

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/chaplainsuit/monkhabit/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.
