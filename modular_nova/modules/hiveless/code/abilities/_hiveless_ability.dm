/// Base for protein-fueled hiveless abilities.
/datum/action/cooldown/spell/hiveless
	name = "Hiveless Power"
	desc = "A biological ability fueled by raw protein."
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	school = SCHOOL_EVOCATION
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE
	sound = null
	cooldown_time = 2 SECONDS
	/// Protein spent per successful cast.
	var/protein_cost = 10
	/// `world.time` of the last "not enough protein" balloon, for throttling spam.
	var/last_protein_alert = 0
	/// Whether this ability is blocked while the owner is on fire.
	var/disabled_by_fire = TRUE

/// Returns the protein-bank stomach on the owner, or null.
/datum/action/cooldown/spell/hiveless/proc/get_protein_bank(mob/living/carbon/user)
	if(!iscarbon(user))
		return null
	return user.get_organ_slot(ORGAN_SLOT_STOMACH)

/datum/action/cooldown/spell/hiveless/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(!iscarbon(owner))
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(disabled_by_fire && carbon_owner.fire_stacks && carbon_owner.on_fire)
		if(feedback)
			owner.balloon_alert(owner, "on fire!")
		return FALSE
	if(carbon_owner.reagents?.has_reagent(/datum/reagent/bz_metabolites, needs_metabolizing = TRUE))
		if(feedback)
			owner.balloon_alert(owner, "bz in blood!")
		return FALSE
	var/obj/item/organ/stomach/hiveless/bank = get_protein_bank(owner)
	if(!istype(bank))
		if(feedback)
			owner.balloon_alert(owner, "body rejects the change!")
		return FALSE
	if(bank.protein < protein_cost)
		if(feedback && (world.time - last_protein_alert >= 3 SECONDS))
			owner.balloon_alert(owner, "not enough protein!")
			last_protein_alert = world.time
		return FALSE
	return TRUE

/// Deducts protein_cost. Returns the stomach on success, null on failure.
/datum/action/cooldown/spell/hiveless/proc/spend_protein()
	var/obj/item/organ/stomach/hiveless/bank = get_protein_bank(owner)
	if(!istype(bank))
		return null
	if(!bank.try_spend_protein(protein_cost, owner))
		return null
	return bank

/// Splatters blood on the caster's tile and adjacent tiles, and stains worn clothing.
/datum/action/cooldown/spell/hiveless/proc/spray_cast_blood(mob/living/source = owner)
	if(!isliving(source))
		return
	var/turf/center = get_turf(source)
	if(!center)
		return
	source.add_splatter_floor(center)
	for(var/turf/nearby in RANGE_TURFS(1, center))
		if(nearby == center)
			continue
		if(prob(35))
			source.add_splatter_floor(nearby, small_drip = TRUE)
	stain_worn_clothing(source)

/// Adds the mob's blood DNA to its equipped clothing.
/datum/action/cooldown/spell/hiveless/proc/stain_worn_clothing(mob/living/source)
	if(!ishuman(source))
		return
	var/mob/living/carbon/human/human_source = source
	var/list/blood_dna = human_source.get_blood_dna_list()
	if(!length(blood_dna))
		return
	human_source.add_blood_DNA_to_items(
		blood_dna,
		ITEM_SLOT_ICLOTHING | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_MASK,
	)
