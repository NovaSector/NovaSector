/datum/deathmatch_modifier/loadout_enabled
	name = "Loadout Enabled"
	description = "Apply loadout to all players"

/datum/deathmatch_modifier/loadout_enabled/apply(mob/living/carbon/player, datum/deathmatch_lobby/lobby)
	. = ..()
	if(!player.client)
		return
	if(!ishuman(player))
		return
	var/datum/preferences/preferences = player.client.prefs
	if(!preferences)
		return
	var/mob/living/carbon/human/human_player = player
	var/outfit = lobby.players[human_player.ckey]["loadout"]
	human_player.equip_outfit_and_loadout(outfit || new /datum/outfit, preferences)

