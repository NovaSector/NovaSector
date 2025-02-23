/obj/item/clothing/under/rank/medical
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/medical_digi.dmi'

/obj/item/clothing/under/rank/medical/doctor/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/medical.dmi'


/obj/item/clothing/under/rank/medical/scrubs/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/medical.dmi'
	icon_state = "scrubswhite" // Because for some reason TG's scrubs dont have an icon on their basetype
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one seems to be the original Scrub."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/medical/chemist/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/medical.dmi'

// Add a 'medical/virologist/nova' here if you make Virologist uniforms

/obj/item/clothing/under/rank/medical/paramedic/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/rank/medical/chief_medical_officer/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/medical.dmi'

/*
*	DOCTOR
*/

/obj/item/clothing/under/rank/medical/doctor/nova/utility
	name = "medical utility uniform"
	desc = "A utility uniform worn by Medical doctors."
	icon_state = "util_med"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/medical/doctor/nova/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/*
*	SCRUBS
*/

/obj/item/clothing/under/rank/medical/scrubs/nova/red
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in a deep red."
	icon_state = "scrubsred"

/obj/item/clothing/under/rank/medical/scrubs/nova/white
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in a cream white colour."
	icon_state = "scrubswhite"

/*
*	CHEMIST
*/

/obj/item/clothing/under/rank/medical/chemist/nova/formal
	name = "chemist's formal jumpsuit"
	desc = "A white shirt with left-aligned buttons and an orange stripe, lined with protection against chemical spills."
	icon_state = "pharmacologist"

/obj/item/clothing/under/rank/medical/chemist/nova/formal/skirt
	name = "chemist's formal jumpskirt"
	icon_state = "pharmacologist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/medical/chemist/skirt
	gets_cropped_on_taurs = FALSE

/*
*	PARAMEDIC
*/

/obj/item/clothing/under/rank/medical/paramedic/nova/light
	name = "light paramedic uniform"
	desc = "A brighter variant of the typical Paramedic uniform made with special fibers that provide minor protection against biohazards, this one has the reflective strips removed."
	icon_state = "paramedic_light"

/obj/item/clothing/under/rank/medical/paramedic/nova/light/skirt
	name = "light paramedic skirt"
	desc = "A brighter variant of the typical Paramedic uniform made with special fibers that provide minor protection against biohazards, this one has had its legs replaced with a skirt."
	icon_state = "paramedic_light_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
*	CHIEF MEDICAL OFFICER
*/

/obj/item/clothing/under/rank/medical/chief_medical_officer/nova/imperial //Rank pins of the Brigadier General
	desc = "A teal, sterile naval suit with a rank badge denoting the Officer of the Medical Corps. Doesn't protect against blaster fire."
	name = "chief medical officer's naval jumpsuit"
	icon_state = "impcmo"

/*

Recolorable Uniforms

This position is temporary until someone or I modify the above code to support it immediately... or until I get the colors right... Cant have the same mistake as the RD labcoat being the wrong color in PR: #

*/

/obj/item/clothing/under/rank/medical/nova/recolorable
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs
	name = "Greyscale Scrubs"
	desc = "This is a failsafe if shit happens, whoops!"
	icon_state = "scrubs"
	greyscale_colors = "#818181#818181"
	greyscale_config = /datum/greyscale_config/scrubs
	greyscale_config_worn = /datum/greyscale_config/scrubs/worn
	greyscale_config_worn_digi = /datum/greyscale_config/scrubs/worn/digi

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/red
	name = "Red Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#9D2522#9D2522"

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/wine
	name = "Wine Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#9D2251#9D2251"

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/blue
	name = "Blue Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#85C1E6#85C1E6"

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/green
	name = "Green Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#219449#219449"

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/black
	name = "Black Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#39393F#39393F"

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/white
	name = "White Scrubs"
	desc = "DEVELOPER DESC, FUCKING CHANGE ME!"
	greyscale_colors = "#EEEEEE#EEEEEE"

/obj/item/clothing/under/rank/medical/nova/recolorable/scrubs/orderly
	name = "Orderlies Scrubs"
	desc = "Test Description"
	greyscale_colors = "#EEEEEE#3E3E48"

// Note, FIGURE OUT ARMOR

/obj/item/clothing/under/rank/medical/nova/recolorable/meduniform
	name = "Medical Uniform"
	desc = "Test Description"
	icon_state = "meduniform"
	greyscale_colors = "#5FA4CC#EEEEEE"
	greyscale_config = /datum/greyscale_config/meduniform
	greyscale_config_worn = /datum/greyscale_config/meduniform/worn
	greyscale_config_worn_digi = /datum/greyscale_config/meduniform/worn/digi

/obj/item/clothing/under/rank/medical/nova/recolorable/meduniform/chemist
	name = "Chemist Uniform"
	desc = "Test Description"
	greyscale_colors = "#D15B1B#EEEEEE"

/obj/item/clothing/under/rank/medical/nova/recolorable/meduniform/virologist
	name = "Virologist Uniform"
	desc = "Test Description"
	greyscale_colors = "#198019#EEEEEE"

/obj/item/clothing/under/rank/medical/nova/recolorable/meduniform/cmo
	name = "Chief Medical Officer Uniform"
	desc = "Test Description"
	greyscale_colors = "#479194#EEEEEE"
