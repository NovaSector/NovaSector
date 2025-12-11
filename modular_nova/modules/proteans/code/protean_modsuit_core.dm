/obj/item/mod/core/protean
	name = "MOD protean core"
	icon_state = "mod-core-ethereal"
	desc = "If you see this, go scream at a coder and tell them how you managed to do this."

	/// We handle as many interactions as possible through the species datum
	/// The species handles cleanup on this
	var/datum/weakref/linked_species_ref

/obj/item/mod/core/protean/charge_source()
	var/datum/species/protean/linked_species = linked_species_ref?.resolve()
	if(isnull(linked_species))
		linked_species_ref = null
		return
	if(isnull(linked_species.owner))
		return
	return linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)

/obj/item/mod/core/protean/charge_amount()
	var/obj/item/organ/stomach/protean/stomach = charge_source()
	if(!istype(stomach))
		return
	var/datum/species/protean/linked_species = linked_species_ref?.resolve()
	if(isnull(linked_species))
		linked_species_ref = null
		return
	if(!linked_species?.owner)
		return
	var/obj/item/organ/brain/protean/brain = linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain) || brain.dead)
		return
	return stomach.metal

/obj/item/mod/core/protean/max_charge_amount()
	return PROTEAN_STOMACH_FULL

/// We don't charge in a standard way
/obj/item/mod/core/protean/add_charge(amount)
	return FALSE

/obj/item/mod/core/protean/subtract_charge(amount)
	return FALSE

/obj/item/mod/core/protean/check_charge(amount)
	var/obj/item/organ/stomach/protean/stomach = charge_source()
	if(!istype(stomach))
		return FALSE
	var/datum/species/protean/linked_species = linked_species_ref?.resolve()
	if(isnull(linked_species))
		linked_species_ref = null
	if(!linked_species?.owner)
		return FALSE
	var/obj/item/organ/brain/protean/brain = linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(stomach.metal <= PROTEAN_STOMACH_FALTERING)
		return FALSE
	if(!istype(brain) || brain.dead)
		return FALSE
	return TRUE

/obj/item/mod/core/protean/get_charge_icon_state()
	return charge_source() ? "0" : "missing"

/obj/item/mod/core/protean/get_chargebar_color()
	if(isnull(charge_amount()))
		return "transparent"
	switch(charge_amount())
		if (-INFINITY to (PROTEAN_STOMACH_FULL * 0.3))
			return "bad"
		if((PROTEAN_STOMACH_FULL * 0.3) to (PROTEAN_STOMACH_FULL * 0.7))
			return "average"
		if((PROTEAN_STOMACH_FULL * 0.7) to INFINITY)
			return "good"

/// Nanite slurry blood type for proteans
/datum/blood_type/nanite_slurry
	name = BLOOD_TYPE_NANITE_SLURRY
	desc = "A metallic grey liquid comprised of microscopic nanomachines suspended in a conductive slurry. \
		These nanites serve as both the protean's circulatory system and repair mechanism."
	dna_string = "Protean Nanite Signature"
	color = /datum/reagent/medicine/nanite_slurry::color // Tied to nanite slurry reagent color
	reagent_type = /datum/reagent/medicine/nanite_slurry
	restoration_chem = /datum/reagent/iron // Proteans use metal to regenerate blood
	compatible_types = list(
		/datum/blood_type/nanite_slurry,
	)
	// Nanite blood should leave DNA and cover surfaces like normal blood
	blood_flags = BLOOD_ADD_DNA | BLOOD_COVER_ALL | BLOOD_TRANSFER_VIRAL_DATA
