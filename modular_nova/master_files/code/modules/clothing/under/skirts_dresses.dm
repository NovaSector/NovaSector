#define SKIRTS_DRESSES_DIGIFILE 'modular_nova/master_files/icons/mob/clothing/under/skirts_dresses_digi.dmi'

/obj/item/clothing/under/dress
	body_parts_covered = CHEST|GROIN	//For reference
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY //For reference - We dont want to cut a random hole in dresses
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON	//For reference - keep in mind some dresses will need adjusted for digi thighs - hence the link below
	worn_icon_digi = SKIRTS_DRESSES_DIGIFILE
	gets_cropped_on_taurs = FALSE
	//God bless the skirt being a subtype of the dress, only need one worn_digi_icon definition

/obj/item/clothing/under/dress/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/skirts_dresses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/skirts_dresses.dmi'

/obj/item/clothing/under/dress/skirt/nova	//Just so they can stay under TG's skirts in case code needs subtypes of them (also SDMM dropdown looks nicer like this)
	icon = 'modular_nova/master_files/icons/obj/clothing/under/skirts_dresses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/skirts_dresses.dmi'

//TG's icons only have a dress.dmi, but that means it's not ABC-sorted to be beside shorts_pants_shirts.dmi. So it's skirts_dresses for us.

/*
 *	TG DIGI VERSION DRESSES
 */
/obj/item/clothing/under/dress/striped
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/skirt/plaid
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/*
 *	Skirts
 */

/obj/item/clothing/under/dress/skirt/nova/swept
	name = "swept skirt"
	desc = "Formal skirt."
	icon_state = "skirt_swept"
	body_parts_covered = GROIN
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/dress/skirt/nova/striped_skirt
	name = "red bra and striped skirt"
	desc = "A red side-slit skirt with stripes! Comes with a matching two-tone bra."
	icon_state = "striped_skirt"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/dress/skirt/nova/red_skirt
	name = "red bra and skirt"
	desc = "An eye-catching knee-length red skirt, with a golden-yellow trim. Comes with a matching two-tone bra."
	icon_state = "red_skirt"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/dress/skirt/nova/black_skirt
	name = "black bra and skirt"
	desc = "A black side-slit skirt with a golden-yellow trim. Screams 'affluent goth'. Comes with a funky-looking matching bra."
	icon_state = "black_skirt"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/dress/skirt/nova/turtleskirt_knit //Essentially the same as the Turtleneck Skirt but with a different texture
	name = "cableknit skirt"
	desc = "A casual turtleneck skirt, with a cableknit pattern."
	icon_state = "turtleskirt_knit"
	custom_price = PAYCHECK_CREW
	greyscale_config = /datum/greyscale_config/turtleskirt_knit
	greyscale_config_worn = /datum/greyscale_config/turtleskirt_knit/worn
	greyscale_colors = "#cc0000#5f5f5f"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/dress/skirt/nova/jean
	name = "jean skirt"
	desc = "Technically, is there much difference between these and jorts? It's just one big hole instead of two. Does that make this a jirt?"
	icon_state = "jean_skirt"
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config = /datum/greyscale_config/jean_skirt
	greyscale_config_worn = /datum/greyscale_config/jean_skirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/jean_skirt/worn/digi
	greyscale_colors = "#787878#723E0E#4D7EAC"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/nova/lone_skirt
	name = "skirt"
	desc = "Just a skirt! Hope you have a tanktop to wear with this."
	icon_state = "lone_skirt"
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/lone_skirt
	greyscale_config_worn = /datum/greyscale_config/lone_skirt/worn
	greyscale_colors = "#5f534a"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/nova/medium
	name = "medium skirt"
	desc = "An appealing medium-length skirt. Top not included."
	icon_state = "medium_skirt"
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/medium_skirt
	greyscale_config_worn = /datum/greyscale_config/medium_skirt/worn
	greyscale_colors = "#3a3c45"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/nova/long
	name = "long skirt"
	desc = "An appealing long skirt. At this point does it qualify as a dress?"
	icon_state = "long_skirt"
	body_parts_covered = GROIN|LEGS
	greyscale_config = /datum/greyscale_config/long_skirt
	greyscale_config_worn = /datum/greyscale_config/long_skirt/worn
	greyscale_colors = "#3a3c45"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	alternate_worn_layer = ABOVE_SHOES_LAYER
	flags_1 = IS_PLAYER_COLORABLE_1

/*
 *	Dresses
 */

/obj/item/clothing/under/dress/nova/short_dress
	name = "short dress"
	desc = "An extremely short dress with a lovely sash and flower - only for those with good self-confidence."
	icon_state = "short_dress"
	greyscale_config = /datum/greyscale_config/short_dress
	greyscale_config_worn = /datum/greyscale_config/short_dress/worn
	greyscale_colors = "#ff3636#363030"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/nova/pinktutu
	name = "pink tutu"
	desc = "A fluffy pink tutu."
	icon_state = "pinktutu"

