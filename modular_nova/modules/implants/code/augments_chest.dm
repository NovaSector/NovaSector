// for readability's sake, define here to match the healthscan() proc's use of it
// if someone updates that upstream, fix that here too, wouldja?

/obj/item/organ/cyberimp/chest/scanner
	name = "internal health analyzer"
	desc = "An advanced health analyzer implant, designed to directly interface with a host's body and relay scan information to the brain on command."
	slot = ORGAN_SLOT_SCANNER
	icon = 'modular_nova/modules/implants/icons/chest_modular.dmi'
	icon_state = "internal_HA"
	actions_types = list(/datum/action/item_action/organ_action/use/internal_analyzer)
	w_class = WEIGHT_CLASS_SMALL
	/// Whether or not we have the chemical scan feature
	var/has_chem_scan = TRUE

/datum/action/item_action/organ_action/use/internal_analyzer
	desc = "LMB: Health scan. RMB: Chemical scan. Requires implanted analyzer to not be failing due to EMPs or other causes. Does not provide treatment assistance."

/datum/action/item_action/organ_action/use/internal_analyzer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/scanner/our_scanner = target
	if(our_scanner.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("Your health analyzer relays an error! It can't interface with your body in its current condition!"))
		return
	if(our_scanner.has_chem_scan && (trigger_flags & TRIGGER_SECONDARY_ACTION))
		chemscan(owner, owner)
	else
		healthscan(owner, owner, SCANNER_VERBOSE, TRUE)

/obj/item/organ/cyberimp/chest/scanner/lite
	actions_types = list(/datum/action/item_action/organ_action/use/internal_analyzer/lite)
	has_chem_scan = FALSE

/datum/action/item_action/organ_action/use/internal_analyzer/lite
	desc = "LMB: Health scan. Requires implanted analyzer to not be failing due to EMPs or other causes. Does not provide treatment assistance."

/datum/action/item_action/organ_action/use/internal_analyzer/lite/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/scanner/our_scanner = target
	if(our_scanner.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("Your health analyzer relays an error! It can't interface with your body in its current condition!"))
		return
	else
		healthscan(owner, owner, SCANNER_CONDENSED, TRUE)

