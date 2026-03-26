///////
/// Toggle Death Signal simply adds and removes the trait required for slimepeople to transmit a GPS signal upon core ejection.
///
/datum/action/innate/core_signal
	name = "Toggle Core Signal"
	desc = "Interface with the microchip placed in your core, modifying if it emits a GPS signal or not; due to how thick your liquid body is, the signal won't reach out until your core is outside of it."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	button_icon_state = "slime_core"
	background_icon_state = "bg_alien"
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE

/datum/action/innate/core_signal/Activate()
	var/mob/living/carbon/human/slime = owner
	var/obj/item/organ/brain/slime/core = slime.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(slime_restricted && !isjellyperson(slime))
		return
	if(core.gps_active)
		to_chat(owner, span_notice("You tune out the electromagnetic signals from your core so they are ignored by GPS receivers upon its rejection."))
		core.gps_active = FALSE
	else
		to_chat(owner, span_notice("You fine-tune the electromagnetic signals from your core to be picked up by GPS receivers upon its rejection."))
		core.gps_active = TRUE
