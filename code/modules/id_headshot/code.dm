/obj/item/card/id
	var/headshot_string

/obj/item/card/id/Initialize(mapload)
	. = ..()
	if(registered_name)
		headshot_string = register_headshot()

/obj/item/card/id/update_label()
	. = ..()
	if(registered_name)
		headshot_string = register_headshot()

/obj/item/card/id/proc/register_headshot()
	for(var/mob/living/carbon/human/user as anything in get_active_player_list())
		if(user.name == registered_name)
			if(user.dna.features[EXAMINE_DNA_HEADSHOT])
				return user.dna.features[EXAMINE_DNA_HEADSHOT]
			break
	return NONE

/obj/item/card/id/get_id_examine_strings(mob/user)
	. = ..()
	if(headshot_string)
		. = list("<img src='[headshot_string]' height='120' height='120' alt='[name]'>")
