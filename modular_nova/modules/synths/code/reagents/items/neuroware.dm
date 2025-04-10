///Data disk which contextualizes drugs as "software" for synthetics or NIF users.
///Like pills, but doesn't directly contain reagents, instead adds them manually.
/obj/item/disk/neuroware
	name = "Generic neuroware datadisk"
	desc = "A datadisk that can be used to upload time-limited \"neuroware\" programs to the user's brain."
	icon = 'modular_nova/modules/modular_implants/icons/obj/disks.dmi'
	icon_state = "base_disk"
	///Associative list of reagents to units. Determines what is added to the mob when the disk is used.
	///Will automatically have pertinent flags set to REAGENT_SYNTHETIC and REAGENT_INVISIBLE.
	var/list/list_reagents
	///Whether or not the disk will be deleted after being used.
	var/reusable = FALSE
	///Whether or not this disk requires lewd item preference enforcement.
	var/is_lewd = FALSE

/obj/item/disk/neuroware/Initialize(mapload)
	. = ..()
	if(is_lewd && CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL

/obj/item/disk/neuroware/attack_self(mob/user, modifiers)
	attempt_software_install(user)


/obj/item/disk/neuroware/attack(mob/living/mob, mob/living/user, params)
	attempt_software_install(mob, user)

///Installs only if the mob has a NIF implant or is synthetic species.
/obj/item/disk/neuroware/proc/attempt_software_install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!ishuman(target))
		balloon_alert(user, "synthetic or NIF required")
		return FALSE
	var/cyberware_type = "persocom"
	if(!issynthetic(target))
		var/obj/item/organ/cyberimp/brain/nif/installed_nif = target.get_organ_by_type(/obj/item/organ/cyberimp/brain/nif)
		if(isnull(installed_nif))
			balloon_alert(user, "synthetic or NIF required!")
			return FALSE
		cyberware_type = "NIF"
	user.balloon_alert_to_viewers("inserting disk...")
	if(target != user)
		target.visible_message(
			span_danger("[user] attempts to insert [src] into [target]'s [cyberware_type] slot!"),
			span_userdanger("[user] attempts to insert [src] into your [cyberware_type] slot!")
		)
		if(target.is_blind())
			to_chat(target, span_userdanger("You feel something being inserted into your [cyberware_type] slot!"))
	if(!do_after(user, 5 SECONDS, target))
		balloon_alert(user, "installation failed!")
		return FALSE
	install(target, user)
	after_install(target, user)
	balloon_alert(user, "neuroware installed")
	if(target != user)
		target.visible_message(
			span_danger("[user] forces [src] into [target]'s [cyberware_type] slot!"),
			span_userdanger("[user] forces [src] into your [cyberware_type] slot!")
		)
		if(target.is_blind())
			to_chat(target, span_userdanger("Something was inserted into your [cyberware_type] slot!"))
	if(!reusable)
		qdel(src)

///Install software (run effects or insert reagents) into the target mob
/obj/item/disk/neuroware/proc/install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(isnull(list_reagents))
		return
	var/total_units = counterlist_sum(list_reagents)
	var/datum/reagents/reagents = new(total_units)
	reagents.add_noreact_reagent_list(list_reagents)
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		// Hide reagent from scanners, as it's "software" in this context
		reagent.chemical_flags |= REAGENT_INVISIBLE
		// Prevent reagent from processing in organics
		reagent.process_flags = REAGENT_SYNTHETIC
	log_combat(user, target, "added neuroware to", reagents.get_reagent_log_string())
	reagents.trans_to(target, total_units)

///Override to safely implement any side-effects after installing.
/obj/item/disk/neuroware/proc/after_install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	return
