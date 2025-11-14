/datum/quirk
	/// Is this quirk restricted to nova stars?
	var/nova_stars_only = FALSE
	/// Is this quirk hidden from TGUI / the character preferences window?
	var/hidden_quirk = FALSE
	/// A list which associates Species Datums with Quirk Datums.
	/// Associations are detours to species-specific sub-Quirks which match to a Quirk holder's Species.
	/// Typepaths in this list are explicitly typed, so include any subtypes if needed.
	/* Example:
	 * /datum/quirk/myquirk
	 *	species_quirks = list(
	 *		/datum/species/robotic = /datum/quirk/myquirk/robotic,
	 *		/datum/species/jelly = /datum/quirk/myquirk/jelly
	 *	)
	*/
	var/list/species_quirks

///An implementation of [/datum/quirk/item_quirk/proc/give_item_to_holder] usable on any quirk.
/datum/quirk/proc/give_item_to_holder_nova(obj/item/quirk_item, list/valid_slots, flavour_text = null, default_location = "at your feet", notify_player = FALSE)
	if(ispath(quirk_item))
		quirk_item = new quirk_item(get_turf(quirk_holder))
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/where = human_holder.equip_in_one_of_slots(quirk_item, valid_slots, qdel_on_fail = FALSE, indirect_action = TRUE) || default_location
	if(notify_player)
		to_chat(quirk_holder, span_boldnotice("You have \a [quirk_item] [where]. [flavour_text]"))

/**
 * NovaSector override to add the quirk to a new quirk_holder.
 * Detours/swaps to a species-specific subtyped quirk which matches new_holder's Species, via "species_quirks".
 * Performs logic to make sure new_holder is a valid holder of this quirk.
 * Returns FALSE/null if there was some kind of error. Returns TRUE otherwise.
 *
 * * new_holder - The mob to add this quirk to.
 * * quirk_transfer - If this is being added to the holder as part of a quirk transfer. Quirks can use this to decide not to spawn new items or apply any other one-time effects.
 */
/datum/quirk/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE, announce = TRUE)
	var/mob/living/carbon/human/human_holder = new_holder
	if(isnull(species_quirks) || !ishuman(new_holder) || isnull(human_holder.dna))
		// No species quirks, or if mob isn't human (lacks Species Datum), add quirk as-is.
		return ..()
	var/species_type = human_holder.dna.species.type
	// Match species datum to quirk datum
	var/datum/quirk/species_quirk = species_quirks[species_type]
	if(!species_quirk)
		// No match, add quirk as-is.
		return ..()
	// If the mob already received the detoured quirk, abort adding.
	if(human_holder.has_quirk(species_quirk))
		return
	species_quirk = new species_quirk()
	// This null prevents infinite loop/detour, because subtyped quirks inherit species_quirks.
	// Setting null here is convenient and removes the need for an extra conditional.
	species_quirk.species_quirks = null
	species_quirk.add_to_holder(new_holder, quirk_transfer, client_source)
	qdel(src)
