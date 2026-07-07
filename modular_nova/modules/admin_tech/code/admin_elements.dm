/// Stores all elements made by the Admin_Tech module.

/// Attach to clothing to grant the wearer all languages (Book of Babel effect) while worn, and revoke on unequip.
/datum/element/babel_clothing// The base element

/datum/element/babel_clothing/Attach(datum/target)// Activates our element features when attaching to whatever
	. = ..()
	// headsets apparently aren't clothing, and that was the original target for this, so now I don't know what I want to do. Lets just remove the incompat for now.
	//if(!isclothing(target))// If it's not clothing
		//return ELEMENT_INCOMPATIBLE// Turn element into whiny plush. I only made this to be used with clothing.
	ADD_TRAIT(target, TRAIT_BABEL_CLOTHING, REF(src))// Add our trait
	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))// Register a signal on our wearer to remove this should they take it off for whatever reason.

/datum/element/babel_clothing/Detach(datum/source, ...)// Handles separation anxiet- I mean our element detaching from its source
	REMOVE_TRAIT(source, TRAIT_BABEL_CLOTHING, REF(src))
	UnregisterSignal(source, COMSIG_ITEM_EQUIPPED)
	UnregisterSignal(source, COMSIG_MOB_UNEQUIPPED_ITEM)
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

/// An Element which reveals the wire legend. If you need it for something. Grants TRAIT_SHOW_ALL_WIRES to whoever is holding/wearing this item.
/datum/element/reveal_wires

/datum/element/reveal_wires/Attach(datum/target)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	ADD_TRAIT(target, TRAIT_REVEAL_WIRES_ITEM, REF(src))
	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(target, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))

/datum/element/reveal_wires/Detach(datum/source, ...)
	REMOVE_TRAIT(source, TRAIT_REVEAL_WIRES_ITEM, REF(src))
	UnregisterSignal(source, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_PICKUP))
	return ..()

/datum/element/reveal_wires/proc/on_equipped(obj/item/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if(!(slot & source.slot_flags))
		return
	grant(equipper)

/datum/element/reveal_wires/proc/on_pickup(obj/item/source, mob/user)
	SIGNAL_HANDLER
	grant(user)

/datum/element/reveal_wires/proc/grant(mob/holder)
	ADD_TRAIT(holder, TRAIT_SHOW_ALL_WIRES, REF(src))
	RegisterSignal(holder, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_mob_unequipped_item))
	RegisterSignal(holder, COMSIG_ITEM_DROPPED, PROC_REF(on_mob_dropped_item))

/datum/element/reveal_wires/proc/on_mob_unequipped_item(mob/wearer, obj/item/unequipped, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER
	check_revoke(wearer, unequipped)

/datum/element/reveal_wires/proc/on_mob_dropped_item(mob/wearer, obj/item/dropped)
	SIGNAL_HANDLER
	check_revoke(wearer, dropped)

/datum/element/reveal_wires/proc/check_revoke(mob/wearer, obj/item/removed)
	if(!HAS_TRAIT(removed, TRAIT_REVEAL_WIRES_ITEM))
		return
	for(var/obj/item/held as anything in wearer.get_equipped_items(INCLUDE_HELD))
		if(held != removed && HAS_TRAIT(held, TRAIT_REVEAL_WIRES_ITEM))
			return
	REMOVE_TRAIT(wearer, TRAIT_SHOW_ALL_WIRES, REF(src))
	UnregisterSignal(wearer, list(COMSIG_MOB_UNEQUIPPED_ITEM, COMSIG_ITEM_DROPPED))
