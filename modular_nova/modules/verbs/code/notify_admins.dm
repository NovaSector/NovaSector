/client/verb/notify_admins()
	set name = "Notify Admins"
	set category = "OOC"

	if(is_banned_from(ckey, list(BAN_ADMIN_NOTIFY)))
		to_chat(src, span_danger("You are not able to use this."))
		return

	log_admin("[key_name(src)] notified admins to observe them.")
	message_admins("[key_name_admin(src)] has requested admin attention/observation. (<a href='?_src_=holder;adminplayerobservefollow=\ref[mob]'>Follow</a>)")

	for(var/client/admin_client as anything in GLOB.admins)
		if(admin_client.prefs?.read_preference(/datum/preference/toggle/admin_notify_alert) == FALSE)
			continue
		SEND_SOUND(admin_client, sound('modular_nova/master_files/sound/effects/admin_notify.ogg'))

	to_chat(src, span_notice("You've notified the admins to take a look at you."))
