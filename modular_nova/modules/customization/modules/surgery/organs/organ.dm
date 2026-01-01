/obj/item/organ
	/// Do we drop when organs are spilling?
	var/drop_when_organ_spilling = TRUE
	/// Special flags that need to be passed over from the sprite_accessory to the organ (but not the opposite).
	var/sprite_accessory_flags = NONE
	/// Relevant layer flags, as set by the organ's associated sprite_accessory, should there be one.
	var/relevant_layers
	///This is for associating an organ with a mutant bodypart. Look at tails for examples
	var/mutantpart_key
	/// A list with utant part preference name, its color and emissives if they exist (check code\__DEFINES\~nova_defines\DNA.dm)
	var/list/list/mutantpart_info
	/// Whether or not we're a species-specific organ that will override
	/// the ear choice on a certain species, while still applying its visuals.
	var/overrides_sprite_datum_organ_type = FALSE
	///Bitfield of mob biotypes which are compatible with this organ.
	///Causes Organ Rejection Syndrome if the organ owner's biotype isn't included.
	var/compatible_biotypes = ALL
	///Mob species string which is compatible with this organ.
	///Causes Organ Rejection Syndrome if not null and the organ owner's species isn't included.
	var/compatible_species

/obj/item/organ/Initialize(mapload)
	. = ..()
	if(mutantpart_key)
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

/obj/item/organ/Remove(mob/living/carbon/organ_owner, special, movement_flags)
	if(mutantpart_key)
		transfer_mutantpart_info(organ_owner, special)
	return ..()

// Checks if the implanted organ is being rejected by the host mob after a transplant.
// If rejected, then infects the mob with Organ Rejection and registers the affected organ with the disease.
/obj/item/organ/on_bodypart_insert(obj/item/bodypart/limb, movement_flags)
	. = ..()
	if(is_rejected(limb.owner))
		start_rejection()

// Checks if the removed organ was being rejected by the host mob.
// If it was rejected, then unregisters the affected organ from the disease.
/obj/item/organ/on_bodypart_remove(obj/item/bodypart/limb, movement_flags)
	. = ..()
	if(is_rejected(limb.owner))
		stop_rejection()

/// Copies the organ's mutantpart_info to the owner's mutant_bodyparts
/obj/item/organ/proc/copy_to_mutant_bodyparts(mob/living/carbon/organ_owner, special)
	var/mob/living/carbon/human/human_owner = organ_owner
	if(!istype(human_owner))
		return

	human_owner.dna.species.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
	if(!special)
		human_owner.update_body()

/// Copies the mob's mutant_bodyparts data to an organ's mutantpart_info for consistency e.g. on organ removal
/obj/item/organ/proc/transfer_mutantpart_info(mob/living/carbon/organ_owner, special)
	var/mob/living/carbon/human/human_owner = organ_owner
	if(!istype(human_owner))
		return

	var/list/mutant_bodyparts = human_owner?.dna?.species?.mutant_bodyparts
	var/list/previous_mutantpart_info = mutant_bodyparts && mutant_bodyparts[mutantpart_key]
	if(previous_mutantpart_info)
		mutantpart_info = previous_mutantpart_info.Copy() //Update the info in case it was changed on the person

	color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
	human_owner.dna.species.mutant_bodyparts -= mutantpart_key
	if(!special)
		human_owner.update_body()

/obj/item/organ/proc/build_from_dna(datum/dna/DNA, associated_key)
	mutantpart_key = associated_key
	mutantpart_info = DNA.mutant_bodyparts[associated_key].Copy()
	color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

///Returns TRUE if the organ is incompatible with the given affected_mob, otherwise returns FALSE
/obj/item/organ/proc/is_rejected(mob/living/carbon/affected_mob)
	if(isnull(affected_mob))
		return FALSE
	if((compatible_biotypes == ALL) || (compatible_biotypes & affected_mob.mob_biotypes))
		return FALSE
	if(!isnull(compatible_species))
		var/datum/dna/mob_dna = affected_mob.has_dna()
		if(isnull(mob_dna) || (mob_dna.species.id == compatible_species))
			return FALSE
	return TRUE

///Infecrs the organ owner with Organ Rejection disease if compatible_biotypes doesn't contain the owner's biotype.
///Registers a bodypart with Organ Rejection disease if the organ owner has it.
/obj/item/organ/proc/start_rejection()
	var/datum/disease/organ_rejection/rejection_disease = locate(/datum/disease/organ_rejection) in owner.diseases
	if(QDELETED(rejection_disease))
		owner.ForceContractDisease(new /datum/disease/organ_rejection(src), make_copy = FALSE, del_on_fail = TRUE)
	else
		rejection_disease.add_organ(src)

///Unregisters a bodypart from Organ Rejection disease if it's present on the organ owner
/obj/item/organ/proc/stop_rejection()
	var/datum/disease/organ_rejection/rejection_disease = locate(/datum/disease/organ_rejection) in owner?.diseases
	if(!QDELETED(rejection_disease))
		rejection_disease.remove_organ(src)
