/obj/item/clothing/under/colonial/nri_police
	name = "imperial police outfit"
	desc = "Fancy blue durathread shirt and a pair of cotton-blend pants with a black synthleather belt. A time-tested design first employed by the NRI police's \
	precursor organisation, Rim-world Colonial Militia, now utilised by them as a tribute."
	icon_state = "under_police"
	armor_type = /datum/armor/clothing_under/rank_security
	strip_delay = 5 SECONDS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/obj/item/clothing/under/colonial/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/clothing/neck/cloak/colonial/nri_police
	name = "imperial police cloak"
	desc = "A cloak made from heavy tarpaulin. Nigh wind- and waterproof thanks to its design. The signature white rectangle of the NRI police covers the garment's back."
	icon_state = "cloak_police"

// Just some extra police equipment
/obj/item/clothing/neck/cloak/colonial/nri_police/Initialize()
	allowed += list(
		/obj/item/restraints/handcuffs,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
	)
	return ..()

/obj/item/clothing/neck/cloak/colonial/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/clothing/head/hats/colonial/nri_police
	name = "imperial police cap"
	desc = "A puffy cap made out of tarpaulin covered by some textile. It is sturdy and comfortable, and seems to retain its form very well. <br>\
		Silver NRI police insignia is woven right above its visor."
	icon_state = "cap_police"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/hats/colonial/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/clothing/mask/gas/nri_police
	name = "imperial police mask"
	desc = "A close-fitting tactical mask."
	icon = 'modular_nova/modules/novaya_ert/icons/mask.dmi'
	worn_icon = 'modular_nova/modules/novaya_ert/icons/wornmask.dmi'
	worn_icon_digi = 'modular_nova/modules/novaya_ert/icons/wornmask_digi.dmi'
	icon_state = "nri_police"
	inhand_icon_state = "swat"
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF

/obj/item/clothing/mask/gas/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/clothing/head/helmet/nri_police
	name = "imperial police helmet"
	desc = "Thick-looking tactical helmet made out of shaped Plasteel. Colored dark blue, similar to one imperial police is commonly using."
	icon_state = "police_helmet"
	icon = 'modular_nova/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_nova/modules/novaya_ert/icons/wornarmor.dmi'

/obj/item/clothing/head/helmet/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/clothing/suit/armor/vest/nri_police
	name = "imperial police plate carrier"
	desc = "A reasonably heavy, yet comfortable armor vest comprised of a bunch of dense plates. Colored dark blue and bears a reflective stripe on the front and back."
	icon_state = "police_vest"
	icon = 'modular_nova/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_nova/modules/novaya_ert/icons/wornarmor.dmi'

/obj/item/clothing/suit/armor/vest/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/clothing/suit/armor/vest/nri_police_jacket
	name = "imperial police aerostatic bomber jacket"
	desc = "A jacket design worn by the more dynamic officers. There are quite a few pockets on the inside, mostly for storing notebooks and compasses."
	icon = 'modular_nova/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_nova/modules/food_replicator/icons/clothing_worn.dmi'
	icon_state = "jacket_police"
	inhand_icon_state = "overalls"
	armor_type = /datum/armor/armor_secjacket
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/nri_police_jacket/Initialize()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)
	allowed += list(
		/obj/item/camera,
		/obj/item/clipboard,
		/obj/item/folder,
		/obj/item/taperecorder,
		/obj/item/tape, //<^notebooks
		/obj/item/gps, //<compasses
	)
	return ..()

/obj/item/clothing/suit/armor/vest/nri_police_jacket/suit
	name = "imperial police official jacket"
	desc = "A black uniform jacket with Zvirdnyan Colonial Militia's signature white rectangle on its right sleeve and backside. \
	Letters inside the collar read: %RANK-%KINK. The jacket is of exceptional quality."
	icon_state = "suit_police"
	inhand_icon_state = "ro_suit"

/obj/item/clothing/suit/armor/vest/nri_police_jacket/suit/Initialize(mapload)
	. = ..()
	var/rank = list("POF","LTN","SGT","DET","CPT","MSL")
	var/kink = list("JFR","2JFR","STL","2STL")
	desc = replacetext(desc, "%RANK", pick(rank))
	if(prob(20))
		desc = replacetext(desc, "%KINK", pick(kink))
	else
		desc = replacetext(desc, "%KINK", "N/A")

/obj/item/clothing/head/soft/nri_police
	name = "imperial police baseball cap"
	desc = "It's a robust baseball hat in tasteless washed out blue colour.<br>\
	Hey, this one's round!"
	icon_state = "policesoft"
	icon = 'modular_nova/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_nova/modules/food_replicator/icons/clothing_worn.dmi'
	soft_type = "police"
	armor_type = /datum/armor/cosmetic_sec
	strip_delay = 60
	dog_fashion = null

/obj/item/clothing/head/soft/nri_police/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)
