/obj/item/card/id
	var/headshot_string

/obj/item/card/id/update_label()
	. = ..()
	if(registered_name)
		headshot_string = register_headshot()

/obj/item/card/id/proc/register_headshot()
	for(var/player in GLOB.player_list)
		if(istype(player, /mob/dead/new_player)) //roundstart code snowflake
			var/mob/dead/new_player/user = player
			if(user.new_character?.name == registered_name)
				return safe_read_pref(user.client, /datum/preference/text/headshot)
		else if(istype(player, /mob/living/carbon))
			var/mob/living/carbon/user = player
			if(user.name == registered_name)
				return safe_read_pref(user.client, /datum/preference/text/headshot)
	return NONE

/obj/item/card/id/get_id_examine_strings(mob/user)
	. = ..()
	if(headshot_string)
		. = list("<img class='hugeicon' src='[headshot_string]'/>")
