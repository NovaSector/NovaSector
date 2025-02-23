/obj/item/clothing/under/rank/medical
	icon = 'icons/obj/clothing/under/medical.dmi'
	worn_icon = 'icons/mob/clothing/under/medical.dmi'
	armor_type = /datum/armor/clothing_under/rank_medical

/datum/armor/clothing_under/rank_medical
	bio = 50

/obj/item/clothing/under/rank/medical/doctor
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	name = "medical doctor's jumpsuit"
	icon_state = "medical"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/doctor/skirt
	name = "medical doctor's jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	icon_state = "medical_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/chief_medical_officer
	desc = "It's a jumpsuit worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	name = "chief medical officer's jumpsuit"
	icon_state = "cmo"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/chief_medical_officer/skirt
	name = "chief medical officer's jumpskirt"
	desc = "It's a jumpskirt worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	icon_state = "cmo_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/chief_medical_officer/scrubs
	name = "chief medical officer's scrubs"
	desc = "A distinctive set of white and turquoise scrubs given to chief medical officers who desire a clinical look."
	icon_state = "scrubscmo"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/chief_medical_officer/scrubs/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck
	name = "chief medical officer's turtleneck"
	desc = "A light blue turtleneck and tan khakis, for a chief medical officer with a superior sense of style."
	icon_state = "cmoturtle"
	inhand_icon_state = "b_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck/skirt
	name = "chief medical officer's turtleneck skirt"
	desc = "A light blue turtleneck and tan khaki skirt, for a chief medical officer with a superior sense of style."
	icon_state = "cmoturtle_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/virologist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	name = "virologist's jumpsuit"
	icon_state = "virology"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/virologist/skirt
	name = "virologist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	icon_state = "virologywhite_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/scrubs
	name = "medical scrubs"

/obj/item/clothing/under/rank/medical/scrubs/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/under/rank/medical/scrubs/blue
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in baby blue."
	icon_state = "scrubsblue"

/obj/item/clothing/under/rank/medical/scrubs/green
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in dark green."
	icon_state = "scrubsgreen"

/obj/item/clothing/under/rank/medical/scrubs/purple
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in deep purple."
	icon_state = "scrubswine"

/obj/item/clothing/under/rank/medical/coroner
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a white cross turned sideways on the chest, denoting that the wearer is a trained coroner."
	name = "coroner jumpsuit"
	icon_state = "coroner"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/coroner/skirt
	name = "coroner jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a white cross turned sideways on the chest, denoting that the wearer is a trained coroner."
	icon_state = "coroner_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/scrubs/coroner
	name = "coroner scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is as dark as an emo's poetry."
	icon_state = "scrubsblack"

/obj/item/clothing/under/rank/medical/chemist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	name = "chemist's jumpsuit"
	icon_state = "chemistry"
	inhand_icon_state = "w_suit"
	armor_type = /datum/armor/clothing_under/medical_chemist

/datum/armor/clothing_under/medical_chemist
	fire = 50
	acid = 65

/obj/item/clothing/under/rank/medical/chemist/skirt
	name = "chemist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	icon_state = "chemistrywhite_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/paramedic
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a dark blue cross on the chest denoting that the wearer is a trained paramedic."
	name = "paramedic jumpsuit"
	icon_state = "paramedic"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/medical/paramedic/skirt
	name = "paramedic jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a dark blue cross on the chest denoting that the wearer is a trained paramedic."
	icon_state = "paramedic_skirt"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/doctor/nurse
	desc = "It's a jumpsuit commonly worn by nursing staff in the medical department."
	name = "nurse's suit"
	icon_state = "nursesuit"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/*

Recolorable Uniforms

This position is temporary until someone or I modify the above code to support it immediately... or until I get the colors right... Cant have the same mistake as the RD labcoat being the wrong color in PR: #

*/

/obj/item/clothing/under/rank/medical/recolorable
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/rank/medical/recolorable/scrubs
	name = "Greyscale Scrubs"
	desc = "This is a failsafe if shit happens, whoops!"
	icon_state = "scrubs"
	greyscale_colors = "#818181#818181"
	greyscale_config = /datum/greyscale_config/scrubs
	greyscale_config_worn = /datum/greyscale_config/scrubs/worn
	greyscale_config_worn_digi = /datum/greyscale_config/scrubs/worn/digi

/obj/item/clothing/under/rank/medical/recolorable/scrubs/red
	name = "Red Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#9D2522#9D2522"

/obj/item/clothing/under/rank/medical/recolorable/scrubs/wine
	name = "Wine Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#9D2251#9D2251"

/obj/item/clothing/under/rank/medical/recolorable/scrubs/blue
	name = "Blue Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#85C1E6#85C1E6"

/obj/item/clothing/under/rank/medical/recolorable/scrubs/green
	name = "Green Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#219449#219449"

/obj/item/clothing/under/rank/medical/recolorable/scrubs/black
	name = "Black Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#39393F#39393F"

/obj/item/clothing/under/rank/medical/recolorable/scrubs/white
	name = "White Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#EEEEEE#EEEEEE"

/obj/item/clothing/under/rank/medical/recolorable/scrubs/orderly
	name = "Orderlies Scrubs"
	desc = "Test Description"
	greyscale_colors = "#EEEEEE#3E3E48"
	armor_type = /datum/armor/clothing_under/rank_medicaldebug

/datum/armor/clothing_under/rank_medicaldebug

	bio = 100
// Note, FIGURE OUT ARMOR

/obj/item/clothing/under/rank/medical/recolorable/meduniform
	name = "Medical Uniform"
	desc = "Test Description"
	icon_state = "meduniform"
	greyscale_colors = "#5FA4CC#EEEEEE"
	greyscale_config = /datum/greyscale_config/meduniform
	greyscale_config_worn = /datum/greyscale_config/meduniform/worn
	greyscale_config_worn_digi = /datum/greyscale_config/meduniform/worn/digi

/obj/item/clothing/under/rank/medical/recolorable/meduniform/chemist
	name = "Chemist Uniform"
	desc = "Test Description"
	greyscale_colors = "#D15B1B#EEEEEE"

/obj/item/clothing/under/rank/medical/recolorable/meduniform/virologist
	name = "Virologist Uniform"
	desc = "Test Description"
	greyscale_colors = "#198019#EEEEEE"

/obj/item/clothing/under/rank/medical/recolorable/meduniform/cmo
	name = "Chief Medical Officer Uniform"
	desc = "Test Description"
	greyscale_colors = "#479194#EEEEEE"
