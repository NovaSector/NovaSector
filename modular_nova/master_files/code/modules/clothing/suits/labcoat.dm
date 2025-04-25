/obj/item/clothing/suit/toggle/labcoat/paramedic/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/storage/medkit,
	)

/obj/item/clothing/suit/toggle/labcoat
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/nova
	name = "SR LABCOAT SUIT DEBUG"
	desc = "REPORT THIS IF FOUND"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/labcoat.dmi'
	worn_icon_teshari = 'modular_nova/master_files/icons/mob/clothing/suits/labcoat_teshari.dmi'
	icon_state = null //Keeps this from showing up under the chameleon hat

/obj/item/clothing/suit/toggle/labcoat/nova/fancy
	name = "Greyscale Fancy Labcoat"
	desc = "Throughout the test of determination, many have sought after such a fancy labcoat, one that was filled with many colors and wears."
	icon_state = "fancy_labcoat"
	greyscale_config = /datum/greyscale_config/fancy_labcoat
	greyscale_config_worn = /datum/greyscale_config/fancy_labcoat/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/fancy_labcoat/worn/teshari
	greyscale_colors = "#EEEEEE#4A77A1"
	gets_cropped_on_taurs = FALSE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/labcoat/nova/fancy/rd
	name = "research directors labcoat"
	desc = "A Nanotrasen standard labcoat for certified Research Directors. It has an extra plastic-latex lining on the outside for more protection from chemical and viral hazards."
	greyscale_colors = "#620B73#EEEEEE"
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|ARMS|LEGS
	armor_type = /datum/armor/nova_rd

/datum/armor/nova_rd
	melee = 5
	bio = 80
	fire = 80
	acid = 70

/obj/item/clothing/suit/toggle/labcoat/nova/fancy/regular
	name = "researcher's labcoat"
	desc = "A Nanotrasen standard labcoat for researchers in the scientific field."
	greyscale_colors = "#EEEEEE#B347A1"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/nova/lalunevest
	name = "sleeveless buttoned coat"
	desc = "A fashionable jacket bearing the La Lune insignia on the inside. It appears similar to a labcoat in design and materials, though the tag warns against it being a replacement for such."
	icon_state = "labcoat_lalunevest"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/nova/fancy/pharmacist
	name = "pharmacist's labcoat"
	desc = "A standard labcoat for chemistry which protects the wearer from acid spills."
	greyscale_colors = "#EEEEEE#E6935C"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/nova/fancy/geneticist
	name = "geneticist's labcoat"
	desc = "A standard labcoat for geneticist."
	greyscale_colors = "#EEEEEE#7497C0"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/nova/fancy/roboticist
	name = "roboticist's labcoat"
	desc = "A standard labcoat for roboticist."
	greyscale_colors = "#2F2E31#A52F29"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/nova/fancy/pharmacist/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/chemistry

/obj/item/clothing/suit/toggle/labcoat/nova/regular/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/xeno

/obj/item/clothing/suit/toggle/labcoat/nova/highvis
	name = "high vis labcoat"
	desc = "A high visibility vest for emergency responders, intended to draw attention away from the blood."
	icon_state = "labcoat_highvis"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/toggle/labcoat/nova/highvis/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/toggle/labcoat/nova/hospitalgown //Intended to keep patients modest while still allowing for surgeries
	name = "hospital gown"
	desc = "A complicated drapery with an assortment of velcros and strings, designed to keep a patient modest during medical stay and surgeries."
	icon_state = "hgown"
	toggle_noun = "drapes"
	body_parts_covered = NONE //Allows surgeries despite wearing it; hiding genitals is handled in /datum/sprite_accessory/genital/is_hidden() (Only place it'd work sadly)
	armor_type = /datum/armor/none
	equip_delay_other = 8

/obj/item/clothing/suit/toggle/labcoat/roboticist //Overwrite the TG Roboticist labcoat to Black and Red (not the Interdyne labcoat though)
	greyscale_colors = "#2D2D33#88242D#88242D#88242D"

/obj/item/clothing/suit/toggle/labcoat/medical //Renamed version of the Genetics labcoat for more generic medical purposes; just a subtype of /labcoat/ for the TG files
	name = "medical labcoat"
	desc = "A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#4A77A1#4A77A1#7095C2"

/obj/item/clothing/suit/toggle/labcoat/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/handheld_soulcatcher,
	)
