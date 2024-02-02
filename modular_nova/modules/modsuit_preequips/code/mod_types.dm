/obj/item/mod/control/pre_equipped/standard/load
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/status_readout,
	)
	default_pins = list(
		/obj/item/mod/module/tether,
	)

/obj/item/mod/control/pre_equipped/standard/civilian
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/flashlight,
	)
	applied_skin = "civilian"

/obj/item/mod/control/pre_equipped/standard/civilian/load
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/status_readout,
	)
	applied_skin = "civilian"
	default_pins = list(
		/obj/item/mod/module/tether,
	)

/obj/item/mod/control/pre_equipped/prototype/load
	theme = /datum/mod_theme/prototype/nerf
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = list()
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/status_readout,
	)
	default_pins = list(
		/obj/item/mod/module/tether,
	)
