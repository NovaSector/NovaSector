/obj/item/organ
	///This is for associating an organ with a mutant bodypart. Look at tails for examples
	var/mutantpart_key
	var/list/list/mutantpart_info
	/// Do we drop when organs are spilling?
	var/drop_when_organ_spilling = TRUE
	/// Special flags that need to be passed over from the sprite_accessory to the organ (but not the opposite).
	var/sprite_accessory_flags = NONE
	/// Relevant layer flags, as set by the organ's associated sprite_accessory, should there be one.
	var/relevant_layers
	/// What the organ is being replaced with (in case it's the same thing, we don't want to remove it from mutant_bodyparts)
	var/obj/item/organ/being_replaced_with

/obj/item/organ/Initialize(mapload)
	. = ..()
	if(mutantpart_key)
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

/obj/item/organ/Insert(mob/living/carbon/receiver, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	var/mob/living/carbon/human/human_receiver = receiver
	if(mutantpart_key && istype(human_receiver))
		human_receiver.dna.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
		human_receiver.dna.species.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
		if(!special)
			human_receiver.update_body()
	return ..()

/obj/item/organ/Remove(mob/living/carbon/receiver, special = FALSE, movement_flags)
	var/mob/living/carbon/human/human_receiver = receiver
	if(mutantpart_key && istype(human_receiver))
		if(human_receiver.dna.species.mutant_bodyparts[mutantpart_key])
			mutantpart_info = human_receiver.dna.species.mutant_bodyparts[mutantpart_key].Copy() //Update the info in case it was changed on the person
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
	. = ..()
	// Don't want to remove this from mutant_bodyparts after we've just added it...(in case of replacing it with the same type of organ)
	if(isnull(being_replaced_with) || (mutantpart_key && being_replaced_with.mutantpart_key && mutantpart_key != being_replaced_with.mutantpart_key))
		human_receiver.dna.mutant_bodyparts -= mutantpart_key
		human_receiver.dna.species.mutant_bodyparts -= mutantpart_key
	if(!special)
		human_receiver.update_body()
	being_replaced_with = null

/obj/item/organ/proc/build_from_dna(datum/dna/DNA, associated_key)
	mutantpart_key = associated_key
	mutantpart_info = DNA.mutant_bodyparts[associated_key].Copy()
	color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
