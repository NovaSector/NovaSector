/datum/asset/spritesheet_batched/chat
	name = "chat"

/datum/asset/spritesheet_batched/chat/create_spritesheets()
	insert_all_icons("emoji", EMOJI_SET)
	// pre-loading all lanugage icons also helps to avoid meta
	insert_all_icons("language", 'icons/ui/chat/language.dmi')
	// catch languages which are pulling icons from another file
	for(var/datum/language/L as anything in subtypesof(/datum/language))
		var/icon = initial(L.icon)
		if (icon != 'icons/ui/chat/language.dmi')
			var/icon_state = initial(L.icon_state)
			insert_icon("language-[icon_state]", uni_icon(icon, icon_state))

	var/datum/universal_icon/byond_member = uni_icon('icons/ui/chat/member_content.dmi', "blag")
	byond_member.scale(16, 16)
	insert_icon("byond_member", byond_member)
	// NOVA EDIT ADDITION START
	var/datum/universal_icon/nova_donator = uni_icon('modular_nova/master_files/icons/donator/donator_chat_icon.dmi', "nova_logo")
	nova_donator.scale(16, 16)
	insert_icon("nova_donator", nova_donator)
	// NOVA EDIT ADDITION END
