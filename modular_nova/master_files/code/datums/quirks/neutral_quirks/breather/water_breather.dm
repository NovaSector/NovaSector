/datum/quirk/item_quirk/breather/water_breather
	name = "Water Breather"
	desc = "You have a pair of gills and are only capable of breathing oxygen through water, stay wet to breathe!"
	alert_text = "Be sure to equip your vaporizer, or you may end up choking to death!"
	icon = FA_ICON_FISH
	medical_record_text = "Patient has a pair of gills on their body."
	gain_text = span_notice("You suddenly have a hard time breathing through thin air.")
	lose_text = span_danger("You suddenly feel like you aren't bound to breathing through liquid anymore.")
	value = 0
	breathing_mask = NONE
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

/datum/quirk/item_quirk/breather/water_breather/add_unique(client/client_source)
	. = ..()
	// The button/action may be granted after quirks run, so defer and purge it
	spawn(0)
		remove_hydrophobia_action(quirk_holder)

/// Find and remove the slime hydrophobia spell/action if present
/proc/remove_hydrophobia_action(mob/living/L)
	if (!L || QDELETED(L) || !islist(L.actions))
		return
	for (var/datum/action/cooldown/spell/slime_hydrophobia/A in L.actions)
		A.Remove(L)   // ungrants from owner
		qdel(A)       // delete the action datum
