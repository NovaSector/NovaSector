/obj/item/card/id
	var/headshot_string

/obj/item/card/id/update_label()
	. = ..()
	if(registered_name)
		for(var/datum/mind/mind as anything in get_crewmember_minds())
			if(mind.current?.real_name == registered_name)
				var/mob/living/carbon/human/assigned_mob = mind.current
				if(assigned_mob.dna.features[EXAMINE_DNA_HEADSHOT])
					headshot_string = assigned_mob.dna.features[EXAMINE_DNA_HEADSHOT]
				break

/obj/item/card/id/get_id_examine_strings(mob/user)
	. = ..()
	if(headshot_string)
		. += list("<img src='[headshot_string]' alt='[name]'>")
	else
		. += list("[icon2html(get_cached_flat_icon(), user, extra_classes = "hugeicon")]")
