/// Attached to an egg that holds a living baby inside. Ghost-poll-free port.
/datum/component/pregnant
	dupe_mode = COMPONENT_DUPE_UNIQUE

	/// Living baby held inside the egg. Released when the egg breaks.
	var/mob/living/baby

	var/mother_name
	var/father_name
	/// Chosen name for the offspring, if set via pen writing during pregnancy.
	var/baby_name
	/// Genetic distribution at 0-100 (0 = all mother, 100 = all father).
	var/genetic_distribution = PREGNANCY_GENETIC_DISTRIBUTION_DEFAULT
	/// Associative record of what has been tampered with (e.g. "name", "genetic_distribution").
	var/list/tampering = list()

	var/datum/dna/father_dna
	var/datum/dna/mother_dna

/datum/component/pregnant/Initialize(mob/living/baby, mother_name, father_name, baby_name, datum/dna/mother_dna, datum/dna/father_dna, genetic_distribution)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	if(!baby)
		qdel(src)
		return

	src.baby = baby
	baby.forceMove(parent)
	if(baby_name)
		tampering["name"] = baby_name
		src.baby_name = baby_name
	src.mother_name = mother_name
	src.father_name = father_name

	if(mother_dna)
		src.mother_dna = new()
		mother_dna.copy_dna(src.mother_dna)
	if(father_dna)
		src.father_dna = new()
		father_dna.copy_dna(src.father_dna)

	if(!isnull(genetic_distribution))
		src.genetic_distribution = genetic_distribution

/datum/component/pregnant/RegisterWithParent()
	RegisterSignal(parent, SIGNAL_ADDTRAIT(TRAIT_WAS_RENAMED), PROC_REF(on_renamed))
	RegisterSignal(parent, SIGNAL_REMOVETRAIT(TRAIT_WAS_RENAMED), PROC_REF(on_renamed_removed))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ATOM_BREAK, PROC_REF(hatch))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	if(baby)
		RegisterSignal(baby, COMSIG_MOVABLE_MOVED, PROC_REF(still_birth))
		RegisterSignal(baby, COMSIG_LIVING_DEATH, PROC_REF(still_birth))
		RegisterSignal(baby, COMSIG_QDELETING, PROC_REF(still_birth))

/datum/component/pregnant/UnregisterFromParent()
	UnregisterSignal(parent, list(\
		SIGNAL_ADDTRAIT(TRAIT_WAS_RENAMED),\
		SIGNAL_REMOVETRAIT(TRAIT_WAS_RENAMED),\
		COMSIG_ATOM_ATTACKBY,\
		COMSIG_ATOM_BREAK,\
		COMSIG_ATOM_EXAMINE,\
	))
	if(!QDELETED(baby))
		UnregisterSignal(baby, list(\
			COMSIG_MOVABLE_MOVED,\
			COMSIG_LIVING_DEATH,\
			COMSIG_QDELETING,\
		))

/datum/component/pregnant/Destroy(force)
	baby = null
	return ..()

/// Tamper with the offspring's genetic distribution by daubing cum onto the egg.
/datum/component/pregnant/proc/on_attackby(atom/source, obj/item/thing, mob/living/user, params)
	SIGNAL_HANDLER

	if(!thing.is_drawable(user) || user.combat_mode)
		return

	var/male_amount = thing.reagents?.get_reagent_amount(/datum/reagent/consumable/cum)
	var/female_amount = thing.reagents?.get_reagent_amount(/datum/reagent/consumable/femcum)
	if(!male_amount && !female_amount)
		return

	var/diff = male_amount - female_amount
	diff = clamp(diff, -genetic_distribution, PREGNANCY_GENETIC_DISTRIBUTION_MAXIMUM - genetic_distribution)
	if(!diff)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	genetic_distribution += diff
	thing.reagents.remove_all(/datum/reagent/consumable/cum)
	thing.reagents.remove_all(/datum/reagent/consumable/femcum)
	to_chat(user, span_notice("You alter the genetic distribution of [parent], it is now [genetic_distribution]%."))
	tampering["genetic_distribution"] = genetic_distribution
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Writing a name on the egg carries over to the baby.
/datum/component/pregnant/proc/on_renamed(atom/source)
	SIGNAL_HANDLER

	var/new_name = reject_bad_name(source.name)
	if(new_name)
		tampering["name"] = new_name
		baby_name = new_name
	else
		tampering -= "name"

