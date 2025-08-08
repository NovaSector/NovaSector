/datum/quirk/item_quirk/breather
	abstract_parent_type = /datum/quirk/item_quirk/breather
	icon = FA_ICON_LUNGS_VIRUS
	///the message that will show up when the quirk is gained or the round starts
	var/alert_text = "Be sure to equip your breathing apparatus, or you may end up choking!"
	///the type of gas the dogtag accessory will be showing
	var/breath_type = "oxygen"
	///the tank of gas that will be supplied once
	var/obj/item/breathing_tank = /obj/item/tank/internals/emergency_oxygen/engi
	///this stores the old lungs so we can grant them on removal of the quirk
	var/obj/item/organ/lungs/old_lungs

/datum/quirk/item_quirk/breather/add_unique(client/client_source)
	var/obj/item/organ/lungs/lungs_holder = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(isnull(lungs_holder))
		to_chat(quirk_holder, span_warning("Your [name] quirk couldn't properly execute due to your species/body lacking a pair of lungs!"))
		qdel(src)
		return FALSE

	// preserve the old lungs
	old_lungs = SSwardrobe.provide_type(lungs_holder.type)
	old_lungs.moveToNullspace()
	STOP_PROCESSING(SSobj, old_lungs)

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
		),
		alert_text,
		notify_player = TRUE,
	)

	// always update lungs to respect the quirk, even if the organ isn't from roundstart
	RegisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))
	return TRUE

/datum/quirk/item_quirk/breather/add(client/client_source)
	add_adaptation()

/datum/quirk/item_quirk/breather/proc/on_gain_organ()
	SIGNAL_HANDLER
	add_adaptation()

///proc for adding the lungs tweaks
/datum/quirk/item_quirk/breather/proc/add_adaptation()
	return

/datum/quirk/item_quirk/breather/remove()
	if(QDELING(quirk_holder))
		return

	UnregisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return

	old_lungs.Insert(quirk_holder, TRUE)
	START_PROCESSING(SSobj, old_lungs)
	qdel(target_lungs)
