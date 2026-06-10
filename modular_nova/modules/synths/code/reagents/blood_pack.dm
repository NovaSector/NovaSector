// I cannot wait to get rid of this. This is so many levels of awful wrapped into one.
/obj/item/reagent_containers/blood/oil
	blood_type = BLOOD_TYPE_OIL

/obj/item/reagent_containers/blood/oil/examine()
	. = ..()
	. += span_notice("There is a flammable warning on the label.")
