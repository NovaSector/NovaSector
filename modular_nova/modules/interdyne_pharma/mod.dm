/obj/item/mod/control/pre_equipped/interdyne/nerfed
	theme = /datum/mod_theme/interdyne
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/defibrillator,
		/obj/item/mod/module/injector,
		/obj/item/mod/module/surgical_processor/preloaded,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/thread_ripper,
	)

/datum/mod_theme/interdyne/nerfed
	armor_type = /datum/armor/mod_theme_interdyne/nerfed
	slowdown_deployed = 0.25
	allowed_suit_storage = list(
		/obj/item/assembly/flash,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/restraints/handcuffs,
		/obj/item/sensor_device,
		/obj/item/shield/energy,
		/obj/item/stack/medical,
		/obj/item/storage/bag/bio,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/pill_bottle,
	)

/datum/armor/mod_theme_interdyne/nerfed
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bomb = 10
	bio = 100
	fire = 60
	acid = 75
	wound = 5

/obj/machinery/suit_storage_unit/interdyne/nerfed
	mask_type = /obj/item/clothing/mask/neck_gaiter
	storage_type = /obj/item/tank/internals/oxygen
	mod_type = /obj/item/mod/control/pre_equipped/interdyne/nerfed
