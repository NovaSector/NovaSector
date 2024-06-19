/mob/dead/new_player/transfer_character()
	if(iscyborg(new_character))
		var/mutable_appearance/character_appearance = new(new_character.appearance)
		GLOB.name_to_appearance[new_character.real_name] = character_appearance // Cache this for Character Directory
	return ..()
