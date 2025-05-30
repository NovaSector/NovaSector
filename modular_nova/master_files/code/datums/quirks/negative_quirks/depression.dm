/datum/quirk/depression/add()
	. = ..()
	if(issynthetic(quirk_holder))
		mail_goodies = list(/obj/item/storage/box/flat/neuroware/happiness)
	else
		mail_goodies = initial(mail_goodies)

