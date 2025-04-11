/datum/deathmatch_modifier/loadout_enabled
	name = "Loadout Enabled"
	description = "Apply loadout to all players"

/datum/deathmatch_modifier/loadout_enabled/apply(mob/living/carbon/player, datum/deathmatch_lobby/lobby)
	. = ..()

	var/datum/preferences/preference_source = player.client?.prefs
	if (!preference_source)
		return

	// using briefcase since im gonna be fuckin honest i tried to refactor the loadout helper code to not depend on outfits
	// and i failed so womp womp
	var/list/loadout_entries = preference_source.read_preference(/datum/preference/loadout)
	var/list/loadout_datums = loadout_list_to_datums(loadout_entries[preference_source.read_preference(/datum/preference/loadout_index)])

	var/obj/item/storage/briefcase/empty/briefcase = new(get_turf(player))

	for(var/datum/loadout_item/item as anything in loadout_datums)
		// NO CAN BE APPLIED TO CHECK. WE GO WILD. WE GO HARD
		var/obj/item/new_item = new item.item_path(get_turf(player))
		if (!new_item.equip_to_best_slot(player))
			new_item.forceMove(briefcase)

	if (!length(briefcase.contents))
		qdel(briefcase)
	else
		briefcase.name = "[preference_source.read_preference(/datum/preference/name/real_name)]'s travel suitcase"
		player.put_in_hands(briefcase)
