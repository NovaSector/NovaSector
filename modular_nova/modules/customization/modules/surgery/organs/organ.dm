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

/obj/item/organ/Initialize(mapload)
	. = ..()
	//if(mutantpart_key)
	//	color = mutantpart_info?.get_primary_color()

/obj/item/organ/proc/get_default_mutant_part()
	return

/obj/item/organ/Remove(mob/living/carbon/organ_owner, special, movement_flags)
	if(!organ_owner.has_dna())
		return ..()
	if(organ_owner.dna.mutant_bodyparts)
		organ_owner.dna.mutant_bodyparts -= mutantpart_key
	return ..()

/obj/item/organ/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(isdummy(organ_owner))
		return
	if(!organ_owner.has_dna())
		return
	if(bodypart_overlay && isnull(organ_owner.dna.mutant_bodyparts[mutantpart_key]))
		var/datum/sprite_accessory/sprite_acc = bodypart_overlay.sprite_datum
		if(sprite_acc)
			organ_owner.dna.mutant_bodyparts[mutantpart_key] = organ_owner.dna.species.build_mutant_part(sprite_acc.name, bodypart_overlay.draw_color, bodypart_overlay.emissive_eligibility_by_color_index)

/obj/item/organ/proc/build_from_dna(datum/dna/build_from, associated_key)
	mutantpart_key = associated_key
	var/datum/mutant_bodypart/mutant_part = build_from.mutant_bodyparts[associated_key]
	if(mutant_part)
		color = mutant_part.get_primary_color()
