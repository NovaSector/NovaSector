//genin are on a similar power level as gaksters, but with different focuses and unusual secondary advantages.

//the kudagitsune are support fighters that get weak (tier ii-ish) but feature rich armor.
/datum/armor/armor_lethal_kudagitsune
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_II
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

//the baku are frontline combatants that get mid tier gakster armor (tier iii-ish)
/datum/armor/armor_lethal_baku
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_II + 10
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

//the chunin are filtres with anime powers, they get filtres-level gear
/datum/armor/armor_lethal_chunin
	melee = ARMOR_LEVEL_MID + 20
	bullet = BULLET_ARMOR_IV
	laser = ARMOR_LEVEL_MID + 10
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID + 25
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/head/helmet/lethal_filtre_helmet/kitsune
	name = "'Ninko' helmet system"
	desc = "A complex helmet system that sacrifices some armor plating for a suite of sensors and signal amplifiers \
	that serve to augment the wearer's situational awareness, sensory capacity, and tactical effect."
	icon = 'modular_np_lethal/ninja_stuff/icons/armor.dmi'
	icon_state = "genin_helmet_kitsune"
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/armor_worn.dmi'
	armor_type = /datum/armor/armor_lethal_kudagitsune
	max_integrity = 400
	limb_integrity = 400
	clothing_traits = list(
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_REAGENT_SCANNER,
		TRAIT_MEDICAL_HUD,
	)

/obj/item/clothing/head/helmet/lethal_filtre_helmet/kitsune/equipped(mob/living/carbon/human/user, slot)
	..()
	if(!(slot & ITEM_SLOT_HEAD))
		return
	for(var/hudtype in list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED))
		var/datum/atom_hud/atom_hud = GLOB.huds[hudtype]
		atom_hud.show_to(user)

/obj/item/clothing/head/helmet/lethal_filtre_helmet/kitsune/dropped(mob/living/carbon/human/user)
	..()
	if(!istype(user) || user.head != src)
		return
	for(var/hudtype in list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED))
		var/datum/atom_hud/atom_hud = GLOB.huds[hudtype]
		atom_hud.hide_from(user)

/obj/item/clothing/head/helmet/lethal_filtre_helmet/oni
	name = "'Bakemono' helmet system"
	desc = "An armored helmet system that makes no sacrifices in terms of protection. The plating is a laminate blend \
	of ceramic, petrochemical resins, and oriented titanium strands that can stand up to more abuse than sacrificial \
	ceramic plates alone."
	icon = 'modular_np_lethal/ninja_stuff/icons/armor.dmi'
	icon_state = "genin_helmet_oni"
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/armor_worn.dmi'
	armor_type = /datum/armor/armor_lethal_baku
	max_integrity = 600
	limb_integrity = 600

/obj/item/clothing/head/helmet/lethal_filtre_helmet/oni/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type, damage_type)
	. = ..()

	if(istype(hitby, /obj/projectile))
		var/obj/projectile/incoming_projectile = hitby
		incoming_projectile.armour_penetration = 0
		playsound(src, SFX_RICOCHET, BLOCK_SOUND_VOLUME, vary = TRUE)

/obj/item/clothing/suit/armor/lethal_ninja_armor
	name = ""
	desc = ""
	icon = 'modular_np_lethal/ninja_stuff/icons/armor.dmi'
	icon_state = "genin_armor_light"
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_kudagitsune
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	max_integrity = 500
	limb_integrity = 300
	slowdown = 0

/obj/item/clothing/suit/armor/lethal_ninja_armor/medium
	name = ""
	desc = ""
	icon = 'modular_np_lethal/ninja_stuff/icons/armor.dmi'
	icon_state = "genin_armor_light"
	worn_icon = 'modular_np_lethal/ninja_stuff/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_baku

//stuff that protects the rest of your body


//stuff that's clothes
/obj/item/clothing/under/genin_uniform
	name = "designer activewear"
	desc = "As innumerable countercultural groups before them, members of the Tsukomogami often hustle or outright \
	steal luxury designer clothing. People who think too much would tell you about subversion and detournement, but \
	most of the actual wearers would just tell you that it's important to look good. Don't get caught wearing fakes."
	icon = ''
	icon_state = ""
	worn_icon = ''
	worn_icon_digi = ''
	worn_icon_state = ""
	has_sensor = SENSOR_COORDS
	random_sensor = FALSE

//stuff that goes on your hands

/obj/item/clothing/gloves/kote
	name = "kote sleeves"
	desc = "A pair of armwarmers has been reinforced with printed chain and and high strength resin plates in \
	imitation of medieval underarmor. The result is less resilient then dedicated armored gauntlets, but these \
	are able to protect your extremities without hampering your manual dexterity."
	icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "gloves"
	worn_icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_state = "gloves"
	clothing_traits = list(TRAIT_QUICK_CARRY)

//stuff that goes on your feet

/obj/item/clothing/shoes/jackboots/jikatabi
	name = "jikatabi"
	desc = ""
	icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "boots"
	worn_icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "boots"
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = NONE

/obj/item/clothing/shoes/jackboots/long_jikatabi
	name = "long jikatabi"
	desc = ""
	icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "boots"
	worn_icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "boots"
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = NONE
