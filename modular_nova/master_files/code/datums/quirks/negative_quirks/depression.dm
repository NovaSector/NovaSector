/datum/quirk/depression/add()
	. = ..()
	if(issynthetic(quirk_holder))
		mail_goodies = list(/obj/item/storage/box/flat/neuroware/happiness)
	else
		mail_goodies = initial(mail_goodies)

/datum/quirk/depression/add_unique(client/client_source)
	var/depression_medication = /obj/item/storage/pill_bottle/happinesspsych
	if(issynthetic(quirk_holder))
		depression_medication = /obj/item/storage/box/flat/neuroware/happiness
	give_item_to_holder_nova(
		depression_medication,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "These will keep your mood stable until you can secure a supply of medication.",
		notify_player = TRUE,
	)
