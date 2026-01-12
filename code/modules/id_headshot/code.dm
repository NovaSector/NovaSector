/obj/item/card/id
	var/headshot_string

/obj/item/card/id/update_label()
	. = ..()
	if(!registered_name)
		return
	headshot_string = register_headshot()

/obj/item/card/id/proc/register_headshot()
	for(var/player in GLOB.player_list)
		if(istype(player, /mob/dead/new_player)) //roundstart code snowflake
			var/mob/dead/new_player/user = player
			if(user.new_character?.name == registered_name)
				return safe_read_pref(user.client, /datum/preference/text/headshot)
		if(istype(player, /mob/living/carbon))
			var/mob/living/carbon/user = player
			if(user.name == registered_name)
				return safe_read_pref(user.client, /datum/preference/text/headshot)
	return NONE

/obj/item/card/id/get_id_examine_strings(mob/user, small_icon)
	. = ..()
	if(!headshot_string)
		return
	if(!user?.client)
		return
	if(!user?.client?.prefs.read_preference(/datum/preference/toggle/see_headshot_on_id))
		return
	if(!small_icon)
		return . = list("<img class='hugeicon' src='[headshot_string]'/>")
	. = list("[icon2html(get_cached_flat_icon(), user, extra_classes = "bigicon")]")

//proc overwrite (more of an addition)
/atom/get_id_examine_strings(mob/user, small_icon)

//pref
/datum/preference/toggle/see_headshot_on_id
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = FALSE
	savefile_key = "see_headshot_on_id"
	savefile_identifier = PREFERENCE_PLAYER
