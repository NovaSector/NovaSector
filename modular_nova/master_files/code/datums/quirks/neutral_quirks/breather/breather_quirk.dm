/datum/quirk/item_quirk/breather
	abstract_parent_type = /datum/quirk/item_quirk/breather
	icon = FA_ICON_LUNGS_VIRUS
	///the message that will show up when the quirk is gained or the round starts
	var/alert_text = "Be sure to equip your breathing apparatus, or you may end up choking!"
	///the type of gas the dogtag accessory will be showing
	var/breath_type = "oxygen"
	///the tank of gas that will be supplied once
	var/obj/item/breathing_tank = /obj/item/tank/internals/emergency_oxygen/engi

/datum/quirk/item_quirk/breather/add_unique(client/client_source)
	if(!quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS))
		to_chat(quirk_holder, span_warning("Your [name] quirk couldn't properly execute due to your species/body lacking a pair of lungs!"))
		qdel(src)
		return FALSE

	// give dogtag accessory
	var/obj/item/clothing/accessory/breathing/target_tag = new(get_turf(quirk_holder))
	target_tag.breath_type = breath_type

	give_item_to_holder(target_tag, list(LOCATION_LPOCKET, LOCATION_RPOCKET, LOCATION_BACKPACK, LOCATION_HANDS))
	give_item_to_holder(breathing_tank,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		), alert_text
	)

	// always update lungs to respect the quirk, even if the organ isn't from roundstart
	RegisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(add))
	return TRUE

/datum/quirk/item_quirk/breather/remove()
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return
	target_lungs.safe_oxygen_min = initial(target_lungs.safe_oxygen_min)
	target_lungs.safe_oxygen_max = initial(target_lungs.safe_oxygen_max)
	target_lungs.oxy_damage_type = initial(target_lungs.oxy_damage_type)
	target_lungs.oxy_breath_dam_min = initial(target_lungs.oxy_breath_dam_min)
	target_lungs.oxy_breath_dam_max = initial(target_lungs.oxy_breath_dam_max)
	// update lung procs
	target_lungs.breathe_always = initial(target_lungs.breathe_always)
	target_lungs.breath_present = initial(target_lungs.breath_present)
	target_lungs.breath_lost = initial(target_lungs.breath_lost)
	// reflect correct lung flags
	target_lungs.respiration_type = initial(target_lungs.respiration_type)
