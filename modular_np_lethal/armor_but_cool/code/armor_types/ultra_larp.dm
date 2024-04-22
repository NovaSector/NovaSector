/datum/armor/armor_lethal_giga_larp
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_V
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/lethal_slick
	name = "'Surimu' type V armor vest"
	desc = "A surprisingly slim armor vest granting the strongest protection around against any threat ballistic. \
		Many of it's users refer to it by the slang term 'slick', whatever that means."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "slick"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_giga_larp
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	body_parts_covered = CHEST
	max_integrity = 500
	limb_integrity = 500
	repairable_by = null

/obj/item/clothing/suit/armor/lethal_slick/examine_more(mob/user)
	. = ..()

	. += "The rarest vest if not only on Mars where it's made, then in most of the galaxy. \
		Combining hundreds of years of military-industrial complex into an article of clothing \
		creates the single most protective vest on the market. Now, does it lack arms and legs? \
		Maybe. Does it make you into a god so long as you're not hit in the limbs? Yeah."

	return .

/obj/item/clothing/head/helmet/lethal_larp_helmet
	name = "'Hitsugi' type V ballistic helmet"
	desc = "A massive helmet made in compliment with the 'Surimu' armor vest type. \
		This beast shares almost none of the slim construction that the vest it compliments \
		sports, however. The mind is a terrible thing to waste, especially if it's wasted by \
		a giant bullet. Thankfully, this thing ought to stop such an event from taking place."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "larp"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_giga_larp
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	max_integrity = 500
	limb_integrity = 500
	repairable_by = null // No being cheeky and keeping a pile of repair materials in your bag to fix it either
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/lethal_larp_helmet/examine_more(mob/user)
	. = ..()

	. += "The rarest helmet if not only on Mars where it's made, then in most of the galaxy. \
		Combining hundreds of years of military-industrial complex into an article of clothing \
		creates the single most protective helmet on the market. Does it entirely suck to wear? \
		Yeah absolutely. Do you want your funeral to be open casket even after a .60 caliber round \
		to the head? It'll do that for you."

	return .