/datum/component/pregnant/proc/on_renamed_removed(atom/source)
	SIGNAL_HANDLER
	tampering -= "name"

/datum/component/pregnant/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("[source] [source.p_have()] something hatching inside of [source.p_them()]!")
	var/parents
	if(mother_name && father_name)
		parents = "<b>[mother_name]</b> and <b>[father_name]</b>"
	else if(mother_name)
		parents = "<b>[mother_name]</b>"
	else if(father_name)
		parents = "<b>[father_name]</b>"
	if(parents)
		examine_list += span_info("It is the offspring of [parents].")
	if(tampering["name"])
		examine_list += span_info("The offspring's name will be \"[tampering["name"]]\".")
	if(isobserver(user))
		if(tampering["genetic_distribution"])
			examine_list += span_info("The offspring will inherit [genetic_distribution]% of their DNA from their father, [100-genetic_distribution]% from their mother.")

/// Released when the egg breaks — spawn baby into the world, unconscious.
/datum/component/pregnant/proc/hatch(atom/source)
	SIGNAL_HANDLER

	var/atom/atom_parent = parent
	if(QDELETED(baby))
		baby = null
	else
		baby.forceMove(atom_parent.drop_location())
		baby.AdjustUnconscious(20 SECONDS)
		if(ishuman(baby) && baby_name)
			var/mob/living/carbon/human/human_baby = baby
			human_baby.real_name = baby_name
			human_baby.name = baby_name
			human_baby.updateappearance()
	if(!QDELING(src))
		qdel(src)

/datum/component/pregnant/proc/still_birth(atom/source)
	SIGNAL_HANDLER

	var/atom/atom_parent = parent
	if(QDELETED(baby))
		baby = null
	else
		QDEL_NULL(baby)
	if(!QDELETED(atom_parent))
		new /obj/effect/gibspawner/generic(atom_parent.drop_location())
		if(atom_parent.uses_integrity)
			atom_parent.take_damage(atom_parent.max_integrity * (1 - atom_parent.integrity_failure))
	if(!QDELING(src))
		qdel(src)

/// Blend DNA of two parents into the baby. Simplified from SPLURT — relies on copy_dna where practical.
/proc/determine_baby_dna(mob/living/carbon/human/baby, datum/dna/mother_dna, datum/dna/father_dna, genetic_distribution = PREGNANCY_GENETIC_DISTRIBUTION_DEFAULT)
	if(!mother_dna && !father_dna)
		return
	// Species: always inherit from mother.
	if(mother_dna?.species)
		baby.set_species(mother_dna.species.type)

	var/datum/dna/source_dna = mother_dna
	if(father_dna && prob(genetic_distribution))
		source_dna = father_dna
	else if(!mother_dna && father_dna)
		source_dna = father_dna

	if(source_dna)
		source_dna.copy_dna(baby.dna)

	// Per-feature random mix from both parents, if we have both.
	if(mother_dna && father_dna)
		var/datum/dna/baby_dna = baby.dna
		baby_dna.features = list()
		for(var/feature in (mother_dna.features | father_dna.features))
			if(prob(genetic_distribution) && father_dna.features[feature])
				baby_dna.features[feature] = father_dna.features[feature]
			else if(mother_dna.features[feature])
				baby_dna.features[feature] = mother_dna.features[feature]

		if(prob(genetic_distribution))
			baby_dna.blood_type = father_dna.blood_type
		else
			baby_dna.blood_type = mother_dna.blood_type

	baby.underwear = "Nude"
	baby.undershirt = "Nude"
	baby.socks = "Nude"
	baby.updateappearance(icon_update = TRUE, mutcolor_update = TRUE, mutations_overlay_update = TRUE)
