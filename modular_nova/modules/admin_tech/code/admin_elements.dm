/// Stores all elements made by the Admin_Tech module.

/// Attach to clothing to grant the wearer all languages (Book of Babel effect) while worn, and revoke on unequip.
/datum/element/babel_clothing// The base element

/datum/element/babel_clothing/Attach(datum/target)// Activates our element features when attaching to whatever
	. = ..()
//	if(!isclothing(target))// If it's not clothing
//		return ELEMENT_INCOMPATIBLE// Turn element into whiny plush. I only made this to be used with clothing.
	ADD_TRAIT(target, TRAIT_BABEL_CLOTHING, REF(src))// Add our trait
	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))// Register a signal on our wearer to remove this should they take it off for whatever reason.

/datum/element/babel_clothing/Detach(datum/source, ...)// Handles separation anxiet- I mean our element detaching from its source
	REMOVE_TRAIT(source, TRAIT_BABEL_CLOTHING, REF(src))
	UnregisterSignal(source, COMSIG_ITEM_EQUIPPED)
	return ..()

/datum/element/babel_clothing/proc/on_equipped(obj/item/source, mob/equipper, slot)// Do thing when worn
	SIGNAL_HANDLER// poke our signaller
	equipper.grant_all_languages(source = LANGUAGE_BABEL)// thank you, book of babel
	equipper.remove_blocked_language(GLOB.all_languages, source = LANGUAGE_ALL)// you saved me
	if(equipper.mind)// all of this is directly from the book of babel itself
		ADD_TRAIT(equipper.mind, TRAIT_TOWER_OF_BABEL, REF(src))
	RegisterSignal(equipper, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_mob_unequipped_item))//signal pass off to the actual mob for the unequip

/datum/element/babel_clothing/proc/on_mob_unequipped_item(mob/wearer, obj/item/unequipped, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER// it sniff the handler
	if(!HAS_TRAIT(unequipped, TRAIT_BABEL_CLOTHING))// it look if we dont have trait
		return// it say good bye if we do not
	for(var/obj/item/worn as anything in wearer.get_equipped_items())// we look at wearer items
		if(worn != unequipped && HAS_TRAIT(worn, TRAIT_BABEL_CLOTHING))// sniffs about for if we have another item doing the same thing, so we dont oopsie a stack of items. who the fuck is wearing multiple items with this? who cares. bug squish in advance.
			return // still wearing another babel item, keep the languages
	UnregisterSignal(wearer, COMSIG_MOB_UNEQUIPPED_ITEM)// cleans up our messes
	wearer.remove_all_languages(source = LANGUAGE_BABEL)// stupifies you cutely :3c
	if(wearer.mind)// of course they have a mind, we're just... you know. we look first. its responsible to look both ways before crossing the street
		REMOVE_TRAIT(wearer.mind, TRAIT_TOWER_OF_BABEL, REF(src))// cleans up last of the things we added
