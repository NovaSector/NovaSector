//DEFAULT NECK ITEMS OVERRIDE//
/obj/item/clothing/neck
	w_class = WEIGHT_CLASS_SMALL

//ASHWALKER TRANSLATOR NECKLACE//
#define LANGUAGE_TRANSLATOR "translator"
/obj/item/clothing/neck/necklace/ashwalker
	name = "ashen necklace"
	desc = "A necklace crafted from ash, connected to the Necropolis through the core of a Legion. This imbues overdwellers with an unnatural understanding of Ashtongue, the native language of Lavaland, while worn."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ashnecklace"
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.

/obj/item/clothing/neck/necklace/ashwalker/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_necklace_equip))
	RegisterSignal(src, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_necklace_unequip))

//uses code from the pirate hat.
/obj/item/clothing/neck/necklace/ashwalker/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_NECK)
		user.grant_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)

/obj/item/clothing/neck/necklace/ashwalker/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_NECK) == src && !QDELETED(src)) //This can be called as a part of destroy
		user.remove_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)

/obj/item/clothing/neck/necklace/ashwalker/proc/on_necklace_equip(datum/source, mob/living/carbon/human/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_NECK))
		return

	if(!istype(equipper))
		return

	equipper.remove_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)
	to_chat(source, span_boldnotice("Slipping the necklace on, you feel the insidious creep of the Necropolis enter your bones, and your very shadow. You find yourself with an unnatural knowledge of Ashtongue; but the amulet's eye stares at you."))

/obj/item/clothing/neck/necklace/ashwalker/proc/on_necklace_unequip(mob/living/carbon/human/source, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	if(!istype(source))
		return

	source.remove_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)
	to_chat(source, span_boldnotice("You feel the alien mind of the Necropolis lose its interest in you as you remove the necklace. The eye closes, and your mind does as well, losing its grasp of Ashtongue."))
//ASHWALKER TRANSLATOR NECKLACE END//
