/obj/item/shield/riot/tele
	w_class = WEIGHT_CLASS_SMALL // original: WEIGHT_CLASS_NORMAL

/obj/item/shield/energy/returning
	name = "returning energy shield"
	active_throwforce = 13 //toolbox worth of damage.

/obj/item/shield/energy/returning/on_transform(obj/item/source, mob/user, active)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		AddComponent(/datum/component/boomerang, throw_range+2, TRUE)
	else
		qdel(GetComponent(/datum/component/boomerang))

/obj/item/shield/energy/returning/examine(mob/user)
	. = ..()
	. += span_info("It has a proppeler that allows it to return to its user after being thrown while its active, as long as its not grabbed in the air.")

/obj/item/shield/energy/returning/blueshield
	name = "blueshield energy shield"

/obj/item/shield/energy/returning/blueshield/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)
