/datum/armor/armor_lethal_paper_vest
	melee = ARMOR_LEVEL_WEAK
	bullet = BULLET_ARMOR_I
	laser = ARMOR_LEVEL_WEAK
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_WEAK
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_STANDARD

/obj/item/clothing/suit/armor/lethal_paper
	name = "'Kami' type I armor vest"
	desc = "A white-colored armor vest seen commonly as light armor used by thugs and bouncers all over Mars. \
		It feels like paper to the touch, but the manufacturer assures us it isn't just 100 layers of printer paper together."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "paper"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_paper_vest
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	max_integrity = 300
	limb_integrity = 300
	repairable_by = null

/obj/item/clothing/suit/armor/lethal_paper/examine_more(mob/user)
	. = ..()

	. += "It's actually 102 layers of paper together, and it's actually not printer paper, for real this time. \
		Special-grown plants (made by accident) on Mars have been turned into a paper-like material that turns out to be \
		surprisingly robust. While there are many live action roleplayers around the galaxy who believe this should be the \
		second great coming of old konjin paper armor, more practical thinkers have realized that this is an effective \
		source of armoring things in a relatively inexpensive way."

	return .
