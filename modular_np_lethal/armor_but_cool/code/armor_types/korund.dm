/obj/item/clothing/suit/armor/lethal_koranda
	name = "'Koranda' type II armor vest"
	desc = "An exceptionally large armor vest made of the same materials as the standard Solfed peacekeeper's kit. \
		The main benefit with a set such as this is the added protection for the legs with a large panel on the front \
		and back of the armor."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "korund"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_sf_peacekeeper
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|LEGS
	max_integrity = 500
	limb_integrity = 300
	repairable_by = null
	slowdown = 0.25

/obj/item/clothing/suit/armor/lethal_koranda/examine_more(mob/user)
	. = ..()

	. += "Constructed almost identically to the usual Solfed peacekeeper's vest, this was a special \
		made version of the armor for close range operations with relatively light armor requirements. \
		In many places, you won't need invincible armor to successful police work, just armor that will \
		stop weaker-energy ammunition over as many of the parts of your body as possible. Frontier police \
		doing as frontier police will do, of course, as resulted in this set being tacticool black."

	return .
