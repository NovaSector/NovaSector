//This file is for any station-aligned or neutral factions, not JUST Nanotrasen.
//Try to keep them all a subtype of centcom/nova, for file sorting and balance - all faction representatives should have the same/similarly armored uniforms

/obj/item/clothing/under/rank/centcom
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/centcom_digi.dmi'

/obj/item/clothing/under/rank/centcom/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/centcom.dmi'

/*
*	NANOTRASEN
*/
//Check modular_nova\modules\nanotrasen_naval_command\code\clothing.dm for more of these! (Or, currently, ALL of these.)

/*
*	LOPLAND (On the chopping block)
*/
/obj/item/clothing/under/rank/centcom/nova/lopland
	name = "\improper Contractor corporate uniform"
	desc = "A sleek jumpsuit worn by a PMC corporate. Its surprisingly well padded."
	icon_state = "lopland_shirt"
	worn_icon_state = "lopland_shirt"

/obj/item/clothing/under/rank/centcom/nova/lopland/instructor
	name = "\improper Contractor instructor's uniform"
	desc = "A over-the-top, militaristic jumpsuit worn by PMC-certified instructors, with a big PMC logo slapped on the back. The amount of pockets could make a space marine cry."
	icon_state = "lopland_tac"
	worn_icon_state = "lopland_tac"


/*
*	MISC
*/
// pizza and other misc ERTs in this file too?
