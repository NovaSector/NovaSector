// SolFed 911 Marshal Uniform | The root of all things good aand evil
/obj/item/clothing/under/solfed
	name = "\improper SolFed marshal's uniform"
	desc = "A modernization of the SolFed's peacekeeping uniform, modernized and refurbished to feel fashionable yet functional in its new modern setting, tailored for federal personnel."
	icon = 'modular_nova/modules/goofsec/icons/obj/uniforms.dmi'
	icon_state = "solpolice"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/uniforms.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/mob/uniforms_digi.dmi'
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/rank_security
	has_sensor = HAS_SENSORS
	sensor_mode = SENSOR_COORDS

// Peacekeeper Jumpsuit
/obj/item/clothing/under/solfed/sol_peacekeeper
	name = "sol peacekeeper uniform"
	desc = "A military-grade uniform with military grade comfort (none at all), often seen on \
		SolFed's various peacekeeping forces, and usually alongside a blue helmet."
	icon_state = "peacekeeper"
	worn_icon_state = "peacekeeper"

// EMT jumpsuit
/obj/item/clothing/under/solfed/sol_emt
	name = "sol emergency medical uniform"
	desc = "A copy of SolFed's peacekeeping uniform, recolored and re-built with paramedics in mind."
	icon_state = "emt"
	worn_icon_state = "emt"
	armor_type = /datum/armor/clothing_under/rank_medical

// SolFed 911 EMT Uniform
/obj/item/clothing/under/solfed/sol_emt/emergencymed
	name = "\improper SolFed emergency paramedic uniform"
	desc = "An official Sol Federation emergency response uniform, denoting members of their paramedical Trauma Teams and protecting them from viral or chemical hazards."
	icon_state = "medrescue"
	worn_icon_state = "medrescue"

// SolFed 911 Atmos Uniform
/obj/item/clothing/under/solfed/emergencyfire
	name = "\improper SolFed emergency atmospherics uniform"
	desc = "An official Sol Federation emergency response uniform, denoting members of their Station Breach Control teams and protecting them from atmospheric or fire hazards."
	icon_state = "atmosrescue"
	worn_icon_state = "atmosrescue"
	armor_type = /datum/armor/clothing_under/atmos_adv

///Federation Officials Uniforms (Identified by stripe and band) || Similar to Civ, but Armored
/obj/item/clothing/under/solfed/official
	name = "\improper SolFed Official Uniform"
	desc = "A uniform worn by officials of the Sol Federation's Civil Services Division."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/official"
	post_init_icon_state = "uniform_pants_1"

	greyscale_colors = "#41579A#39393F#41579A#41579A"
	greyscale_config = /datum/greyscale_config/solfed_off_reg
	greyscale_config_worn = /datum/greyscale_config/solfed_off_reg/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_reg/worn/digi

	/// Incase admins and players wannaa get creative
	obj_flags = INFINITE_RESKIN | UNIQUE_RENAME

	can_adjust = FALSE

	unique_reskin = list(
		"default" = "uniform_pants_1",
		"default-gold" = "uniform_pants_2",
		"default-blue" = "uniform_pants_3",
		"default-bnb" = "uniform_pants_4",
		"default-bng" = "uniform_pants_5",
		"default-gags-trim" = "uniform_pants_6",
		"default-gags-accent" = "uniform_pants_7",
		"default-gags-trimnacc" = "uniform_pants_8",
		"puffy" = "uniform_puffy_1",
		"puffy-gold" = "uniform_puffy_1",
		"puffy-blue" = "uniform_puffy_1",
		"puffy-bnb" = "uniform_puffy_1",
		"puffy-bng" = "uniform_puffy_1",
		"puffy-gags-trim" = "uniform_puffy_1",
		"puffy-gags-accent" = "uniform_puffy_1",
		"puffy-gags-trimnacc" = "uniform_puffy_1",
	)
