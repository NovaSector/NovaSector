/obj/item/mod/module/anomaly_locked/antigrav/on_activation()
	. = ..()
	// Check to see if the users has the spacer quirk. If not null, will result in the negation of gravity sickness.
	if (!isnull(mod.wearer.get_quirk(/datum/quirk/spacer_born)))
		spacer_quirk.in_space(mod.wearer)

/obj/item/mod/module/anomaly_locked/antigrav/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	// Check to see if the users has the spacer quirk. If not null, will result in the negation of gravity sickness.
	if (!isnull(mod.wearer?.get_quirk(/datum/quirk/spacer_born)))
		spacer_quirk.check_z(mod.wearer)
