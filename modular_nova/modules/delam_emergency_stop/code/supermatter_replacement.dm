/**
 * Replaces a crewmember who has been permanently removed from play (e.g. dusted by the
 * supermatter) with a freshly spawned "clone" of their character, as if they had just
 * late-joined the round.
 */
/mob/living/carbon/human/proc/replace_with_clone()
	if(QDELETED(src) || !mind || istype(mind.assigned_role, /datum/job/unassigned))
		return FALSE // NT don't give a shit about replacing this person, they're either not a player, not crew or not a player with a job
	var/atom/destination = mind.assigned_role.get_latejoin_spawn_point()
	// A lot of this is copied from new_player, but we need to run through a lot of this boiler-plate to "properly" make a "just late-joined" character.
	if(!destination)
		CRASH("Failed to find a latejoin spawn point.")
	if(!client)
		CRASH("Client disconnected before we could make the replacement mob.")
	mind.active = FALSE
	var/mob/living/carbon/human/spawning_mob = mind.assigned_role.get_spawn_mob(client, destination)
	mind.transfer_to(spawning_mob)
	// Notably we do NOT set original character here, because this is not their actual original character.
	spawning_mob.PossessByPlayer(ckey)
	if(!spawning_mob.client)
		CRASH("Client disconnected while we were making the replacement mob.")
	to_chat(spawning_mob, span_userdanger("You have forgotten everything you did this shift. You are left with a horrible sense of Deja Vu."))
	var/area/joined_area = get_area(spawning_mob.loc)
	if(joined_area)
		joined_area.on_joining_game(spawning_mob)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CREWMEMBER_JOINED, spawning_mob, spawning_mob.mind.assigned_role.title)
	SSjob.equip_rank(spawning_mob, spawning_mob.mind.assigned_role, spawning_mob.client)
	spawning_mob.mind.assigned_role.after_latejoin_spawn(spawning_mob)
	spawning_mob.increment_scar_slot()
	spawning_mob.load_persistent_scars()
	SSpersistence.load_modular_persistence(spawning_mob.get_organ_slot(ORGAN_SLOT_BRAIN))
	if(GLOB.curse_of_madness_triggered)
		give_madness(spawning_mob, GLOB.curse_of_madness_triggered)
	if(spawning_mob.mind.assigned_role.job_flags & JOB_ASSIGN_QUIRKS)
		if(CONFIG_GET(flag/roundstart_traits))
			SSquirks.AssignQuirks(spawning_mob, spawning_mob.client)
	else
		spawning_mob.clear_personalities()
	var/list/loadout = spawning_mob.client?.get_loadout_datums()
	for(var/datum/loadout_item/item as anything in loadout)
		if (item.restricted_roles && length(item.restricted_roles) && !(spawning_mob.mind.assigned_role.title in item.restricted_roles))
			continue
		item.post_equip_item(spawning_mob.client?.prefs, spawning_mob)
	return TRUE