/*
/obj/item/clothing/under/solfed/official/hoodie
	icon_state = "/obj/item/clothing/under/solfed/official/hoodie"

	greyscale_config = /datum/greyscale_config/solfed_off_hoodie
	greyscale_config_worn = /datum/greyscale_config/solfed_off_hoodie/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_hoodie/worn/digi

/obj/item/clothing/under/solfed/official/puffy
	icon_state = "/obj/item/clothing/under/solfed/official/puffy"

	greyscale_config = /datum/greyscale_config/solfed_off_puffy
	greyscale_config_worn = /datum/greyscale_config/solfed_off_puffy/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_puffy/worn/digi

/obj/item/clothing/under/solfed/official/twopart
	icon_state = "/obj/item/clothing/under/solfed/official/twopart"

	greyscale_config = /datum/greyscale_config/solfed_off_twopart
	greyscale_config_worn = /datum/greyscale_config/solfed_off_twopart/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_twopart/worn/digi
*/
///Civilian Variants of the SolFed Officials (Lacking Armbands, Patches, Stripes)
/obj/item/clothing/under/solfed/civil
	name = "SolFed Civilian Uniform"
	desc = "A standard civilian outfit for any fresh spacetiding citizen of the great Sol Federation..."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/civil"
	post_init_icon_state = "uniform"

	greyscale_colors = "#41579A#39393F"
	greyscale_config = /datum/greyscale_config/solfed_civ_reg
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_reg/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_reg/worn/digi

	armor_type = /datum/armor/none

	can_adjust = FALSE

	unique_reskin = list(
		"default" = "uniform",
		"puffy pants" = "uniform_alt_1",
	)

/obj/item/clothing/under/solfed/civil/hoodie
	name = "SolFed Civilian Hoodie"
	icon_state = "/obj/item/clothing/under/solfed/civilian/hoodie"

	greyscale_config = /datum/greyscale_config/solfed_civ_hoodie
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_hoodie/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_hoodie/worn/digi

/obj/item/clothing/under/solfed/civil/puffy
	name = "SolFed Civilian Puffy Uniform"
	icon_state = "/obj/item/clothing/under/solfed/civilian/puffy"

	greyscale_config = /datum/greyscale_config/solfed_civ_puffy
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_puffy/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_puffy/worn/digi

/obj/item/clothing/under/solfed/civil/twopart
	name = "SolFed Civilian Two Part Uniform"
	icon_state = "/obj/item/clothing/under/solfed/civilian/twopart"

	greyscale_config = /datum/greyscale_config/solfed_civ_twopart
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_twopart/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_twopart/worn/digi

// SolFed Espatier Uniforms
/obj/item/clothing/under/solfed/espatiers
	name = "\improper SolFed Espatier uniform"
	desc = "A camouflage uniform for members of the SolFed Espatier Corps, typically serving as Starfleet (SFSF) and Space Guard (SFSG) shipboard security. \
		They additionally fill the role of simple space-borne infantry, earning the nickname of \"Space espatiers\" from many spacers."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/espatiers"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/solfedcamo
	greyscale_config_worn = /datum/greyscale_config/solfedcamo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfedcamo/worn/digi
	greyscale_colors = "#4d4d4d#333333#292929"
	can_adjust = FALSE

/obj/item/clothing/under/solfed/espatiers/squadleader
	icon_state = "/obj/item/clothing/under/solfed/espatiers/squadleader"
	post_init_icon_state = "solfed_camo_squadlead"
	worn_icon_state = "solfed_camo_squadlead"
	worn_icon_digi = "solfed_camo_squadlead"

/obj/item/clothing/under/solfed/espatiers/paramedic
	icon_state = "/obj/item/clothing/under/solfed/espatiers/paramedic"
	post_init_icon_state = "solfed_camo_paramed"
	worn_icon_state = "solfed_camo_paramed"
	worn_icon_digi = "solfed_camo_paramed"

/obj/item/clothing/under/solfed/espatiers/smartgunner
	icon_state = "/obj/item/clothing/under/solfed/espatiers/smartgunner"
	post_init_icon_state = "solfed_camo_smartgun"
	worn_icon_state = "solfed_camo_smartgun"
	worn_icon_digi = "solfed_camo_smartgun"

/obj/item/clothing/under/solfed/espatiers/specialist
	icon_state = "/obj/item/clothing/under/solfed/espatiers/specialist"
	post_init_icon_state = "solfed_camo_specialist"
	worn_icon_state = "solfed_camo_specialist"
	worn_icon_digi = "solfed_camo_specialist"

/obj/item/clothing/under/solfed/espatiers/engineer
	icon_state = "/obj/item/clothing/under/solfed/espatiers/engineer"
	post_init_icon_state = "solfed_camo_engie"
	worn_icon_state = "solfed_camo_engie"
	worn_icon_digi = "solfed_camo_engie"

/obj/item/clothing/under/solfed/espatiers/assault
	icon_state = "/obj/item/clothing/under/solfed/espatiers/assault"
	post_init_icon_state = "solfed_camo_assault"
	worn_icon_state = "solfed_camo_assault"
	worn_icon_digi = "solfed_camo_assault"
	greyscale_colors = "#FFFFFF#CBCDD1#8C92A5"
