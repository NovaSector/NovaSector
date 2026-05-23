//TRANSLATOR NECKLACE//
#define LANGUAGE_TRANSLATOR "translator"

/obj/item/clothing/neck/necklace/translator/
	name = "ashen necklace"
	desc = "A necklace crafted from ash, connected to the Necropolis through the core of a Legion. This imbues overdwellers with an unnatural understanding of Ashtongue, the native language of Lavaland, while worn."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	slot_flags = ITEM_SLOT_NECK | ITEM_SLOT_OCLOTHING
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.
	/// The language granted by this necklace
	var/datum/language/language_granted = /datum/language/ashtongue
	/// Where the power comes from
	var/power_source = "the Necropolis"
	/// Whether this necklace has been granted passage through tribal den holes.
	var/attuned = FALSE
	/// Display name of whoever granted passage.
	var/attuned_by_name


/obj/item/clothing/neck/necklace/translator/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_necklace_equip))

/obj/item/clothing/neck/necklace/translator/examine(mob/user)
	. = ..()
	if(attuned)
		. += span_notice("It has been granted passage by [attuned_by_name || "an unknown hand"].")
	else
		. += span_notice("It can be granted passage by a tribal.")

/obj/item/clothing/neck/necklace/translator/attack_self(mob/living/user, modifiers)
	. = ..()
	if(attuned)
		if(can_attune(user))
			attuned = FALSE
			attuned_by_name = null
			to_chat(user, span_notice("You revoke [src]'s passage rights."))
			playsound(user, SFX_PORTAL_CREATED, 40, TRUE)

			var/mob/living/carbon/human/wearer = loc
			if(istype(wearer) && wearer.wear_neck == src)
				remove_access(wearer)
			return

		to_chat(user, span_notice("[src] has already been granted passage by [attuned_by_name || "an unknown hand"]."))
		return

	if(!can_attune(user))
		to_chat(user, span_warning("You do not know the rite needed to grant passage with [src]."))
		return

	attuned = TRUE
	attuned_by_name = user.real_name || user.name
	to_chat(user, span_notice("You grant [src] passage rights"))
	playsound(user, SFX_PORTAL_CREATED, 40, TRUE)

	var/mob/living/carbon/human/wearer = loc
	if(istype(wearer) && wearer.wear_neck == src)
		grant_access(wearer)

/obj/item/clothing/neck/necklace/translator/proc/can_attune(mob/living/user)
	return istribal(user) || check_rights_for(user?.client, R_ADMIN)

/obj/item/clothing/neck/necklace/translator/proc/is_attuned()
	return attuned

/// Handles giving the language to the equipper when equipped.
/obj/item/clothing/neck/necklace/translator/proc/on_necklace_equip(datum/source, mob/living/carbon/human/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot_flags & slot))
		return

	if(!istype(equipper))
		return

	equipper.grant_language(language_granted, source = LANGUAGE_TRANSLATOR)
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_necklace_unequip))
	if(slot & ITEM_SLOT_NECK)
		RegisterSignal(equipper, COMSIG_ATOM_EXAMINE, PROC_REF(on_wearer_examine))
		if(attuned)
			grant_access(equipper)

	equip_feedback(equipper)


/// Handles sending text feedback to the equipper. Override to change the text.
/obj/item/clothing/neck/necklace/translator/proc/equip_feedback(mob/living/carbon/human/equipper)
	to_chat(equipper, span_boldnotice( \
		"Slipping the necklace on, you feel the insidious creep of [power_source] \
		enter your bones, your very shadow and soul. You find yourself with an \
		unnatural knowledge of the [initial(language_granted.name)]; but the \
		amulet's eye stares back at you with a gleeful intent. Causing you to \
		shiver with unease, you don't want to keep this on forever." \
	))


/// Handles removing the language from the unequipper when unequipped.
/obj/item/clothing/neck/necklace/translator/proc/on_necklace_unequip(obj/item/source, mob/living/carbon/human/unequipper)
	SIGNAL_HANDLER

	if(!istype(unequipper))
		return

	unequipper.remove_language(language_granted, source = LANGUAGE_TRANSLATOR)
	remove_access(unequipper)
	UnregisterSignal(unequipper, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(source, COMSIG_ITEM_DROPPED)

	unequip_feedback(unequipper)


/// Handles sending text feedback to the unequipper. Override to change the text.
/obj/item/clothing/neck/necklace/translator/proc/unequip_feedback(mob/living/carbon/human/unequipper)
	to_chat(unequipper, span_boldnotice( \
		"You feel the alien mind of [power_source] lose its interest in you as \
		you remove the necklace. The eye closes, and your mind does as well, \
		losing its grasp of [initial(language_granted.name)]" \
	))

/obj/item/clothing/neck/necklace/translator/proc/grant_access(mob/living/carbon/human/wearer)
	ADD_TRAIT(wearer, TRAIT_TRIBAL_DEN_ACCESS, src)

/obj/item/clothing/neck/necklace/translator/proc/remove_access(mob/living/carbon/human/wearer)
	REMOVE_TRAIT(wearer, TRAIT_TRIBAL_DEN_ACCESS, src)

/obj/item/clothing/neck/necklace/translator/proc/on_wearer_examine(mob/living/carbon/human/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(source.wear_neck != src || !attuned)
		return

	examine_list += span_notice("[source.p_They(TRUE)] [source.p_have()] den passage granted by [attuned_by_name || "an unknown hand"].")

#undef LANGUAGE_TRANSLATOR
