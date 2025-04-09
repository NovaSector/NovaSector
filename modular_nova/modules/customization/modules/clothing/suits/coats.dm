#define STUFF_WINTER_COATS_HOLD list( \
	/obj/item/flashlight, \
	/obj/item/lighter, \
	/obj/item/modular_computer/pda, \
	/obj/item/radio, \
	/obj/item/storage/bag/books, \
	/obj/item/storage/fancy/cigarettes, \
	/obj/item/tank/internals/emergency_oxygen, \
	/obj/item/tank/internals/plasmaman, \
	/obj/item/toy, \
)

/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	allowed = list(
		/obj/item/analyzer,
		/obj/item/stack/medical,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/hypospray,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/paper,
		/obj/item/melee/baton/telescopic,
	)
	armor_type = /datum/armor/wintercoat_paramedic

/datum/armor/wintercoat_paramedic
	bio = 50
	acid = 45
	wound = 3

/obj/item/clothing/suit/flakjack
	name = "flak jacket"
	desc = "A dilapidated jacket made of a supposedly bullet-proof material (Hint: It isn't.). Smells faintly of napalm."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "flakjack"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	resistance_flags = NONE
	armor_type = /datum/armor/suit_flakjack
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/datum/armor/suit_flakjack
	bomb = 5
	fire = -5
	acid = -15

/obj/item/clothing/suit/hooded/cloak/david
	name = "red cloak"
	icon_state = "goliath_cloak"
	desc = "Ever wanted to look like a badass without ANY effort? Try this nanotrasen brand red cloak, made of entirely synthetic material."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/david
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hooded/cloakhood/david
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	name = "red cloak hood"
	icon_state = "golhood"
	desc = "Conceal your face in shame with this nanotrasen brand mock-goliath hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/urban
	name = "urban coat"
	desc = "A coat built for urban life."
	icon_state = "urban_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/urban_coat
	greyscale_config_worn = /datum/greyscale_config/urban_coat/worn
	greyscale_colors = "#252e5a#938060#66562b"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/deckard
	name = "runner coat"
	desc = "They say you overused reference. Tell them you're eating in this lovely coat, a long flowing brown one."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "deckard"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	inhand_icon_state = "det_suit"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/toggle_deckard
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/datum/armor/toggle_deckard
	melee = 25
	bullet = 10
	laser = 25
	energy = 35
	acid = 45

/obj/item/clothing/suit/jacket/leather/colourable
	desc = "Now with more color!"
	icon_state = "leather_jacket"
	greyscale_config = /datum/greyscale_config/leather_jacket
	greyscale_config_worn = /datum/greyscale_config/leather_jacket/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/duster
	name = "duster"
	desc = "This station ain't big enough for the both of us."
	icon_state = "duster"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/duster
	greyscale_config_worn = /datum/greyscale_config/duster/worn
	greyscale_colors = "#954b21"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/peacoat
	name = "peacoat"
	desc = "The way you guys are blending in with the local colour. I mean, Flag Girl was bad enough, but U-Boat Captain?"
	icon_state = "peacoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/peacoat
	greyscale_config_worn = /datum/greyscale_config/peacoat/worn
	greyscale_colors = "#61618a"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/lawyer/black/better
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "suitjacket_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/lawyer/white
	name = "white suit jacket"
	desc = "A very versatile part of a suit ensable. Oddly in fashion with mobsters."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "suitjacket_white"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/det_suit/runner
	name = "joyful coat"
	desc = "<i>\"You look like a good Joe.\"</i>"
	icon_state = "bladerunner_neue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	heat_protection = CHEST|ARMS|GROIN|LEGS
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	blood_overlay_type = "coat"

/obj/item/clothing/suit/jacket/croptop
	name = "crop top turtleneck"
	desc = "A comfy looking turtleneck that exposes your midriff, fashionable but makes the point of a sweater moot."
	icon_state = "croptop"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	greyscale_config = /datum/greyscale_config/croptop
	greyscale_config_worn = /datum/greyscale_config/croptop/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/croptop/worn/teshari
	greyscale_colors = "#1d1b1b"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/white_robe
	name = "white robe"
	desc = "A white long robe."
	icon_state = "white_robe"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS

/obj/item/clothing/suit/varsity
	name = "varsity jacket"
	desc = "A simple varsity jacket with no obvious sources."
	icon_state = "varsity_jacket"
	greyscale_config = /datum/greyscale_config/varsity
	greyscale_config_worn = /datum/greyscale_config/varsity/worn
	greyscale_colors = "#553022#a67a5b#2d2d33"
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/varsity/Initialize(mapload)
	. = ..()
	allowed += STUFF_WINTER_COATS_HOLD

/obj/item/clothing/suit/hooded/leather
	name = "hooded leather coat"
	desc = "A simple leather coat with a hoodie underneath it, not really hooded is it?"
	icon_state = "leatherhoodie"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	hoodtype = /obj/item/clothing/head/hooded/leather

/obj/item/clothing/head/hooded/leather
	name = "jacket hood"
	desc = "A hood attached to a hoodie, nothing special."
	icon_state = "leatherhood"
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	flags_inv = HIDEHAIR

