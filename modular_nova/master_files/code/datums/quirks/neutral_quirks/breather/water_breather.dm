/datum/quirk/item_quirk/breather/water_breather
	name = "Water Breather"
	desc = "You have a pair of gills and are only capable of breathing oxygen through water, stay wet to breathe!"
	alert_text = "Be sure to equip your vaporizer, or you may end up choking to death!"
	icon = FA_ICON_FISH
	medical_record_text = "Patient has a pair of gills on their body."
	gain_text = span_notice("You suddenly have a hard time breathing through thin air.")
	lose_text = span_danger("You suddenly feel like you aren't bound to breathing through liquid anymore.")
	value = 0
	breathing_tank = /obj/item/clothing/accessory/vaporizer
	breath_type = "water"
	// bonus trait
	mob_trait = TRAIT_WATER_BREATHING

/datum/quirk/item_quirk/breather/water_breather/is_species_appropriate(datum/species/mob_species)
	if(istype(mob_species, /datum/species/akula))
		return FALSE
	else
		return ..()

/datum/quirk/item_quirk/breather/water_breather/add_adaptation()
	// this proc is guaranteed to be called multiple times
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return
	// set lung vars
	target_lungs.safe_oxygen_min = 0
	// update lung procs
	target_lungs.add_gas_reaction(/datum/gas/water_vapor, always = TYPE_PROC_REF(/obj/item/organ/lungs, breathe_water))
	// reflect correct lung flags
	target_lungs.respiration_type = RESPIRATION_OXYGEN

/datum/quirk/item_quirk/breather/water_breather/remove()
	. = ..()
	quirk_holder.clear_alert(ALERT_NOT_ENOUGH_WATER)
