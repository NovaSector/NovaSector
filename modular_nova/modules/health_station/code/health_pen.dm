/obj/item/reagent_containers/hypospray/medipen/health_station //mining pen lite
	name = "colonial survival medipen"
	desc = "A medipen for surviving in the harsh environments, heals most common damage sources. Cheaper in-atmosphere alternative to more common mining pens. \
	May cause fatigue and drowsiness."
	icon = 'modular_nova/modules/health_station/icons/medipen.dmi'
	icon_state = "pen"
	inhand_icon_state = "stimpen"
	base_icon_state = "pen"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 10,
	/datum/reagent/medicine/c2/lenturi = 10,
	/datum/reagent/medicine/c2/tirimol = 5,
	/datum/reagent/medicine/morphine = 5,
	)

/obj/item/reagent_containers/hypospray/medipen/health_station/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_COLONIAL)
