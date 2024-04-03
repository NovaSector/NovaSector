// Kneepad parent and three variants
/obj/item/clothing/accessory/kneepad
	name = "\improper kneepad"
	desc = "The parent to all kneepads"
	icon = 'modular_np_lethal/knee_pads/icons/object.dmi'
	worn_icon = 'modular_np_lethal/knee_pads/icons/on_mob.dmi'
	icon_state = "kneepad_cheap"
	slot_flags = ITEM_SLOT_ON_BODY
	attachment_slot = LEGS

/obj/item/clothing/accessory/kneepad/cheap
	name = "improvised kneepads"
	desc = "An old backpack and sheet steel sign have found new life as craftmade PPE. \
	These types of kneepads are common both with freelance scavs and as in field replacements \
	for the attrition experienced by factory made gear."

/obj/item/clothing/accessory/kneepad/basic
	name = "kneepads"
	desc = "Innumerable indistinguishable kneepads like this pair are issued to contract scavenge techs. \
	The compression sleeves are said to improve leg posture, but they tend to lose their elasticity with \
	extended use."
	icon_state = "kneepad_basic"

/obj/item/clothing/accessory/kneepad/expensive
	name = "Lopland Tactical Knee Defenders"
	desc = "The Lopland Tactical catalogue devotes two paragraphs to explaining the features on these kneepads, \
	but it still isn't clear how different they are from cheaper models. Some operatives and private owners alike \
	swear they last longer, though."
	icon_state = "kneepad_expensive"
