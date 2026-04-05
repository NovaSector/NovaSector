//masks

//parent type
/obj/item/clothing/mask/patho
	icon = 'modular_iris/modules/provenance_ports/costumes/patho/icons/masks/patho_masks.dmi'
	worn_icon = 'modular_iris/modules/provenance_ports/costumes/patho/icons/masks/patho_masks_worn.dmi'
	lefthand_file = 'modular_iris/modules/provenance_ports/costumes/patho/icons/masks/patho_masks_lefthand.dmi'
	righthand_file = 'modular_iris/modules/provenance_ports/costumes/patho/icons/masks/patho_masks_righthand.dmi'

/obj/item/clothing/mask/patho/tragedian
	name = "tragedian's mask"
	desc = "A simple white mask often used in tragic plays."
	icon_state = "tragedian_mask"
	inhand_icon_state = "tragedian_mask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEEARS

/obj/item/clothing/mask/patho/orderly
	name = "orderly's mask"
	desc = "Birdies, birdies... gather ye here 'round the marble nest."
	icon_state = "orderly_mask"
	inhand_icon_state = "orderly_mask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEEARS

//suits

//parent type
/obj/item/clothing/suit/patho
	icon = 'modular_iris/modules/provenance_ports/costumes/patho/icons/suits/patho_suits.dmi'
	worn_icon = 'modular_iris/modules/provenance_ports/costumes/patho/icons/suits/patho_suits_worn.dmi'
	lefthand_file = 'modular_iris/modules/provenance_ports/costumes/patho/icons/suits/patho_suits_lefthand.dmi'
	righthand_file = 'modular_iris/modules/provenance_ports/costumes/patho/icons/suits/patho_suits_righthand.dmi'

/obj/item/clothing/suit/patho/tragedian
	name = "tragedian's suit"
	desc = "A form fitting black suit used by certain actors in tragic plays."
	icon_state = "tragedian_suit"
	inhand_icon_state = "tragedian_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/patho/orderly
	name = "orderly's costume"
	desc = "A heavy cloak used in plays, often repurposed to help protect against disease."
	icon_state = "orderly_costume"
	inhand_icon_state = "orderly_costume"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER

/obj/item/clothing/suit/patho/thanatologist
	name = "thanatologist's coat"
	desc = "The clothes of the prickliest prick who'd have us all buried."
	icon_state = "thanatologists_coat"
	inhand_icon_state = "thanatologists_coat"
	body_parts_covered = ARMS

/obj/item/clothing/suit/patho/physician
	name = "physician's coat"
	desc = "A coat to which clings the pungent odor of twire."
	icon_state = "physicians_coat"
	inhand_icon_state = "physicians_coat"
	body_parts_covered = ARMS

/obj/item/clothing/suit/patho/miraculist
	name = "miraculist's coat"
	desc = "The coat of a thief, or perhaps not."
	icon_state = "miraculists_coat"
	inhand_icon_state = "miraculists_coat"
	body_parts_covered = ARMS

//shoes

//parent type
/obj/item/clothing/shoes/patho
	icon = 'modular_iris/modules/provenance_ports/costumes/patho/icons/shoes/patho_shoes.dmi'
	worn_icon = 'modular_iris/modules/provenance_ports/costumes/patho/icons/shoes/patho_shoes_worn.dmi'
	lefthand_file = 'modular_iris/modules/provenance_ports/costumes/patho/icons/shoes/patho_shoes_lefthand.dmi'
	righthand_file = 'modular_iris/modules/provenance_ports/costumes/patho/icons/shoes/patho_shoes_righthand.dmi'

/obj/item/clothing/shoes/patho/thanatologist
	name = "thanatologist's boots"
	desc = "Heavy black boots for walking through diseased terrain unharmed."
	icon_state = "thanatologists_boots"
	inhand_icon_state = "thanatologists_boots"

/obj/item/clothing/shoes/patho/physician
	name = "physician's boots"
	desc = "A pair of brown boots."
	icon_state = "physicians_boots"
	inhand_icon_state = "physicians_boots"

/obj/item/clothing/shoes/patho/miraculist
	name = "miraculist's boots"
	desc = "A pair of light brown boots with ankle high socks."
	icon_state = "miraculists_boots"
	inhand_icon_state = "miraculists_boots"
