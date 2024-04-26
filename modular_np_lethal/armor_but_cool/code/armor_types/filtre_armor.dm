/datum/armor/armor_lethal_filtre
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_IV
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_SMALL
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID + 25
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_HIGH

/datum/armor/armor_lethal_filtre_super
	melee = ARMOR_LEVEL_MID + 25
	bullet = BULLET_ARMOR_V
	laser = ARMOR_LEVEL_MID + 25
	energy = ARMOR_LEVEL_SMALL
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID + 25
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/lethal_filtre
	name = "'Firuta' type IV full armor kit"
	desc = "A heavy full kit of armor for protecting every part of your body but the head with exceptional plating. \
		The armor's excessive bulk, however, makes the kit slow to move in. A small price to pay for such superior protection."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "filtre_light"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_giga_larp
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	max_integrity = 900
	limb_integrity = 600
	slowdown = 0.75
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam_super

/obj/item/clothing/suit/armor/lethal_filtre/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

/obj/item/clothing/suit/armor/lethal_filtre/examine_more(mob/user)
	. = ..()

	. += "What do you do when you need to protect a single point against an unknown number of attackers \
		with unknown gear and unknown approach? You simply prepare for everything of course. \
		Armor kits such as these are rarely standardized, being made up of multiple different \
		types of armor combined into a generally cohesive theme of providing full protection from everything."

	return .

/obj/item/clothing/suit/armor/lethal_filtre/heavy
	name = "'Firuta' type V heavy armor kit"
	desc = "An excessively heavy full kit of armor for protecting every part of your body but the head with exceptional plating. \
		The armor's insane bulk, however, makes the kit extremely slow to move in. A small price to pay for such superior protection."
	icon_state = "filtre_heavy"
	armor_type = /datum/armor/armor_lethal_filtre_super
	slowdown = 1.25

/obj/item/clothing/head/helmet/lethal_filtre_helmet
	name = "'Firuta' type V ballistic helmet"
	desc = "A high tech full-head helmet with supreme class V protection for the whole of the second \
		most important part of a marine's body. Vision is provided by an internal camera system, \
		the only signs of which on the outside are the twin pair of visible cameras on the front of the face. \
		There are, of course, more than this, but the visible ones are for the fun factor."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "larp"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_filtre_super
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	max_integrity = 800
	limb_integrity = 800
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam_super

/obj/item/clothing/head/helmet/lethal_filtre_helmet/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

/obj/item/clothing/head/helmet/lethal_filtre_helmet/examine_more(mob/user)
	. = ..()

	. += "What do you do when you need to protect a single point against an unknown number of attackers \
		with unknown gear and unknown approach? You simply prepare for everything of course. \
		Armor kits such as these are rarely standardized, being made up of multiple different \
		types of armor combined into a generally cohesive theme of providing full protection from everything."

	return .
