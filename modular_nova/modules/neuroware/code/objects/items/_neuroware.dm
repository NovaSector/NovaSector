#define CHIP_LABEL_BISHOP " It has a <b>[span_cyan("Bishop Cybernetics, Inc.")]</b> label visible on it."
#define CHIP_LABEL_DEFOREST " It has <b>[span_cyan("DeForest Medical Corporation")]</b> laser-etched into it."
#define CHIP_LABEL_DONK " It has a <b>[span_green("Donk Corporation")]</b> label visible on it."
#define CHIP_LABEL_MAINT " It has <b>[span_sans("XLR8.EXE")]</b> and <b>[span_sans("wakes you up!")]</b> drawn onto it."
#define CHIP_LABEL_NT " It has a <b>[span_blue("Nanotrasen Systems, Inc.")]</b> label visible on it."
#define CHIP_LABEL_SYNDIE " It has <b>[span_red("Cybersun Industries")]</b> laser-etched into it."
#define CHIP_LABEL_WARD " It has <b>[span_yellow("Ward-Takahashi Manufacturing")]</b> laser-etched into it."
#define CHIP_LABEL_ZENGHU " It has a <b>[span_pink("Zeng-Hu Pharmaceuticals")]</b> label visible on it."
///Neuroware chips are installed into this
#define NEURO_SLOT_NAME "persocom chip slot"

///Data chip which contextualizes drugs as "software" for synthetic brains.
///Like pills, but doesn't directly contain reagents, instead adds them manually.
/obj/item/disk/neuroware
	name = "blank neuroware"
	special_desc = "A neuroware chip uploads neurocomputing programs to the user's brain. The recipient must be a synthetic humanoid. \
	Neurocomputing software, also known as neuroware, are programs designed to execute their code within the synaptic connections of artificial neural networks."
	icon = 'modular_nova/modules/neuroware/icons/neuroware.dmi'
	icon_state = "chip_generic"
	greyscale_config = /datum/greyscale_config/neuroware
	// Color of circuitboard underlay.
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	var/success_message = "inserted neuroware chip"
	///Associative list of reagent types to units. Added to the mob when the chip is used.
	var/list/list_reagents
	///Manufacturer label appended to examine.
	var/manufacturer_tag
	///How many deciseconds to delay when used on someone else.
	var/external_delay = 5 SECONDS
	///If set to FALSE, won't install if the same reagents already exist in the target.
	var/can_overdose = FALSE
	///If set to FALSE, the chip gets deleted when uses reaches 0.
	var/reusable = TRUE
	///How many times the chip can be used.
	var/uses = 1
	///Whether or not this chip requires lewd item preference enforcement.
	var/is_lewd = FALSE

/obj/item/disk/neuroware/Initialize(mapload)
	. = ..()
	if(is_lewd && CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	if(isnull(manufacturer_tag))
		return
	switch(manufacturer_tag)
		if(NEUROWARE_NT)
			desc += CHIP_LABEL_NT
		if(NEUROWARE_BISHOP)
			desc += CHIP_LABEL_BISHOP
		if(NEUROWARE_DEFOREST)
			desc += CHIP_LABEL_DEFOREST
		if(NEUROWARE_DONK)
			desc += CHIP_LABEL_DONK
		if(NEUROWARE_MAINT)
			desc += CHIP_LABEL_MAINT
		if(NEUROWARE_SYNDIE)
			desc += CHIP_LABEL_SYNDIE
		if(NEUROWARE_WARD)
			desc += CHIP_LABEL_WARD
		if(NEUROWARE_ZENGHU)
			desc += CHIP_LABEL_ZENGHU

/obj/item/disk/neuroware/examine()
	. = ..()
	if(uses > 0)
		. += span_notice("It has [uses] user license[uses > 1 ? "s" : ""] left.")
	else
		. += span_notice("It is spent.")

/obj/item/disk/neuroware/attack_self(mob/user, modifiers)
	if(!try_install(user, user))
		return ..()

/obj/item/disk/neuroware/attack(mob/living/mob, mob/living/user, params)
	if(!try_install(mob, user))
		return ..()

///Safely implement any side-effects after installing.
/obj/item/disk/neuroware/proc/after_install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	return

///Installs only if the mob has a synthetic brain
/obj/item/disk/neuroware/proc/try_install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!ishuman(target))
		return
	if(uses == 0)
		balloon_alert(user, "it's been used up!")
		return
	var/obj/item/organ/brain/owner_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(isnull(owner_brain) || !(owner_brain.organ_flags & ORGAN_ROBOTIC))
		balloon_alert(user, "synthetic brain required!")
		return
	if(is_lewd && !(target.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		balloon_alert(user, "installation failed!")
		return
	if(target != user)
		target.visible_message(
			span_danger("[user] tries to force [src] into [target]'s [NEURO_SLOT_NAME]!"),
			span_userdanger("[user] tries to force [src] into your [NEURO_SLOT_NAME]!")
		)
		if(target.is_blind())
			to_chat(target, span_userdanger("You feel something being inserted into your [NEURO_SLOT_NAME]!"))
		if(external_delay > 0)
			user.balloon_alert_to_viewers("inserting chip...")
			if(!do_after(user, 5 SECONDS, target))
				return
		target.visible_message(
			span_danger("[user] forces [src] into [target]'s [NEURO_SLOT_NAME]!"),
			span_userdanger("[user] forces [src] into your [NEURO_SLOT_NAME]!")
		)
		if(target.is_blind())
			to_chat(target, span_userdanger("Something was inserted into your [NEURO_SLOT_NAME]!"))

	playsound(src, 'sound/machines/pda_button/pda_button1.ogg', 50, TRUE)
	var/install_status = install(target, user)
	if(!install_status)
		balloon_alert(user, "installation failed!")
		return

	target.balloon_alert_to_viewers(success_message)
	after_install(target, user)

	uses += -1
	if(!reusable && (uses == 0))
		qdel(src)

	return TRUE

///Installs neuroware (insert reagents) into the target mob. Returns TRUE on success.
/obj/item/disk/neuroware/proc/install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(isnull(list_reagents))
		return TRUE
	// Prevent install if it would cause a reagent overdose
	if(!can_overdose)
		for(var/reagent_type as anything in list_reagents)
			var/datum/reagent/existing_reagent = target.has_reagent(reagent_type)
			if(!existing_reagent || existing_reagent.overdose_threshold == 0)
				continue
			var/new_volume = list_reagents[reagent_type] + existing_reagent.volume
			if(new_volume >= existing_reagent.overdose_threshold)
				return FALSE

	var/total_units = counterlist_sum(list_reagents)
	var/datum/reagents/chip_reagents = new(total_units)
	chip_reagents.add_noreact_reagent_list(list_reagents)
	chip_reagents.trans_to(target, total_units)

	var/datum/status_effect/neuroware/neuro_status = target.has_status_effect(/datum/status_effect/neuroware)
	if(isnull(neuro_status))
		target.apply_status_effect(/datum/status_effect/neuroware, length(list_reagents))
	else
		neuro_status.adjust_program_count(length(list_reagents))

	if(target != user)
		log_combat(user, target, "added neuroware to", chip_reagents.get_reagent_log_string())

	return TRUE

#undef CHIP_LABEL_BISHOP
#undef CHIP_LABEL_DEFOREST
#undef CHIP_LABEL_DONK
#undef CHIP_LABEL_MAINT
#undef CHIP_LABEL_NT
#undef CHIP_LABEL_SYNDIE
#undef CHIP_LABEL_WARD
#undef CHIP_LABEL_ZENGHU
#undef NEURO_SLOT_NAME
