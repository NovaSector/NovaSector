//TRANSLATOR NECKLACE//
#define LANGUAGE_TRANSLATOR "translator"
/obj/item/clothing/neck/necklace/translator/
	name = "ashen necklace"
	desc = "A necklace crafted from ash, connected to the Necropolis through the core of a Legion. This imbues overdwellers with an unnatural understanding of Ashtongue, the native language of Lavaland, while worn."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ashnecklace"
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.
	/// The language granted by this necklace
	var/datum/language/language_granted = /datum/language/ashtongue
	/// Where the power comes from
	var/power_source = "the Necropolis"
	/// Whether or not to display the message upon equipping/unequipping
	var/silent

/obj/item/clothing/neck/necklace/translator/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_necklace_equip))

/obj/item/clothing/neck/necklace/translator/proc/on_necklace_equip(datum/source, mob/living/carbon/human/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_NECK))
		return

	if(!istype(equipper))
		return

	equipper.grant_language(language_granted, source = LANGUAGE_TRANSLATOR)
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_necklace_unequip))

	if(!silent)
		to_chat(equipper, span_boldnotice("Slipping the necklace on, you feel the insidious creep of [power_source] enter your bones, your very shadow and soul. You find yourself with an unnatural knowledge of the [initial(language_granted.name)]; but the amulet's eye stares back at you with a gleeful intent. Causing you to shiver with unease, you don't want to keep this on forever."))

/obj/item/clothing/neck/necklace/translator/proc/on_necklace_unequip(obj/item/source, mob/living/carbon/human/unequipper)
	SIGNAL_HANDLER

	if(!istype(unequipper))
		return

	if(unequipper.wear_neck != source)
		return

	unequipper.remove_language(language_granted, source = LANGUAGE_TRANSLATOR)
	UnregisterSignal(source, COMSIG_ITEM_DROPPED)

	if(!silent)
		to_chat(unequipper, span_boldnotice("You feel the alien mind of [power_source] lose its interest in you as you remove the necklace. The eye closes, and your mind does as well, losing its grasp of [initial(language_granted.name)]"))

/obj/item/clothing/neck/necklace/translator/hearthkin
	name = "gemmed necklace"
	desc = "A necklace crafted from a gem found in the frozen wastes. This imbues overdwellers with an unnatural understanding of the Hearthkin while worn."
	language_granted = /datum/language/siiktajr
	power_source = "a dark nature"
