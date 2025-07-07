// LOADOUT ITEM DATUMS FOR THE MASK SLOT

/datum/loadout_category/face
	category_name = "Face"
	category_ui_icon = FA_ICON_MASK
	type_to_generate = /datum/loadout_item/mask
	tab_order = /datum/loadout_category/glasses::tab_order + 1

/datum/loadout_item/mask
	abstract_type = /datum/loadout_item/mask

/datum/loadout_item/mask/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.mask))
		..()
		return TRUE

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.mask)
			LAZYADD(outfit.backpack_contents, outfit.mask)
		outfit.mask = item_path
	else
		outfit.mask = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/mask/driscoll
	name = "Driscoll Mask"
	item_path = /obj/item/clothing/mask/gas/driscoll

/datum/loadout_item/mask/facescarf
	name = "Facescarf"
	item_path = /obj/item/clothing/mask/facescarf

/datum/loadout_item/mask/lollipop
	name = "Lollipop"
	item_path = /obj/item/food/lollipop

/datum/loadout_item/mask/neck_gaiter
	name = "Neck Gaiter"
	item_path = /obj/item/clothing/mask/neck_gaiter

/datum/loadout_item/mask/pipe
	name = "Pipe"
	item_path = /obj/item/cigarette/pipe

/datum/loadout_item/mask/corn_pipe
	name = "Pipe - Corn Cob"
	item_path = /obj/item/cigarette/pipe/cobpipe

/datum/loadout_item/mask/surgical
	name = "Sterile Mask (Colorable)"
	item_path = /obj/item/clothing/mask/surgical/greyscale

/*
*	BANDANAS
*/

/datum/loadout_item/mask/bandana
	name = "Bandana  (Colorable)"
	item_path = /obj/item/clothing/mask/bandana

/datum/loadout_item/mask/bandana_striped
	name = "Bandana  (Colorable, Striped)"
	item_path = /obj/item/clothing/mask/bandana/striped

/datum/loadout_item/mask/skull_bandana
	name = "Bandana  (Colorable, Skull)"
	item_path = /obj/item/clothing/mask/bandana/skull

/datum/loadout_item/mask/black_bandana
	name = "Bandana (Black)"
	item_path = /obj/item/clothing/mask/bandana/black

/datum/loadout_item/mask/blue_bandana
	name = "Bandana (Blue)"
	item_path = /obj/item/clothing/mask/bandana/blue

/datum/loadout_item/mask/gold_bandana
	name = "Bandana (Gold)"
	item_path = /obj/item/clothing/mask/bandana/gold

/datum/loadout_item/mask/green_bandana
	name = "Bandana (Green)"
	item_path = /obj/item/clothing/mask/bandana/green

/datum/loadout_item/mask/red_bandana
	name = "Bandana (Red)"
	item_path = /obj/item/clothing/mask/bandana/red

/*
*	BALACLAVAS
*/

/datum/loadout_item/mask/balaclava
	name = "Balaclava"
	item_path = /obj/item/clothing/mask/balaclava

/datum/loadout_item/mask/balaclavaadj
	name = "Balaclava - Adjustable"
	item_path = /obj/item/clothing/mask/balaclava/adjustable

/datum/loadout_item/mask/balaclavathree
	name = "Balaclava - Three-Hole (Black)"
	item_path = /obj/item/clothing/mask/balaclava/threehole

/datum/loadout_item/mask/balaclavagreen
	name = "Balaclava - Three-Hole (Green)"
	item_path = /obj/item/clothing/mask/balaclava/threehole/green

/*
*	GAS MASKS
*/

/datum/loadout_item/mask/gas_mask
	name = "Gas Mask"
	item_path = /obj/item/clothing/mask/gas

/datum/loadout_item/mask/gas_alt
	name = "Gas Mask - Alt"
	item_path = /obj/item/clothing/mask/gas/alt

/datum/loadout_item/mask/gas_glass
	name = "Gas Mask - Glass"
	item_path = /obj/item/clothing/mask/gas/glass

/datum/loadout_item/mask/respirator
	name = "Half Mask Respirator"
	item_path = /obj/item/clothing/mask/gas/respirator

/*
*	COSTUME
*/

/datum/loadout_item/mask/fake_mustache
	name = "Fake Moustache"
	item_path = /obj/item/clothing/mask/fakemoustache
	group = "Costumes"

/datum/loadout_item/mask/joy
	name = "Joy Mask"
	item_path = /obj/item/clothing/mask/joy
	group = "Costumes"

/datum/loadout_item/mask/kitsune
	name = "Kitsune Mask"
	item_path = /obj/item/clothing/mask/kitsune
	group = "Costumes"

/datum/loadout_item/mask/monkey
	name = "Monkey Mask"
	item_path = /obj/item/clothing/mask/gas/monkeymask
	group = "Costumes"

/datum/loadout_item/mask/owl
	name = "Owl Mask"
	item_path = /obj/item/clothing/mask/gas/owl_mask
	group = "Costumes"

/datum/loadout_item/mask/paper
	name = "Paper Mask"
	item_path = /obj/item/clothing/mask/paper
	group = "Costumes"

/datum/loadout_item/mask/plague_doctor
	name = "Plague Doctor Mask"
	item_path = /obj/item/clothing/mask/gas/plaguedoctor
	group = "Costumes"

/datum/loadout_item/mask/rebellion
	name = "Rebellion Mask"
	item_path = /obj/item/clothing/mask/rebellion
	group = "Costumes"

// MASQUERADE MASKS
/datum/loadout_item/mask/masquerade
	name = "Masquerade Mask"
	item_path = /obj/item/clothing/mask/masquerade
	group = "Costumes"

/datum/loadout_item/mask/masquerade/two_colors
	name = "Masquerade Mask - Split"
	item_path = /obj/item/clothing/mask/masquerade/two_colors
	group = "Costumes"

/datum/loadout_item/mask/masquerade/feathered
	name = "Masquerade Mask - Feathered"
	item_path = /obj/item/clothing/mask/masquerade/feathered
	group = "Costumes"

/datum/loadout_item/mask/masquerade/two_colors/feathered
	name = "Masquerade Mask - Feathered, Split"
	item_path = /obj/item/clothing/mask/masquerade/two_colors/feathered
	group = "Costumes"

/*
*	JOB-LOCKED
*/
// No group (groups should be ~5+ items)

/datum/loadout_item/mask/whistlesec
	name = "Police Whistle"
	item_path = /obj/item/clothing/mask/whistle
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/*
*	DONATOR
*/

/datum/loadout_item/mask/donator
	abstract_type = /datum/loadout_item/mask/donator
	donator_only = TRUE
