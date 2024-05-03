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
	var/being_replaced_with

/obj/item/organ/Initialize(mapload)
	. = ..()
	if(mutantpart_key)
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

/obj/item/organ/on_mob_insert(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner
	if(!istype(human_owner))
		return
	if(mutantpart_key)
		human_owner.dna.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
		human_owner.dna.species.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
		if(!special)
			human_owner.update_body()

/obj/item/organ/on_mob_remove(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner
	if(!istype(human_owner))
		return

	if(mutantpart_key)
		human_owner.dna.mutant_bodyparts -= mutantpart_key
		human_owner.dna.species.mutant_bodyparts -= mutantpart_key
		if(!special)
			human_owner.update_body()

/obj/item/organ/proc/build_from_dna(datum/dna/DNA, associated_key)
	mutantpart_key = associated_key
	mutantpart_info = DNA.mutant_bodyparts[associated_key].Copy()
	color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
