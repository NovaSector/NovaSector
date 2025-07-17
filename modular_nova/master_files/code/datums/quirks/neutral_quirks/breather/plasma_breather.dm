/datum/quirk/item_quirk/breather/plasma_breather
	name = "Plasma Breather"
	desc = "You breathe plasma, even if you might not normally breathe it. Oxygen is poisonous."
	medical_record_text = "Patient can only breathe plasma."
	gain_text = span_notice("You suddenly have a hard time breathing anything but plasma.")
	lose_text = span_danger("You suddenly feel like you aren't bound to plasma anymore.")
	icon = FA_ICON_FIRE_FLAME_SIMPLE
	value = 0
	breathing_tank = /obj/item/tank/internals/plasmaman/belt/full
	breath_type = "plasma"

/datum/quirk/item_quirk/breather/plasma_breather/is_species_appropriate(datum/species/mob_species)
	// slimeppl heal their blood volume rapidly from breathing plasma, this would be op
	if(istype(mob_species, /datum/species/jelly) || istype(mob_species, /datum/species/plasmaman))
		return FALSE
	else
		return ..()

/datum/quirk/item_quirk/breather/plasma_breather/add_adaptation()
	// this proc is guaranteed to be called multiple times
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return
	// set lung vars
	target_lungs.safe_oxygen_min = 0 //Dont need oxygen
	target_lungs.safe_oxygen_max = 2 //But it is quite toxic
	target_lungs.safe_plasma_min = 4 //default of plasmaman's plasma tank
	target_lungs.safe_plasma_max = 30
	target_lungs.oxy_damage_type = TOX
	target_lungs.oxy_breath_dam_min = 6
	target_lungs.oxy_breath_dam_max = 20
	// update lung procs
	target_lungs.add_gas_reaction(/datum/gas/plasma, always = TYPE_PROC_REF(/obj/item/organ/lungs, breathe_plasma))
	target_lungs.add_gas_reaction(/datum/gas/oxygen, while_present = TYPE_PROC_REF(/obj/item/organ/lungs, too_much_oxygen))
	target_lungs.add_gas_reaction(/datum/gas/oxygen, on_loss = TYPE_PROC_REF(/obj/item/organ/lungs, safe_oxygen))
	// reflect correct lung flags
	target_lungs.respiration_type = RESPIRATION_PLASMA

/datum/quirk/item_quirk/breather/plasma_breather/remove()
	. = ..()
	quirk_holder.clear_alert(ALERT_NOT_ENOUGH_PLASMA)
	quirk_holder.clear_alert(ALERT_TOO_MUCH_OXYGEN)
