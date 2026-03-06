/datum/voucher_set/traitor/mod

/datum/voucher_set/traitor/mod/nukie
	name = "Syndicate MODsuit"
	description = /datum/mod_theme/syndicate::desc
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "syndicate-helmet-sealed"
	set_items = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/construction/plating/syndicate,
	)

/datum/voucher_set/traitor/mod/elite
	name = "Elite MODsuit"
	description = /datum/mod_theme/elite::desc
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "elite-helmet-sealed"
	set_items = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/stealth,
		/obj/item/mod/construction/plating/syndicate_elite,
	)

/datum/voucher_set/traitor/mod/infiltrator
	name = "Infiltrator MODsuit"
	description = /datum/mod_theme/infiltrator::desc
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "infiltrator-helmet-sealed"
	set_items = list(
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/chameleon,
		/obj/item/mod/construction/plating/syndicate_infiltrator,
	)

/datum/voucher_set/traitor/mech
///	These mechs are their 'evil' type because they have stronger armor values suitable for nova
//	Its also just thematically cooler

/datum/voucher_set/traitor/mech/gygax
	name = /obj/vehicle/sealed/mecha/gygax/dark::name
	description = /obj/vehicle/sealed/mecha/gygax/dark::desc
	icon = /obj/vehicle/sealed/mecha/gygax/dark::icon
	icon_state = /obj/vehicle/sealed/mecha/gygax/dark::icon_state
	set_items = list(
		/obj/vehicle/sealed/mecha/gygax/dark/marauder,
	)

/datum/voucher_set/traitor/mech/mauler
	name = /obj/vehicle/sealed/mecha/marauder/mauler::name
	description = /obj/vehicle/sealed/mecha/marauder/mauler::desc
	icon = /obj/vehicle/sealed/mecha/marauder/mauler::icon
	icon_state = /obj/vehicle/sealed/mecha/marauder/mauler::icon_state
	set_items = list(
		/obj/vehicle/sealed/mecha/marauder/mauler/marauder,
	)

/datum/voucher_set/traitor/mech/ripley
	name = /obj/vehicle/sealed/mecha/ripley/deathripley::name
	description = /obj/vehicle/sealed/mecha/ripley/deathripley::desc
	icon = /obj/vehicle/sealed/mecha/ripley/deathripley::icon
	icon_state = /obj/vehicle/sealed/mecha/ripley/deathripley::icon_state
	set_items = list(
		/obj/vehicle/sealed/mecha/ripley/deathripley/marauder,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/stack/sheet/animalhide/goliath_hide,
	)

/datum/voucher_set/traitor/mech/honker
	name = /obj/vehicle/sealed/mecha/honker/dark::name
	description = /obj/vehicle/sealed/mecha/honker/dark::desc
	icon = /obj/vehicle/sealed/mecha/honker/dark::icon
	icon_state = /obj/vehicle/sealed/mecha/honker/dark::icon_state
	set_items = list(
		/obj/vehicle/sealed/mecha/honker/dark/marauder,
	)
