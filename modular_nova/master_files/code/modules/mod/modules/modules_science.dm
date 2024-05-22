/obj/item/mod/module/anomaly_locked/antigrav/on_activation()
	. = ..()
	if (!isnull(spacer_quirk))
		spacer_quirk.in_space(mod.wearer)

/obj/item/mod/module/anomaly_locked/antigrav/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if (!isnull(spacer_quirk))
		spacer_quirk.check_z(mod.wearer)
