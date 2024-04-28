/datum/armor/armor_lethal_filtre
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_IV
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID + 25
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_HIGH

/datum/armor/armor_lethal_filtre_super
	melee = ARMOR_LEVEL_MID + 25
	bullet = BULLET_ARMOR_V
	laser = ARMOR_LEVEL_MID + 25
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID + 25
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/lethal_filtre
	name = "'Firuta' type IV high mobility armor kit"
	desc = "A heavy full kit of armor for protecting every part of your body but the head and legs with exceptional plating. \
		The armor's excessive bulk, however, makes the kit slow to move in. A small price to pay for such superior protection."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "filtre_light"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_giga_larp
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	body_parts_covered = CHEST|GROIN|ARMS
	max_integrity = 1200
	limb_integrity = 900
	slowdown = 0.5
	equip_delay_self = 10 SECONDS

/obj/item/clothing/suit/armor/lethal_filtre/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		light_icon_state = null, \
		light_overlay_icon = null, \
		light_overlay = null, \
		)

/obj/item/clothing/suit/armor/lethal_filtre/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

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
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	slowdown = 1.25
	max_integrity = 1600
	limb_integrity = 1100

/obj/item/clothing/suit/armor/lethal_filtre/heavy/giggler
	name = "'Armageddon' type V heavy armor kit"
	desc = "An excessively heavy full kit of armor for protecting every part of your body but the head with exceptional plating. \
		The armor's insane bulk, however, makes the kit extremely slow to move in. A small price to pay for such superior protection. \
		This one appears to have been modified with extra plating and red markings, but remains otherwide identical in performance \
		to the standard filtre's armor."
	icon_state = "filtre_heavy_armageddon"

/obj/item/clothing/head/helmet/lethal_filtre_helmet
	name = "'Firuta' type V ballistic helmet"
	desc = "A high tech full-head helmet with supreme class V protection for the whole of the second \
		most important part of a marine's body. Vision is provided by an internal camera system, \
		the only signs of which on the outside are the twin pair of visible cameras on the front of the face. \
		There are, of course, more than this, but the visible ones are for the fun factor."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "filtre_helmet"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_filtre_super
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	max_integrity = 900
	limb_integrity = 900
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/lethal_filtre_helmet/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

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

/obj/item/clothing/head/helmet/lethal_filtre_helmet/giggler
	name = "'Armageddon' type V ballistic helmet"
	desc = "A high tech full-head helmet with supreme class V protection for the whole of the second \
		most important part of a marine's body. Vision is provided by an internal camera system. \
		This one appears to be modified with a more visible HUD system, as well as a bright-red \
		face shield that someone has painted a smiley face on."
	icon_state = "filtre_helmet_armageddon"
