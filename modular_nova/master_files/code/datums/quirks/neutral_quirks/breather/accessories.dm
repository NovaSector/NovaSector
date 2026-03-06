/obj/item/clothing/accessory/breathing
	name = "breathing dogtag"
	desc = "A dogtag which labels what kind of gas a person may breathe."
	icon_state = "allergy"
	above_suit = FALSE
	attachment_slot = NONE
	var/breath_type

/obj/item/clothing/accessory/breathing/examine(mob/user)
	. = ..()
	. += "The dogtag reads: I breathe [breath_type]."

/obj/item/clothing/accessory/breathing/accessory_equipped(obj/item/clothing/under/uniform, user)
	. = ..()
	RegisterSignal(user, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/obj/item/clothing/accessory/breathing/accessory_dropped(obj/item/clothing/under/uniform, user)
	. = ..()
	UnregisterSignal(user, COMSIG_ATOM_EXAMINE)

/obj/item/clothing/accessory/breathing/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/accessory_wearer = user
	examine_list += "[accessory_wearer.p_Their()] <b>[name]</b> reads: 'I breathe [breath_type]'."
