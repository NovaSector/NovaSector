/datum/sprite_accessory/clothing/socks
	//All underwear goes in the same file for the sake of digi variants
	icon = 'modular_nova/master_files/icons/mob/clothing/underwear.dmi'
	use_static = TRUE
	layer = NOVA_BRA_SOCKS_LAYER

/datum/sprite_accessory/clothing/socks/get_icon_state(physique, bodyshape)
	if(has_custom_digi_sprite && (bodyshape & BODYSHAPE_DIGITIGRADE))
		return icon_state + "_d"
	return icon_state

/datum/sprite_accessory/clothing/socks/socks_norm
	name = "Normal (Greyscale)"
	icon_state = "white_norm"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stirrups_norm
	name = "Normal Stirrups (Greyscale)"
	icon_state = "socks_norm-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/socks_short
	name = "Short (Greyscale)"
	icon_state = "white_short"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/socks_knee
	name = "Knee-high (Greyscale)"
	icon_state = "white_knee"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stirrups_knee
	name = "Knee-high Stirrups"
	icon_state = "socks_knee-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/striped_knee
	name = "Knee-high - Striped"
	icon_state = "striped_knee"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/thin_knee
	name = "Knee-high - Thin"
	icon_state = "thin_knee"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/socks_thigh
	name = "Thigh-high (Greyscale)"
	icon_state = "white_thigh"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stirrups_thigh
	name = "Thigh-high Stirrups (Greyscale)"
	icon_state = "socks_thigh-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/striped_thigh
	name = "Thigh-high (Striped)"
	icon_state = "striped_thigh"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/striped_thigh/stirrups
	name = "Thigh-high (Striped Stirrups)"
	icon_state = "striped_thigh-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/leggings/stirrups/gym
	name = "Thigh-high Stirrups (black with stripe)"
	icon_state = "leggings_black-stir"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/bee_thigh
	name = "Thigh-high - Bee (Old)"
	icon_state = "bee_thigh_old"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/bee_knee
	name = "Knee-high - Bee (Old)"
	icon_state = "bee_knee_old"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/christmas_norm
	name = "Normal - Christmas"
	icon_state = "christmas_norm"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/candycaner_norm
	name = "Normal - Red Candy Cane"
	icon_state = "candycaner_norm"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/candycaneg_norm
	name = "Normal - Green Candy Cane"
	icon_state = "candycaneg_norm"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/christmas_knee
	name = "Knee-High - Christmas"
	icon_state = "christmas_knee"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/candycaner_knee
	name = "Knee-High - Red Candy Cane"
	icon_state = "candycaner_knee"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/candycaneg_knee
	name = "Knee-High - Green Candy Cane"
	icon_state = "candycaneg_knee"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/christmas_thigh
	name = "Thigh-high - Christmas"
	icon_state = "christmas_thigh"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/candycaner_thigh
	name = "Thigh-high - Red Candy Cane"
	icon_state = "candycaner_thigh"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/candycaneg_thigh
	name = "Thigh-high - Green Candy Cane"
	icon_state = "candycaneg_thigh"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/rainbow_thigh
	name = "Thigh-high - Rainbow"
	icon_state = "rainbow_thigh"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/rainbow_knee
	name = "Knee-high - Rainbow"
	icon_state = "rainbow_knee"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/rainbow_knee/stirrups
	name = "Knee-high - Rainbow Stirrups"
	icon_state = "rainbow_knee-stir"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/rainbow_thigh/stirrups
	name = "Thigh-high - Rainbow Stirrups"
	icon_state = "rainbow_thigh-stir"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/fishnet_thigh_sr
	name = "Thigh-high - Fishnet"
	icon_state = "fishnet"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/fishnet_thigh/alt
	name = "Thigh-high - Fishnet (Greyscale)"
	icon_state = "fishnet_alt"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/pantyhose/stirrups
	name = "Pantyhose Stirrups"
	icon_state = "pantyhose-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/pantyhose_ripped
	name = "Pantyhose - Ripped"
	icon_state = "pantyhose_ripped"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/pantyhose_ripped/stirrups
	name = "Pantyhose - Ripped Stirrups"
	icon_state = "pantyhose_ripped-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_ripped
	name = "Stockings - Ripped"
	icon_state = "stockings_ripped"
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/leggings
	name = "Leggings"
	icon_state = "leggings"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/leggings/stirrups
	name = "Leggings - Stirrups"
	icon_state = "leggings-stir"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/leggings/latex
	name = "Socks - Latex"
	icon_state = "socks_latex"
	erp_accessory = TRUE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/thigh_m
	name = "Thigh-high Socks - Shaded"
	icon_state = "socks_thigh_m"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/socks_knee_m
	name = "Knee High Socks - Shaded"
	icon_state = "socks_knee_m"
	use_static = FALSE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/leggings/gym
	name = "Thigh-highs (black with stripe)"
	icon_state = "leggings_black"
	use_static = TRUE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/ripped_thigh
	name = "Ripped Black Thigh-highs"
	icon_state = "thigh_high_ripped"
	use_static = TRUE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/thigh_high
	name = "Black Thigh-highs"
	icon_state = "thigh_high"
	use_static = TRUE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/right_side_thigh_high
	name = "Right sided Black Thigh-highs"
	icon_state = "right_side_thigh_high"
	use_static = TRUE
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/left_side_thigh_high
	name = "Left sided Black Thigh-highs"
	icon_state = "left_side_thigh_high"
	use_static = TRUE
	has_custom_digi_sprite = TRUE

// TG Socks

/datum/sprite_accessory/clothing/socks/ace_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/black_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/commie_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/usa_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/trans_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/uk_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/white_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/fishnet_knee
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/black_norm
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/white_norm
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/pantyhose
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/black_short
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/white_short
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_blue
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_cyan
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_dpink
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_green
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_orange
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_programmer
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_purple
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_yellow
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/stockings_fishnet
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/ace_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/black_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/commie_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/usa_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/thin_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/trans_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/uk_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/white_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/fishnet_thigh
	has_custom_digi_sprite = TRUE

/datum/sprite_accessory/clothing/socks/thocks
	has_custom_digi_sprite = TRUE