/obj/item/clothing/suit/tailored_jacket
	name = "tailored jacket"
	desc = "A somewhat long jacket tailor made for... however it looks right now!"
	icon_state = "tailored_jacket"
	greyscale_config = /datum/greyscale_config/tailored_jacket
	greyscale_config_worn = /datum/greyscale_config/tailored_jacket/worn
	greyscale_colors = "#8c8c8c#8c8c8c#8c8c8c#bf9f78#8c8c8c#8c8c8c#8c8c8c#bf9f78#8c8c8c" // Look this has a lot of colorable sections
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/tailored_jacket/Initialize(mapload)
	. = ..()
	allowed += STUFF_WINTER_COATS_HOLD
	AddComponent(/datum/component/toggle_icon, "sleeves")

/obj/item/clothing/suit/tailored_jacket/short
	name = "tailored short jacket"
	desc = "A jacket tailor made for... however it looks right now!"
	greyscale_config = /datum/greyscale_config/tailored_short_jacket
	greyscale_config_worn = /datum/greyscale_config/tailored_short_jacket/worn
	greyscale_colors = "#8c8c8c#8c8c8c#8c8c8c#bf9f78#8c8c8c#8c8c8c#bf9f78#8c8c8c"

/obj/item/clothing/suit/warm_coat
	name = "warm coat"
	desc = "A long insulated coat with fur, it looks quite comfortable."
	icon_state = "warm_coat"
	greyscale_config = /datum/greyscale_config/warm_coat
	greyscale_config_worn = /datum/greyscale_config/warm_coat/worn
	greyscale_colors = "#7a5f4f#d9cec7"
	flags_1 = IS_PLAYER_COLORABLE_1
	cold_protection = CHEST|GROIN|ARMS
	body_parts_covered = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/warm_coat/Initialize(mapload)
	. = ..()
	allowed += STUFF_WINTER_COATS_HOLD

/obj/item/clothing/suit/crop_jacket
	name = "crop-top jacket"
	desc = "A jacket that, some time long past, probably made quite the effective outdoors wear. Now, \
		some barbarian has cut the entire bottom half out."
	icon_state = "crop_jacket"
	greyscale_config = /datum/greyscale_config/crop_jacket
	greyscale_config_worn = /datum/greyscale_config/crop_jacket/worn
	greyscale_colors = "#ebebeb#a52f29#292929"
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/crop_jacket/Initialize(mapload)
	. = ..()
	allowed += STUFF_WINTER_COATS_HOLD
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/crop_jacket/shortsleeve
	name = "short-sleeved crop-top jacket"
	desc = "A jacket that, some time long past, probably made quite the effective outdoors wear. Now, \
		some barbarian has cut the entire bottom half out, as well as half the sleeves."
	icon_state = "crop_jacket_short"
	greyscale_config = /datum/greyscale_config/shortsleeve_crop_jacket
	greyscale_config_worn = /datum/greyscale_config/shortsleeve_crop_jacket/worn

/obj/item/clothing/suit/crop_jacket/sleeveless
	name = "sleeveless crop-top jacket"
	desc = "A jacket that, some time long past, probably made quite the effective outdoors wear. Now, \
		some barbarian has cut the entire bottom half out, as well as the sleeves."
	icon_state = "crop_jacket_sleeveless"
	greyscale_config = /datum/greyscale_config/sleeveless_crop_jacket
	greyscale_config_worn = /datum/greyscale_config/sleeveless_crop_jacket/worn
	greyscale_colors = "#ebebeb#a52f29"
	body_parts_covered = CHEST

/obj/item/clothing/suit/crop_jacket/long
	name = "sports jacket"
	desc = "A jacket that probably makes quite the effective outdoors wear."
	icon_state = "jacket"

/obj/item/clothing/suit/crop_jacket/shortsleeve/long
	name = "short-sleeved sports jacket"
	desc = "A jacket that probably makes quite the effective outdoors wear. However, \
		some barbarian has cut the sleeves in half."
	icon_state = "jacket_short"

/obj/item/clothing/suit/crop_jacket/sleeveless/long
	name = "sleeveless sports jacket"
	desc = "A jacket that probably makes quite the effective outdoors wear. However, \
		some barbarian has cut the sleeves off."
	icon_state = "jacket_sleeveless"

/obj/item/clothing/suit/big_jacket
	name = "\improper Alpha Atelier pilot jacket"
	desc = "An exacting reproduction of the pilot jackets worn in the infancy of faster than light travel, \
		right down the precise tension of thread spun on the precisely correct looms. The pilots it pays homage \
		to worked in small ships and in close proximity to their supercooled drives and needed extreme insulation, \
		hence the bulk."
	icon_state = "big_jacket"
	greyscale_config = /datum/greyscale_config/big_jacket
	greyscale_config_worn = /datum/greyscale_config/big_jacket/worn
	greyscale_colors = "#666633#333300#666633"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK

/obj/item/clothing/suit/big_jacket/Initialize(mapload)
	. = ..()
	allowed += STUFF_WINTER_COATS_HOLD

/obj/item/clothing/suit/toggle/labcoat/nova/custom
	name = "custom labcoat"
	desc = "A suit that protects against minor chemical spills.  This one has custom stripes & coloration."
	icon_state = "labcoat_job"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#FF0000#FF0000#333333"

#undef STUFF_WINTER_COATS_HOLD
