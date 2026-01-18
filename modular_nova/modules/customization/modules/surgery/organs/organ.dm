/obj/item/organ
	/// Do we drop when organs are spilling?
	var/drop_when_organ_spilling = TRUE
	/// Special flags that need to be passed over from the sprite_accessory to the organ (but not the opposite).
	var/sprite_accessory_flags = NONE
	/// Relevant layer flags, as set by the organ's associated sprite_accessory, should there be one.
	var/relevant_layers
	///This is for associating an organ with a mutant bodypart. Look at tails for examples
	var/mutantpart_key
	/// Whether or not we're a species-specific organ that will override
	/// the ear choice on a certain species, while still applying its visuals.
	var/overrides_sprite_datum_organ_type = FALSE

/obj/item/organ/proc/get_default_mutant_part()
	return

/obj/item/organ/proc/build_from_dna(datum/dna/build_from, associated_key)
	mutantpart_key = associated_key
	var/datum/mutant_bodypart/mutant_part = build_from.mutant_bodyparts[associated_key]
	if(mutant_part)
		color = mutant_part.get_primary_color()
