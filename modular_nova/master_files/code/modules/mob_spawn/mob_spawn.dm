/obj/effect/mob_spawn/ghost_role
	/// set this to make the spawner use the outfit.name instead of its name var for things like cryo announcements and ghost records
	/// modifying the actual name during the game will cause issues with the GLOB.mob_spawners associative list
	var/use_outfit_name
	/// Can we use our loadout for this role?
	var/loadout_enabled = FALSE
	/// Can we use our quirks for this role?
	var/quirks_enabled = FALSE
	/// Should the ghost role get mechanical loadout items (i.e weaponry)
	var/allow_mechanical_loadout_items = FALSE
	/// Are we limited to a certain species type? LISTED TYPE
	var/restricted_species

/obj/effect/mob_spawn/ghost_role/create(mob/mob_possessor, newname, apply_prefs)
	var/mob/living/spawned_mob = ..(mob_possessor, newname, apply_prefs)

	var/mob/living/carbon/human/spawned_human
	if (istype(spawned_mob, /mob/living/carbon/human))
		spawned_human = spawned_mob

		if(!apply_prefs)
			var/datum/language_holder/holder = spawned_human.get_language_holder()
			holder.get_selected_language() //we need this here so a language starts off selected
			post_transfer_prefs(spawned_human)
			return spawned_human

		spawned_human?.client?.prefs?.safe_transfer_prefs_to(spawned_human)
		spawned_human.dna.update_dna_identity()
		if(spawned_human.mind)
			spawned_human.mind.name = spawned_human.real_name // the mind gets initialized with the random name given as a result of the parent create() so we need to readjust it
		spawned_human.dna.species.give_important_for_life(spawned_human) // make sure they get plasmaman/vox internals etc before anything else

		if(quirks_enabled)
			SSquirks.AssignQuirks(spawned_human, spawned_human.client)

		post_transfer_prefs(spawned_human)

	if(apply_prefs && loadout_enabled)
		spawned_human?.equip_outfit_and_loadout(outfit, spawned_mob.client.prefs, FALSE, null, allow_mechanical_loadout_items)
	else if (!isnull(spawned_human))
		equip(spawned_human)
		var/mutable_appearance/character_appearance = new(spawned_human.appearance)
		GLOB.name_to_appearance[spawned_human.real_name] = character_appearance // Cache this for Character Directory

	return spawned_mob

// Anything that can potentially be overwritten by transferring prefs must go in this proc
// This is needed because safe_transfer_prefs_to() can override some things that get set in special() for certain roles, like name replacement
// In those cases, please override this proc as well as special()
// TODO: refactor create() and special() so that this is no longer necessary
/obj/effect/mob_spawn/ghost_role/proc/post_transfer_prefs(mob/living/new_spawn)
	apply_job_traits(new_spawn) // for things in after_spawn e.g. liver traits
	return

/obj/effect/mob_spawn/ghost_role/human/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..(spawned_mob, mob_possessor, apply_prefs)
	var/mob/living/carbon/human/spawned_human = spawned_mob
	var/datum/job/spawned_job = SSjob.get_job_type(spawner_job_path)
	spawned_human.job = spawned_job.title

/**
 * Apply [/datum/job/var/mind_traits] and [/datum/job/var/liver_traits] to newly spawned mob along with [TRAIT_CLIENT_STARTING_ORGAN] to every organ
 */
/obj/effect/mob_spawn/ghost_role/proc/apply_job_traits(mob/living/carbon/human/spawned_human)
	if(!istype(spawned_human) && !spawned_human.mind)
		return

	var/datum/job/job_role = spawned_human.mind.assigned_role
	if(!job_role)
		return

	if(length(job_role.mind_traits))
		spawned_human.mind.add_traits(job_role.mind_traits, JOB_TRAIT)

	var/obj/item/organ/liver/liver = spawned_human.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && length(job_role.liver_traits))
		liver.add_traits(job_role.liver_traits, JOB_TRAIT)

	for(var/obj/item/organ/our_organ in spawned_human.organs)
		ADD_TRAIT(our_organ, TRAIT_CLIENT_STARTING_ORGAN, ROUNDSTART_TRAIT)