/obj/item/clothing/under/dress/nova/flower
	name = "flower dress"
	desc = "Lovely dress. Colored like the autumn leaves."
	icon_state = "flower_dress"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/dress/nova/redformal
	name = "formal red dress"
	desc = "Not too wide flowing, but big enough to make an impression."
	icon_state = "formal_red"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/nova/countess
	name = "countess dress"
	desc = "A wide flowing dress fitting for a countess; may be prone to catching onto stuff as you pass."
	icon_state = "countess"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/nova/strapless
	name = "strapless dress"
	desc = "Typical formal wear with no straps, instead opting to be tied at the waist. Most likely will need constant adjustments."
	icon_state = "dress_strapless"
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/strapless_dress
	greyscale_config_worn = /datum/greyscale_config/strapless_dress/worn
	greyscale_colors = "#cc0000#5f5f5f"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/nova/pentagram
	name = "pentagram strapped dress"
	desc = "A soft dress with straps designed to rest as a pentragram. Isn't this against NT's whole \"Authorized Religion\" stuff?"
	icon_state = "dress_pentagram"
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/pentagram_dress
	greyscale_config_worn = /datum/greyscale_config/pentagram_dress/worn
	greyscale_colors = "#403c46"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/nova/jute
	name = "Jacarta Dress"
	desc = "A thick dress with a strong rough exterior layer; lined with a soft breathable thin layer. It's loose-fitting, and has a tag inside that says 'Made in Jacarta'."
	icon_state = "jute"
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/dress/wedding_dress
	icon_state = "wedding_dress"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/skirts_dresses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/skirts_dresses.dmi'
	greyscale_config = /datum/greyscale_config/wedding_dress
	greyscale_config_worn = /datum/greyscale_config/wedding_dress/worn
	greyscale_colors = "#FFFFFF"
	body_parts_covered = CHEST|GROIN|LEGS
	flags_inv = HIDESHOES
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/dress/wedding_dress/ribbon
	name = "wedding dress with ribbon"
	desc = "A luxurious gown for once-in-a-lifetime occasions. Now with a cute ribbon, because you deserve it!"
	icon_state = "wedding_dress_with_ribbon"
	greyscale_colors = "#FFFFFF#FF0000"
	greyscale_config = /datum/greyscale_config/wedding_dress_ribbon
	greyscale_config_worn = /datum/greyscale_config/wedding_dress_ribbon/worn

/obj/item/clothing/under/dress/nova/giant_scarf
	name = "giant scarf"
	desc = "An absurdly massive scarf, worn as the main article of clothing over the body. Ironically, not very suitable for the cold."
	icon_state = "giant_scarf"
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/giant_scarf
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/worn
	greyscale_colors = "#EEEEEE"
	female_sprite_flags = NO_FEMALE_UNIFORM
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/nova/giant_scarf/crystal
	icon_state = "giant_scarf_crystal"
	greyscale_config = /datum/greyscale_config/giant_scarf/crystal
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/crystal/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/stripe
	icon_state = "giant_scarf_stripe"
	greyscale_config = /datum/greyscale_config/giant_scarf/stripe
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/stripe/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/two_tone
	icon_state = "giant_scarf_twotone"
	greyscale_config = /datum/greyscale_config/giant_scarf/two_tone
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/two_tone/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/arrow
	icon_state = "giant_scarf_arrow"
	greyscale_config = /datum/greyscale_config/giant_scarf/arrow
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/arrow/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/fancy
	icon_state = "giant_scarf_fancy"
	greyscale_config = /datum/greyscale_config/giant_scarf/fancy
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/fancy/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/sepharim
	icon_state = "giant_scarf_sepharim"
	greyscale_config = /datum/greyscale_config/giant_scarf/sepharim
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/sepharim/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/bones
	icon_state = "giant_scarf_bones"
	greyscale_config = /datum/greyscale_config/giant_scarf/bones
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/bones/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/lines
	icon_state = "giant_scarf_lines"
	greyscale_config = /datum/greyscale_config/giant_scarf/lines
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/lines/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/runes
	icon_state = "giant_scarf_runes"
	greyscale_config = /datum/greyscale_config/giant_scarf/runes
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/runes/worn
	greyscale_colors = "#EEEEEE#bbbbbb"

/obj/item/clothing/under/dress/nova/giant_scarf/heart
	icon_state = "giant_scarf_heart"
	greyscale_config = /datum/greyscale_config/giant_scarf/heart
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/heart/worn
	greyscale_colors = "#EEEEEE#bbbbbb"
/*
 *	Others
 */

/obj/item/clothing/under/dress/skirt/nova/loincloth
	name = "loincloth"
	desc = "A simple elegant cloth, to use wrapped around your waist and groin."
	icon_state = "loincloth"
	greyscale_config = /datum/greyscale_config/loincloth
	greyscale_config_worn = /datum/greyscale_config/loincloth/worn
	greyscale_colors = "#413069"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = GROIN|LEGS
	has_sensor = NO_SENSORS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/dress/skirt/nova/loincloth/loincloth_alt
	name = "shorter loincloth"
	desc = "A simple elegant cloth, to use wrapped around your waist and groin. This one uses a shorter cloth."
	icon_state = "loincloth_alt"
	greyscale_config = /datum/greyscale_config/loincloth_alt
	greyscale_config_worn = /datum/greyscale_config/loincloth_alt/worn
